define ->

  class CoffeeUtils

    # Gets all coffeescript classes (i.e constructors linked via __super__) of given obj, constructor or target instance.
    # If called on an instance without params, it gets all inherited classes for this instance (including its own class).
    #
    # @param instOrClass {Object|class} optional
    #   If an object instance is passed, we get all the classes that its constructor is extending (including its own class)
    #   If a constructor Function (i.e coffeeScript class) is passed, we again get all classes it is extending.
    #
    #   It can be called without `instOrClass` param, in which case it is initialized to `this`, which means:
    #     * the instance if the target is an instance (i.e `myinstance.getClasses()`
    #     * the class if its called statically on the class (i.e `MyClass.getClasses()`)
    #
    # @return Array<Function> of coffeescript classes (i.e `constructor`s) of given object or class/constuctor.
    #    Order is descending i.e Base class is first, followed by all subclasses, the last one being the given constructor / current instance's class.
    getClasses: (instOrClass, _classes=[])->
      instOrClass = @ if not instOrClass

      if (typeof instOrClass) isnt 'function'
        instOrClass = instOrClass.constructor

      _classes.unshift instOrClass
      if instOrClass.__super__
        @getClasses instOrClass.__super__.constructor, _classes
      else
        _classes

    @getClasses: @::getClasses