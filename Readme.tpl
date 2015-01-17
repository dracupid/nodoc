nodoc
==================
Generate gitHub flavored markdown API doc from source code comments.

## Supported Languages
- CoffeeScript

#### Language Name Alias
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

## Write your own template
Nodoc uses [lo-dash template](https://lodash.com/docs#template) to render the markdown template. You need to realize that template is not HTML's privilege.   
If you don't want to use the default template, you can use your own.
```javascript
doc.generate('./src/parser/index.coffee', {
    template: 'Here is your own template'
    tplData: {}  // You can use this object to add custom data to your template
}).then(function(markdown){});
```

However, if you even want to use a alternative template engine, please use parser module directly.

## Write your own language parser
If the languages you use is not supported by nodoc, you can write your own parser. If you want your parser be a part of nodoc, it is warmly welcomed, please contact me.

A parser show provide follow API: 
### Parser API
<%= parserAPI %>

### Rule
A parser use and is supposed to expose the rules it uses to parse the code.

#### Rule for coffee parser
```javascript
<%= coffeeRule %>
```

### License 
MIT
