nodoc
==================
Generate gitHub flavored markdown API doc from source code comments.

## Supported Languages
- CoffeeScript

### Language Name Alias
Use lower case.
```javascript
<%= alias %>
```

## Quick Start
```javascript
var doc = require('nodoc'),
    fs = require('fs');

doc.generate('./src/parser/index.coffee', {
    moduleName: 'parser',
    moduleDesc: 'This is a parser!'
}).then(function(markdown){
    fs.writeFileSync('./api.md', markdown);
});
```

## API
<%= api %>

## Parser Module
<%= parser %>

## Write your own language parser

### Parser API

### Rule

