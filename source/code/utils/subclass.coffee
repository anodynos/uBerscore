## Borrowed from Backbone v.1.1 'extend' helper - renamed to subclass to differntiate from _.extend

# Helper function to correctly set up the prototype chain, for subclasses.
# Similar to `goog.inherits`, but uses a hash of prototype properties and
# class properties to be extended.
subclass = module.exports = (protoProps, staticProps) ->
  parent = this
  child = undefined

  # The constructor function for the new subclass is either defined by you
  # (the "constructor" property in your `extend` definition), or defaulted
  # by us to simply call the parent's constructor.
  if protoProps and _.has(protoProps, "constructor")
    child = protoProps.constructor
  else
    child = -> parent.apply this, arguments

  # Add static properties to the constructor function, if supplied.
  _.extend child, parent, staticProps

  # Set the prototype chain to inherit from `parent`, without calling
  # `parent`'s constructor function.
  Surrogate = -> @constructor = child; @
  Surrogate:: = parent::
  child:: = new Surrogate

  # Add prototype properties (instance properties) to the subclass,
  # if supplied.
  _.extend child::, protoProps if protoProps

  # Set a convenience property in case the parent's prototype is needed
  # later.
  child.__super__ = parent::
  child