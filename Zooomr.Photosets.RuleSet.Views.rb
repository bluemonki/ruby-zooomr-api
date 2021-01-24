#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/

require 'Zooomr.Photosets.RuleSet'

# A Views rule for a photoset
class ZooomrPhotosetsRuleSetViews < ZooomrPhotosetsRuleSetBase
  
  attr_accessor :match_test, :match_type, :match_args
  
  # Match tests
  EQUALTO           = "1"
  NOTEQUALTO        = "16"
  GREATERTHAN       = "32"
  LESSTHAN          = "64"
  
  # Constructor
  #
  # Required Parameters:
  # * match_test - one the provided constants above
  # * views - the number of views to test against
  #
  # Returns:
  # * a new object to be added to the ZooomrPhotosetRuleSet object
  #
  def initialize(a_parameter_hash)
    
    required_params = ['match_test', 'views']
    
    ZooomrPhotosetsRuleSet.params_are_valid(required_params, nil, a_parameter_hash)
    
    unless (
              (a_parameter_hash['match_test'] == ZooomrPhotosetsRuleSetViews::EQUALTO) or
              (a_parameter_hash['match_test'] == ZooomrPhotosetsRuleSetViews::NOTEQUALTO) or
              (a_parameter_hash['match_test'] == ZooomrPhotosetsRuleSetViews::GREATERTHAN) or
              (a_parameter_hash['match_test'] == ZooomrPhotosetsRuleSetViews::LESSTHAN)
            )
        raise ArgumentError, "ZooomrPhotosetsRuleSetView: a_match constant not a recognised value", caller
      end
      
    @match_test = a_parameter_hash['match_test']
    @match_type = ZooomrPhotosetsRuleSet::PHOTOSETMATCH_VIEWS
    @match_args = a_parameter_hash['views']
  end
end
