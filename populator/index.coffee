parsesline = require('./parsesonerecord')()
linereader = require('./linereader')()
MongoClient = require('mongodb').MongoClient
config = require '../config'
_ = require 'underscore'

class Populator
  populatewith: (filetoprocess, callback) ->
    connectionstring = config.voterdb
    votercollectionname = config.votercollection
    batchsize = config.populator.batchsize

    linereader.read filetoprocess, (err, lines) ->
      if err?
        callback err
        return

      parsesline.withkey lines[0]

      MongoClient.connect connectionstring, (err, db) ->
        if err?
          callback err if callback?
          return

        db.collection votercollectionname, (err, collection) ->
          if err?
            callback err if callback?
            return

          iterations = Math.ceil (lines.length - 1) / batchsize
          laststop = 0

          batches = for iteration in [1..iterations]
            do () ->
              batchnumber = iteration
              start = laststop+1
              end = start + batchsize
              laststop = end

              (next) ->
                voters = _.chain(lines[start..end]).map(parsesline.record).value()

                collection.insert voters, (err, result) ->
                  console.log "Problem inserting batch: #{err}" if err?
                  next() if next?
   
          atend = () ->
            db.close (err, result) ->
              callback err, result

          compose = (f, g) ->
            () -> f(g)

          composed = atend
          for batch in batches.reverse()
            composed = compose(batch, composed)

          composed()

exports = module.exports = ->
  new Populator()


