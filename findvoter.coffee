config = require './config'
processor = require('./processesrecords')()
fs = require 'fs'

lines = fs.readFileSync('data/WARREN.TXT').toString().split('\n').map (line) -> line.replace '\r',''
key = lines[0]
lines = lines.slice 1, lines.length-1

all = processor.process lines, key

exports.byId = (voterid) ->
  matches = all.filter (item) ->
    item.id == voterid

  if matches.length > 0 then matches[0] else {}

exports.find = (criteria) ->
  part = criteria.toLowerCase()

  results = all.filter (item) ->
    item.lastName.toLowerCase().indexOf(part) > -1

  last = config.resultslimit-1
  results.slice(0, last)

