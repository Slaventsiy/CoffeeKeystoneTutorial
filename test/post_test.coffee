assert = require 'assert'

### MANDATORY SETUP ###

require("dotenv").load();
keystone   = require "keystone"
Post = null
postItem = null
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
			"port":										3001

		keystone.import "../src/server/models"

		keystone.set 'locals',
			_: require('underscore'),
			env: keystone.get('env'),
			utils: keystone.utils,
			editable: keystone.content.editable

		keystone.set 'routes', require '../src/server/routes'

		keystone.start();

		Post = keystone.list 'Post'

		postItem = new Post.model()
		postItem.set 'title', 'Test post'
		postItem.set 'state', 'published'
		postItem.save()

	after ->
		postItem.remove()

	describe '#loadPosts(cb)', ->
		it 'should be callable', ->

			loadPosts = Post.model.loadPosts
			assert.equal typeof loadPosts, 'function'

		it 'should not throw an error', ->

			Post.model.loadPosts (err, results) ->
				assert.ifError(err)

		it 'should return something', ->

			Post.model.loadPosts (err, results) ->
				assert.ok(results)

	describe '#loadCurrentPost(postFilter, cb)', ->
		it 'should be callable', ->

			loadCurrentPost = Post.model.loadCurrentPost
			assert.equal typeof loadCurrentPost, 'function'

		it 'should not throw an error', ->

			Post.model.loadCurrentPost '', (err, results) ->
				assert.ifError(err)

		it 'should return a post', ->

			Post.model.loadCurrentPost 'test-post', (err, results) ->
				assert.equal results.slug, 'test-post'