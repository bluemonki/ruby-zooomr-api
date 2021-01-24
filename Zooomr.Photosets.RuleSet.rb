#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/

# Base object for photoset rules - don't construct
class ZooomrPhotosetsRuleSetBase
  
  def initialize()
    raise ArgumentError, "ZooomrPhotosetsRuleSetBase: don't construct me I'm just a base class!", caller
  end
end

require 'Zooomr.Photosets.RuleSet.Labels'
require 'Zooomr.Photosets.RuleSet.Views'
require 'Zooomr.Photosets.RuleSet.PeopleTags'
require 'Zooomr.Photosets.RuleSet.DateUploaded'
require 'Zooomr.Photosets.RuleSet.DateTaken'
require 'Zooomr.Photosets.RuleSet.GeoTags'

# RuleSet object, add ZooomrPhotosetsRuleSetLabels, ZooomrPhotosetsRuleSetViews,
# ZooomrPhotosetsRuleSetPeopleTags, ZooomrPhotosetsRuleSetGeoTags, ZooomrPhotosetsRuleSetDateUploaded,
# ZooomrPhotosetsRuleSetDateTaken objects to this and then use it in the construction of a photoset
#
# You can only have one of each!
class ZooomrPhotosetsRuleSet
  
  # Match categories
  PHOTOSETMATCH_PEOPLETAG    = "0"
  PHOTOSETMATCH_LABEL        = "1"
  PHOTOSETMATCH_DATEUPLOADED = "2"
  PHOTOSETMATCH_VIEWS        = "6"
  PHOTOSETMATCH_GEO          = "7"
  PHOTOSETMATCH_DATETAKEN    = "8"

  attr_accessor :rule_array
  # Constructor - takes no arguments
  def initialize()
    @rule_array = Array.new(9)
  end
  
  # Add a rule
  #
  # Required Parameters:
  # * rule => one of ZooomrPhotosetsRuleSetLabels, ZooomrPhotosetsRuleSetViews, ZooomrPhotosetsRuleSetPeopleTags, ZooomrPhotosetsRuleSetGeoTags, ZooomrPhotosetsRuleSetDateUploaded, ZooomrPhotosetsRuleSetDateTaken
  #
  def addRule(a_parameter_hash)
    required_params = ['rule']
    
    ZooomrRestAPI.params_are_valid(required_params, nil, a_parameter_hash)
    
    if (!(a_parameter_hash['rule'].is_a?(ZooomrPhotosetsRuleSetBase)))
      raise ArgumentError, "ZooomrPhotosetsRuleSet.addRule only takes a ZooomrPhotosetsRuleSetBase derived object!", caller
    end
    
    @rule_array[a_parameter_hash['rule'].match_type.to_i] = a_parameter_hash['rule'];
  end
  
  # Another wrapper that just calls ZooomrRestAPI.params_are_valid
  def ZooomrPhotosetsRuleSet.params_are_valid(a_array_of_required_params = (), a_array_of_extra_allowed_param_names = (), a_hash_of_params_and_values = {})
    ZooomrRestAPI.params_are_valid(a_array_of_required_params, a_array_of_extra_allowed_param_names, a_hash_of_params_and_values)
  end
  
end



