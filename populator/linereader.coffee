fs = require 'fs'
_ = require 'underscore'

noerr = null

class LineReader
  _readlines = (data, callback) ->
    data = data.replace "\r", ""
    lines = data.split "\n"

    callback noerr, lines

  read: (file, callback) ->
    fs.exists file, (exists) ->
      callback (file + ' does not exist') if not exists
      return if not exists

      fs.readFile file, (err, data) ->
        callback err if err?

        _readlines data.toString(), callback
        
exports = module.exports = ->
  new LineReader()
