#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/

require 'Zooomr.Photosets.RuleSet'

# DateTaken rule for a photoset
class ZooomrPhotosetsRuleSetDateTaken < ZooomrPhotosetsRuleSetBase
  
  attr_accessor :match_test, :match_type, :match_args
  
  # Constructor
  #
  # Required Parameters:
  # * date - a ruby Date object
  # 
  # Returns:
  # * a new object to be added to the ZooomrPhotosetRuleSet object
  #
  def initialize(a_parameter_hash)
    
    required_params = ['date']
    
    ZooomrPhotosetsRuleSet.params_are_valid(required_params, nil, a_parameter_hash)
    
    if (!(a_parameter_hash['date'].is_a?(Date)))
      raise ArgumentError, "ZooomrPhotosetsRuleSetDateTaken: requires a Date object for date", caller
    end
  
    unixtime = Time.local(a_parameter_hash['date'].year,
                           a_parameter_hash['date'].mon,
                           a_parameter_hash['date'].mday
                           )
    
    @match_test = "0" # no match test for Date Uploaded
    @match_type = ZooomrPhotosetsRuleSet::PHOTOSETMATCH_DATETAKEN
    @match_args = unixtime.to_i.to_s
  end
end
