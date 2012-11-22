class Voter
  firstName: ""
  lastName: ""
  party: ""
  fullName: ->
    @firstName + " " + @lastName

exports = module.exports = ->
  return new Voter()
