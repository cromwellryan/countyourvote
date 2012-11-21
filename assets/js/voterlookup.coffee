class voterlookup
  constructor: ->
    @reset = []
    @results = []

  find: (criteria) ->
    firereset.call this
    fireresults.call this

  onreset: (subscriber) ->
    @reset.push subscriber

  onresults: (subscriber) ->
    @results.push subscriber

  firereset = ->
    fire.call this, @reset

  fireresults = ->
    fire.call this, @results

  fire = (subscribers) ->
    for subscriber in subscribers
      do (subscriber) ->
        subscriber this, null

exports = module.exports = new voterlookup()
