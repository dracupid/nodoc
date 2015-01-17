parser = require './parser'
_ = require 'lodash'
fs = require 'nofs'
path = require 'path'

defaultTemplate = fs.readFileSync path.join __dirname, 'template/markdown.tpl'

generateMarkdown = (srcPath, opts = {})->
	_.defaults opts,
		moduleName: ''
		moduleDescription: ''
		tplData: {}
		template: defaultTemplate

	parser.parseFile srcPath, opts
	.then (comments)->
		moduleName = do ->
			if opts.moduleName then return opts.moduleName

			baseName = path.basename srcPath, path.extname(srcPath)
			dirName  = path.dirname(srcPath).split(path.sep)[-1]

			return if baseName is 'index' then dirName else baseName

		_.assign opts.tplData, {
			moduleDescription: opts.moduleDescription
			moduleName
			comments
			srcPath
		}

		_.template(opts.template)(opts.tplData).replace(/(\r\n|\n)(\ |\r\n|\n)*(\r\n|\n)/g, '\n\n')

module.exports = {
	parser
	generateMarkdown
}