#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/

require 'rubygems'
require 'json'
require 'net/http'
require 'digest/md5'

require 'Zooomr.Photos'
require 'Zooomr.People'
require 'Zooomr.Auth'
require 'Zooomr.Activity'
require 'Zooomr.Contacts'
require 'Zooomr.Favorites'
require 'Zooomr.Groups'
require 'Zooomr.Photosets'
require 'Zooomr.Tags'
require 'Zooomr.Test'
require 'Zooomr.Upload'
require 'Zooomr.Zipline'

require 'Zooomr.Response'

# Main Zooomr API Class - give access to subclasses that make it look like
# you're calling the documented methods
class ZooomrRestAPI
 
  attr_accessor :photos, :people, :auth, :activity, :contacts, :favorites, :groups, :photosets, :tags, :test, :upload, :zipline, :api_key
  ###########################################
  # Constructor
  #
  # IN:
  # * a_api_key       => your API key
  # * a_shared_secret => your shared secret
  #
  # RETURNS:
  # * new ZooomrRestAPI Object
  #
  def initialize(a_api_key, a_shared_secret)
    if (nil.eql?(a_api_key))
      raise ArgumentError, "API KEY is nil", caller
    end

    if (nil.eql?(a_shared_secret))
      raise ArgumentError, "SHARED SECRET is nil", caller
    end
    
    @api_key        = a_api_key
    @shared_secret  = a_shared_secret
    
    @photos     = ZooomrPhotos.new(self)
    @people     = ZooomrPeople.new(self)
    @auth       = ZooomrAuth.new(self)
    @activity   = ZooomrActivity.new(self)
    @contacts   = ZooomrContacts.new(self)
    @favorites  = ZooomrFavorites.new(self)
    @groups     = ZooomrGroups.new(self)
    @photosets  = ZooomrPhotosets.new(self)
    @tags       = ZooomrTags.new(self)
    @test       = ZooomrTest.new(self)
    @upload     = ZooomrUpload.new(self)
    @zipline    = ZooomrZipline.new(self)
  end

  ######################################################
  # Create the signature required for signing methods
  # see http://www.flickr.com/services/api/auth.howto.desktop.html
  # for more detialed info
  #
  # IN:
  # * a_params => a hash of parameters that are required to be passed to the method you want to call - must include the method its self
  #
  # RETURNS:
  # * a signature for the call you want to make
  #
  def create_signature(a_params)
    # start with the shared secret
    ascii_sig = @shared_secret
    
    # append all the params in alphabetical order
    a_params.sort.each do |key, value|
      ascii_sig += key + value.to_s
    end
    
    # turn it into a MD5 digest
    #puts "ASCII SIG: " + ascii_sig
    return Digest::MD5.hexdigest(ascii_sig)
  end
  
  ######################################################
  # Make a call to the REST api
  #
  # IN:
  # * a_method_to_call => method to call
  # * a_params => a hash of parameters that are required to be passed to the method you want to call - must NOT include the method its self
  #
  # RETURNS:
  # * false on failure, ZooomrResponse object on success
  #
  def call_method(a_method_to_call, a_params)
    params = a_params
    params['method']          = a_method_to_call
    params['format']          = 'json'
    params['nojsoncallback']  = 1
    api_sig = create_signature(params)
    
    ascii_url = 'http://api.zooomr.com/services/rest?method=' + a_method_to_call + '&api_sig=' + api_sig
    
    a_params.sort.each do |key, value|
      ascii_url += '&' + key + '=' + URI.escape(value.to_s) 
    end
    
		url = URI.parse(ascii_url)
		
    req = Net::HTTP.get_response(url)
       
    # check that we got a response
    if (nil.eql?(req))
      return false
    end
    
    puts "METHOD: " + a_params['method']
    puts "RESPONSE: " + req.body + "\n\n"

    resp_hash = JSON.parse(req.body)

    return ZooomrResponse.new(resp_hash)
  end
  
  
  ######################################################
  # Make a call to the REST api
  #
  # IN:
  # * a_method_to_call => method to call
  # * a_params => a hash of parameters that are required to be passed to the method you want to call - must NOT include the method its self
  #
  # RETURNS:
  # * false on failure, ZooomrResponse document of the response on success
  #
  def call_post_method(a_method_to_call, a_params)
    
    a_params['method']          = a_method_to_call
    a_params['format']          = 'json'
    a_params['nojsoncallback']  = 1
    
    api_sig = create_signature(a_params)
    
    a_params['api_sig'] = api_sig
    
    ascii_url = 'http://api.zooomr.com/services/rest?'
    
    a_params.sort.each do |key, value|
      ascii_url += '&' + key + '=' + URI.escape(value.to_s) 
    end
    
    puts "ASCII URL: " + ascii_url
		url = URI.parse(ascii_url)
		
    req = Net::HTTP.post_form(url, a_params)
       
    # check that we got a response
    if (nil.eql?(req))
      # this is what we expect from a post that worked
      resp_hash = JSON.parse("{\"stat\": \"ok\"}")
      
      return ZooomrResponse.new(resp_hash)
    end
    
    puts "RESPONSE: " + req.body

    resp_hash = JSON.parse(req.body)
    return ZooomrResponse.new(resp_hash)
	end
	
	
	
	###############################################
	# Start the authentication process, return a link that
	# the user needs to follow to tick the relavent box
	#
	# Required Parameters:
	# *  a_perms - "read" or "write"
	# RETURNS:
	# * ZooomrResponse object on failure to get frob, or a hash of:
	# *  frob => frob to use with getToken/complete_authentication after the link is followed
	# *  link => http link for the user to follow to allow the access)
	#
	def authenticate_application(a_parameter_hash)
	
	  required_params = ['perms']
    
    params_are_valid(required_params, nil, a_parameter_hash)
    
    response = auth.getFrob()
    
    if (false == response)
      
      return response
    
    else
      
      json = response.json_response
      frob = json['frob']
      
      params = { 'frob' => frob }
      params = params.merge(a_parameter_hash)
      
      link = create_login_link(params)
      return {'frob' => frob, 'link' => link}
    
    end
	end
	
	################################################
	# Finishes the authentication process by calling
	# get_token
	#
	# Required Parameters:
	# * frob - frob from get_frob/authentication application
	# RETURNS:
	# * ZooomrResponse object
	#
	def complete_authentication(a_parameter_hash)
    
    required_params = ['frob']
    
    params_are_valid(required_params, nil, a_parameter_hash)
    
    return auth.getToken(a_parameter_hash)
	end
	
	######################################################
  # Create a auth link for the user to follow to allow this app
  #
  # Required Parameters:
  # * frob - frob to use
  # * perms - "read" or "write"
  #
  # RETURNS:
  # * a URL that the user must follow in order to allow the app
  #
  def create_login_link(a_parameter_hash)
    
    required_params = ['perms', 'frob']
    
    params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @api_key }
    params = params.merge(a_parameter_hash)
    
    api_sig = create_signature(params)

    login_link = "http://www.zooomr.com/services/auth/?api_key=" + @api_key + "&api_sig=" + api_sig + "&frob=" + a_parameter_hash['frob']+ "&perms=" + a_parameter_hash['perms']
    
    return login_link
  end
  
  # calls ZooomrRestAPI.params_are_valid  
  def params_are_valid(a_array_of_required_params, a_array_of_extra_allowed_param_names, a_hash_of_params_and_values)
    ZooomrRestAPI.params_are_valid(a_array_of_required_params, a_array_of_extra_allowed_param_names, a_hash_of_params_and_values);
  end
  
  # Internal method for checking if the passed hash of params is acceptable to a given methods parameter list
  def ZooomrRestAPI.params_are_valid(a_array_of_required_params, a_array_of_extra_allowed_param_names, a_hash_of_params_and_values)
    
    if ( nil == a_array_of_required_params )
      a_array_of_required_params = ()
    end
    
    # get the keys
    array_of_passed_params = ()
    unless( nil == a_hash_of_params_and_values )
      array_of_passed_params = a_hash_of_params_and_values.keys  
    end
    
    unless ( nil == a_array_of_required_params )
      a_array_of_required_params.sort
      
      # check that all the required params are in the hash
      missing_required_params = a_array_of_required_params - array_of_passed_params
      
      unless (missing_required_params.length == 0)
        raise ArgumentError, "Zooomr::params_are_valid missing  required parameter(s)" + missing_required_params.join(", ") + " was passed: " + a_hash_of_params_and_values.to_s ,
        caller
      end
    end
    
    if ( nil == a_hash_of_params_and_values && nil == a_array_of_extra_allowed_param_names)
      # don't worry about it if they're both nil
    elsif( (!nil == a_array_of_extra_allowed_param_names) )
      # check that there aren't any extra ones we weren't expecting
      a_array_of_extra_allowed_param_names.sort
      
      # make sure we've removed the mandatory ones
      extra_params = array_of_passed_params
      unless( nil == a_array_of_required_params )
        extra_params = array_of_passed_params - a_array_of_required_params
      end
      
      extra_params.sort
      
      unrecognised_params = extra_params - a_array_of_extra_allowed_param_names
      
      unless (0 == unrecognised_params.length)
        raise ArgumentError,
        "Zooomr::params_are_valid unrecognised parameter(s) " + unrecognised_params.join(", "),
        caller
      end
    end
  end
  
end
