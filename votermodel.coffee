mongoose = require 'mongoose'
voterdb = require './voterdb'

voterSchema = mongoose.Schema { 
  id: String,
  lastName: String,
  firstName: String,
  party: String,
  city: String
  votingrecord: [ {
    election: {
      type: String,
      date: Date },
    voted: String } ]
}

Voter = voterdb.model 'Voter', voterSchema

exports = module.exports = Voter

