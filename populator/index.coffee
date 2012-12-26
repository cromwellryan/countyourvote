parsesline = require('./parsesonerecord')()
linereader = require('./linereader')()
MongoClient = require('mongodb').MongoClient
config = require '../config'
_ = require 'underscore'

filetoprocess = "data/WARREN.TXT"
connectionstring = config.voterdb
votercollectionname = config.votercollection
batchsize = config.populator.batchsize

voters = null
if not err?
  linereader.read filetoprocess, (err, lines) ->
    
    parsesline.withkey lines[0]

    console.log "Found #{lines.length-1} lines"

    MongoClient.connect connectionstring, (err, db) ->
      console.log "Unable to connect to db: #{err}" if err?
      return if err?

      db.collection votercollectionname, (err, collection) ->
        console.log "Unable to connect to collection: #{err}" if err?
        return if err?

        iterations = Math.ceil (lines.length - 1) / batchsize
        laststop = 0

        batches = for iteration in [1..iterations]
          do () ->
            batchnumber = iteration
            start = laststop+1
            end = start + batchsize
            laststop = end

            (next) ->
              console.log "Batch #{batchnumber} (#{start} - #{end})"
              voters = _.chain(lines[start..end]).map(parsesline.record).value()

              collection.insert voters, (err, result) ->
                console.log "Problem inserting voters: #{err}" if err?

                next() if next?
 
        atend = () ->
          db.close (err, result) ->
            console.log "Closed connection to #{connectionstring}" unless err?
            console.log "Problems closing connection to #{connectionstring}: #{err}" if err?

        compose = (f, g) ->
          () -> f(g)

        composed = atend 
        for batch in batches.reverse()
          composed = compose(batch, composed)

        composed()

