parser = require './parser'
_ = require 'underscore'
fs = require 'fs'
path = require 'path'

defaultTemplate = '' + fs.readFileSync path.join __dirname, 'template/markdown.tpl'

removeTag = (comment, tagName)->
    comment.tags = comment.tags.filter (tag)->
        tag.tagName isnt tagName
    comment

getTag = (comment, tagName)->
    tag = comment.tags.filter (tag)->
        tag.tagName is tagName
    tag

hasTag = (comment, tagName)->
    getTag(comment, tagName).length

###*
 * Remove tags not to be shown
 * @param  {Array} comments comments array
 * @return {Array}          filtered array
 * @private
###
commentFilter = (comments)->
    cos = comments.filter (comment)->
        not (hasTag comment, 'private' or hasTag comment, 'nodoc')
    cos.forEach (comment)->
        aliasTag = getTag(comment, 'alias')
        if aliasTag.length
            alias = aliasTag.reduce (str, a)->
                str += a.description + ' '
            , ''
            if alias then comment.name += " (alias: #{alias}) "
            removeTag(comment, 'alias')

        prefixTag = getTag(comment, 'prefix')[0]
        if prefixTag
            comment.name =  (prefixTag.description or '') + comment.name
            removeTag(comment, 'prefix')

    cos


###*
 * Generate formatted markdown API document from source code
 * @alias  render
 * @param  {string} srcPath Path of source code file
 * @param  {Object=} opts    Options, optional
 * ```javascript
 * {
 *     moduleName: '', // module name of the file, or it will be auto set to file name, of parent directory name for `index` file.
 *     moduleDesc: '', // module decription
 *     template: '',   // custom template
 *     tplData: {},    // addition template data
 *     cwd: process.cwd()   // current working directory
 *     language: ''         // specify the language, or it will be auto recognized by extname
 *     rule: {}             // specific parser rule, items vary from parsers
 * }
 * ```
 * @return {Promise}        Resolve formatted markdown
 * @example
 * ```javascript
 * nodoc.generate('./src/index.coffee').then(function(md){
 *     console.log(md);
 * });
 * ```
###
generate = (srcPath, opts = {})->
    _.defaults opts,
        moduleName: undefined
        moduleDesc: ''
        tplData: {}
        template: defaultTemplate

    parser.parseFile srcPath, opts
    .then (comments)->
        moduleName = do ->
            if typeof opts.moduleName isnt 'undefined'  then return opts.moduleName

            baseName = path.basename srcPath, path.extname(srcPath)
            dirName  = path.dirname(srcPath).split(path.sep).slice(-1)[0]

            return if baseName is 'index' then dirName else baseName

        _.extend opts.tplData, {
            moduleDesc: opts.moduleDesc
            moduleName
            comments: commentFilter comments
            srcPath
        }

        _.template(opts.template + '')(opts.tplData).replace(/(\r\n|\n)(\ |\r\n|\n)*(\r\n|\n)/g, '\n\n')

module.exports = {
    ###*
     * Parser module, see below for details.
    ###
    parser
    generate
    render: generate
}
