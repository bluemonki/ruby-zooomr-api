#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/

require 'Zooomr'

# Manipulate Geotags for a photo
class ZooomrPhotosGeo
  
  # Constructor
  #
  # a_zooomr_api => a ZooomrRestAPI object
  #
  def initialize(a_zooomr_api)
    if (a_zooomr_api.nil?)
      raise ArgumentError, "ZooomrPhotosGeo requires a ZooomrAPI object", caller
    end
    @zooomr = a_zooomr_api
  end
  
  # Remove the current geotag from a photo
  #
  # Required Parameters:
  # * photo_id => photo to remove geotag from
  # * auth_token => your auth token
  #
  def removeLocation(a_parameter_hash)
    method = 'zooomr.photos.geo.removeLocation'
    
    required_params = ['photo_id', 'auth_token']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
  
    return @zooomr.call_post_method(method, params)
  end
  
  # Set the location for a photo
  #
  # Required Parameters:
  # * photo_id => photo to set geo tag for
  # * lat => latitude
  # * lon => longitude
  # * auth_token => your auth token
  #  
  # Optional Parameters
  # * accuracy => level of accurac
  #
  def setLocation(a_parameter_hash)
    method = 'zooomr.photos.geo.setLocation'
    
    required_params = ['photo_id', 'lat', 'lon', 'auth_token']
    optional_params = ['accuracy']
    
    @zooomr.params_are_valid(required_params, optional_params, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_post_method(method, params)
  end
end
