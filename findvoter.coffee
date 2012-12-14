Voter = require './voter'

exports.byId = (voterid, callback) ->
  matches = Voter.findOne {id: voterid}, callback

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

  Voter.find search, (err, results) ->
    console.log err if err?
    callback(err, results)

