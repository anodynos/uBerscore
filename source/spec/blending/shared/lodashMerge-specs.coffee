assert = chai.assert
expect = chai.expect

# clone to check mutability
{ projectDefaults, globalDefaults, bundleDefaults,
  obj, arrInt, arrInt2, arrStr
} = _.clone data, true

module.exports = (deepExtendMergeBlend)->

  describe 'lodash.merge specs', ->

    it "should merge `source` into the destination object", ->
      names = stooges: [
        name: "moe"
      ,
        name: "larry"
      ]
      ages = stooges: [
        age: 40
      ,
        age: 50
      ]
      heights = stooges: [
        height: "5'4\""
      ,
        height: "5'5\""
      ]
      expected = stooges: [
        name: "moe"
        age: 40
        height: "5'4\""
      ,
        name: "larry"
        age: 50
        height: "5'5\""
      ]

      expect(
        deepExtendMergeBlend names, ages, heights
      ).to.deep.equal expected

    it "should merge sources containing circular references", ->
      object =
        foo: a: 1
        bar: a: 2

      source =
        foo:b:foo:c: {}
        bar: {}

      source.foo.b.foo.c = source
      source.bar.b = source.foo.b
      actual = deepExtendMergeBlend object, source

      expect(
        actual.bar.b is actual.foo.b and actual.foo.b.foo.c is actual.foo.b.foo.c.foo.b.foo.c
      ).to.be.true


    it "should merge problem JScript properties (test in IE < 9)", ->
      object =
        constructor: 1
        hasOwnProperty: 2
        isPrototypeOf: 3

      source =
        propertyIsEnumerable: 4
        toLocaleString: 5
        toString: 6
        valueOf: 7

      blended = deepExtendMergeBlend object, source

      expect(
        blended
      ).to.deep.equal {
          constructor: 1
          hasOwnProperty: 2
          isPrototypeOf: 3
          propertyIsEnumerable: 4
          toLocaleString: 5
          toString: 6
          valueOf: 7
      }


#
#    it "", ->
#      expect(
#        deepExtendMergeBlend(
#
#        )
#      ).to.deep.equal(
#
#      )


# lodash tests
#(->
#  args = arguments_
#  test "should merge `source` into the destination object", ->
#   DONE!
#
#  test "should merge sources containing circular references", ->
#   DONE!
#

#
#  test "should merge problem JScript properties (test in IE < 9)", ->
# DONE!
#
#  test "should not treat `arguments` objects as plain objects", ->
#    object = args: args
#    source = args:
#      3: 4
#
#    actual = _.merge(object, source)
#    equal _.isArguments(actual.args), false
#
#  test "should work with four arguments", ->
#    expected = a: 4
#    deepEqual _.merge(
#      a: 1
#    ,
#      a: 2
#    ,
#      a: 3
#    , expected), expected
#
#  test "should work with `_.reduce`", ->
#    actual = a: 1
#    array = [
#      b: 2
#    ,
#      c: 3
#    ]
#    _.reduce array, _.merge, actual
#    deepEqual actual,
#      a: 1
#      b: 2
#      c: 3
#
#
#  test "should assign `null` values", ->
#    actual = _.merge(
#      a: 1
#    ,
#      a: null
#    )
#    strictEqual actual.a, null
#
#  test "should not assign `undefined` values", ->
#    a = undefined
#    actual = _.merge(
#      a: 1
#    ,
#      a: `undefined`
#    )
#    strictEqual actual.a, 1
#
#  test "should pass the correct `callback` arguments", ->
#    args = undefined
#    _.merge
#      a: 1
#    ,
#      a: 2
#    , ->
#      args or (args = slice.call(arguments_))
#
#    deepEqual args, [1, 2]
#
#  test "should correct set the `this` binding", ->
#    actual = _.merge({},
#      a: 0
#    , (a, b) ->
#      this[b]
#    , [2])
#    deepEqual actual,
#      a: 2
#
#
#) 1, 2, 3


# Original code from 1.0.0rc3
#
# (function() {
#    var args = arguments;
#
#    test('should merge `source` into the destination object', function() {
#      var names = {
#        'stooges': [
#          { 'name': 'moe' },
#          { 'name': 'larry' }
#        ]
#      };
#
#      var ages = {
#        'stooges': [
#          { 'age': 40 },
#          { 'age': 50 }
#        ]
#      };
#
#      var heights = {
#        'stooges': [
#          { 'height': '5\'4"' },
#          { 'height': '5\'5"' }
#        ]
#      };
#
#      var expected = {
#        'stooges': [
#          { 'name': 'moe', 'age': 40, 'height': '5\'4"' },
#          { 'name': 'larry', 'age': 50, 'height': '5\'5"' }
#        ]
#      };
#
#      deepEqual(_.merge(names, ages, heights), expected);
#    });
#
#    test('should merge sources containing circular references', function() {
#      var object = {
#        'foo': { 'a': 1 },
#        'bar': { 'a': 2 }
#      };
#
#      var source = {
#        'foo': { 'b': { 'foo': { 'c': { } } } },
#        'bar': { }
#      };
#
#      source.foo.b.foo.c = source;
#      source.bar.b = source.foo.b;
#
#      var actual = _.merge(object, source);
#      ok(actual.bar.b === actual.foo.b && actual.foo.b.foo.c === actual.foo.b.foo.c.foo.b.foo.c);
#    });
#
#    test('should merge problem JScript properties (test in IE < 9)', function() {
#      var object = {
#        'constructor': 1,
#        'hasOwnProperty': 2,
#        'isPrototypeOf': 3
#      };
#
#      var source = {
#        'propertyIsEnumerable': 4,
#        'toLocaleString': 5,
#        'toString': 6,
#        'valueOf': 7
#      };
#
#      deepEqual(_.merge(object, source), shadowed);
#    });
#
#    test('should not treat `arguments` objects as plain objects', function() {
#      var object = {
#        'args': args
#      };
#
#      var source = {
#        'args': { '3': 4 }
#      };
#
#      var actual = _.merge(object, source);
#      equal(_.isArguments(actual.args), false);
#    });
#
#    test('should work with four arguments', function() {
#      var expected = { 'a': 4 };
#      deepEqual(_.merge({ 'a': 1 }, { 'a': 2 }, { 'a': 3 }, expected), expected);
#    });
#
#    test('should work with `_.reduce`', function() {
#      var actual = { 'a': 1},
#          array = [{ 'b': 2 }, { 'c': 3 }];
#
#      _.reduce(array, _.merge, actual);
#      deepEqual(actual, { 'a': 1, 'b': 2, 'c': 3});
#    });
#
#    test('should assign `null` values', function() {
#      var actual = _.merge({ 'a': 1 }, { 'a': null });
#      strictEqual(actual.a, null);
#    });
#
#    test('should not assign `undefined` values', function() {
#      var a
#      var actual = _.merge({ 'a': 1 }, { 'a': undefined });
#      strictEqual(actual.a, 1);
#    });
#
#    test('should pass the correct `callback` arguments', function() {
#      var args;
#
#      _.merge({ 'a': 1 }, { 'a': 2 }, function() {
#        args || (args = slice.call(arguments));
#      });
#
#      deepEqual(args, [1, 2]);
#    });
#
#    test('should correct set the `this` binding', function() {
#      var actual = _.merge({}, { 'a': 0 }, function(a, b) {
#        return this[b];
#      }, [2]);
#
#      deepEqual(actual, { 'a': 2 });
#    });
#  }(1, 2, 3));


