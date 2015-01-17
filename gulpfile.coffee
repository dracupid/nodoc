gulp = require 'gulp'
aside = require 'gulp-aside'
coffee = require 'gulp-coffee'
fs = require 'nofs'
_ = require 'lodash'
nodoc = require './src/index.coffee'


gulp.task 'build', ->
	gulp.src 'src/**'
	.pipe aside '**/*.coffee', coffee bare: true
	.pipe gulp.dest 'dist'

gulp.task 'doc', ->
	data = {}

	fs.readFileP 'Readme.tpl'
	.then (doc)->
		nodoc.generate './src/index.coffee'
		.then (api)->
			data.api = api
			nodoc.generate './src/parser/index.coffee'
		.then (parser)->
			data.parser = parser
		.then (alias)->
			data.alias = JSON.stringify require('./src/language/name'), null, 4
			_.template(doc + '')(data)
	.then (md)->
		fs.writeFileP 'Readme.md', md

gulp.task 'default', ['build', 'doc']