chai = require 'chai'
assert = chai.assert
expect = chai.expect

_ = require 'lodash'
_B = require 'uberscore'
l = new _B.Logger 'type-spec'

class AClass
  constructor: (@prop='a property value')->

anInstance = new AClass # {prop: 'a property value'}

oOs = { #@ todo: provide ALL test cases from The Good Parts !
  'Array':      [['this', 'is', 1, 'array'], new Array(1,2,3)]
  'Arguments':  [ do -> return arguments ]
  'Function':   [((x)->x), new Function("var a = 'a'"), class A, -> ]
  'String':     ["I am a String!", new String('I am another String')]
  'Number':     [667, new Number(668.13)]
  'Date':       [new Date()]
  'RegExp':     [/./g, new RegExp('/./')]
  'Boolean':    [true, false, new Boolean(true)]
  'Null':       [null]
  'Undefined':  [undefined, `void 0`, do ->]
  'Object':     [{someProp:'SomeVal'}, anInstance, new Object, new ->] # also works for plain objects {}, BUT NOT for Function and Array
}
describe 'types & its associates:', ->

  describe "`type` distisquishes all types", ->
    for typeName, values of oOs
      for value in values
        do (typeName
            value
            longType = _B.type(value)
            shortType = _B.type(value, true)
          )->
            it "`type` recognises value of type '#{typeName}' both as long='#{longType}', as short='#{shortType}", ->
              expect( longType ).to.equal _B.type.toLong(typeName)
              expect(_B.type.isType longType ).to.be.true

              expect( shortType ).to.equal _B.type.toShort(typeName)
              expect(_B.type.isType shortType ).to.be.true

              expect( _B.type.areEqual longType, shortType).to.be.true
              null
      null
    null

  describe '`type` recognises all Object/Hashes {} correctly :', ->
    it "`type` correctly treats instances as Object, unlike lodash's `_.isPlainObject(anInstance) is false`", ->
      expect(_.isPlainObject anInstance ).to.be.false # how bad is that ? We cant safely distinquish an {} from all others, if its an instance.
      expect(_B.type anInstance ).to.equal 'Object'

  describe "`_B.isObject` uses the above to solve distinquishing an {} from other types (->, []), even if {} is an instance.", ->
    it "`_B.isObject` recognises all {} as Objects, all Arrays & Functions are NON Objects", ->
      expect(_B.isObject anInstance ).to.be.true
      expect(_B.isObject {}).to.be.true
      expect(_B.isObject []).to.be.false
      expect(_B.isObject ->).to.be.false

    it "`_.isObject` is too broad - considers Arrays & Functions as `Object`", ->
      expect(_.isObject anInstance ).to.be.true
      expect(_.isObject {} ).to.be.true
      expect(_.isObject []).to.be.true  # that's too broad, it forces us to explicitelly use isArray
      expect(_.isObject ->).to.be.true  # again's too broad, it forces us to explicitelly use isFunction

    it "`_.isPlainObject` (lodash) is too strict - non `Object` constructed {} are not Object!", ->
      expect(_.isPlainObject {} ).to.be.true          # ok... but
      expect(_.isPlainObject anInstance ).to.be.false # ... very bad!
      expect(_.isPlainObject []).to.be.false          # ok, but still woobly
      expect(_.isPlainObject ->).to.be.false          # ok, but still woobly

  describe '`isObject` recognises all types correctly:', ->
    for typeName, values of oOs
      for value in values
        do (typeName, value)->
          it "`isObject` for '#{typeName}' returns '#{if typeName is 'Object' then 'true' else 'false'}", ->
            if typeName is 'Object'
              expect( _B.isObject value).to.be.true
            else
              expect( _B.isObject value).to.be.false
            null
      null
    null

  describe 'isPlain correctly recognises plain (non-nested) value types:', ->
    isPlainType = (typeName)->typeName in [ 'String', 'Date', 'RegExp', 'Number', 'Boolean', 'Null', 'Undefined']
    for typeName, values of oOs
      for value in values
        do (typeName, value)->
            it "`isPlain` recognises all '#{typeName}' as a #{if isPlainType typeName then '' else 'NON'} plain type", ->
              if isPlainType typeName
                expect( _B.isPlain value).to.be.true
              else
                expect( _B.isPlain value).to.be.false
              null
      null
    null