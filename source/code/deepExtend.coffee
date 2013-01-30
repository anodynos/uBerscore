_ = require 'lodash' # not need anymore, we have it as a uRequire 'dependencies.bundleExports' !
prettify = (o)-> JSON.stringify o, null, ' '

# Coffeescript adaptation & changes/extra features by Agelos.Pikoulas@gmail.com
# Original by Kurt Milam - follows below

# Changes/extra features
# - extra: allow lodash'es 'shadowed' variables
# - change: ${} instead of #{} in parentRE, cause it conflicts with Coffeescript!

#/**
#   * Based conceptually on the _.extend() function in underscore.js ( see http://documentcloud.github.com/underscore/#extend for more details )
#   * Copyright (C) 2012 Kurt Milam - http://xioup.com | Source: https://gist.github.com/1868955
#   *
#   * This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
#   *
#   * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#   *
#   * You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/.
#   **/
shadowed = [
  'constructor'
  'hasOwnProperty'
  'isPrototypeOf'
  'propertyIsEnumerable'
  'toLocaleString'
  'toString'
  'valueOf'
  ]

deepExtend = (obj, sources...) ->
  parentRE = /\${\s*?_\s*?}/

  #for source in sources
  for source in sources
    for own prop of source
      if _.isUndefined(obj[prop])
        obj[prop] = source[prop]
      else
        ###
        String
        ###
        if _.isString(source[prop]) and parentRE.test(source[prop])
          if _.isString(obj[prop])
            obj[prop] = source[prop].replace parentRE, obj[prop]

        else
          ### Array ###
          if _.isArray(obj[prop]) or _.isArray(source[prop])
            if not _.isArray(obj[prop]) or not _.isArray(source[prop])
              throw """
                deepExtend: Error: Trying to combine an array with a non-array.

                Property: #{prop}
                destination[prop]: #{prettify obj[prop]}
                source[prop]: #{prettify source[prop]}

                #{(if _.isArray(source[prop])
                    'source is Array: '
                  else
                    'source is NOT Array: ') + source[prop]
                }

                #{(if _.isArray(obj[prop])
                    'destination is Array: '
                  else
                    'destination is NOT Array: ') + obj[prop]
                }
                """
            else
              obj[prop] = _.reject(deepExtend(obj[prop], source[prop]), (item)->_.isNull item)

          else
            ### Object ###
            if ( _.isObject(obj[prop]) and
                 not (_.isFunction(obj[prop]) and prop in shadowed)) or #lodash merge appears to have this behaviour
                _.isObject(source[prop])
              if not _.isObject(obj[prop]) or not _.isObject(source[prop])
                throw """
                  deepExtend: Error trying to combine an object with a non-object.

                  Property: #{prop}
                  destination[prop]: #{prettify obj[prop]}
                  source[prop]: #{prettify source[prop]}

                  #{(if _.isObject(source[prop])
                      'source is Object: '
                    else
                      'source is NOT Object: ') + source[prop]
                  }

                  #{(if _.isObject(obj[prop])
                      'destination is Object: '
                    else
                      'destination is NOT Object: ') + obj[prop]
                  }
                """
              else
                obj[prop] = deepExtend(obj[prop], source[prop])

            # All non-nested sources
            else
              val = source[prop]
              if (val is null) and (_.isPlainObject obj)
                delete obj[prop]
              else
                obj[prop] = val

  # _.reject(obj, (item)->_.isNull item)  # @todo: without this, its not consistent
                                          # in `[1,2,3,4], ["${_}",null]`
                                          # VS `{a:[1,2,3,4]}, {a:["${_}",null]}`
                                          # but leave it to the outside user to decide!
  obj

module.exports = deepExtend


## Inline dev tests

#console.log deepExtend(
#          [1,       2,        3,  4]
#          ["${_}",  null]
#        )

