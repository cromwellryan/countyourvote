allrecords = require './processesrecords'
fs = require 'fs'

lines = fs.readFileSync('data/WARREN.TXT').toString().split('\n')
lines = lines.slice 1, lines.length-1

all = allrecords lines

exports.byId = (voterid) ->
  matches = all.filter (item) ->
    item.id == voterid

  if matches.length > 0 then matches[0] else {}

exports.find = (criteria) ->
  part = criteria.toLowerCase()

  all.filter (item) ->
    item.lastName.toLowerCase().indexOf(part) > -1

