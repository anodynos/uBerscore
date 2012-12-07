define ->
  if typeof _ is "undefined"
    __nodeRequire "lodash"
  else
    _