production =
  appname: 'Count Your Vote™'
  resultslimit:  100
  populator:
    batchsize:  5000
  voterdb: 'mongodb://app:passw0rd!@ds041157.mongolab.com:41157/countyourvote'
  votercollection: 'voters'

dev =
  appname: 'Count Your Vote™'
  resultslimit:  100
  populator:
    batchsize:  5000
  voterdb: 'mongodb://localhost/countyourvote'
  votercollection: 'voters'

test =
  appname: 'Count Your Vote™'
  resultslimit:  100
  populator:
    batchsize:  5000
  voterdb: 'mongodb://localhost/test'
  votercollection: 'voters'

environments =
  production: production
  test: test
  dev: dev

environment = (process.env.NODE_ENV || "dev").toLowerCase()

activeConfig = environments[environment]

throw "Unable to determine environment.  NODE_ENV = #{environment}" unless activeConfig?
console.log "Using config for #{environment}" if activeConfig?

exports = module.exports = activeConfig

