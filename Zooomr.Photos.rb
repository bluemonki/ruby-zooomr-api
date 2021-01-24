#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/

require 'Zooomr'
require 'date'
require 'Zooomr.Photos.Comments'
require 'Zooomr.Photos.Geo'
require 'Zooomr.Photos.License'
require 'Zooomr.Photos.Notes'
require 'Zooomr.Photos.Transform'

# Photo methods
class ZooomrPhotos
  
  attr_accessor :comments, :geo, :licenses, :notes, :transform
  
  # Constructor
  #
  # a_zooomr_api => a ZooomrRestAPI object
  #
  def initialize(a_zooomr_api)
    if (a_zooomr_api.nil?)
      raise ArgumentError, "ZooomrPeople requires a ZooomrAPI object", caller
    end
    @zooomr     = a_zooomr_api
    @comments   = ZooomrPhotosComments.new(a_zooomr_api)
    @geo        = ZooomrPhotosGeo.new(a_zooomr_api)
    @licenses   = ZooomrPhotosLicense.new(a_zooomr_api)
    @notes      = ZooomrPhotosNotes.new(a_zooomr_api)
    @transform  = ZooomrPhotosTransform.new(a_zooomr_api)
  end

  # Get sizes of an image (contains links)
  #
  # Required Parameters:
  # * photo_id => ID of the photo you want the sizes for
  # * auth_token => your auth token
  #
  def getSizes(a_parameter_hash)
    method = 'zooomr.photos.getSizes'
    
    required_params = ['photo_id', 'auth_token']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_method(method, params)
  end

  # Add tags to a photo
  #
  # Required Parameters:
  # * photo_id => photo to add tags to
  # * tags => array of tags (must be an array)
  # * auth_token => your auth token
  #
  def addTags(a_parameter_hash)
    method = 'zooomr.photos.addTags'
    
    required_params = ['photo_id', 'tags', 'auth_token']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    if (!(a_parameter_hash['tags'].is_a?(Array)))
      raise ArgumentError, "ZooomrPhotos.addTags:: tags must be an array", caller
    end
    
    a_parameter_hash['tags'] = "\"" + a_parameter_hash['tags'].join("\" \"") + "\""
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_post_method(method, params)
  end
  
  # Delete a photo
  #
  # Required Parameters:
  # * photo_id => photo you want to delete
  # * auth_token => your auth token
  #
  def delete(a_parameter_hash)
    method = 'zooomr.photos.delete'
    
    required_params = ['photo_id', 'auth_token']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_post_method(method, params)
  end
  
  # Get next and previous for a photo
  #
  # Required Parameters:
  # * photo_id => photo you want to know next and prev for
  #
  def getContext(a_parameter_hash)
    method = 'zooomr.photos.getContext'
    
    required_params = ['photo_id']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_method(method, params)
  end
  
  # Get favorites for a photo
  #
  # Required Parameters:
  # * photo_id => photo you want the favs for
  #
  # Optional Parameters:
  # * page => page of results you want
  # * per_page => number of results per page
  #
  def getFavorites(a_parameter_hash)
    method = 'zooomr.photos.getFavorites'
    
    required_params = ['photo_id']
    optional_params = ['page', 'per_page']
    
    @zooomr.params_are_valid(required_params, optional_params, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_method(method, params)
  end
  
  # Get info about a photo
  #
  # Required Parameters:
  # * photo_id => photo you want info for
  #
  # Optional Parameters:
  # * secret => secret photo id, perms checking skipped if this is set and correct
  #
  def getinfo(a_parameter_hash)
    method = 'zooomr.photos.getinfo'
    
    required_params = ['photo_id']
    optional_params = ['secret']
    
    @zooomr.params_are_valid(required_params, optional_params, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_method(method, params)
  end
  
  # Get a users recent photos
  #
  # Required Parameters:
  # * none
  #
  # Optional Parameters:
  # * extras => extra info to return
  # * page => page of results
  # * per_page => number of results per page
  #
  def getRecent(a_parameter_hash = nil)
    method = 'zooomr.photos.getRecent'
    
    required_params = nil
    optional_params = ['extras', 'page', 'per_page']
    
    @zooomr.params_are_valid(required_params, optional_params, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    
    unless (nil == a_parameter_hash)
      params = params.merge(a_parameter_hash)
    end
    
    return @zooomr.call_method(method, params)
  end
  
  # Get your recently updated photos from a given time
  #
  # Required Parameters:
  # * min_date => ruby date object
  # * auth_token => your auth token
  #
  # Optional Parameters:
  # * extras => extra info to return
  # * page => page of results required
  # * per_page => how many results per page
  #
  def recentlyUpdated(a_parameter_hash)
    
    required_params = ['min_date', 'auth_token']
    optional_params = ['extras', 'page', 'per_page']
    
    @zooomr.params_are_valid(required_params, optional_params, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    
    if (!(a_parameter_hash['min_date'].is_a?(DateTime)))
      raise ArgumentError, "zooomr.photos.recentlyUpdated requires a DateTime object for min_date", caller
    end
  
    unixtime = Time.local(a_parameter_hash['min_date'].year,
                           a_parameter_hash['min_date'].mon,
                           a_parameter_hash['min_date'].mday,
                           a_parameter_hash['min_date'].hour,
                           a_parameter_hash['min_date'].min,
                           a_parameter_hash['min_date'].sec,
                           a_parameter_hash['min_date'].sec_fraction)

    a_parameter_hash['min_date'] = unixtime.to_i.to_s
    
    params = params.merge(a_parameter_hash)
    
    method = 'zooomr.photos.recentlyUpdated'
    
    return @zooomr.call_method(method, params)
  end
  
  # Remove a tag from a photo
  #
  # Required Parameters:
  # * tag_id => ID of the tag you want to remove
  # * photo_id => ID of the photo you want to remve the tag from
  #
  def removeTag(a_parameter_hash)
    method = 'zooomr.photos.removeTag'
    
    required_params = ['tag_id', 'auth_token']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_post_method(method, params)
  end
  
  # Search photos
  #
  # Required Parameters:
  # * query => query string
  #
  # Optional Parameters:
  # * user_id => search for photos by user_id
  # * extras => extra info to return
  # * page => page of results you want
  # * per_page => how many results per page
  #
  def search(a_parameter_hash)
    method = 'zooomr.photos.search'
    
    required_params = ['query']
    optional_params = ['extras', 'page', 'per_page', 'user_id']
    
    @zooomr.params_are_valid(required_params, optional_params, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_method(method, params)
  end
  
  # Set meta information for a photo
  #
  # Required Parameters:
  # * photo_id => photo you want to set meta info for
  # * title => title
  # * description => description
  # * auth_token => your auth token
  #
  def setMeta(a_parameter_hash)
    method = 'zooomr.photos.setMeta'
    
    required_params = ['photo_id', 'title', 'description', 'auth_token']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_post_method(method, params)
  end

  # Set permissions for a photo
  #
  # Required Parameters:
  # * photo_id => photo to set perms on
  # * is_public => 0 or 1
  # * is_friend => 0 or 1
  # * is_family => 0 or 1
  # * perm_comment => who can add comments: 0, 1, 2, 3
  # * perm_addmeta => who can add notes/tags: 0, 1, 2, 3
  # * auth_token => your auth token
  #
  def setPerms(a_parameter_hash)
    method = 'zooomr.photos.setPerms'
    
    required_params = ['photo_id', 'is_public', 'is_friend', 'is_family', 'perm_comment', 'perm_addmeta', 'auth_token']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
   
    return @zooomr.call_post_method(method, params)
  end
  
end

