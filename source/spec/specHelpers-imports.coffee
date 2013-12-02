# these vars are 'imported' in every module
# or once in `combined` template
# using module.mergedCode
{ equal, notEqual,
  ok, notOk,
  tru, fals,
  deepEqual, notDeepEqual,
  exact, notExact,
  iqual, notIqual,
  ixact, notIxact,
  like, notLike,
  likeBA, notLikeBA,
  equalSet, notEqualSet
} = specHelpers