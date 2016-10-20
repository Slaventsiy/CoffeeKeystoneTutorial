require("dotenv").load();

keystone   = require "keystone"

keystone.init
	"auth":                   true
	"auto update":            true
	"brand":                  "CoffeeKeystoneTutorial"
#	"cookie secret":          config.server.cookieSecret
	"favicon":                "client/favicon.ico"
	"less":                   "../client"
	"name":                   "Coffee Keystone Tutorial"
#	"signin redirect":        "/"
#	"signout redirect":       "/signin"
	"static":                 [ "../client" ]
#	"session store":          "connect-mongo"
#	"session store options" : config.db
	"user model":             "User"
	"view engine":            "jade"
	"logger" :                false
	"views":                  "templates/views"
#	"port":                   config.server.port
	"mongo":                  'mongodb://' + process.env.MONGODB_PORT_27017_TCP_ADDR + ':' + process.env.MONGODB_PORT_27017_TCP_PORT+ '/testdb'
	"session":								true

keystone.import "models"

keystone.set 'locals',
	_: require('underscore'),
	env: keystone.get('env'),
	utils: keystone.utils,
	editable: keystone.content.editable

keystone.set 'routes', require './routes'

# Configure the navigation bar in Keystone's Admin UI
keystone.set 'nav',
	posts: ['posts', 'post-categories'],
	enquiries: 'enquiries',
	users: 'users'

#Start Keystone to connect to your database and initialise the web server

keystone.start();