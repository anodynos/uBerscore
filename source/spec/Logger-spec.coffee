describe "Logger debug():", ->

  describe "simple cases, no maxDebugLevel or pathLevels", ->

    before ->
      delete _B.Logger.debugPathsLevels # clear paths
      delete _B.Logger.maxDebugLevel

    describe "default instance debugLevel = 1:", ->
      l = new _B.Logger

      describe "test debug() :", ->

        it "default debug() level is also 1:", ->
          expect(l.deb "something").to.be.not.undefined

        it "does debug() for level 0 or 1:", ->
          expect(l.deb 0, "something").to.be.not.undefined
          expect(l.deb 1, "something").to.be.not.undefined

        it "not debug() for level > 1:", ->
          expect(l.deb 2, "something").to.be.undefined

      describe "test deb(level) on default debugLevel :", ->

        it "is true for ded(0) or deb(1):", ->
          expect(l.deb 0).to.be.true
          expect(l.deb "something").to.be.not.undefined

          expect(l.deb 1).to.be.true
          expect(l.deb "something").to.be.not.undefined

        it "not debug() for level > 1:", ->
          expect(l.deb 2).to.be.false
          expect(l.deb "something").to.be.undefined

    describe "set debugLevel instance level = 0:", ->
      l = new _B.Logger 'title', 0

      it "not debug() for default level = 1 :", ->
        expect(l.deb "something").to.be.undefined

      it "does debug() for explicit level = 0 :", ->
        expect(l.deb 0, "something").to.be.not.undefined

      it "not debug() for default level >= 1 :", ->
        expect(l.deb 1, "something").to.be.undefined
        expect(l.deb 2, "something").to.be.undefined

    describe "test deb(level) on user set debugLevel = 30:", ->
      l = new _B.Logger 'title', 30

      it "is true for ded(0) or deb(1):", ->
        expect(l.deb 0).to.be.true
        expect(l.deb "something").to.be.not.undefined

        expect(l.deb 30).to.be.true
        expect(l.deb "something").to.be.not.undefined

      it "not debug() for level > 30:", ->
        expect(l.deb 31).to.be.false
        expect(l.deb "something").to.be.undefined

  describe "With debug Path Levels, even as Number parsable strings:", ->
    before ->
      delete _B.Logger.debugPathsLevels
      _B.Logger.addDebugPathLevel 'foo/bar/froo', '60'
      _B.Logger.addDebugPathLevel 'foo/bar', '40'
      _B.Logger.addDebugPathLevel 'foo/', 10
      _B.Logger.addDebugPathLevel 'baz/faux', 12

    it "correctly sets _B.Logger.debugPathsLevels, as Numbers", ->
      expect(_B.Logger.debugPathsLevels).to.be.deep.equal
        foo:
          _level: 10
          bar:
            _level: 40
            froo:
              _level: 60
        baz:
          faux:
            _level:12

    it "throws Error if debugLevel is not parsable Number", ->
      expect(-> _B.Logger.addDebugPathLevel 'baz/faux', 'blah012').to.throw Error, /debugLevel 'blah012' isNaN (Not a Number or not Number parsable)*/

    describe "without Logger.maxDebugLevel  ", ->

      describe "getDebugPathLevel() gets the closest _level:", ->

        it "level of last common path", ->
          l = new _B.Logger 'foo/bar/joe/doe'
          expect(l.getDebugPathLevel()).to.equal 40

        it "level of exact common path #1", ->
          l = new _B.Logger '/foo'
          expect(l.getDebugPathLevel()).to.equal 10

        it "level of exact common path #2", ->
          l = new _B.Logger 'baz/faux/'
          expect(l.getDebugPathLevel()).to.equal 12

        it "level of inexistent path", ->
          l = new _B.Logger 'blah/blah/'
          expect(l.getDebugPathLevel()).to.be.undefined

        it "matching any path on root", ->
          _B.Logger.addDebugPathLevel '/', 5 # matches any path
          l = new _B.Logger 'blah/blah/'
          expect(l.getDebugPathLevel()).to.be.equal 5

      describe "logger instance without debugLevel", ->
        l = new _B.Logger 'foo/bar/joe/doe'

        it "is true for ded(<=30) :", ->
          expect(l.deb 0).to.be.true
          expect(l.deb "something").to.be.not.undefined

          expect(l.deb 1).to.be.true
          expect(l.deb "something").to.be.not.undefined

          expect(l.deb 30).to.be.true
          expect(l.deb "something").to.be.not.undefined

        it "not debug() for level > 40:", ->
          expect(l.deb 41).to.be.false
          expect(l.deb "something").to.be.undefined

      describe "logger instance debugLevel = 50 is respected", ->
        l = new _B.Logger 'foo/bar/joe/doe', 50

        it "is true for ded(<=50) :", ->
          expect(l.deb 0).to.be.true
          expect(l.deb "something").to.be.not.undefined

          expect(l.deb 1).to.be.true
          expect(l.deb "something").to.be.not.undefined

          expect(l.deb 50).to.be.true
          expect(l.deb "something").to.be.not.undefined

        it "not debug() for level > 40:", ->
          expect(l.deb 51).to.be.false
          expect(l.deb "something").to.be.undefined

      describe "logger instance debugLevel = 0 is respected:", ->
        l = new _B.Logger 'foo/bar/joe/doe', 0

        it "is true for ded(=0) :", ->
          expect(l.deb 0).to.be.true
          expect(l.deb "something").to.be.not.undefined

        it "is false for ded(>0) :", ->
          expect(l.deb 1).to.be.false
          expect(l.deb "something").to.be.undefined

          expect(l.deb 50).to.be.false
          expect(l.deb "something").to.be.undefined

          expect(l.deb 51).to.be.false
          expect(l.deb "something").to.be.undefined


    describe "with Logger.maxDebugLevel = 20 always respected as upper limit :", ->
      before -> _B.Logger.maxDebugLevel = 20

      describe "logger instance without debugLevel", ->
        l = new _B.Logger 'foo/bar/joe/doe'

        it "l.getDebugPathLevel()", ->
          expect(l.getDebugPathLevel()).to.equal 40

        it "is true for ded( <= Logger.maxDebugLevel = 20) :", ->
          expect(l.deb 0).to.be.true
          expect(l.deb "something").to.be.not.undefined

          expect(l.deb 1).to.be.true
          expect(l.deb "something").to.be.not.undefined

          expect(l.deb 20).to.be.true
          expect(l.deb "something").to.be.not.undefined

        it "not debug() for level > Logger.maxDebugLevel  = 20:", ->
          expect(l.deb 21).to.be.false
          expect(l.deb "something").to.be.undefined

      describe "logger instance with debugLevel = 50", ->
        l = new _B.Logger 'foo/bar/joe/doe', 50

        it "l.getDebugPathLevel()", ->
          expect(l.getDebugPathLevel()).to.equal 40

        it "is true for ded(<=20) :", ->
          expect(l.deb 0).to.be.true
          expect(l.deb "something").to.be.not.undefined

          expect(l.deb 1).to.be.true
          expect(l.deb "something").to.be.not.undefined

          expect(l.deb 20).to.be.true
          expect(l.deb "something").to.be.not.undefined

        it "not debug() for level > 20:", ->
          expect(l.deb 21).to.be.false
          expect(l.deb "something").to.be.undefined
