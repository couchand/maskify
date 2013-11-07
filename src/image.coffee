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

scale = (opts) ->
    opts.scale ?= 1
    opts.out ?= './scale-out.png'
    opts.success ?= ->
    opts.error ?= (e) ->
        console.error e if e
    opts.handle ?= (e) ->
        if not e then opts.success() else opts.error e

    gm(opts.in)
        .size (err, size) ->
            throw 'up' if err
            @resize size.width*opts.scale, size.height*opts.scale
            @write opts.out, opts.handle

composite = (opts) ->
    opts.top ?= 0
    opts.left ?= 0
    opts.out ?= './composite-out.png'
    opts.error ?= (e) ->
        console.error e if e

    gm().command('composite')
        .in('-geometry', "+#{opts.left}+#{opts.top}")
        .in(opts.change)
        .in(opts.base)
        .write opts.out, opts.error

module.exports =
    composite: composite
    rotate: rotate
    scale: scale
