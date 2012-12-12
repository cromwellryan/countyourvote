processor = require('./processesrecords')()
fs = require 'fs'
mongodestination = require('./mongodestination')()
populator = require('./populator')()

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

populator.populate mongodestination, all
