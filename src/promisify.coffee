Promise = require 'yaku'
module.exports = (fn, self) ->
    (args...) ->
        if typeof args[args.length - 1] is 'function'
            return fn.apply self, args

        new Promise (resolve, reject) ->
            args.push (err, rs) ->
                if err then reject err else resolve rs
            fn.apply self, args
