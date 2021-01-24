#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/

require 'Zooomr'
require 'Zooomr.Photosets.RuleSet'
require 'Zooomr.Photosets.Context'
require 'Zooomr.Photosets.SortMode'

# Create and Edit photosets
class ZooomrPhotosets
  
  # Constructor
  #
  # a_zooomr_api => a ZooomrRestAPI object
  #
  def initialize(a_zooomr_api)
    if (a_zooomr_api.nil?)
      raise ArgumentError, "ZooomrPhotosets requires a ZooomrAPI object", caller
    end
    @zooomr = a_zooomr_api
  end
  
  # Create a photoset
  #
  # Required Parameters:
  # * title => title for the photoset
  # * description => desciption for the photoset
  # * primary_photo_id => ID of the photo to use for a cover photo
  # * ruleset => a ZooomrPhotosetRuleSet object populated with rules
  # * context => who to match photos from, constants from ZooomrPhotosetsContext
  # * sortmode => how to sort the set contents, constants from ZooomrPhotosetsSoftMode
  # * auth_token => Your auth token
  def create(a_parameter_hash)
    
    required_params = ['title', 'description', 'primary_photo_id', 'ruleset', 'context', 'sortmode', 'auth_token']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    if (!(a_parameter_hash['ruleset'].is_a?(ZooomrPhotosetsRuleSet)))
      raise ArgumentError, "ZooomrPhotosets.create:: ruleset should be a ZooomrPhotosetsRuleSet object!", caller
    end
    
    # build the ruleset
    rules = ""
    rule_array = a_parameter_hash['ruleset'].rule_array
    
    rule_array.each do |rule|
      unless(rule.nil?)
        rules += rule.match_type + "|" + rule.match_args + "|" + rule.match_test + "\n"
      end
    end
    
    method = 'zooomr.photosets.create'
    
    a_parameter_hash.delete('ruleset')
    
    params = {  'api_key' => @zooomr.api_key,
                'rules'   => rules}
    
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_post_method(method, params)
  end
  
  # delete a photoset
  #
  # Required Parameters:
  # * photoset_id - ID of the photoset to delete
  # * auth_token - your auth token
  #
  def delete(a_parameter_hash)
    method = 'zooomr.photosets.delete'
    
    required_params = ['photoset_id', 'auth_token']
   
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key' => @zooomr.api_key }
    
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_post_method(method, params)
  end
  
  # Edit a photoset
  #
  # Required Parameters:
  # * photoset_id => ID for the photoset you want to edit
  # * title => title for the photoset
  # * auth_token => Your auth token
  #
  # Optional Parameters:
  # * description => desciption for the photoset
  # * primary_photo_id => ID of the photo to use for a cover photo
  # * ruleset => a ZooomrPhotosetRuleSet object populated with rules
  # * context => who to match photos from, constants from ZooomrPhotosetsContext
  # * sortmode => how to sort the set contents, constants from ZooomrPhotosetsSoftMode
  # 
  def edit(a_parameter_hash)
    
    required_params = ['photoset_id' , 'title', 'auth_token']
    optional_params = ['description', 'primary_photo_id', 'ruleset', 'context', 'sortmode']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    if (a_parameter_hash.has_key?('ruleset'))
      if (!(a_parameter_hash['ruleset'].is_a?(ZooomrPhotosetsRuleSet)))
        raise ArgumentError, "ZooomrPhotosets.edit:: a_ruleset should be a ZooomrPhotosetsRuleSet object!", caller
      end 
      
      # build the ruleset if there is one
      rules = ""
      rule_array = a_parameter_hash['ruleset'].rule_array
      
      rule_array.each do |rule|
        unless(rule.nil?)
          rules += rule.match_type + "|" + rule.match_args + "|" + rule.match_test + "\n"
        end
      end
      a_parameter_hash['rules'] = rules
    end
    
    a_parameter_hash.delete('ruleset')
    
    method = 'zooomr.photosets.edit'
    
    params = {  'api_key' => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_post_method(method, params)
  end
  
  # Get info about a photoset
  #
  # Required Parameters:
  # * photoset_id => photoset to get info for
  #
  def getInfo(a_parameter_hash)
    method = 'zooomr.photosets.getInfo'
    
    required_params = ['photoset_id']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_method(method, params)
  end
  
  # Get a list of photosets for a user
  #
  # Required Parameters:
  # * user_id => user id you want the photosets for
  #  
  def getList(a_parameter_hash)
    method = 'zooomr.photosets.getList'
    
    required_params = ['user_id']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_method(method, params)
  end
  
  # Get photos from a photoset
  #
  # Required Parameters:
  # * photoset_id => ID of the photoset you want the images from
  #
  # Optional Parameters:
  # * page => page you want
  # * per_page => number of photos per page
  #
  def getPhotos(a_parameter_hash)
    method = 'zooomr.photosets.getPhotos'
    
    required_params = ['photoset_id']
    optional_params = ['page', 'per_page']
    
    @zooomr.params_are_valid(required_params, optional_params, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_method(method, params)
  end
  
end
