express = require 'express'
routes = require './routes'
http = require 'http'
path = require 'path'

app = express()

app.configure ->
  app.set 'port', process.env.PORT || 3000
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static path.join(__dirname, 'public')
  app.use require('less-middleware') src: __dirname + '/public' 
  app.use require('connect-assets')()

app.configure 'development', -> 
  app.use express.errorHandler()

app.get '/', routes.index
app.get '/voter', routes.voters
app.get '/voter/:voterid', routes.voter

http.createServer(app).listen app.get('port'), -> 
  console.log "Express server listening on port " + app.get('port')
