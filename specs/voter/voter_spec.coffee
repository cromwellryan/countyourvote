voter = require '../../voter'

describe 'Voter', ->
  it 'can be created', ->
    voter()

  it 'has a full name', ->
    v = voter( firstName: 'Ryan', lastName: 'Cromwell' )

    expect(v.fullName()).toBe 'Ryan Cromwell'

  it 'has election results', ->
    v = voter()

    expect(v.votingrecord).toBeDefined()

  it 'can have election record', ->
    v1 = voter()
    v1.votingrecord.push {
      electiontype: 'qwer'
    }
    
    v = voter()

    v.votingrecord.push {
      electiontype: 'asdf'
      held: new Date()
      voted: 'Yes'
    }

    expect(v.votingrecord[0].electiontype).toBe 'asdf'
