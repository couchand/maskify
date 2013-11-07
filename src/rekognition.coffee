# rekognition api

request = require('http').request
stringify = require('querystring').stringify

class ReKognition
    constructor: (@creds) ->

    request: (params, cb) ->
        _params = {}
        _params[k] = v for k, v of params
        _params.api_key = @creds.api_key
        _params.api_secret = @creds.api_secret
        opts =
            hostname: "rekognition.com"
            path: "/func/api/?#{stringify _params}"

        request opts, cb

module.exports = (c) ->
    new ReKognition c
