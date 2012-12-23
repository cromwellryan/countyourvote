#PRIMARY-03/07/2000
#GENERAL-11/07/2000
#SPECIAL-05/08/2001

election = require '../../populator/parseselection'

describe 'election', ->
  describe 'types', ->
    it 'handles primaries', ->
      e = election 'PRIMARY-03/07/2000'
      expect(e.type).toBe 'Primary'

    it 'handles General elections', ->
      e = election 'GENERAL-11/07/2000'
      expect(e.type).toBe 'General'

    it 'handles Special elections', ->
      e = election 'SPECIAL-05/08/2001'
      expect(e.type).toBe 'Special'

    it 'fails at empty', ->
      expect( -> election '' ).toThrow 'Missing election key'
      expect( -> election null ).toThrow 'Missing election key'
      expect( -> election undefined ).toThrow 'Missing election key'

    it 'Throws for unknown election type prefix', ->
      expect( -> election 'GOOFY-01/10/2011' ).toThrow 'Unknown election type'

    it 'handles the election date', ->
      expect( (election 'PRIMARY-03/07/2000').held).toEqual new Date '03/07/2000'
