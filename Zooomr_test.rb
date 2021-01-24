#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/

require 'Zooomr'

zooomr = ZooomrRestAPI.new('APIKEY', 'SHAREDSECRET')

token = 'TOKENSTRING'

frob = zooomr.auth.getFrob()

# check to see if we need to get authorisation
response = zooomr.auth.checkToken('auth_token' => token)
#response = false

if (false.eql?(response))
    
  link_hash = zooomr.authenticate_application('perms' => "write")

  puts "Follow this to authenticate: " + link_hash['link']

  gets

  info_hash = zooomr.complete_authentication('frob' => link_hash['frob'])
  
else
  
  json_resp = response.json_response
  token = json_resp['auth']['_content']['token']
    

  user      = json_resp['auth']['_content']['user']
  user_id   = user['nsid']
  username  = user['username']
  fullname  = user['fullname']
  
  puts "NSID: " + user_id + ", USERNAME: " + username + ", FULLNAME: " + fullname
  
end

photos = zooomr.people.getPhotos('user_id' => 'bluemonki', 'auth_token' => token).json_response
first_photo_id = photos['photos']['photo'][0]['id'].to_s

puts "First photo id: " + first_photo_id

zooomr.people.getPhotos('user_id' => 'jonward', 'auth_token' => token)

sizes = zooomr.photos.getSizes('photo_id' => first_photo_id, 'auth_token' => token)

info = zooomr.people.getInfo('user_id' => "bluemonki")

groups = zooomr.people.getPublicGroups('user_id' => "jonward")

uploadStatus = zooomr.people.getUploadStatus('auth_token' => token)

# photos
tags = [ "d d", "e e", "f f" ];
tag_resp    = zooomr.photos.addTags('photo_id' => first_photo_id, 'tags' => tags, 'auth_token' => token)
context     = zooomr.photos.getContext('photo_id' => first_photo_id);
favourites  = zooomr.photos.getFavorites('photo_id' => first_photo_id)
photo_info  = zooomr.photos.getinfo('photo_id' => first_photo_id).json_response

dd_tag_id = photo_info['photo']['tags']['tag'][0]['id']
ee_tag_id = photo_info['photo']['tags']['tag'][1]['id']
ff_tag_id = photo_info['photo']['tags']['tag'][2]['id']

recent      = zooomr.photos.getRecent()
#
require 'date'
require 'time'
#
date = Date.today();
datetimenow = DateTime.now();
datetime100daysago = datetimenow - 2;
recentlyupdated = zooomr.photos.recentlyUpdated('min_date' => datetime100daysago, 'auth_token' => token)

zooomr.photos.removeTag('tag_id' => dd_tag_id, 'auth_token' => token)
zooomr.photos.removeTag('tag_id' => ee_tag_id, 'auth_token' => token)
zooomr.photos.removeTag('tag_id' => ff_tag_id, 'auth_token' => token)

results = zooomr.photos.search('query' => "bluemonki")
#zooomr.photos.setMeta('photo_id' => first_photo_id, 'title' => "Using the ZAPI", 'decription' => "This meta info was set using the Zooomr REST API!", 'auth_token' => token)
zooomr.photos.setPerms( 'photo_id'      => first_photo_id,
                        'is_public'     => "1",
                        'is_friend'     => "1",
                        'is_family'     => "1",
                        'perm_comment'  => "3",
                        'perm_addmeta'  => "3",
                        'auth_token'    => token)

# activity
userphotos = zooomr.activity.userPhotos('auth_token' => token)
userphotos = zooomr.activity.userPhotos('auth_token' => token, 'page' => '2', 'timeframe' => '20d', 'per_page' => '5')

# contacts
contacts = zooomr.contacts.getList('auth_token' => token)
contacts = zooomr.contacts.getList('auth_token' => token, 'filter' => 'both')
public_contacts = zooomr.contacts.getPublicList('user_id' => "bluemonki")

# favorites
zooomr.favorites.add('photo_id' => "4778592", 'auth_token' => token)
favs = zooomr.favorites.getList('auth_token' => token)
favs = zooomr.favorites.getList('auth_token' => token, 'user_id' => 'jonward', 'page' => '2', 'per_page' => '5')
zooomr.favorites.remove('photo_id' => "4778592", 'auth_token' => token)

# groups
groupinfo = zooomr.groups.getInfo('group_id' => "4@Z01", 'lang' => 'de-de')

# comments
comment_res = zooomr.photos.comments.addComment('photo_id' => first_photo_id, 'comment_text' =>"Test Comment", 'auth_token' => token).json_response
comment_id = comment_res['comment']['id']

zooomr.photos.comments.editComment('comment_id' => comment_id, 'comment_text' => "Edited comment", 'auth_token' => token)
comment_list = zooomr.photos.comments.getList('photo_id' => first_photo_id)
zooomr.photos.comments.deleteComment('comment_id' => comment_id, 'auth_token' => token)

