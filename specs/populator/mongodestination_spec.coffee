mongodestination = require '../../populator/mongodestination'
Voter = require '../../votermodel'

describe 'MongoDestination', ->
  beforeEach ->
    Voter.collection.remove()
  destination = mongodestination()
  it 'will be pissed without an id', ->
    cont = false
    lasterr = null
    destination.receive {}, (err,data) ->
      lasterr = err
      cont = true

    waitsFor -> 
      cont

    runs ->
      expect(lasterr).toBe 'We need an Id man'

  it 'will save things to Voter db', ->
    lastcount = -1
    isdone = false
    destination.receive {id: 123, name:'Jimmy John'}, (err,data) ->
      console.log ('receive err ' + err) if err?
      isdone = true if err?

      Voter.count {id: 123}, (err, count) ->
        console.log ('count err ' + err) if err?
        lastcount = count 
        isdone = true
      
    waitsFor -> 
      return isdone

    runs ->
      expect(lastcount).toBe 1

