mongoose = require 'mongoose'
config = require './config'

exports = module.exports = mongoose.connect config.voterdb
