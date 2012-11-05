line1 = ',,,CROMWELL,RYAN,,,,R'
line2 = ',,,FROCK,JEANNINE,,,,D'
lines = [line1,line2]

sut = require '../processesrecords'

describe 'processesrecords', ->
  it 'turns lines into an array', ->
    expect(sut(lines).length).toBe 2

  it 'turns em into voters', ->
    names = sut(lines).map (voter) ->
      voter.lastName

    expect(names).toEqual ['CROMWELL', 'FROCK']
