Voter = require '../votermodel'

class MongoDestination
  receive: (item, callback) ->
    if not item.id? 
      callback('We need an Id man') if callback?
    else
      Voter.update {id: item.id}, item, {upsert: true}, (err) ->
        callback err, item if callback?

exports = module.exports = ->
  new MongoDestination()
