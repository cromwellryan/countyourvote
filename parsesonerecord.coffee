parties = {
  'C': 'Constitution Party'
  'D': 'Democrat Party'
  'E': 'Reform Party'
  'G': 'Green Party'
  'L': 'Libertarian Party'
  'N': 'Natural Law Party'
  'R': 'Republican Party'
  'S': 'Socialist Party'
}

parts = {
  lastName: (pieces) -> pieces[3]
  firstName: (pieces) -> pieces[4]
  party: (pieces) -> 
    indicator = pieces[9]

    parties[indicator]
}

exports = module.exports =
  record: (line) ->
    pieces = line.split ','

    voter = {}

    for prop, extractor of parts
      voter[prop] = extractor(pieces)

    voter
