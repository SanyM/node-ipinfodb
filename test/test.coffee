fs = require 'fs'
chai = require 'chai'  
chai.should()

TESTS = [
		# 86.179.147.206 is the ip my broadband router at home was given on 10/11/12, nearby London
		ip: "86.179.147.206"
		expectedResponse: 
			statusCode : "OK"
			statusMessage : ""
			ipAddress : "86.179.147.206"
			countryCode : "UK"
			countryName : "UNITED KINGDOM"
			regionName : "ENGLAND"
			cityName : "LONDON"
			zipCode : "-"
			latitude : "51.5085"
			longitude : "-0.12574"
			timeZone : "+00:00"
	, 
		# 74.125.132.104 was one of www.google.com's IP addresses on 10/11/12
		ip: "74.125.132.104"
		expectedResponse: 
			statusCode: 'OK'
			statusMessage: ''
			ipAddress: '74.125.132.104'
			countryCode: 'US'
			countryName: 'UNITED STATES'
			regionName: 'CALIFORNIA'
			cityName: 'MOUNTAIN VIEW'
			zipCode: '94043'
			latitude: '37.3861'
			longitude: '-122.084'
			timeZone: '-07:00' 
]


console.log "Remember to save the IPInfoDB API key in the IPINFODB_API_KEY
  file in the 'test' folder before running the test scripts"

ipInfoDbApiKey = ''
ipinfodb = undefined

describe 'The testing suite', ->

	it 'should be able to read the API key from the IPINFODB_API_KEY file', (done) ->
		fs.readFile 'test/IPINFODB_API_KEY', (err, text) ->
			text.should.not.equal '' # TODO: Not really enough here
			ipInfoDbApiKey = text
			done()

	it 'should be able to require the source code for the module', (done) ->
		ipinfodb = new (require("../lib/main"))(ipInfoDbApiKey)
		done()

describe 'IPInfoDB', ->

	for t in TESTS
		it 'should be able to query the IPInfoDB API and fetch the expected data for ' + t.ip, (done) ->
			ipinfodb.getLocation t.ip, (err, body) ->
				body.should.deep.equal t.expectedResponse
				done()

