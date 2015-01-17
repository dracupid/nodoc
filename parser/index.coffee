path = require 'path'
_ = require 'lodash'
fs = require 'nofs'
nameMap = require '../language/name'

parsers = {}

getLangName = (name)->
    if not name
        throw new Error 'Language name is required!'
    newName = nameMap[name]
    if not newName
        throw new Error 'Language Not Support: ' + name
    else
        newName

getParser = (language)->
    language = getLangName language
    parsers[language] or parsers[language] = require './' + language

###*
 * Parse source code directly.
 * @param  {string}     source       source code
 * @param  {string}     language     specify source language
 * @param  {Object=}     opts         option
 * @return {string}                  parsed comment object
###
parse = (source, language, opts = {})->
    _.defaults opts,
        rule: null

    getParser(language).parse source + ''

_parseFile = (filePath, opts, sync)->
    _.defaults opts,
        rule: null
        language: ''
        cwd: process.cwd()

    language = opts.language or path.extname(filePath)[1...]
    filePath = path.join opts.cwd, filePath

    if sync
        parse fs.readFileSync(filePath), language, opts
    else
        fs.readFileP filePath
        .then (source)->
            parse source, language, opts

###*
 * Parse source code from file
 * @param  {string}      filePath   souce file path
 * @param  {Object=}     opts       option
 * @return {Promise}                parsed comment object
###
parseFileSync = (filePath, opts = {})->
    _parseFile filePath, opts, true

parseFile = (filePath, opts = {})->
    _parseFile filePath, opts, false


setRule = (language, rule)->
    getParser(language).setRule rule



module.exports ={
    parse
    parseFileSync
    parseFile
    setRule
}
