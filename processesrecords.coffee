parsesone = require './parsesonerecord'

exports = module.exports = (lines) ->
  lines.map parsesone.record
