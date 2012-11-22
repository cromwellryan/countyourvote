allrecords = require './processesrecords'
fs = require 'fs'

lines = fs.readFileSync('data/WARREN.TXT').toString().split('\n')

exports.byId = (voterid) ->
  matches = allrecords(lines).filter (item) ->
    item.id == voterid

  if matches.length > 0 then matches[0] else {}
