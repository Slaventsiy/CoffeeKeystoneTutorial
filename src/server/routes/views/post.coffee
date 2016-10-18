keystone = require 'keystone'
postModel = require '../../models/Post'

exports = module.exports = (req, res) -> 

	view = new keystone.View(req, res)
	locals = res.locals

	#	Set locals
	locals.section = 'blog'
	locals.filters = 
		post: req.params.post
	locals.data =
		posts: []

	#	Load the current post
	view.on 'init', (next) ->
		results = postModel.loadCurrentPost locals.filters.post, (err, results) ->
			locals.data.post = results
			console.log err
			next err

	# Load other posts
	view.on 'init', (next) ->
		results = postModel.loadPosts (err, results) ->
			locals.data.posts = results
			next err

	# Render the view
	view.render 'post'
