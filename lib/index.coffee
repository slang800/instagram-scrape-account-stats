request = require 'request-promise'

getAccountStats = ({username}) ->
  if not username? then throw new Error('A username needs to be passed')
  uri = "https://instagram.com/#{username}/?__a=1"

  request.get(
    uri: uri
  ).then((resp) ->
    data = JSON.parse(resp).user

    return {
      description: data.biography
      followers: data['followed_by'].count
      following: data.follows.count
      isExplicit: false # Instagram bans this
      isPrivate: data['is_private']
      isVerified: data['is_verified']
      name: data['full_name']
      userId: data.id
      username: data.username
      posts: data.media.count
      website: data['external_url']
    }
  )
    .catch((err) ->
      if err.statusCode == 404 then throw new Error('Username not found')

      throw err
  )

module.exports = {getAccountStats}
