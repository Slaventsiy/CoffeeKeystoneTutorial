keystone = require('keystone')
Types = keystone.Field.Types

###
  Post Model
==============
###

Post = new keystone.List 'Post',
	map:
		name: 'title'
	autokey:
		path: 'slug'
		from: 'title'
		unique: true

Post.add
	title: 
		type: String
		required: true
	state: 
		type: Types.Select
		options: 'draft, published, archived'
		default: 'draft'
		index: true
	author: 
		type: Types.Relationship
		ref: 'User'
		index: true
	publishedDate: 
		type: Types.Date
		index: true
		dependsOn: 
			state: 'published'
	image: 
		type: Types.CloudinaryImage
	content:
		brief: 
			type: Types.Html
			wysiwyg: true
			height: 150
		extended: 
			type: Types.Html
			wysiwyg: true
			height: 400
	categories: 
		type: Types.Relationship
		ref: 'PostCategory'
		many: true

Post.schema.virtual 'content.full'
	.get -> @content.extended || @content.brief

Post.defaultColumns = 'title, state|20%, author|20%, publishedDate|20%'
Post.register()

exports = module.exports = {}

exports.loadPosts = (cb) ->
	keystone.list 'Post'
		.model
			.find()
			.where 'state', 'published'
			.sort '-publishedDate'
	.populate 'author'
		.limit '4'
	.exec cb

exports.loadCurrentPost = (postFilter, cb) ->

	keystone.list('Post')
		.model
			.findOne
				state: 'published'
				slug: postFilter
		.populate 'author categories'
		.exec cb
