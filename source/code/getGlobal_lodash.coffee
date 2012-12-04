define -> #window._
#  if window._
#    window._
#  else
#    require 'lodash'

  console.log "window._ is \n", window._
  if window._
    window._
  else
    x = require "lodash"
    console.log "x is \n", x
    console.log "window._ is \n", window._
    x