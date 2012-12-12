class Populator 
  populate: (destination, items, callback) ->
    destination.receive item for item in items
    callback() if callback?

exports = module.exports = -> 
  new Populator()


