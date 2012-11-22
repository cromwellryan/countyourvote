Voter = require './voter'

parties = {
  'C': 'Constitution'
  'D': 'Democrat'
  'E': 'Reform'
  'G': 'Green'
  'L': 'Libertarian'
  'N': 'Natural Law'
  'R': 'Republican'
  'S': 'Socialist'
}

parts = {
  id: (pieces) -> pieces[0]
  lastName: (pieces) -> pieces[3]
  firstName: (pieces) -> pieces[4]
  party: (pieces) -> 
    indicator = pieces[9]

    parties[indicator]
  city: (pieces) ->
    pieces[27]
}

exports = module.exports =
  record: (line) ->
    pieces = line.split ','

    voter = new Voter

    for prop, extractor of parts
      voter[prop] = extractor(pieces)

    voter
