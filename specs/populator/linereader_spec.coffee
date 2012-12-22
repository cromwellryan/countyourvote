linereader = require('../../populator/linereader')()

describe 'linereader', ->
  it 'does nothign with an mia file', ->
    done = false
    lasterr = null
    linereader.read 'waldo.txt', (err, line) ->
      lasterr = err
      done = true

    waitsFor -> 
      done

    runs ->
      expect(lasterr).toBe 'waldo.txt does not exist'

  it 'first line is index 0', ->
    lastindex = -1
    done = false

    linereader.read __dirname + '/scenarios/0.txt', (err, line, index) ->
      lastindex = index
      done = true

    waitsFor -> 
      done

    runs ->
      expect(lastindex).toBe 0

