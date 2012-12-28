config = require '../config'
withcollection = require '../withcollection'

exports.byId = (voterid, callback) ->
  withcollection.use config.voterdb, config.votercollection, (collection, finished) ->
    collection.findOne {id: voterid}, (err, results) ->
      callback err, results
      finished()

exports.find = (criteria, callback) ->

  potential = criteria.split(' ').map (part) ->
    part = part.toUpperCase()

    new RegExp("^#{part}")
  
  matches = {$in: potential}

  if potential.length == 1
    search = { $or: [{lastName: matches}, {firstName: matches}] }
  else
    search = { $and: [{lastName: matches}, {firstName: matches}] }

  withcollection.use config.voterdb, config.votercollection, (collection, finished) ->
    collection.find(search).limit(config.resultslimit).toArray (err, results) ->
      callback err, results
      finished()
