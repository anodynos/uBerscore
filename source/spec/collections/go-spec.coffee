assert = chai.assert
expect = chai.expect

# clone to check mutability
{ projectDefaults, globalDefaults, bundleDefaults
  obj, arrInt, arrInt2, arrStr
} = _.clone data, true

# simple usage
describe "go: version 0.0.3", ->
  describe "go: Object passed, no params, ", ->
    result = _B.go obj
    it "should be a same looking object", ->
      expect( result ).to.deep.equal obj

    it "but should NOT be the *identical* object, but a clone of it", ->
     expect( result ).to.not.equal obj
     expect( result isnt obj ).to.be.true # is / === check equality ?

  describe "go: Array<int> passed, no params, ", ->
    result = _B.go arrInt
    it "equal's contents array returned", ->
      expect( result ).to.deep.equal arrInt

    it "but should NOT be the *identical* array, but a clone of it", ->
      expect( ).to.not.equal arrInt


  describe "go: Array<String> passed, no params, ", ->
    result = _B.go _B.go arrStr
    it "equal's contents array returned", ->
      expect( result ).to.deep.equal arrStr

    it "but should NOT be the *identical* array, but a clone of it", ->
      expect( result ).to.not.equal arrStr


  # filter
  describe "go: Filter : Object ", ->
    it "keys named b", ->
      expect(
        _B.go obj, fltr: (val, key)-> key not in ["b"]
      ).to.deep.equal
        ciba: 4, aaa: 7, c: -1

    it "values < 5", ->
      expect(
        _B.go obj, fltr: (val, key)-> val < 5
      ).to.deep.equal
        ciba: 4, b: 2, c: -1


  # Filter & sortBy Object
  describe "Object: filter values < 5 and sortBy key, ", ->
    result = _B.go obj,
          fltr: (val, key)-> val < 5
          sort: (val, key)-> key

    it "deeply equals {b: 2, ciba: 4, c: -1}", ->
      expect(result).to.deep.equal
        b: 2, ciba: 4, c: -1 ## irrespective of order!

    it "keys 'appear' sorted - WARNING: might not work with some runtimes!", ->
      expect(_.map result, (v,k)->k ).to.deep.equal [
          'b', 'c', 'ciba']

    it "iter respects sorted order", ->
      expect( _.map (_B.go result), (v,k)->k ).to.deep.equal [
          'b', 'c', 'ciba']

  describe "Object: filter large key-names & sortBy value descenting", ->
    result = _B.go obj,
          fltr: (val, key)-> key.length < 4
          sort: (val)-> -val

    it "deeply equals {aaa: 7, b: 2, c: -1}", ->
      expect(result).to.deep.equal
        aaa: 7, b: 2, c: -1 # irrespective of order!

    it "keys 'appear' sorted - WARNING: might not work with some runtimes!", ->
      expect(_.map result, (v,k)->k ).to.deep.equal [
          'aaa', 'b', 'c' ]

    it "iter respects sorted order", ->
      expect( _.map (_B.go result), (v,k)->k ).to.deep.equal [
          'aaa', 'b', 'c']

  # Filter & sortBy Array<int>
  describe "Object: filter values < 5 and sortBy value", ->
    result = _B.go arrInt,
          fltr: (val)-> val < 5
          sort: (val)-> val

    it "deeply equals [-1, 2, 4] ", ->
      expect(result).to.deep.equal [-1, 2, 4] ## order matters!

  # Filter & sortBy Array<String>
  describe "Object: filter historical names and sortBy value", ->
    result = _B.go arrStr,
          fltr: (val)-> val not in ['Babylon', 'Sparta']
          sort: (val)-> val

    it "deeply equals ['Agelos', 'Anodynos', 'Pikoulas' ] ", ->
      expect(result).to.deep.equal ['Agelos', 'Anodynos', 'Pikoulas'] ## order matters!

  # Collecting!
  describe "Collecting types & objects", ->
    describe "Object: collects to Array & Object!", ->

      it "collect values as Array ", ->
        expect(
          _B.go obj,
            sort: (v,k)->k # @todo true to use default ({}: key, []:val)
            grab: '[]' # or 'array', 'a' or [] (slower). Will collect VALUES on this type
        ).to.deep.equal(
          [ 7, 2, -1, 4 ]
        )

      it "declaratively collect on another object, but also returns Obj!", ->
        newObj = {oldKey: "oldValue"}
        result = _B.go obj,
                    sort: (v,k)->k #
                    grab: newObj

        expect(newObj).to.deep.equal { oldKey: "oldValue", aaa:7, b:2, c:-1, ciba:4 }
        expect(result).to.deep.equal { aaa:7, b:2, c:-1, ciba:4 }


      it "using grab:-> collects keys as Array (in reverse -unsihft!), but returns sorted proper sorted Obj!", ->
        newArr = []
        result = _B.go obj,
                    sort: (v,k)->k #
                    grab: (v,k)-> newArr.unshift k

        expect(newArr).to.deep.equal [ 'ciba', 'c', 'b', 'aaa']
        expect(result).to.deep.equal { aaa:7, b:2, c:-1, ciba:4 }


    describe "Array: collects to Object (& Array)!", ->
      it "returns an Object when grab instructs it", ->
        expect(
          _B.go arrInt,
            sort: (v,k)->v # @todo true to use default ({}: key, []:val)
            fltr: (v)-> v < 7
            grab: '{}' # or 'object', 'o' or {} (slower!). Will collect VALUES on this type
        ).to.deep.equal(
          { '0': -1, '1': 2, '2': 4 }
        )

      it "'grab' declaratively collects array values as object values, with idx as key",->
        newObj = {oldKey: "oldValue"}

        result = _B.go arrInt,
                    sort: (v)-> v #todo: true for value sorting
                    grab: newObj

        expect(newObj).to.deep.equal { '0': -1, '1': 2, '2': 4, '3': 7, oldKey: 'oldValue' }
        #it "it also returns Array of oa items, as they should be", ->
        expect(result).to.deep.equal { '0': -1, '1': 2, '2': 4, '3': 7 }

      it "using a function, it collects keys/values newObj, but returns sorted Array!", ->
        newObj = {oldKey: "oldValue"}

        result = _B.go arrInt,
                    sort: (v,k)->v
                    grab: (v,k)-> newObj[k] = v

        expect(newObj).to.deep.equal { '0': -1, '1': 2, '2': 4, '3': 7, oldKey: 'oldValue' }
        #it "it also returns Array of oa items, as they should be", ->
        expect(result).to.deep.equal [ -1, 2, 4, 7 ]


  describe "Object: mimicking various _ functions!", ->
    it "resembles _.pick with single string name", ->
      expect(
        _B.go obj, fltr: 'ciba'
      ).to.deep.equal(
        _.pick obj, 'ciba'
      )

    it "resembles _.pick with array of String (or string evaluated objects)", ->
      aaa = {}
      aaa.toString =-> 'aaa'
      expect(
        _B.go obj, fltr: ['ciba', aaa]
      ).to.deep.equal(
        _.pick obj, 'ciba', aaa
      )

    it "resembles _.omit ", ->
      expect(
        _B.go obj, fltr: (v,k)-> k not in ['ciba', 'aaa']
      ).to.deep.equal(
        _.omit obj, 'ciba', 'aaa'
      )

    it "resembles _.difference", ->
      expect(
        _B.go arrInt, fltr: (v)-> v not in arrInt2
      ).to.deep.equal(
        _.difference arrInt, arrInt2
      )

    it "resembles _.map", ->
      ar = []
      _B.go obj, grab:(v)-> ar.push v
      expect( ar ).to.deep.equal( _.map obj, (v)->v )

    it "resembles _.map, with a difference: not restricted to collect in array!", ->
      ob = {}
      _B.go obj, grab:(v,k)-> ob[v]=k

      expect(ob).to.deep.equal(
        '4':'ciba', '7':'aaa', '2':'b', '-1':'c'
      )

    it "resembles _.keys (with order guaranteed!)", ->
      keys = []
      result = _B.go obj,
        sort: (v,k)->k
        grab: (v,k)->keys.push k  # @todo: allow 'keys' as shortcut for [] & keys ???
      expect(keys).to.deep.equal (_.keys obj).sort()

      #it "it also returns object of oa items, as they should be", ->
      expect(result).to.deep.equal { aaa: 7, b: 2, c: -1, ciba: 4}

    it "resembles _.pluck", ->
      stooges = [
          { 'name': 'moe', 'age': 40 },
          { 'name': 'larry', 'age': 50 },
          { 'name': 'curly', 'age': 60 }
        ]
      names = []
      _B.go stooges, grab: (v)-> names.push v.name

      expect(names).to.deep.equal _.pluck stooges, 'name'

      #it "but can grab more than just field names", ->
      agedNames = []
      _B.go stooges,
        grab: (v)-> agedNames.push v.name + " (" + v.age + ")"

      expect(agedNames).to.deep.equal ['moe (40)', 'larry (50)', 'curly (60)']


  describe "Original objects not mutated", ->
    expect(bundleDefaults).to.deep.equal data.bundleDefaults
    expect(projectDefaults).to.deep.equal data.projectDefaults
    expect(globalDefaults).to.deep.equal data.globalDefaults
    expect(obj).to.deep.equal data.obj
    expect(arrStr).to.deep.equal data.arrStr
    expect(arrInt).to.deep.equal data.arrInt
    expect(arrInt2).to.deep.equal data.arrInt2
