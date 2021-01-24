#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/

require 'Zooomr'

# Zipline methods  - all methods return a ZooomrResponse object
class ZooomrZipline
  
  # Constructor
  #
  # a_zooomr_api => a ZooomrRestAPI instance
  #
  def initialize(a_zooomr_api)
    if (a_zooomr_api.nil?)
      raise ArgumentError, "ZooomrZipline requires a ZooomrAPI object", caller
    end
    @zooomr = a_zooomr_api
  end
  
  # Post some text to zipline
  #
  # Required Parameters:
  # * status => the text you want to post
  # * auth_token => Your auth token
  #
  def postLine(a_parameter_hash)
    method = 'zooomr.zipline.postLine'
    
    required_params = ['status', 'auth_token']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_post_method(method, params)
  end
  
  # Get all of your posts from Zipline
  #
  # Required Parameters:
  # * auth_token => Your auth token
  #
  def getLine(a_parameter_hash)
    method = 'zooomr.zipline.getLine'
    
    required_params = ['auth_token']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_method(method, params)
  end
end
