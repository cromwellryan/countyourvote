parsesline = require('./parsesonerecord')()
linereader = require('./linereader')()

linereader.read "data/WARREN.TXT", (err, line, index) ->
  parsesline.withkey line if index == 0

  if index > 0
    voter = parsesline.record line

    voter.save (err, voter) ->
      console.log "Damn it #{err}" if err?
      console.log "Saved #{voter.id}" unless err?

