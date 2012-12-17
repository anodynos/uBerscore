# This is bogus : it's not (yet) part of uberscore: Its here only as a test of uRequire (github.com/anodynos/urequire)
#Backbone = require 'backbone'
#module.exports = backboner = ()->
define ['backbone'], (Backbone)->
  ->
    console.log 'Loaded Backbone.VERSION=', Backbone.VERSION
    Backbone
