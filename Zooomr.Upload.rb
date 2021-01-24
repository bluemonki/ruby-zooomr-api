#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/

require 'Zooomr'
require 'rubygems'
require 'mime/types'
require "base64"

# Upload methods - all methods return a ZooomrResponse object
class ZooomrUpload
  
  # Constructor
  #
  # * a_zooomr_api => a ZooomrRestAPI instance
  #
  def initialize(a_zooomr_api)
    if (a_zooomr_api.nil?)
      raise ArgumentError, "ZooomrFavorites requires a ZooomrAPI object", caller
    end
    @zooomr = a_zooomr_api
  end
  
  #  Upload a photo to Zooomr
  #
  #  Required Parameters:
  #  * filename => Filename of the file to upload
  #  * auth_token + Your auth token
  #  Optional Parameters:
  #  * title  => Title for image
  #  * description => Description for image
  #  * tags  => An array of tags to apply to the photo.
  #  * is_public, is_friend, is_family  => Set to 0 for no, 1 for yes. Specifies who can view the photo.
  #  * safety_level => Set to 1 for Safe, 2 for Moderate, or 3 for Restricted.
  #  * content_type => Set to 1 for Photo, 2 for Screenshot, or 3 for Other.
  #  * hidden => Set to 1 to keep the photo in global search results, 2 to hide from public searches.
  #  
  def uploadPhoto(a_parameters_hash)
    
    required_params = [ 'filename', 'auth_token']
    optional_params = [ 'title', 'description', 'tags', 'is_public', 'is_friend', 'is_family', 'safety_level', 'content_type', 'hidden']
    
    params = {  'api_key'         => @zooomr.api_key,
                'format'          => 'json',
                'nojsoncallback'  => 1,
             }
    
    a_filename        = a_parameters_hash['filename']
    file              = File.open(a_filename).binmode #photo data
    
    @zooomr.params_are_valid(required_params, optional_params, a_parameters_hash)
    a_parameters_hash.delete('filename')
    
    if (a_parameters_hash.has_key?('tags'))
      if (!(a_parameters_hash['tags'].is_a?(Array)))
        raise ArgumentError, "Upload:: tags should be an array!", caller
      end 
    end
    
    ascii_url = 'http://upload.zooomr.com/services/upload/'
    
    params = params.merge(a_parameters_hash)
    
    # create the post request
    post_boundary = "---------------------------7d44e178b0434"
    post_data     = ""
    params.sort.each do |key, value|
      post_data += "--" + post_boundary + "\r\n"
      post_data += "Content-Disposition: form-data; name=\"" + key + "\"\r\n\r\n"
      post_data += value.to_s + "\r\n"
    end
     
    api_sig           = @zooomr.create_signature(params)
    params['api_sig'] = api_sig
    params['photo']   = file.read
    
    post_data += "--" + post_boundary + "\r\n"
    post_data += "Content-Disposition: form-data; name=\"api_sig\"\r\n\r\n"
    post_data += api_sig + "\r\n"

    # add the photo data
    post_data += "--" + post_boundary + "\r\n"
    post_data += "Content-Disposition: form-data; name=\"photo\"; filename=\""+a_filename+"\"\r\n"
    post_data += "Content-Transfer-Encoding: binary\r\n"
    post_data += "Content-Type: "
    post_data += MIME::Types.type_for(a_filename).to_s 
    post_data += "\r\n\r\n"
    post_data += params['photo'] + "\r\n"
    post_data += "--" + post_boundary + "--"
    
    url = URI.parse(ascii_url)
    http = Net::HTTP.new(url.host)
    response, body = http.post(url.path,
                               post_data,                                   
                              {'Content-type'=>'multipart/form-data; boundary=' + post_boundary})
    
    puts "RESPONSE: " + body
    
    #  jsonZooomrApi({"ticket": {"_content": "1vl8zc-15k-50N-2M-3b-16d2Hjj1y"}, "stat": "ok", "photoid": {"_content": 4808881}, "secret": {"_content": "9a472d5d15"}});
    body =~ /jsonZooomrApi\((.*?)\);/
    body_without_callback = $1
    resp_hash = JSON.parse(body_without_callback)

    return ZooomrResponse.new(resp_hash)
  end
end
