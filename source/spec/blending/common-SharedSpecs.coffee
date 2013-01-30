assert = chai.assert
expect = chai.expect

# clone to check mutability
{ projectDefaults, globalDefaults, bundleDefaults
  obj, arrInt, arrInt2, arrStr, persons, personDetails, personDetails2
} = _.clone data, true

module.exports = (deepExtendMergeBlend)->

  describe 'common (deepExtend, _.merge, _B.blend) examples', ->
    blended = deepExtendMergeBlend persons, personDetails, personDetails2

    it "'Persons' are deeply extended, overwriting from right to left.", ->
      expect(
        blended
      ).to.deep.equal [
        {
          surname: 'Peakoulas',
          name: "Agelos"
          age: 42
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
          familyState:
            married:false
            children:0
        }
      ]

    it "'Persons' === the destination/target/extended object", ->
      expect(blended).to.equal persons

#    it "", ->
#      expect(
#        deepExtendMergeBlend(
#
#        )
#      ).to.deep.equal (
#
#      )
#
#    it "", ->
#      expect(
#        deepExtendMergeBlend(
#
#        )
#      ).to.deep.equal (
#
#      )
#
#    it "", ->
#      expect(
#        deepExtendMergeBlend(
#
#        )
#      ).to.deep.equal (
#
#      )
#
#    it "", ->
#      expect(
#        deepExtendMergeBlend(
#
#        )
#      ).to.deep.equal (
#
#      )
#