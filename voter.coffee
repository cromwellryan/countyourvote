class Voter
  firstName: ""
  lastName: ""
  party: ""
  fullName: ->
    @firstName + " " + @lastName
  city: ""

exports = module.exports = ->
  return new Voter()
