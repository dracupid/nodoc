nodoc
==================
Generate gitHub flavored markdown API doc from source code comments.

## Supported Languages
- CoffeeScript

### Language Name Alias
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


- #### <a href="./src/index.coffee?source#L29" target="_blank"><b>generate</b></a>
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

- #### <a href="./src/index.coffee?source#L59" target="_blank"><b>parser</b></a>
  Parser module, see below for details.



## Parser Module


- #### <a href="./src/parser/index.coffee?source#L21" target="_blank"><b>setParser</b></a>
  Create a new parser or override an old ones

  - **<u>param</u>**: `name` { _string_ }

    parser's name

  - **<u>param</u>**: `parser` { _Object_ }

    parser object

- #### <a href="./src/parser/index.coffee?source#L37" target="_blank"><b>parse</b></a>
  Parse source code directly.

  - **<u>param</u>**: `source` { _string_ }

    source code

  - **<u>param</u>**: `language` { _string_ }

    specify source language

  - **<u>param</u>**: `opts` { _Object=_ }

    option

  - **<u>return</u>**: { _Array_ }

    parsed comments object array

- #### <a href="./src/parser/index.coffee?source#L65" target="_blank"><b>parseFile</b></a>
  Parse source code from file. Use Promise instead of callback

  - **<u>param</u>**: `filePath` { _string_ }

    souce file path

  - **<u>param</u>**: `opts` { _Object=_ }

    option

  - **<u>return</u>**: { _Promise_ }

    resolve parsed comment object

- #### <a href="./src/parser/index.coffee?source#L72" target="_blank"><b>parseFileSync</b></a>
  Synchronous version of parseFile

  - **<u>return</u>**: { _Object_ }

    parsed comment object array

- #### <a href="./src/parser/index.coffee?source#L80" target="_blank"><b>setRule</b></a>
  Set parser's rule

  - **<u>param</u>**: `language` { _String_ }

    parser name

  - **<u>param</u>**: `rule` { _Object_ }

    parser's rule



## Write your own language parser

### Parser API

### Rule

