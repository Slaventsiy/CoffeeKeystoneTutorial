keystone = require 'keystone'
# postModel = require '../../models/Post'
Post = keystone.list 'Post'

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
		Post.model.loadCurrentPost locals.filters.post, (err, results) ->
			locals.data.post = results
			next err

	# Load other posts
	view.on 'init', (next) ->
		Post.model.loadPosts (err, results) ->
			locals.data.posts = results
			next err

	# Render the view
	view.render 'post'