# geo
zooomr.photos.geo.setLocation('photo_id' => first_photo_id, 'lat' => '1', 'lon' => '1', 'auth_token' => token)
zooomr.photos.geo.removeLocation('photo_id' => first_photo_id, 'auth_token' => token)

# license
zooomr.photos.licenses.setLicense('photo_id' => first_photo_id, 'license_id' => "5", 'auth_token' => token)

#photo_id_array = [4758854, 4758861, 4758866]
#tags = [ "uploaded via ZAPI", "canon 400D"]

#photo_id_array.each { |photo_id|
#  zooomr.photos.licenses.setLicense(photo_id, "5", token)
#  zooomr.photos.addTags(photo_id, tags, token)
#  }

# test tags with spaces
#tags = [ "uploaded via ZAPI", "canon 400D"];
#zooomr.photos.addTags(4734781, tags, token)


# notes
note_doc      = zooomr.photos.notes.add('photo_id' => first_photo_id, 'note_x' => "0", 'note_y' => "0", 'note_w' => "50", 'note_h' => "50", 'note_text' => "test note", 'auth_token' => token).json_response
note_id       = note_doc['note']['id']
zooomr.photos.notes.edit('note_id' => note_id, 'note_x' => "50", 'note_y' => "50", 'note_w' => "50", 'note_h' => "50", 'note_text' => "edited note text", 'auth_token' => token)
zooomr.photos.notes.delete('note_id' => note_id, 'auth_token' => token)

# transform
zooomr.photos.transform.rotate('photo_id' => first_photo_id, 'degrees' => "90", 'auth_token' => token)

# delete the photo
zooomr.photos.delete('photo_id' => first_photo_id, 'auth_token' => token)

# photosets
# create a rule set object
rule_set = ZooomrPhotosetsRuleSet.new()

# create a label rule object
label_rule = ZooomrPhotosetsRuleSetLabels.new('match_test' => ZooomrPhotosetsRuleSetLabels::MATCHNONEOF, 'labels' => ["bluemonki"])

# create a views rule object
view_rule = ZooomrPhotosetsRuleSetViews.new('match_test' => ZooomrPhotosetsRuleSetViews::GREATERTHAN, 'views' => "100")

# create a people tag rule
peopletag_rule = ZooomrPhotosetsRuleSetPeopleTags.new('match_test' => ZooomrPhotosetsRuleSetPeopleTags::MATCHANYOF, 'people_tags' => ["bluemonki"])

# create a dateuploaded rule
dateuploaded_rule = ZooomrPhotosetsRuleSetDateUploaded.new('date' => date)

# create a datetaken rule
datetaken_rule = ZooomrPhotosetsRuleSetDateTaken.new('date' => date)

# create a geotags rule
geotags_rule = ZooomrPhotosetsRuleSetGeoTags.new('lat' => 51.3827, 'lon' => -2.7191)

# add the rules to the ruleset object
rule_set.addRule('rule' => label_rule)
rule_set.addRule('rule' => view_rule)
rule_set.addRule('rule' => peopletag_rule)
rule_set.addRule('rule' => dateuploaded_rule)
rule_set.addRule('rule' => datetaken_rule)
rule_set.addRule('rule' => geotags_rule)


photoset_doc = zooomr.photosets.create('title'             => "photo set title",
                'description'       => "description",
                'primary_photo_id'  => first_photo_id,
                'ruleset'             => rule_set,
                'context'           => ZooomrPhotosetsContext::PHOTOSFROM_EVERYONE,
                'sortmode'          => ZooomrPhotosetsSortMode::SORTEDBY_AWESOMENESS,
                'auth_token'        => token).json_response
                
#photoset_doc = zooomr.photosets.create("Photoset title",
#                                       "description",
#                                       first_photo_id,
#                                       rule_set,
#                                       ZooomrPhotosetsContext::PHOTOSFROM_EVERYONE,
#                                       ZooomrPhotosetsSortMode::SORTEDBY_AWESOMENESS,
#                                       token)


photoset_id = photoset_doc['photoset']['id']
zooomr.photosets.getInfo('photoset_id' => photoset_id)
zooomr.photosets.getInfo('photoset_id' => "30060")
zooomr.photosets.getList('user_id' => "bluemonki")

zooomr.photosets.edit('photoset_id' => photoset_id, 'title' => "New title", 'primary_photo_id' => first_photo_id, 'auth_token' => token)
zooomr.photosets.getPhotos('photoset_id' => photoset_id)
zooomr.photosets.delete('photoset_id' => photoset_id, 'auth_token' => token)

# tags
photo_tags  = zooomr.tags.getListPhoto('photo_id' => first_photo_id)
user_tags   = zooomr.tags.getListUser('user_id' => "bluemonki")

# test
params = { 'param_name' => "param_value"}
zooomr.test.echo(params)

zooomr.test.login('auth_token' => token)


# test the upload
zooomr.upload.uploadPhoto('filename' => image_path, 'auth_token' => token)

# test zipline
zooomr.zipline.postLine('status' => "Testing zipline from the Zooomr API", 'auth_token' => token)
zooomr.zipline.getLine('auth_token' => token)
