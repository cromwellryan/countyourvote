production =
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

exports = module.exports = if process.env.NODE_ENV == 'test' then test else production
