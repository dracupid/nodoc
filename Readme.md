nodoc
==================
Generate gitHub flavored markdown API doc from source code comments.

## Supported Languages
- CoffeeScript

#### Language Name Alias
Use lower case.
```javascript
{
    "coffee": "coffee",
    "js": "javascript",
    "javascript": "javascript"
}
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


- #### <a href="./src/index.coffee?source#L31" target="_blank"><b>generate</b></a>
  Generate formatted markdown API document from source code

  - **<u>param</u>**: `srcPath` { _string_ }

    Path of source code file

  - **<u>param</u>**: `opts` { _Object=_ }

    Options, optional
    ```javascript
    {
        moduleName: '', // module name of the file
        moduleDesc: '', // module decription
        template: '',   // custom template
        tplData: {},    // addition template data
        cwd: process.cwd()   // current working directory
        language: ''         // specify the language, or recognize from extname
        rule: {}                // specific parser rule, varies from parsers
    }
    ```

  - **<u>return</u>**: { _Promise_ }

    Resolve formatted markdown

  - **<u>example</u>**: 

    ```javascript
    nodoc.generate('./src/index.coffee').then(function(md){
        console.log(md);
    });
    ```

- #### <a href="./src/index.coffee?source#L61" target="_blank"><b>parser</b></a>
  Parser module, see below for details.



## Parser Module


- #### <a href="./src/parser/index.coffee?source#L22" target="_blank"><b>setParser</b></a>
  Create a new parser or override an old ones

  - **<u>param</u>**: `name` { _string_ }

    parser's name

  - **<u>param</u>**: `parser` { _Object_ }

    parser object

- #### <a href="./src/parser/index.coffee?source#L38" target="_blank"><b>parse</b></a>
  Parse source code directly.

  - **<u>param</u>**: `source` { _string_ }

    source code

  - **<u>param</u>**: `language` { _string_ }

    specify source language

  - **<u>param</u>**: `opts` { _Object=_ }

    option

  - **<u>return</u>**: { _Array_ }

    parsed comments object array

- #### <a href="./src/parser/index.coffee?source#L66" target="_blank"><b>parseFile</b></a>
  Parse source code from file. Use Promise instead of callback

  - **<u>param</u>**: `filePath` { _string_ }

    souce file path

  - **<u>param</u>**: `opts` { _Object=_ }

    option

  - **<u>return</u>**: { _Promise_ }

    resolve parsed comment object

- #### <a href="./src/parser/index.coffee?source#L73" target="_blank"><b>parseFileSync</b></a>
  Synchronous version of parseFile

  - **<u>return</u>**: { _Object_ }

    parsed comment object array

- #### <a href="./src/parser/index.coffee?source#L81" target="_blank"><b>setRule</b></a>
  Set parser's rule

  - **<u>param</u>**: `language` { _String_ }

    parser name

  - **<u>param</u>**: `rule` { _Object_ }

    parser's rule



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

### coffee

- #### <a href="./src/parser/coffee.coffee?source#L51" target="_blank"><b>parse</b></a>
  Parse comment from source code

  - **<u>param</u>**: `source` { _string_ }

    source code

  - **<u>param</u>**: `localRule` { _Object=_ }

    optional, custom rule object, use once

  - **<u>return</u>**: { _Array_ }

    parsed comments object array

- #### <a href="./src/parser/coffee.coffee?source#L71" target="_blank"><b>setRule</b></a>
  Set the rule of the parser

  - **<u>param</u>**: `ruleObj` { _Object_ }

    rule object

- #### <a href="./src/parser/coffee.coffee?source#L77" target="_blank"><b>getRule</b></a>
  Hmm..., I'd like to use this to generate document.

  - **<u>return</u>**: { _Object_ }

    rule object



### Rule
A parser use and is supposed to expose the rules it uses to parse the code.

#### Rule for coffee parser
```javascript
{ commentReg: /###\*([\s\S]+?)###\s+([\w\.]+)/g,
  splitReg: /^\s+\* ?@/m,
  tagNameReg: /^([\w\.]+)\s*/,
  typeReg: /^\{(.+?)\}\s*/,
  nameReg: /^(\w+)\s*/,
  nameTags: [ 'param', 'property' ],
  descriptionReg: /^([\s\S]*)/ }
```

### License 
MIT
