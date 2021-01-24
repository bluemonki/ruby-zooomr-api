#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/
require 'Zooomr'

# Info about groups
class ZooomrGroups
  
  # Constructor
  #
  # a_zooomr_api => a ZooomrRestAPI object
  #
  def initialize(a_zooomr_api)
    if (a_zooomr_api.nil?)
      raise ArgumentError, "ZooomrGroups requires a ZooomrAPI object", caller
    end
    @zooomr = a_zooomr_api
  end
  
  # Get info about a group
  #
  # Required Parameters:
  # * group_id => id of the group you want info for
  #
  # Optional Parameters:
  # * lang => language for response
  #
  def getInfo(a_parameter_hash)
    method = 'zooomr.groups.getInfo'
    
    required_params = ['group_id']
    optional_params = ['lang']
    
    @zooomr.params_are_valid(required_params, optional_params, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_method(method, params)
  end
end
