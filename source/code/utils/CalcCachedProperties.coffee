define ['utils/CoffeeUtils'], (CoffeeUtils)->

  l = new (require 'Logger') 'uberscore/utils/CalcCachedProperties'

  # Instances have calculated *cached* properties.
  # Properties are calculated on 1st use, use the cache thereafter.
  # Properties can be cleaned with cleanProp (String|Function)...
  class CalcCachedProperties extends CoffeeUtils

    prefix = (prop)-> '__$$' + prop + '__$$'
    cacheKey = prefix 'cache'
    cUndefined = {'cUndefined':true} # allow undefined as a valid cached value - store this instead of deleting key

    # @return Object with {calcPropertyName:calcPropertyFunction} of all (inherited) calcProperties.
    # Properties in subclasses override (overwrite) those os super classes.
    getAllCalcProperties: (instOrClass=@)->
      calcProps = {}
      for aClass in @getClasses(instOrClass)
        for cProp, cFunct of aClass.calcProperties
          calcProps[cProp] = cFunct # overwrite inherited properties with subclass's properties
      calcProps

    @getAllCalcProperties: @::getAllCalcProperties

    Object.defineProperties @::,
      allCalcProperties: get:->
        if not @constructor::hasOwnProperty '_allCalcProperties' # use cached result, shared by all instances
          Object.defineProperty @constructor::, '_allCalcProperties', value: @getAllCalcProperties(), enumerable: false
        @constructor::_allCalcProperties

      classes: get:->
        if not @constructor::hasOwnProperty '_classes' # use cached result, shared by all instances
          Object.defineProperty @constructor::, '_classes', value: @getClasses(), enumerable: false
        @constructor::_classes

    constructor: -> @defineCalcProperties()

    defineCalcProperties: (isOverwrite)->
      Object.defineProperty @, cacheKey, value: {}, enumerable: false, configurable: false, writeable: false
      for cPropName, cPropFn of @allCalcProperties
        @[cacheKey][cPropName] = cUndefined
        if not @constructor::hasOwnProperty(cPropName) or isOverwrite
          do (cPropName, cPropFn)=>
            l.deb "...defining calculated property #{@constructor.name}.#{cPropName}" if l.deb(99)
            Object.defineProperty @constructor::, cPropName, # @todo: allow instance properties to be added dynamically
              enumerable: true
              configurable: true # @todo: check if its not same class and redefine ?
              get:->
                l.deb "...requesting calculated property #{@constructor.name}.#{cPropName}" if l.deb(99)
                if @[cacheKey][cPropName] is cUndefined
                  l.deb "...refreshing calculated property #{@constructor.name}.#{cPropName}" if l.deb(95)# and cPropName isnt 'dstFilenames'
                  @[cacheKey][cPropName] = cPropFn.call @
                @[cacheKey][cPropName]

              set: (v)-> @[cacheKey][cPropName] = v
      null

    # use as cleanProps 'propName1', ((p)-> p is 'propName2'), undefined, 'propName3'
    # or cleanProps() to clear them all
    # undefined args are ignored
    cleanProps: (cleanArgs...)->
      cleanArgs = _.keys(@allCalcProperties) if _.isEmpty cleanArgs
      cleaned = []
      for ca in cleanArgs when ca
        if _.isFunction ca
          propKeys = _.keys @allCalcProperties if not propKeys # `propKeys or=` can't be assigned with ||= because it has not been declared before
          for p in propKeys when ca(p)
            if @[cacheKey][p] isnt cUndefined
              l.deb "...delete (via fn) value of property #{@constructor.name}.#{p}" if l.deb 100
              @[cacheKey][p] = cUndefined
              cleaned.push p
        else # should be string-able
          if @[cacheKey][ca] isnt cUndefined
            l.deb "...delete value of property #{@constructor.name}.#{ca}" if l.deb 100
            @[cacheKey][ca] = cUndefined
            cleaned.push ca
      cleaned