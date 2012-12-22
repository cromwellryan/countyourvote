parsesone = require '../../populator/parsesonerecord.coffee'

key = "SOS_VOTERID,COUNTY_NUMBER,COUNTY_ID,LAST_NAME,FIRST_NAME,MIDDLE_NAME,SUFFIX,YEAR_OF_BIRTH,REGISTRATION_DATE,PARTY_AFFILIATION,RESIDENTIAL_ADDRESS1,RESIDENTIAL_SECONDARY_ADDR,RESIDENTIAL_CITY,RESIDENTIAL_STATE,RESIDENTIAL_ZIP,RESIDENTIAL_ZIP_PLUS4,RESIDENTIAL_COUNTRY,RESIDENTIAL_POSTALCODE,MAILING_ADDRESS1,MAILING_SECONDARY_ADDRESS,MAILING_CITY,MAILING_STATE,MAILING_ZIP,MAILING_ZIP_PLUS4,MAILING_COUNTRY,MAILING_POSTAL_CODE,CAREER_CENTER,CITY,CITY_SCHOOL_DISTRICT,COUNTY_COURT_DISTRICT,CONGRESSIONAL_DISTRICT,COURT_OF_APPEALS,EDUCATIONAL_SERVICE_CENTER_DISTRICT,EXEMPTED_VILLAGE_SCHOOL_DISTRICT,LIBRARY,LOCAL_SCHOOL_DISTRICT,MUNICIPAL_COURT_DISTRICT,PRECINCT_NAME,PRECINCT_CODE,STATE_BOARD_OF_EDUCATION,STATE_REPRESENTATIVE_DISTRICT,STATE_SENATE_DISTRICT,TOWNSHIP,VILLAGE,WARD,PRIMARY-03/07/2000,GENERAL-11/07/2000,SPECIAL-05/08/2001,GENERAL-11/06/2001,PRIMARY-05/07/2002,GENERAL-11/05/2002,SPECIAL-05/06/2003,GENERAL-11/04/2003,PRIMARY-03/02/2004,GENERAL-11/02/2004,SPECIAL-02/08/2005,PRIMARY-05/03/2005,PRIMARY-09/13/2005,GENERAL-11/08/2005,SPECIAL-02/07/2006,PRIMARY-05/02/2006,GENERAL-11/07/2006,PRIMARY-05/08/2007,PRIMARY-09/11/2007,GENERAL-11/06/2007,PRIMARY-11/06/2007,GENERAL-12/11/2007,PRIMARY-03/04/2008,PRIMARY-10/14/2008,GENERAL-11/04/2008,GENERAL-11/18/2008,PRIMARY-05/05/2009,PRIMARY-09/08/2009,PRIMARY-09/15/2009,PRIMARY-09/29/2009,GENERAL-11/03/2009,PRIMARY-05/04/2010,PRIMARY-07/13/2010,PRIMARY-09/07/2010,GENERAL-11/02/2010,PRIMARY-05/03/2011,PRIMARY-09/13/2011,GENERAL-11/08/2011,PRIMARY-03/06/2012"

line1 = 'OH0016715713,83,92360,NORMAN,GARY,BRUCE,,1947,09/24/1969,R,3342  MC INTIRE RD ,   ,MORROW,OH,45152,,,,  P.O. BOX # 211  ,   ,MORROW,OH,45152,,,,WARREN COUNTY JVSD,,,,01,12,WARREN COUNTY EDUC SRV CTR,,,LITTLE MIAMI LOCAL SD,,HAMILTON TWP J,83AGS,04,62,07,HAMILTON TOWNSHIP,,,R,X,,,R,X,,,R,X,,,,X,,,X,,,,,,,,X,,,,,,X,R,,,X,X,,X,R'

line2 = 'OH0016737419,83,101710,STEWARD,JONATHAN,STEVEN,,1962,04/17/1980,R,1521  GARFIELD PARK BLVD ,   ,LEBANON,OH,45036,,,,  P.O. BOX 513  ,   ,LEBANON,OH,45036,,,,WARREN COUNTY JVSD,LEBANON CITY,LEBANON CITY SD,,01,12,,,,,LEBANON,LEBANON CITY A,83AAP,04,54,07,LEBANON CITY PAPER,,,D,X,,X,,X,,X,R,X,,,,X,,R,X,,,,,,R,,X,,,,,,X,R,,,X,,,X,'

line3 = 'OH0016737419,83,101710,STEWARD,JONATHAN,STEVEN,,1962,04/17/1980,,1521  GARFIELD PARK BLVD ,   ,LEBANON,OH,45036,,,,  P.O. BOX 513  ,   ,LEBANON,OH,45036,,,,WARREN COUNTY JVSD,LEBANON CITY,LEBANON CITY SD,,01,12,,,,,LEBANON,LEBANON CITY A,83AAP,04,54,07,LEBANON CITY PAPER,,,D,X,,X,,X,,X,R,X,,,,X,,R,X,,,,,,R,,X,,,,,,X,R,,,X,,,X,'

describe 'parses stuff', ->
  parser = parsesone()
  parser.withkey key

  it 'turns 69-119 into last name', ->
    expect(parser.record(line1).lastName).toBe('NORMAN')
    expect(parser.record(line2).lastName).toBe('STEWARD')

  it 'pulls out first name', ->
    expect(parser.record(line1).firstName).toBe('GARY')

  it 'pulls out party affiliation', ->
    expect(parser.record(line2).party).toBe('Republican')

  it 'party affiliation can be not set', ->
    expect(parser.record(line3).party).toBe('')

  it 'pulls primary election record', ->
    expect(parser.record(line1).votingrecord[0].electiontype).toBe 'Primary' #'03/07/2000'
    expect(parser.record(line1).votingrecord[0].voted).toBe 'Republican'
    expect(parser.record(line2).votingrecord[0].voted).toBe 'Democrat'
    expect(parser.record(line2).votingrecord[4].electiontype).toBe 'Primary' #'PRIMARY-05/07/2002'

  it 'pulls general election records', ->
    voter = parser.record(line1)
    
    expect(voter.votingrecord[1].electiontype).toBe 'General' #'GENERAL-11/07/2000'
    expect(voter.votingrecord[1].voted).toBe 'Voted'