mongoose = require 'mongoose'
voterdb = require './voterdb'

electionSchema = mongoose.Schema {
  electiontype: String,
  held: Date,
  voted: String 
}

voterSchema = mongoose.Schema { 
  id: String,
  lastName: String,
  firstName: String,
  party: String,
  city: String,
  votingrecord: [electionSchema]
}

voterSchema.methods.fullName = () ->
  @firstName + ' ' + @lastName

Voter = voterdb.model 'Voter', voterSchema

exports = module.exports = Voter

