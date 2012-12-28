withcollection = require '../withcollection'
config = require '../config'

withcollection.use config.voterdb, config.votercollection, (collection, finished) ->

  console.log "Using collection #{config.votercollection}"
    
  # Unique index on voter id
  collection.ensureIndex {id: 1}, {unique: true}, (err, indexName) ->
    reportindexresult err, indexName

    # index on last name and first name together
    collection.ensureIndex {lastName: 1, firstName: 1}, (err, indexName) -> 
      reportindexresult err, indexName

       # index on last name together
      collection.ensureIndex {lastName: 1}, (err, indexName) -> 
        reportindexresult err, indexName
        finished()

reportindexresult = (err, indexName) ->
  msg = if err? "Error ensuring index \"#{indexName}\": err" else "Index \"#{indexName}\" ensured"
  console.log msg
