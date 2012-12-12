parsesone = require './parsesonerecord'

class Processor
  constructor: ->
    @parser = parsesone()

  process: (lines,key) ->
    @parser.withkey key

    lines.map @parser.record 

exports = module.exports = ->
  new Processor
