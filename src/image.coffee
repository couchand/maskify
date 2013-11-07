# image manipulations

gm = require 'gm'

rotate = (opts) ->
    opts.rotate ?= 0
    opts.out ?= './rotate-out.png'
    opts.success ?= ->
    opts.error ?= (e) ->
        console.error e if e
    opts.handle ?= (e) ->
        if not e then opts.success() else opts.error e

    gm(opts.in)
        .rotate("#000F", opts.rotate)
        .write opts.out, opts.handle

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
    rotate: rotate
