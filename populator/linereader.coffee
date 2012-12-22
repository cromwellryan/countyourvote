fs = require 'fs'
_ = require 'underscore'

noerr = null

class LineReader
  _readlines = (data, callback) ->
    data = data.replace "\r", ""
    lines = data.split "\n"

    lines.forEach (line, index) ->
      callback noerr, line, index if line.length > 0

  read: (file, callback, finished) ->
    fs.exists file, (exists) ->
      callback (file + ' does not exist') unless exists
      return unless exists

      fs.readFile file, (err, data) ->
        callback err if err?

        _readlines data.toString(), callback
        
exports = module.exports = (->
  new LineReader)
