#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/

require 'Zooomr.Photosets.RuleSet'

# A PeopleTag rule for a photoset
class ZooomrPhotosetsRuleSetPeopleTags < ZooomrPhotosetsRuleSetBase
  
  attr_accessor :match_test, :match_type, :match_args
  
  # Match tests
  MATCHALLOF         = "2"
  MATCHANYOF         = "4"
  MATCHNONEOF        = "8"

  # Constructor
  #
  # Required Parameters:
  # * match_test - one the provided constants above
  # * people_tags - array of people tags to test against
  #
  # Returns:
  # * a new object to be added to the ZooomrPhotosetRuleSet object
  #
  def initialize(a_parameter_hash)
    
    required_params = ['match_test', 'people_tags']
    
    ZooomrPhotosetsRuleSet.params_are_valid(required_params, nil, a_parameter_hash)
    
    unless (
              (a_parameter_hash['match_test'] == ZooomrPhotosetsRuleSetPeopleTags::MATCHALLOF) or
              (a_parameter_hash['match_test'] == ZooomrPhotosetsRuleSetPeopleTags::MATCHANYOF) or
              (a_parameter_hash['match_test'] == ZooomrPhotosetsRuleSetPeopleTags::MATCHNONEOF)
            )
        raise ArgumentError, "ZooomrPhotosetsRuleSetPeopleTags: a_match constant not a recognised value", caller
    end
    
    unless ( a_parameter_hash['people_tags'].is_a?(Array) )
      raise ArgumentError, "ZooomrPhotosetsRuleSetLabel: match_args must be an array", caller
    end
      
    @match_test = a_parameter_hash['match_test']
    @match_type = ZooomrPhotosetsRuleSet::PHOTOSETMATCH_PEOPLETAG
    @match_args = a_parameter_hash['people_tags'].join(",")
  end
end
