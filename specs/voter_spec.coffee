voter = require '../voter'

describe 'Voter', ->
  it 'can be created', ->
    voter()

  it 'has a full name', ->
    voter = voter( firstName: 'Ryan', lastName: 'Cromwell' )

    expect(voter.fullName()).toBe 'Ryan Cromwell'

  it 'has election results', ->
    voter = voter

    expect(voter.votingrecord).toBeDefined()

  it 'can have election record', ->
    voter = voter

    voter.votingrecord.push { 
      electiontype: 'asdf',
      held: new Date(), 
      voted: 'Yes' 
    }

    expect(voter.votingrecord[0].electiontype).toBe 'asdf'
