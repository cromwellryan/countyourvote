class Voter

  constructor: (init) ->
    if init?
      for key, value of init
        @[key] = value
    @votingrecord = []

  fullName: =>
    @firstName + ' ' + @lastName

exports = module.exports = (init) ->
  new Voter(init)

