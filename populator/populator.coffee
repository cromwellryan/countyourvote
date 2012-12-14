async = require 'async'
class Populator 
  populate: (destination, items, callback) ->

    series = items.map (item) ->
      ( (c) ->
        destination.receive item, c)

    async.series series, callback

exports = module.exports = -> 
  new Populator()


