#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/
require 'Zooomr'

# Manipulate a users favorites
class ZooomrFavorites
  
  # Constructor
  #
  # a_zooomr_api => a ZooomrRestAPI object
  #
  def initialize(a_zooomr_api)
    if (a_zooomr_api.nil?)
      raise ArgumentError, "ZooomrFavorites requires a ZooomrAPI object", caller
    end
    @zooomr = a_zooomr_api
  end
  
  # Add a photo as a fave
  #
  # Required Parameters:
  # * photo_id => photo to add as a fave
  # * auth_token => your auth token
  #
  def add(a_parameter_hash)
    method = 'zooomr.favorites.add'
    
    required_params = ['auth_token', 'photo_id']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_post_method(method, params)
  end
  
  # Get a list of faves for a user
  #
  # Required Parameters:
  # * auth_token => your auth token
  #
  # Optional Parameters:
  # * user_id => user you want the faves for (defaults to calling user)
  # * extras => extra info to return
  # * page => page of results
  # * per_page => results per page
  #  
  def getList(a_parameter_hash)
    method = 'zooomr.favorites.getList'
    
    required_params = ['auth_token']
    optional_params = ['user_id', 'page', 'per_page', 'extras']
    
    @zooomr.params_are_valid(required_params, optional_params, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
  
    return @zooomr.call_method(method, params)
  end
  
  # Remove a photo from your faves
  #
  # Required Parameters:
  # * photo_id => photo to remove as a fave
  # * auth_token => your auth token
  def remove(a_parameter_hash)
    method = 'zooomr.favorites.remove'
    
    required_params = ['auth_token', 'photo_id']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_post_method(method, params)
  end
end
