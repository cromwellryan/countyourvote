key = 'a,b,c,Last,First,d,e,f,Affiliation'
line1 = ',,,CROMWELL,RYAN,,,,R'
line2 = ',,,FROCK,JEANNINE,,,,D'
lines = [line1,line2]

processesrecords = require '../../populator/processesrecords'

describe 'processesrecords', ->
  sut = processesrecords()

  it 'turns lines into an array', ->
    expect(sut.process(lines,key).length).toBe 2

  it 'turns em into voters', ->
    names = sut.process(lines,key).map (voter) ->
      voter.lastName

    expect(names).toEqual ['CROMWELL', 'FROCK']
