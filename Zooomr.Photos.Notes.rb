#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/
require 'Zooomr'

# Manipulate notes on photos
class ZooomrPhotosNotes
  def initialize(a_zooomr_api)
    if (a_zooomr_api.nil?)
      raise ArgumentError, "ZooomrPhotosNotes requires a ZooomrAPI object", caller
    end
    @zooomr = a_zooomr_api
  end
  
  # Add a note to a photo
  #
  # Required Parameters:
  # * photo_id => a photo to add a note to
  # * note_text => text of the note
  # * note_x => The left coordinate of the note
  # * note_y => The top coordinate of the note
  # * note_w => The width of the note
  # * note_h => The height of the note
  # * auth_token => your auth token
  #
  def add(a_parameter_hash)
    method = 'zooomr.photos.notes.add'
    
    required_params = ['photo_id', 'note_x', 'note_y', 'note_w', 'note_h', 'note_text', 'auth_token']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_post_method(method, params)
  end
  
  # Edit a note on a photo
  #
  # Required Parameters:
  # * note_id => note to edit
  # * note_text => text of the note
  # * note_x => The left coordinate of the note
  # * note_y => The top coordinate of the note
  # * note_w => The width of the note
  # * note_h => The height of the note
  # * auth_token => your auth token
  #
  def edit(a_parameter_hash)
    method = 'zooomr.photos.notes.edit'
    
    required_params = ['note_id', 'note_x', 'note_y', 'note_w', 'note_h', 'note_text', 'auth_token']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    
    return @zooomr.call_post_method(method, params)
  end
  
  # delete a note
  #
  # Required Parameters:
  # * note_id => note to delete
  # * auth_token => your auth token
  #
  def delete(a_parameter_hash)
    method = 'zooomr.photos.notes.delete'
    
    required_params = ['note_id', 'auth_token']
    
    @zooomr.params_are_valid(required_params, nil, a_parameter_hash)
    
    params = {  'api_key'     => @zooomr.api_key }
    params = params.merge(a_parameter_hash)
    return @zooomr.call_post_method(method, params)
  end
  
end
