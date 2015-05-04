# Inspired by nokit.parseComment: https://github.com/ysmood/nokit

_ = require 'underscore'

rule =
    commentReg: /###\*([\s\S]+?)###\s+([\w\.]+)/g
    splitReg: /^\s+\* ?@/m
    tagNameReg: /^([\w\.]+)\s*/
    typeReg: /^\{(.+|}?)\}\s*/
    nameReg: /^([\w\.]+)\s*/
    nameTags: ['param', 'property']
    descriptionReg: /^([\s\S]*)/
    removePrefix: /self\.|this\./

parseContent = (content, r) ->
    # Unescape '\/'
    content = content.replace /\\\//g, '/'

    # Clean the prefix '*'
    arr = content.split(r.splitReg).map (el) ->
        el.replace(/^[ \t]+\*[ \t]?/mg, '').trim()

    description: arr[0] or ''
    tags: arr[1..].map (el) ->
        parseTag = (reg) ->
            m = el.match reg
            if m and m[1]
                el = el[m[0].length..]
                m[1]
            else
                null

        tag = {}

        tag.tagName = parseTag r.tagNameReg
        type = parseTag r.typeReg

        if type
            tag.type = type.trim()
            if tag.tagName in r.nameTags
                tag.name = parseTag r.nameReg

        tag.description = parseTag(r.descriptionReg) or ''

        tag
###*
 * Parse comment from source code
 * @param  {string} source        source code
 * @param  {Object=} localRule    optional, custom rule object, use once
 * @return {Array}                parsed comments object array
###
parse = (source, localRule = {}) ->
    r = _.defaults localRule, rule

    comments = []
    while m = r.commentReg.exec source
        content = parseContent m[1], r
        lastIndex = r.commentReg.lastIndex
        comments.push
            name: m[2].replace r.removePrefix, ''
            description: content.description
            tags: content.tags
            lineNum: source[...lastIndex].split('\n').length
    comments

module.exports =
    parse: parse
    ###*
     * Set the rule of the parser
     * @param {Object} ruleObj rule object
    ###
    setRule: (ruleObj) ->
        _.extend rule, ruleObj
    ###*
     * Hmm..., I'd like to use this to generate document.
     * @return {Object} rule object
    ###
    getRule: -> rule
