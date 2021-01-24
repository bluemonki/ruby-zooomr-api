#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/
require 'Zooomr'
# Auth routines
class ZooomrAuth
  
  # Constructor
  #
  # a_zooomr_api => a ZooomrRestAPI object
  #
  def initialize(a_zooomr_api)
    if (a_zooomr_api.nil?)
      raise ArgumentError, "ZooomrAuth requires a ZooomrAPI object", caller
    end
    @zooomr = a_zooomr_api
  end
  
  ###############################################
	# Call the zooomr.auth.getFrob method
	#
	def getFrob
    method    = 'zooomr.auth.getFrob'
    params    = {  'api_key' => @zooomr.api_key }
    
    return @zooomr.call_method(method, params)
	end
	
	
	###############################################
	# Call the zooomr.auth.getToken method
	#
	# Required Parameters:
	# * frob => a frob to get the token with (must have authed with zooomr first)
	#
  def getToken(a_parameter_hash)
    method    = 'zooomr.auth.getToken'
    
    required_params = ['frob']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_method(method, params)
  end
  
  ###############################################
	# Call the zooomr.auth.checkToken method
	#
	# Required Parameters:
	# * token  => token to check
	#
  def checkToken(a_parameter_hash)
    
    method = 'zooomr.auth.checkToken'
    
    required_params = ['auth_token']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_method(method, params)
  end
  
end
