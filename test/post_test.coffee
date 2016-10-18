assert = require 'assert'

### MANDATORY SETUP ###

require("dotenv").load();
keystone   = require "keystone"
postModel = null
### TESTS ###

describe 'Post Loading', ->
	
	before ->
		keystone.init
			"auth":                   true
			"auto update":            false
			"brand":                  "CoffeeKeystoneTutorial"
			"less":                   "../src/client"
			"name":                   "Coffee Keystone Tutorial"
			"static":                 [ "../src/client" ]
			"user model":             "User"
			"view engine":            "jade"
			"logger" :                false
			"views":                  "../src/server/templates/views"
			"session":								true
	
		keystone.import "../src/server/models"
		
		keystone.set 'locals',
			_: require('underscore'),
			env: keystone.get('env'),
			utils: keystone.utils,
			editable: keystone.content.editable
		
		keystone.set 'routes', require '../src/server/routes'
		
		keystone.start();
		
		postModel = require '../src/server/models/Post'


	describe '#loadPosts(cb)', ->
		it 'should not return error', (done) ->
			postModel.loadPosts(done)
			assert.ok(true)