#data = require '../spec/spec-data'
## clone to check mutability
#projectDefaults = _.clone data.projectDefaults, true
#globalDefaults = _.clone data.globalDefaults, true
#bundleDefaults = _.clone data.bundleDefaults, true
#
#result = deepExtend globalDefaults, projectDefaults, bundleDefaults
#
#console.log JSON.stringify result, null, ' '
#console.log deepExtend({url: "www.example.com"}, {url: 'http://!{_}/path/to/file.html'})
#
#
#
############ Original js code
#//  var _ = require('lodash')
#//
#//  deepExtend = function (obj) {
#//    var parentRE = /#{\s*?_\s*?}/,
#//      slice = Array.prototype.slice,
#//      hasOwnProperty = Object.prototype.hasOwnProperty;
#//
#//    _.each(slice.call(arguments, 1), function (source) {
#//      for (var prop in source) {
#//        if (hasOwnProperty.call(source, prop)) {
#//          if (_.isUndefined(obj[prop])) {
#//            obj[prop] = source[prop];
#//          }
#//          else if (_.isString(source[prop]) && parentRE.test(source[prop])) {
#//            if (_.isString(obj[prop])) {
#//              obj[prop] = source[prop].replace(parentRE, obj[prop]);
#//            }
#//          }
#//          else if (_.isArray(obj[prop]) || _.isArray(source[prop])) {
#//            if (!_.isArray(obj[prop]) || !_.isArray(source[prop])) {
#//              throw 'Error: Trying to combine an array with a non-array (' + prop + ')';
#//            } else {
#//              obj[prop] = _.reject(deepExtend(obj[prop], source[prop]), function (item) {
#//                return _.isNull(item);
#//              });
#//            }
#//          }
#//          else if (_.isObject(obj[prop]) || _.isObject(source[prop])) {
#//            if (!_.isObject(obj[prop]) || !_.isObject(source[prop])) {
#//              throw 'Error: Trying to combine an object with a non-object (' + prop + ')';
#//            } else {
#//              obj[prop] = deepExtend(obj[prop], source[prop]);
#//            }
#//          } else {
#//            obj[prop] = source[prop];
#//          }
#//        }
#//      }
#//    });
#//    return obj;
#//  };


#  /**
#   * Dependency: underscore.js ( http://documentcloud.github.com/underscore/ )
#   *
#   * Mix it in with underscore.js:
#   * _.mixin({deepExtend: deepExtend});
#   *
#   * Call it like this:
#   * var myObj = _.deepExtend(grandparent, child, grandchild, greatgrandchild)
#   *
#   * Notes:
#   * Keep it DRY.
#   * This function is especially useful if you're working with JSON config documents. It allows you to create a default
#   * config document with the most common settings, then override those settings for specific cases. It accepts any
#   * number of objects as arguments, giving you fine-grained control over your config document hierarchy.
#   *
#   * Special Features and Considerations:
#   * - parentRE allows you to concatenate strings. example:
#   * var obj = _.deepExtend({url: "www.example.com"}, {url: "http://#{_}/path/to/file.html"});
#   * console.log(obj.url);
#   * output: "http://www.example.com/path/to/file.html"
#   *
#   * - parentRE also acts as a placeholder, which can be useful when you need to change one value in an array, while
#   * leaving the others untouched. example:
#   * var arr = _.deepExtend([100, {id: 1234}, true, "foo", [250, 500]],
#   * ["#{_}", "#{_}", false, "#{_}", "#{_}"]);
#   * console.log(arr);
#   * output: [100, {id: 1234}, false, "foo", [250, 500]]
#   *
#   * - The previous example can also be written like this:
#   * var arr = _.deepExtend([100, {id:1234}, true, "foo", [250, 500]],
#   * ["#{_}", {}, false, "#{_}", []]);
#   * console.log(arr);
#   * output: [100, {id: 1234}, false, "foo", [250, 500]]
#   *
#   * - And also like this:
#   * var arr = _.deepExtend([100, {id:1234}, true, "foo", [250, 500]],
#   * ["#{_}", {}, false]);
#   * console.log(arr);
#   * output: [100, {id: 1234}, false, "foo", [250, 500]]
#   *
#   * - Array order is important. example:
#   * var arr = _.deepExtend([1, 2, 3, 4], [1, 4, 3, 2]);
#   * console.log(arr);
#   * output: [1, 4, 3, 2]
#   *
#   * - You can remove an array element set in a parent object by setting the same index value to null in a child object.
#   * example:
#   * var obj = _.deepExtend({arr: [1, 2, 3, 4]}, {arr: ["#{_}", null]});
#   * console.log(obj.arr);
#   * output: [1, 3, 4]
#   *
#   **/


