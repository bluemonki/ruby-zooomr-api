#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/

require 'Zooomr'

# Test API methods - all methods return a ZooomrResponse object
class ZooomrTest
  
  # Constructor
  #
  # a_zooomr_api => a ZooomrRestAPI instance
  def initialize(a_zooomr_api)
    if (a_zooomr_api.nil?)
      raise ArgumentError, "ZooomrTest requires a ZooomrAPI object", caller
    end
    @zooomr = a_zooomr_api
  end
  
  # echo the parameters passed to Zooomr
  #
  # Required Parameters:
  # * none
  # Optional Parameters:
  # * anything you like!!
  #
  def echo(a_parameter_hash = {})
    method = 'zooomr.test.echo'
                
    return @zooomr.call_method(method, a_parameter_hash)
  end
  
  # show your current login info
  #
  # Required Parameters:
  # * auth_token => Your auth token
  #
  def login(a_parameter_hash)
    method = 'zooomr.test.login'
    
    required_params = ['auth_token']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_method(method, params)
  end
end
