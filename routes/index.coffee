config = require '../config'
findvoter = require '../findvoter'

exports.index = (req, res) -> 
  res.render 'index', title: config.appname, app: config.appname, resultslimit: config.resultslimit

exports.voters = (req, res) ->
  res.json findvoter.find req.query.q

exports.voter = (req, res) ->
  voter = findvoter.byId req.params.voterid
  title = config.appname + " - " + voter.fullName()
  res.render 'voter', {title: title, app: config.appname, voter: voter}
