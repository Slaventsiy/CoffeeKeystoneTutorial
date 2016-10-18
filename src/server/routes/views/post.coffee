var keystone = require('keystone');
var postModel = require('../../models/Post');

exports = module.exports = function (req, res) {

	var view = new keystone.View(req, res);
	var locals = res.locals;

	// Set locals
	locals.section = 'blog';
	locals.filters = {
		post: req.params.post,
	};
	locals.data = {
		posts: [],
	};

	// Load the current post
	view.on('init', function(next) {
		
		const results = postModel.loadCurrentPost(locals.filters.post, function(err, results) {
			locals.data.post = results;
			console.log(err);
			next(err);
		});
	});

	// Load other posts
	view.on('init', function(next) {
		const results = postModel.loadPosts(function(err, results) {
			locals.data.posts = results;
			next(err);
		});
	});

	// Render the view
	view.render('post');
};
