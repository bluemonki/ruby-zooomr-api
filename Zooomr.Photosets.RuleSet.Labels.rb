#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/

require 'Zooomr.Photosets.RuleSet'

# Label rule object for a photoset
class ZooomrPhotosetsRuleSetLabels<ZooomrPhotosetsRuleSetBase
  
  attr_accessor :match_test, :match_type, :match_args
  
  # Match tests
  MATCHALLOF         = "2"
  MATCHANYOF         = "4"
  MATCHNONEOF        = "8"

  # Constructor
  #
  # Required Parameters:
  # * match_test - one the provided constants above
  # * labels - array of labels to test against
  #
  # Returns:
  # * a new object to be added to the ZooomrPhotosetRuleSet object
  #
  def initialize(a_parameter_hash)
    
    required_params = ['match_test', 'labels']
    
    ZooomrPhotosetsRuleSet.params_are_valid(required_params, nil, a_parameter_hash)
    
    unless (
              (a_parameter_hash['match_test'] == ZooomrPhotosetsRuleSetLabels::MATCHALLOF) or
              (a_parameter_hash['match_test'] == ZooomrPhotosetsRuleSetLabels::MATCHANYOF) or
              (a_parameter_hash['match_test'] == ZooomrPhotosetsRuleSetLabels::MATCHNONEOF)
            )
        raise ArgumentError, "ZooomrPhotosetsRuleSetLabel: match_test not a recognised value", caller
    end
    
    unless ( a_parameter_hash['labels'].is_a?(Array) )
      raise ArgumentError, "ZooomrPhotosetsRuleSetLabel: match_args must be an array", caller
    end
      
    @match_test = a_parameter_hash['match_test']
    @match_type = ZooomrPhotosetsRuleSet::PHOTOSETMATCH_LABEL
    @match_args = a_parameter_hash['labels'].join(",")
  end
end
