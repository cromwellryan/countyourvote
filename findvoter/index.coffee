MongoClient = require('mongodb').MongoClient
config = require '../config'

exports.byId = (voterid, callback) ->
  MongoClient.connect config.voterdb, (err, db) ->
    if err?
      callback err
      return

    db.collection config.votercollection, (err, collection) ->
      if err?
        console.log search
        callback err
        return

      collection.findOne({id: voterid}, callback)

exports.find = (criteria, callback) ->
  potential = criteria.split(' ').map (part) ->
    part = part.toUpperCase()

    pattern = ".*" + part + ".*"

    new RegExp(pattern)
  
  matches = {$in: potential}

  if potential.length == 1
    search = { $or: [{lastName: matches}, {firstName: matches}] }
  else
    search = { $and: [{lastName: matches}, {firstName: matches}] }

  MongoClient.connect config.voterdb, (err, db) ->
    if err?
      callback err
      return

    db.collection config.votercollection, (err, collection) ->
      if err?
        console.log search
        callback err
        return

      collection.find(search).limit(config.resultslimit).toArray callback
