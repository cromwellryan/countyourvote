mongoose = require 'mongoose'
processor = require('./processesrecords')()
fs = require 'fs'
async = require 'async'
config = require './config'
Voter = require './votermodel'

console.log 'pulling lines'
lines = fs
  .readFileSync('data/WARREN.TXT')
  .toString()
  .split('\n')
  .map (line) -> line.replace '\r',''

key = lines[0]
lines = lines.slice 1, lines.length - 1
console.log 'done ' + (lines.length - 1)

console.log 'processing'
all = processor.process lines, key
console.log 'done'

createandsave = (item, callback) ->
  Voter.update {id: item.id}, item, {upsert: true}, (err) ->
    callback err, item

creators = all.map (item) ->
  ( (callback) ->
    createandsave item, callback)


console.log 'saving all'
async.parallel creators, (err, results) ->
  console.log ('error: ' + err) if err?
  console.log 'done'
