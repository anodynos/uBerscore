chai = require 'chai'
assert = chai.assert
expect = chai.expect

_ = require 'lodash'
_B = require 'uBerscore' #

data = require './spec-data'
# clone to check mutability
projectDefaults = _.clone data.projectDefaults, true
globalDefaults = _.clone data.globalDefaults, true
bundleDefaults = _.clone data.bundleDefaults, true

describe 'okv :', ->
  weirdKeyName = ' $#%!@&'

  it "builds a simple object, with weird keyName", ->
    expect(
      _B.okv {},
        "foo_#{weirdKeyName}", 8
        "bar#{weirdKeyName}", 'some bar'
    ).to.deep.equal {
        "foo_ $#%!@&": 8
        "bar $#%!@&": 'some bar'
    }

  describe "build a more invloved object", ->#
    o = {}

    _B.okv o,
      "foo_#{weirdKeyName}", 8
      bar = "bar#{weirdKeyName}", 'some bar' # note we store key name

    o[bar] = _B.okv {},
      "nestedBar#{weirdKeyName}", "This is a secret bar"
      "anotherBar#{weirdKeyName}", "Many bars, no foo"

    it "o is build, then part of it augmented", ->
      expect(
        o
      ).to.deep.equal {
         "foo_ $#%!@&": 8,
         "bar $#%!@&":
           "nestedBar $#%!@&": "This is a secret bar",
           "anotherBar $#%!@&": "Many bars, no foo"
      }

    it "add nested weird keyd bars on existing key", ->
      _B.okv o[bar],
        "newbar#{weirdKeyName}", "a new bar!"
        'bar' + ("#{i}" for i in [1,2,3]).join('-'), "ther weirest bar!"

      expect(
        o
      ).to.deep.equal {
         "foo_ $#%!@&": 8,
         "bar $#%!@&":
           "nestedBar $#%!@&": "This is a secret bar",
           "anotherBar $#%!@&": "Many bars, no foo"
           "newbar $#%!@&": "a new bar!"
           "bar1-2-3": "ther weirest bar!"
      }


