assert = chai.assert
expect = chai.expect

# clone to check mutability
{ projectDefaults, globalDefaults, bundleDefaults
  obj, arrInt, arrInt2, arrStr
} = _.clone data, true

persons = [
  {
    name: "agelos"
    male:true
  }

  {name: "AnoDyNoS"}
]

personDetails = [
  {
    age: 37
    address: "1 Peak Str, Earth"
    familyState: null
  }

  {
    age: 33
    familyState:
      married: false
  }
]

personDetails2 = [
  {
    surname: 'Peakoulas'
    name: "Agelos"
    age: undefined

    address: # overwrite String <-- {}
      street:'1 Peak Str'
      country: "Earth"

    familyState: # overwrite Boolean <-- {}
      married: true
      children: 3
  }

  {
    job: "Dreamer, developer, doer"
    #familyState: null # Does it overwrite 'Any <-- null' ? # @todo: uncomment when lodash #180 is solved
                      # Unsure! https://github.com/bestiejs/lodash/issues/180
  }
]


module.exports = (deepExtendMergeBlend)->

  describe 'lodashMerge_Blender-specs (shared): ', ->
    blended = deepExtendMergeBlend persons, personDetails, personDetails2

    it "'Persons' are deeply extended, overwriting from right to left.", ->
      expect(
        blended
      ).to.deep.equal [
        {
          surname: 'Peakoulas',
          name: "Agelos"
          age: 37 # Doesn't overwrite 'Any <-- Undefined'
          male:true
          address:
            street:'1 Peak Str'
            country: "Earth"
          familyState:
            married: true
            children: 3
        }

        {
          name: "AnoDyNoS"
          age: 33
          job: "Dreamer, developer, doer"
          familyState:        # Does it overwrite 'Any <-- null' ? Unsure! https://github.com/bestiejs/lodash/issues/180
            married: false
        }
      ]

    it "'Persons' === the destination/target/extended object: ", ->
      expect(blended).to.equal persons


    it "merges/blends 'Object <-- Array", ->
      result = deepExtendMergeBlend(
          {property:"I am an Object"}
          ['I am', 'an', 'Array']
        )

      expect(result).to.deep.equal {
          property: "I am an Object"
          0: 'I am'
          1: 'an'
          2: 'Array'
        }


    it "Array <-- Object", ->
      result = deepExtendMergeBlend(
          ['I am', 'an', 'Array']
          {property:"I am an Object"}
        )

      expected = ['I am', 'an', 'Array' ]
      expected.property = 'I am an Object' # Array should also have `property: 'I am an Object'`

      expect( result ).to.deep.equal expected

# @todo: uncomment these when lodash #180 is solved
# Does it overwrite 'Any <-- null' or 'Undefined' ? Unsure! https://github.com/bestiejs/lodash/issues/180
#    it "Null / Undefined as source are ignored", ->
#      result = deepExtendMergeBlend(
#         ['I am', 'an', 'Array']
#         [111, null, undefined, objProp: "Object Property"]
#         [null, undefined, null, anotherProp: "Another Object Property" ]
#      )
#
#      expect( result ).to.deep.equal [
#        111, 'an', 'Array',
#        {
#          objProp: "Object Property"
#          anotherProp: "Another Object Property"
#        }
#      ]
#
#    it "Null / Undefined as overwritten as destination ", ->
#      result = deepExtendMergeBlend(
#         [null, undefined, null, anotherProp: "Another Object Property" ]
#         [111, null, undefined, objProp: "Object Property"]
#         [null, 'I am', 'an']
#      )
#
#      expect( result ).to.deep.equal [
#        111, 'I am', 'an', {
#          objProp: "Object Property"
#          anotherProp: "Another Object Property"
#        }
#      ]


#    it "", ->
#      result = deepExtendMergeBlend()
#      expect( result ).to.deep.equal expected

#    it "", ->
#      result = deepExtendMergeBlend()
#      expect( result ).to.deep.equal expected

#    it "", ->
#      result = deepExtendMergeBlend()
#      expect( result ).to.deep.equal expected

#    it "", ->
#      result = deepExtendMergeBlend()
#      expect( result ).to.deep.equal expected

