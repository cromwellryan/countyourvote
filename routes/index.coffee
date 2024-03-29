config = require '../config'
findvoter = require '../findvoter'

exports.index = (req, res) -> 
  res.render 'index', title: config.appname, app: config.appname, resultslimit: config.resultslimit

exports.voters = (req, res) ->
  findvoter.find req.query.q, (err, results) ->
    console.log err if err?
    res.json results

exports.voter = (req, res) ->
  findvoter.byId req.params.voterid, (err, voter) ->
    console.log err if err?
    title = "#{config.appname} - #{voter.lastName}"
    votervm = 
      friendlyName: voter.firstName +  " " + voter.lastName
      affiliation: voter.party
      voterid: voter.id
      city: voter.city
      recentElections:  voter.votingrecord.concat().reverse((record) -> record.date).slice 0,9

    res.render 'voter', 
      title: title
      app: config.appname
      voter: votervm
