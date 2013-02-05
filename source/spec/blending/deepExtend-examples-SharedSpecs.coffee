assert = chai.assert
expect = chai.expect

# clone to check mutability
{ projectDefaults, globalDefaults, bundleDefaults
  obj, arrInt, arrInt2, arrStr
} = _.clone data, true

module.exports = (deepExtendMergeBlend)->

  describe 'deepExtend source code examples : ', ->

    it "parentRE allows you to concatenate strings.", ->
      expect(
        deepExtendMergeBlend(
          {url: "www.example.com"},
          {url: 'http://${_}/path/to/file.html'}
        )
      ).to.deep.equal url:"http://www.example.com/path/to/file.html"

    it """
       parentRE also acts as a placeholder, which can be useful when you need to change one value in an array,
       while leaving the others untouched.
       """, ->
          expect(
            deepExtendMergeBlend(
              [100,     {id: 1234}, true, "foo", [250, 500]],
              ["${_}", "${_}", false, "${_}", "${_}"]
            )
          ).to.deep.equal [100, {id: 1234}, false, "foo", [250, 500]]

    it "parentRE also acts as a placeholder, #2 ", ->
      expect(
        deepExtendMergeBlend(
          [100,     {id:1234},  true,   "foo",    [250, 500]],
          ["${_}",  {},         false,  "${_}",   []]
        )
      ).to.deep.equal [100, {id: 1234}, false, "foo", [250, 500]]

    it "parentRE also acts as a placeholder, #3", ->
      expect(
        deepExtendMergeBlend(
          [100,      {id:1234},   true,       "foo",    [250, 500]],
          ["${_}",   {},          false]
        )
      ).to.deep.equal [100, {id: 1234}, false, "foo", [250, 500]]

    it "Array order is important.", ->
      expect(
        deepExtendMergeBlend(
          [1, 2, 3, 4],
          [1, 4, 3, 2]
        )
      ).to.deep.equal [1, 4, 3, 2]

    it "Remove Array element in destination object, by setting same index to null in a source object.", ->
      expect(
        deepExtendMergeBlend(
          {arr: [1,       2,        3,  4]},
          {arr: ["${_}",  null]}
        )
      ).to.deep.equal arr: [1, 3, 4]

  describe 'more deepExtend examples: ', ->
    it "Remove Object key in destination object, by setting same key to undefined in a source object, similar to null in Array!", ->
      expect(
        deepExtendMergeBlend(
            {
              foo:"foo"
              bar:
                name:"bar"
                price:20
            }
            ,
            {
              foo:undefined
              bar:
                price:undefined
            }
        )
      ).to.deep.equal bar:name:'bar'