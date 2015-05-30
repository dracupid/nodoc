# nodoc
A simple and 'low-level' source code comment parser and documentation generator.
> Oops, this doc is generated by nodoc itself !

[![NPM version](https://badge.fury.io/js/nodoc.svg)](http://badge.fury.io/js/nodoc)
[![Deps Up to Date](https://david-dm.org/dracupid/nodoc.svg?style=flat)](https://david-dm.org/dracupid/nodoc)

## Supported Languages
- CoffeeScript

> Other languagage, especially javascript, will be supported soon.

#### Language Name Alias
Use lower case, used both for language option and extname recognization.
```javascript
<%= alias %>
```


## Usage
0. Convert comment block to an object as following:
#### Parsed Comment Object
    ```javascript
    {
        name: 'parseFile',
        description: 'Parse source code from file. Use Promise instead of callback',
        tags: [ [Object], [Object], [Object], [Object] ], // tag objects array
        lineNum: 78
    }
    ```
    #### Tag Object
    ```javascript
    {
        tagName: 'param',
        type: 'string', // only @param, @property, @option, @return
        name: 'srcPath', // only @param, @property, @option
        description: 'Path of source code file'
    }
    ```
    Tags are only key-value pairs, except `@param`, `@return`, `@property`, `@option`. They may have extra type and (maybe) name.

    ```javascript
    var doc = require('nodoc');

    // From file
    doc.parser.parseFile('./src/parser/index.coffee').then(function(res){});
    res = doc.parser.parseFileSync('./src/parser/index.coffee')
    //From source code
    doc.parser.parse('A piece of source code', 'coffee').then(function(res){});
    ```

0. Generate gitHub flavored markdown API doc from comments.

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

    In this case, predefined tags will make effects.

    ### Predefined tags
    + `@private`: Hidden in the generated document.
    + `@nodoc`: Same behavior as `@private`, but they are differ in semantics.
    + `@alias`: Shown as an addition of function name.
    + `@prefix`: Add a custom prefix to function name.
    + `@noPrefix`: Only preserve the real name, regard `util.promisify` as `promisify`.


## Comment format
Of course, you need to write your comments in a standard way to make a parser work.
Such as:
```coffeescript
###*
 * Generate formatted markdown API document from source code
 * @param  {string} srcPath Path of source code file
 * @param  {Object={}} opts    Options, optional
 * @return {Promise}        Resolve formatted markdown
 * @example
 * ` ``javascript
 * nodoc.generate('./src/index.coffee').then(function(md){
 *     console.log(md);
 * });
 * ` ``
###
```
As you can see, you can use **markdown** in your comment!

> Reference: [jsdoc](http://usejsdoc.org/)

## API
<%= api %>

## Parser Module
<%= parser %>


## Write your own template
Nodoc uses [underscore template](http://underscorejs.org/#template) to render the markdown template. You need to realize that template is not HTML's privilege.
If you don't want to use the default template, you can use your own.
```javascript
doc.generate('./src/parser/index.coffee', {
    template: 'Here is your own template'
    tplData: {}  // You can use this object to add custom data to your template
}).then(function(markdown){});
```

However, if you even want to use a alternative template engine, please use parser module directly.

## Write your own language parser
If the languages you use is not supported by nodoc, you can write your own parser and register it by `parser.setParser`. If you want your parser to be a part of nodoc, please make a pull request, it is warmly welcomed.

A parser should provide follow APIs:
### Parser API
<%= parserAPI %>

### Rule
A parser uses and is supposed to expose the rules it uses to parse the code.

#### Rule for coffee parser
```javascript
<%= coffeeRule %>
```

### License
MIT
