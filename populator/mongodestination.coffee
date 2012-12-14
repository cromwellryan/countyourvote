Voter = require '../voter'

class MongoDestination
  receive: (item, callback) ->
    if not item.id? 
      callback('We need an Id man') if callback?
    else
      item.save (err) ->
        callback err, item if callback?

exports = module.exports = ->
  new MongoDestination()
