
### parser

This is a parser!

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

