Voter = require '../voter'

describe 'Voter', ->
  it 'can be created', ->
    new Voter()

  it 'has a full name', ->
    voter = new Voter({ 
      firstName: 'Ryan'
      lastName: 'Cromwell'
    })

    expect(voter.fullName()).toBe 'Ryan Cromwell'

  it 'has election results', ->
    voter = new Voter

    expect(voter.votingrecord).toBeDefined()

  it 'can have election record', ->
    voter = new Voter

    voter.votingrecord.push { 
      electiontype: 'asdf',
      held: new Date(), 
      voted: 'Yes' 
    }

    expect(voter.votingrecord[0].electiontype).toBe 'asdf'
