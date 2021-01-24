#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/

require 'Zooomr.Photosets.RuleSet'

# GeoTag rule for a photoset
class ZooomrPhotosetsRuleSetGeoTags < ZooomrPhotosetsRuleSetBase
  
  attr_accessor :match_test, :match_type, :match_args

  # Constructor
  #
  # Required Parameters:
  # * lat - latitude
  # * lon - longitude
  #
  # Optional Parameters:
  # * map_zoom_level - Zoom level for the map displayed next to the photoset
  #
  # Returns:
  # * a new object to be added to the ZooomrPhotosetRuleSet object (defaults to 3)
  #
  def initialize(a_parameter_hash)
      
    required_params = ['lat', 'lon']
    optional_params = ['map_zooom_level']
    
    ZooomrPhotosetsRuleSet.params_are_valid(required_params, optional_params, a_parameter_hash)
    
    if ( ! a_parameter_hash.has_key?('map_zoom_level') )
      a_parameter_hash['map_zoom_level'] = 3
    end
    params = {}
    params = params.merge(a_parameter_hash)
    
    @match_test = "0" # no match constant for GeoTags
    @match_type = ZooomrPhotosetsRuleSet::PHOTOSETMATCH_GEO
    @match_args = "" + a_parameter_hash['lat'].to_s + "," + a_parameter_hash['lon'].to_s + "," + a_parameter_hash['map_zooom_level'].to_s
  end
end
