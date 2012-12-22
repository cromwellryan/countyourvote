class Voter
  votingrecord: []

  constructor: (init) ->
    if init?
      for key, value of init
        @[key] = value

  fullName: =>
    @firstName + ' ' + @lastName

exports = module.exports = (init) ->
  new Voter(init)

