assert = chai.assert
expect = chai.expect

{ objectWithProtoInheritedProps, Class3, c3, expectedPropertyValues

  project, team, bundle
  bundle_project_team

  earth
  laboratory
  experiment
  earth_laboratory_experiment
  experiment_laboratory_earth
  laboratory_experiment
} = data

describe "Defaults: The DeepDefaultsBlender, overwritting only null/undefined & merging all nested types", ->

  describe "Default settings:", ->
    deepDefaultsBlender = new _B.DeepDefaultsBlender

    describe "bundle, project, team", ->

      result = deepDefaultsBlender.blend {}, bundle, project, team

      it "_.isEqual result, bundle_project_team", ->
        expect(_.isEqual result, bundle_project_team).to.be.true

      it "_.isRefDisjoint result with each of bundle, project, team", ->
        for o in [bundle, project, team]
          expect(_B.isRefDisjoint result, o).to.be.true

    describe "earth, laboratory, experiment", ->

      result = deepDefaultsBlender.blend {}, earth, laboratory, experiment

      it "_.isEqual result, earth_laboratory_experiment", ->
        expect(_.isEqual result, earth_laboratory_experiment).to.be.true

      it "_.isRefDisjoint result with each of earth, laboratory, experiment", ->
        for o in [bundle, project, team]
          expect(_B.isRefDisjoint result, o).to.be.true

    describe "experiment, laboratory, earth", ->

      result = deepDefaultsBlender.blend {}, experiment, laboratory, earth

      it "_.isEqual result, experiment_laboratory_earth", ->
        expect(_.isEqual result, experiment_laboratory_earth).to.be.true

      it "_.isRefDisjoint result with each of experiment, laboratory, earth", ->
        for o in [experiment, laboratory, earth]
          expect(_B.isRefDisjoint result, o).to.be.true

    describe "laboratory, experiment", ->

      result = deepDefaultsBlender.blend {}, laboratory, experiment

      it "_.isEqual result, laboratory_experiment", ->
        expect(_.isEqual result, laboratory_experiment).to.be.true

      it "_.isRefDisjoint result with each of laboratory, experiment", ->
        for o in [laboratory, experiment]
          expect(_B.isRefDisjoint result, o).to.be.true



  describe 'Using path in BlenderBehavior.order: ', ->

    peopleUniqueBlender = new _B.DeepDefaultsBlender(

      # we overide the behavior of DeepDefaultsBlender for `* <-- []`,
      # only for Arrays somewhere within `/life/people/**`

      # We choose to add a person in the Array only if an person with same name exists,
      # in which case we simply update it.

      'order': ['src', 'path']
      Array: # our 'src'
        life: people: '|': # 'path' follows 'src' in order. @todo: allow '/life/people'
          (prop, src, dst, blender)->
              for person in src[prop]
                if not _.isArray dst[prop]
                  dst[prop] = []
                else # find person with same name
                  foundPerson = _.find(dst[prop], ((v)-> v.name is person.name))

                if not foundPerson            #push new person
                  dst[prop].push person
                else                          #update found person
                  _.extend foundPerson, person

              dst[prop]
    )

    result = peopleUniqueBlender.blend laboratory, experiment

    it "_.isEqual result, laboratory_experiment", ->
      expect(_.isEqual result, {
            name: 'laboratoryDefaults'
            environment:
               temperature: 35
               moisture: max: 40
               gravity: 1.5
            life:
               races: [ 'Caucasian', 'African', 'Asian', 'Mutant' ]
               people: [
                  { name: 'moe', age: 400 }
                  { name: 'larry', age: 500 }
                  { name: 'blanka', age: 20 }
                  { name: 'ken', age: 25 }
                  { name: 'ryu', age: 28 }
               ]
            results: success: false
          }
      ).to.be.true
