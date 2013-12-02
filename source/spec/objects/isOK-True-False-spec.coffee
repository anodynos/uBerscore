truthies = [ {}, [], 'aa', 1, /./ ]
falsies =  [ '', 0, null, undefined ]

describe '_B.isOk:', ->

  for v in truthies.concat (new Boolean false)
    do (v)->
      it "with truthy type:'#{_B.type v}', value:'#{v}'", ->
        ok _B.isOk v

  for v in falsies.concat false
    do (v)->
      it "with falsey type:'#{_B.type v}', value:'#{v}'", ->
        notOk _B.isOk v

describe '_B.isTrue:', ->

  describe 'true only with boolean true:', ->
    for v in [ true, new Boolean(true)]
      do (v)->
        it "type:'#{_B.type v}', value:'#{v}'", ->
          tru _B.isTrue v

  describe 'false with any truthy:', ->
    for v in truthies.concat (new Boolean false)
      do (v)->
        it "type:'#{_B.type v}', value:'#{v}'", ->
          fals _B.isTrue v

describe '_B.isFalse:', ->

  describe 'false *only with boolean false:', ->
    for v in [ false, new Boolean(false)]
      do (v)->
        it "type:'#{_B.type v}', value:'#{v}'", ->
          tru _B.isFalse v

  describe 'false with any falsies:', ->
    for v in falsies
      do (v)->
        it "type: '#{_B.type v}', value:'#{v}'", ->
          fals _B.isFalse v