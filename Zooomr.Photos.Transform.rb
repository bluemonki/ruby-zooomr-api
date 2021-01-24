#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/
require 'Zooomr'

# Transform routines
class ZooomrPhotosTransform
  
  # Constructor
  #
  # a_zooomr_api => a ZooomrRestAPI object
  def initialize(a_zooomr_api)
    if (a_zooomr_api.nil?)
      raise ArgumentError, "ZooomrPhotosTransform requires a ZooomrAPI object", caller
    end
    @zooomr = a_zooomr_api
  end
  
  # Rotate a photo
  #
  # Required Parameters:
  # * photo_id => the photo you want to rotate
  # * degrees => number of degrees to rotate the photo (90, 180, 270)
  # * auth_token => your auth token
  #
  def rotate(a_parameter_hash)
    method = 'zooomr.photos.transform.rotate'
    
    required_params = ['photo_id', 'degrees', 'auth_token']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_post_method(method, params)
  end
end
