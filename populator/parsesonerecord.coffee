Voter = require '../voter'
election = require '../election'

parties = 
  'C': 'Constitution'
  'D': 'Democrat'
  'E': 'Reform'
  'G': 'Green'
  'L': 'Libertarian'
  'N': 'Natural Law'
  'R': 'Republican'
  'S': 'Socialist'
  '': ''

parts =
  id: (pieces) -> pieces[0]
  lastName: (pieces) -> pieces[3]
  firstName: (pieces) -> pieces[4]
  party: (pieces) -> 
    indicator = pieces[9]

    parties[indicator]
  city: (pieces) ->
    pieces[27]

howvoted = (raw, type) ->
  if type == "PRI" 
    parties[raw]
  else
    if raw == "X" then "Voted" else ""

extractvotingrecord = (pieces, electiondecoders) ->
  record = electiondecoders.map (electioninfo) ->
    votestatus = pieces[electioninfo.index]

    election: election(electioninfo.name), voted: howvoted(votestatus, electioninfo.type)

  record

class Parser
  withkey: (@key) -> 
    @elections = key.split(',')
                   .map (piece,index) -> 
                      key: piece, index: index
                   .filter (piece) ->
                      (piece.key.indexOf('PRIMARY') == 0 or
                       piece.key.indexOf('GENERAL') == 0 or
                       piece.key.indexOf('SPECIAL') == 0)
                   .map (piece) -> 
                      name: piece.key, index:piece.index, type: piece.key[0..2]
                 
  record: (line, key) ->
    pieces = line.split ','

    voter = new Voter

    for prop, extractor of parts
      voter[prop] = extractor(pieces)

    if @elections?
      voter.votingrecord = extractvotingrecord pieces, @elections

    voter

exports = module.exports = ->
  new Parser
