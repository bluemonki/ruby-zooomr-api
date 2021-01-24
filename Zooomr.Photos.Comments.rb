#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/

require 'Zooomr'

# Manipulate comments for photos
class ZooomrPhotosComments
  
  # Constructor
  #
  # a_zooomr_api => a ZooomrRestAPI object
  #
  def initialize(a_zooomr_api)
    if (a_zooomr_api.nil?)
      raise ArgumentError, "ZooomrPhotosComments requires a ZooomrAPI object", caller
    end
    @zooomr = a_zooomr_api
  end
  
  # Add a comment to a photo
  #
  # Required Parameters:
  # * photo_id => a photo to add a comment for
  # * comment_text => comment
  # * auth_token => your auth token
  #
  def addComment(a_parameter_hash)
    method = 'zooomr.photos.comments.addComment'
    
    required_params = ['auth_token', 'photo_id', 'comment_text']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_post_method(method, params)
  end
  
  # delete a comment
  #
  # Required Parameters:
  # * comment_id => comment to delete
  # * auth_token => your auth token
  #
  def deleteComment(a_parameter_hash)
    method = 'zooomr.photos.comments.deleteComment'
    
    required_params = ['comment_id', 'auth_token']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_post_method(method, params)
  end
  
  # Edit a comment
  #
  # Required Parameters:
  # * comment_id => comment to edit
  # * comment_text => new comment text
  # * auth_token => your auth token
  #
  def editComment(a_parameter_hash)
    method = 'zooomr.photos.comments.editComment'
    
    required_params = ['comment_id', 'auth_token', 'comment_text']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_post_method(method, params)
  end
  
  # Get a list of comments for a photo
  #
  # Required Parameters:
  # * photo_id => photo you want the comments for
  #
  def getList(a_parameter_hash)
    method = 'zooomr.photos.comments.getList'
    
    required_params = ['photo_id']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_post_method(method, params)
  end

end
