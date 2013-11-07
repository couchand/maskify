# image manipulations

gm = require 'gm'

composite = (opts) ->
    opts.top ?= 0
    opts.left ?= 0
    opts.width ?= 0
    opts.height ?= 0
    opts.out ?= 'composite-out.png'
    opts.error ?= (e) ->
        console.error e if e

    gm().command('composite')
        .in('-geometry', "#{opts.width}x#{opts.height}+#{opts.left}+#{opts.top}")
        .in(opts.change, opts.base)
        .write opts.out, opts.error

module.exports =
    composite: composite
