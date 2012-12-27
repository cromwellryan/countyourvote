populator = require('./populator')()

populator.populatewith "#{__dirname}/data/WARREN.TXT", (err, result) ->
  console.log err if err?


