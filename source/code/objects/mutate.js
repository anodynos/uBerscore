/*
  Mutates the `Value` for each of the `Keys` of a given Object or Array

  @param oa Object or Array
  @param Function mutator (v,k) is given the old val & key and returns a new value.
  @param Filter as in `_B.isAgree`, otherwise this key/value its not mutated.
         Note: isAgree allows "undefined" as a truthy filter

  @todo: (2 2 2) mutateKey() ?
*/
var isAgree = require('agreement/isAgree');

var mutate = function(oa, mutator, fltr) {
  if (_.isFunction(mutator)) {
    _.each(oa, function(val, key) {
        if (isAgree(val, fltr)) {
          return oa[key] = mutator(val, key);
        }
    });
  }
  return oa;
};

module.exports = mutate;
