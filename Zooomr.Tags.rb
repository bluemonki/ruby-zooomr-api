#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/

require 'Zooomr'

# Tag manipulation methods - all methods return a ZooomrResponse object
class ZooomrTags
  
  # Constructor
  #
  # a_zooomr_api => a ZooomrRestAPI instance
  def initialize(a_zooomr_api)
    if (a_zooomr_api.nil?)
      raise ArgumentError, "ZooomrTags requires a ZooomrAPI object", caller
    end
    @zooomr = a_zooomr_api
  end
  
  # Get a list of tags for a photo
  #
  # Required Parameters:
  # * photo_id => the ID of the photo you want the tags for
  #
  def getListPhoto(a_parameter_hash)
    method = 'zooomr.tags.getListPhoto'
    
    required_params = ['photo_id']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_method(method, params)
  end
  
  # Get a list of tags used by the user
  #
  # Required Parameters:
  # * user_id => the user id you want to know the tags for
  #  
  def getListUser(a_parameter_hash)
    method = 'zooomr.tags.getListUser'
    
    required_params = ['user_id']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_method(method, params)
  end
end
