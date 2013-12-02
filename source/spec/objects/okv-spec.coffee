describe 'okv :', ->
  weirdKeyName = ' $#%!@&'

  it "builds a simple object, with weird keyName", ->
    expect(
      _B.okv {},
        "foo_#{weirdKeyName}", 8
        "bar#{weirdKeyName}", 'some bar'
    ).to.deep.equal
        "foo_ $#%!@&": 8
        "bar $#%!@&": 'some bar'

  describe "build a more invloved object", ->#
    o = theO = {}

    o = _B.okv o,
      "foo_#{weirdKeyName}", 8
      bar = "bar#{weirdKeyName}", 'some bar' # note we store key name

    o[bar] = _B.okv {},
      "nestedBar#{weirdKeyName}", "This is a secret bar"
      "anotherBar#{weirdKeyName}", "Many bars, no foo"

    it "the object passed, is the object returned", ->
      expect(o).to.equal theO

    it "o is build, then part of it augmented", ->
      expect(o).to.deep.equal
         "foo_ $#%!@&": 8,
         "bar $#%!@&":
           "nestedBar $#%!@&": "This is a secret bar",
           "anotherBar $#%!@&": "Many bars, no foo"

    it "add nested weird keyd bars on existing key, with ignored reduntan key", ->
      _B.okv o[bar],
        "newbar#{weirdKeyName}", "a new bar!"
        'bar' + ("#{i}" for i in [1,2,3]).join('-'), "ther weirest bar!",
        'reduntantKey'

      expect(o).to.deep.equal
         "foo_ $#%!@&": 8,
         "bar $#%!@&":
           "nestedBar $#%!@&": "This is a secret bar",
           "anotherBar $#%!@&": "Many bars, no foo"
           "newbar $#%!@&": "a new bar!"
           "bar1-2-3": "ther weirest bar!"

  describe "passing a string instead of obj as 1st param & toString objects as keys", ->

    it "creates a new object, when 1st param is a String, which becomes the 1st key", ->
      o = _B.okv 'some' + 'property', {a:'value'}
      expect(o).to.deep.equal 'someproperty': {a:'value'}

    it "key is an object, converted toString", ->

      objectWithToString =
        prop: 'a property of an object'
        toString:-> @prop + ' that becomes a String'

      o = _B.okv {}, objectWithToString, {a:'value'}
      expect(o).to.deep.equal 'a property of an object that becomes a String': {a:'value'}




