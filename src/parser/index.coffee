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

###*
 * Create a new parser or override an old ones
 * @param {string|Array} name   parser's name/language (and aliases)
 * @param {Object} parser parser object, see below
###
setParser = (name, parser)->
    name = Array::concat.call [], name
    name.forEach (n)->
        parsers[n] = parser

getParser = (language)->
    language = getLangName language.toLowerCase()
    parsers[language] or parsers[language] = require './' + language

###*
 * Parse source code directly.
 * @param  {string}     source       source code
 * @param  {string}     language     specify source language
 * @param  {Object=}    opts         option, optional
 * @return {Array}                   parsed comments object **array**
 * @example
 * ```javascript
 * nodoc.parser.parse("This is source code with comments", "coffee").then(function(comments){
 *     console.log(comments);
 * })
 * ```
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
 * Parse source code from file. Use Promise instead of callback
 * @param  {string}      filePath   souce file path
 * @param  {Object=}     opts       options
 * @return {Promise}                resolve parsed comment object **array**
 * @example
 * ```javascript
 * nodoc.parser.parseFile("index.coffee", {cwd: './src'}).then(function(comments){
 *     console.log(comments);
 * });
 * ```
###
parseFile = (filePath, opts = {})->
    _parseFile filePath, opts, false

###*
 * Synchronous version of parseFile
 * @return {Object} parsed comment object **array**
###
parseFileSync = (filePath, opts = {})->
    _parseFile filePath, opts, true

###*
 * Set parser's rule
 * @param {string} language parser's name/language
 * @param {Object} rule     parser's rule object
 * @example
 * ```javascript
 * nodec.parser.setRule('coffee', {
 *     commentReg: /#?([\s\S]+?)#\s+([\w\.]+)/g
 * });
 * ```
###
setRule = (language, rule)->
    getParser(language).setRule rule

module.exports = {
    parse
    parseFileSync
    parseFile
    setParser
    setRule
}
