populator = require '../../populator/populator'

describe 'populator', ->
  it 'sends all to destination', ->
    destination = new FakeDestination()

    isdone = false
    items = [{}, {}, {}]

    populator = populator()

    populator.populate destination, items, ->
      isdone = true

    waitsFor (-> return isdone), 'Never done', 1000

    expect(destination.received).toBe 3

class FakeDestination
  constructor: ->
    @received = 0

  receive: (voter) ->
    @received++
