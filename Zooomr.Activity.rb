#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/
require 'Zooomr'

# Get a users activity
class ZooomrActivity
  
  # Constructor
  #
  # a_zooomr_api => a ZooomrRestAPI object
  #
  def initialize(a_zooomr_api)
    if (a_zooomr_api.nil?)
      raise ArgumentError, "ZooomrActivity requires a ZooomrAPI object", caller
    end
    @zooomr = a_zooomr_api
  end
  
  # Get a users photos
  #
  # Required Parameters:
  # * auth_token => your auth token
  #
  # Optional Parameters:
  # * timeframe => timeframe to get updates for 2d - 2 days, 4h - 4 hours
  # * page => page of results
  # * per_page => results per page
  #
  def userPhotos(a_parameter_hash)
    method = 'zooomr.activity.userPhotos'
    
    required_params = ['auth_token']
    optional_params = ['timeframe', 'per_page', 'page']
    
    @zooomr.params_are_valid(required_params, optional_params, a_parameter_hash)
    
    params = {  'api_key'       => @zooomr.api_key,
                'nojsoncallback'=> '1',
                'format'        => 'json'}
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_method(method, params)
  end
end
