parser = require './parser'
_ = require 'lodash'
fs = require 'nofs'
path = require 'path'

defaultTemplate = fs.readFileSync path.join __dirname, 'template/markdown.tpl'

###*
 * Generate formatted markdown API document from source code
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
 *     rule: {}				// specific parser rule, items vary from parsers
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

		_.assign opts.tplData, {
			moduleDesc: opts.moduleDesc
			moduleName
			comments
			srcPath
		}

		_.template(opts.template)(opts.tplData).replace(/(\r\n|\n)(\ |\r\n|\n)*(\r\n|\n)/g, '\n\n')

module.exports = {
	###*
	 * Parser module, see below for details.
	###
	parser
	generate
}