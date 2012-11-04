parse = require '../parsesonerecord.coffee'

line1 = 'OH0016715713,83,92360,NORMAN,GARY,BRUCE,,1947,09/24/1969,R,3342  MC INTIRE RD ,   ,MORROW,OH,45152,,,,  P.O. BOX # 211  ,   ,MORROW,OH,45152,,,,WARREN COUNTY JVSD,,,,01,12,WARREN COUNTY EDUC SRV CTR,,,LITTLE MIAMI LOCAL SD,,HAMILTON TWP J,83AGS,04,62,07,HAMILTON TOWNSHIP,,,R,X,,,R,X,,,R,X,,,,X,,,X,,,,,,,,X,,,,,,X,R,,,X,X,,X,R'

line2 = 'OH0016737419,83,101710,STEWARD,JONATHAN,STEVEN,,1962,04/17/1980,R,1521  GARFIELD PARK BLVD ,   ,LEBANON,OH,45036,,,,  P.O. BOX 513  ,   ,LEBANON,OH,45036,,,,WARREN COUNTY JVSD,LEBANON CITY,LEBANON CITY SD,,01,12,,,,,LEBANON,LEBANON CITY A,83AAP,04,54,07,LEBANON CITY PAPER,,,R,X,,X,,X,,X,R,X,,,,X,,R,X,,,,,,R,,X,,,,,,X,R,,,X,,,X,'

describe 'parses stuff', ->
  it 'turns 69-119 into last name', ->
    expect(parse.record(line1).lastName).toBe('NORMAN')
    expect(parse.record(line2).lastName).toBe('STEWARD')

  it 'pulls out first name', ->
    expect(parse.record(line1).firstName).toBe('GARY')

  it 'pulls out party affiliation', ->
    expect(parse.record(line2).party).toBe('Republican Party')
