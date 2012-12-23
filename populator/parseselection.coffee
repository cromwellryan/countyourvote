typepart = (parts) ->
  part = parts[0]

  switch part 
    when "PRIMARY" then "Primary"
    when "GENERAL" then "General"
    when "SPECIAL" then "Special"
    else throw 'Unknown election type'

extractdate = (parts) ->
  part = parts[1]

  new Date part

fromkey = (key) ->
  throw 'Missing election key' if not key? or key == ''

  parts = key.split '-'

  { type: (typepart parts), held: (extractdate parts) }

exports = module.exports = fromkey
