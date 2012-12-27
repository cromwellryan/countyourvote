populator = require('../../populator')()
findvoter = require '../../findvoter'
config = require '../../config'

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

    MongoClient = require('mongodb').MongoClient
    MongoClient.connect config.voterdb, (err, db) ->
      console.log err if err?
      db.collection config.votercollection, (err, collection) ->
        console.log err if err?
        collection.remove (err, result) ->
          done = true

    waitsFor -> 
      done
