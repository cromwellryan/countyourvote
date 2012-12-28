MongoClient = require('mongodb').MongoClient

use = (dbname, collectionname, operation) ->
  MongoClient.connect dbname, (err, db) ->
    finished = (err, result) ->
      db.close()

    if err?
      finished err
    else
      db.collection collectionname, (err, collection) ->
        if err?
          finished err
        else
          operation collection, finished

module.exports =
  use: use
