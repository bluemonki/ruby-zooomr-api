#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/

require 'Zooomr'

# Manipulate licenses for photos
class ZooomrPhotosLicense
  
  # License types
  LICENSE_ALL_RIGHTS_RESERVED              = "0"
  LICENSE_CC_ATTRIBUTION                   = "1"
  LICENSE_CC_NO_DERIVITIVES                = "2"
  LICENSE_CC_NON_COMMERCIAL_NO_DERIVITIVES = "3"
  LICENSE_CC_NON_COMMERCIAL                = "4"
  LICENSE_CC_NON_COMMERCIAL_SHARE_ALIKE    = "5"
  LICENSE_CC_SHARE_ALIKE                   = "6"

  # Constructor
  #
  # a_zooomr_api => a ZooomrRestAPI object
  #
  def initialize(a_zooomr_api)
    if (a_zooomr_api.nil?)
      raise ArgumentError, "ZooomrPhotosLicense requires a ZooomrAPI object", caller
    end
    @zooomr = a_zooomr_api
  end
  
  # Set the license for a given photo
  #
  # Required Parameters:
  # * photo_id => photo to set the license for
  # * license_id => license to user (from constants above)
  # * auth_token => your auth token
  #
  def setLicense(a_parameter_hash)
    method = 'zooomr.photos.licenses.setLicense'
    
    required_params = ['photo_id', 'license_id', 'auth_token']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_post_method(method, params)
  end
end
