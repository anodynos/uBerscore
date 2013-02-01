 var x = "123456767891011121314151617181920"
   , expected = [x,x,x,x,x,x,x]
   , expected2 = [1,2,x,5,6,7,8,9,{a:x},12,expected,14,15,16,expected,30]
   , expected3 = 
    { a: x
    , b: x
    , c: x
    , d: x
    , e: x
    , f: x }
    , expected4 = expected
      expected4[4] = expected3
   
    console.log(inspect(expected))
    console.log(inspect(expected2))
    console.log(inspect(expected3))
    console.log(inspect(require))
