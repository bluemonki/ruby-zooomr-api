#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/
require 'Zooomr'

# Manipulate a users contacts
class ZooomrContacts
  
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
  
  # Get a list of a users contacts
  #
  # Required Parameters:
  # * auth_token => your auth token
  #
  # Optional Parameters:
  # * filter => string friends,family,both
  # * page => page of results
  # * per_page => results per page
  #
  def getList(a_parameter_hash)
    method = 'zooomr.contacts.getList'
    
    required_params = ['auth_token']
    optional_params = ['filter', 'page', 'per_page']
    
    @zooomr.params_are_valid(required_params, optional_params, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_method(method, params)
  end
  
  # Get a list of a users public contacts
  #
  # Required Parameters:
  # * user_id => user you want the contacts for
  #
  # Optional Parameters:
  # * page => page of results
  # * per_page => results per page
  #
  def getPublicList(a_parameter_hash)
    method = 'zooomr.contacts.getPublicList'
    
    required_params = ['user_id']
    optional_params = ['page', 'per_page']
    
    @zooomr.params_are_valid(required_params, optional_params, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_method(method, params)
  end
end
