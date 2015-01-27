gulp = require 'gulp'
aside = require 'gulp-aside'
coffee = require 'gulp-coffee'
fs = require 'nofs'
_ = require 'lodash'
util = require 'util'
nodoc = require './src/index.coffee'

gulp.task 'build', ->
	gulp.src 'src/**'
	.pipe aside '**/*.coffee', coffee bare: true
	.pipe gulp.dest 'dist'

gulp.task 'doc', ->
	data = {}

	fs.readFile 'Readme.tpl'
	.then (doc)->
		nodoc.generate './src/index.coffee', moduleName: ''
		.then (api)->
			data.api = api
			nodoc.generate './src/parser/index.coffee', moduleName: ''
		.then (parser)->
			data.parser = parser
			nodoc.generate './src/parser/coffee.coffee', moduleName: ''
		.then (parserApi)->
			data.parserAPI = parserApi
			data.alias = JSON.stringify require('./src/language/name'), null, 4
			data.coffeeRule = util.inspect require('./src/parser/coffee').getRule()
			_.template(doc + '')(data)
	.then (md)->
		fs.writeFile 'Readme.md', md

gulp.task 'default', ['build', 'doc']