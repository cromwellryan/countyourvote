parsesone = require './parsesonerecord'

class Processor
  process: (lines,key) ->
    parser = parsesone()

    parser.withkey key

    lines.map (line) ->
      parser.record line

exports = module.exports = ->
  new Processor
