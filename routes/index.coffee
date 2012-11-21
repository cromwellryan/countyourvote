config = require '../config'

exports.index = (req, res) -> 
  res.render 'index', title: config.appname, app: config.appname
