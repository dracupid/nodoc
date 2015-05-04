util = require 'util'
nodoc = require './src/index.coffee'

kit = require 'nokit'
drives = kit.require 'drives'
_ = kit._

module.exports = (task) ->
    task 'build', ->
        kit.warp 'src/**'
        .load drives.reader isCache: no
        .load drives.auto 'lint', '.coffee': config: 'coffeelint-strict.json'
        .load drives.auto 'compile'
        .run 'dist'
        .catch -> return

    task 'doc', ->
        data = {}

        kit.readFile 'Readme.tpl'
        .then (doc) ->
            nodoc.generate './src/index.coffee', moduleName: ''
            .then (api) ->
                data.api = api
                nodoc.generate './src/parser/index.coffee', moduleName: ''
            .then (parser) ->
                data.parser = parser
                nodoc.generate './src/parser/coffee.coffee', moduleName: ''
            .then (parserApi) ->
                data.parserAPI = parserApi
                data.alias = JSON.stringify require('./src/language/name'), null, 4
                data.coffeeRule = util.inspect require('./src/parser/coffee').getRule()
                _.template(doc + '') data
        .then (md)->
            kit.writeFile 'Readme.md', md

    task 'default', ['build', 'doc']
