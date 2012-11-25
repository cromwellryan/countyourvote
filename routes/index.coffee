config = require '../config'
findvoter = require '../findvoter'

exports.index = (req, res) -> 
  res.render 'index', title: config.appname, app: config.appname, resultslimit: config.resultslimit

exports.voters = (req, res) ->
  res.json findvoter.find req.query.q

exports.voter = (req, res) ->
  voter = findvoter.byId req.params.voterid
  title = config.appname + " - " + voter.fullName()
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
