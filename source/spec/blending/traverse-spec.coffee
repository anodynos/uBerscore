# @todo: spec properly - this is lame
describe 'traverse:', ->
  o =
    a:
      a1:
        a1_1:
          a1_1_1: 111
      a2:
        bingo: true
        a2_1:
          a2_1_1: 211
     b:2

  it 'traverses nested objects', ->
    props = []
    _B.traverse o, (prop, src, blender)-> props.push prop
    expect(props).to.be.deep.equal ['a','a1', 'a1_1','a2', 'a2_1']

  it 'quits branch if callback returns false', ->
    props = []
    _B.traverse o,
      (prop, src, blender)->
        props.push prop
        return false if src[prop].bingo is true

    expect(props).to.be.deep.equal ['a','a1', 'a1_1','a2']