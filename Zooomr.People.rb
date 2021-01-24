#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/

require 'Zooomr'

# Get user info
class ZooomrPeople
  
  # Constructor
  #
  # a_zooomr_api => a ZooomrRestAPI object
  #
  def initialize(a_zooomr_api)
    if (a_zooomr_api.nil?)
      raise ArgumentError, "ZooomrPeople requires a ZooomrAPI object", caller
    end
    @zooomr = a_zooomr_api
  end
  
  # Get photos for a user
  #
  # Required Parameters:
  # * user_id => user to get photos for
  # * auth_token => your auth token
  #
  def getPhotos(a_parameter_hash)
    method = 'zooomr.people.getPhotos'
    
    required_params = ['user_id', 'auth_token']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_method(method, params)
  end
  
  # Get info about a user
  #
  # Required Parameters:
  # * user_id => user you want info about
  #
  def getInfo(a_parameter_hash)
    method = 'zooomr.people.getInfo'
    
    required_params = ['user_id']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)

    return @zooomr.call_method(method, params)
  end
  
  # Get a list of public groups for a user
  #
  # Required Parameters:
  # * user_id => user to find groups for
  #
  def getPublicGroups(a_parameter_hash)
    method = 'zooomr.people.getPublicGroups'
    
    required_params = ['user_id']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_method(method, params)
  end
  
  # Get upload stats for the calling user
  #
  # Required Parameters:
  # * auth_token => your auth token
  #
  def getUploadStatus(a_parameter_hash)
    method = 'zooomr.people.getUploadStatus'
    
    required_params = ['auth_token']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_method(method, params)
  end
  
end
