_ = require("underscore")
express = require("express")
bodyParser = require("body-parser")
twilio = require("twilio")
Sandbox = require('sandbox')

app = express()
app.use bodyParser.json()
app.use bodyParser.urlencoded()

app.post "/sms", (req, res) ->
	msg = req.body.Body
	sb = new Sandbox()
	sb.run msg, (output) ->
		twiml = new twilio.TwimlResponse()
		twiml.message(output.result)
		res.writeHead(200, 'Content-Type':'text/xml')
		res.end(twiml.toString())

app.listen 3333
