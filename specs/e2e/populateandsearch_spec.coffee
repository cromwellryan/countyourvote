populator = require('../../populator')()
findvoter = require '../../findvoter'
config = require '../../config'

describe 'e2e', ->

  it 'scenario 1', ->
    cont = false

    populator.populatewith "#{__dirname}/scenarios/scenario1.txt", (err, results)->
      console.log err if err?
      cont = true

    waitsFor -> cont

    runs ->
      findvoter.find "Cromwell", (err, results) ->
        console.log err if err?
        expect(results.length).toBe(1)
        expect(results[0].lastName).toBe("CROMWELL")

  afterEach ->
    done = false

    MongoClient = require('mongodb').MongoClient
    MongoClient.connect config.voterdb, (err, db) ->
      console.log err if err?
      db.collection config.votercollection, (err, collection) ->
        console.log err if err?
        collection.remove (err, result) ->
          done = true

    waitsFor -> done
