populator = require('../../populator')()
findvoter = require '../../findvoter'
config = require '../../config'
withcollection = require '../../querycollection'

describe 'end 2 end', ->

  beforeEach ->
    done = false

    populator.populatewith "#{__dirname}/scenarios/scenario1.txt", (err, results)->
      console.log err if err?
      done = true

    waitsFor -> 
      done

  it 'can search for people imported', ->
    runs ->
      findvoter.find "Cromwell", (err, results) ->
        console.log err if err?
        expect(results.length).toBe(1)
        expect(results[0].lastName).toBe("CROMWELL")

  it 'will limit results', ->
    previously = config.resultslimit
    config.resultslimit = 2

    runs ->
      findvoter.find " ", (err, results) ->
        console.log err if err?
        expect(results.length).toBe(2)
        config.resultslimit = previously

  afterEach ->
    done = false

    withcollection.use config.voterdb, config.votercollection, (collection, finished) ->
      collection.remove (err, result) ->
        console.log err if err?
        finished()
        done = true

    waitsFor -> 
      done
