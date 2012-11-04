line1 = ',,,CROMWELL,RYAN,,,,R'
line2 = ',,,FROCK,JEANNINE,,,,D'
lines = [line1,line2]

p = require '../processesrecords'

describe 'processesrecords', ->
  it 'does that', ->
    expect(p(lines).length).toBe 2

  it 'still does that', ->
    a = p(lines)[0]
    expect(a.lastName).toBe 'CROMWELL'
