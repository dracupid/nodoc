doc = require('./src/index.coffee')
fs = require('fs');

doc.generate('./src/parser/index.coffee', {
    moduleName: 'parser',
    moduleDesc: 'This is a parser!'
}).then (markdown)->
    fs.writeFile('./api.md', markdown);
