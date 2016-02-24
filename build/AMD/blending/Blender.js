// Generated by uRequire v0.7.0-beta.25 target: 'AMD' template: 'AMD'
(function () {
  
var bind = function (fn, me) {
    return function () {
      return fn.apply(me, arguments);
    };
  }, extend = function (child, parent) {
    for (var key in parent) {
      if (hasProp.call(parent, key))
        child[key] = parent[key];
    }
    function ctor() {
      this.constructor = child;
    }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.__super__ = parent.prototype;
    return child;
  }, hasProp = {}.hasOwnProperty, slice = [].slice;
define(['require', 'exports', 'module', '../types/type', '../objects/getp', '../types/isHash', '../utils/CoffeeUtils', 'lodash', '../utils/subclass', '../Logger'], function (require, exports, module, type, getp, isHash, CoffeeUtils, _) {
  

var ActionResult, Blender;
  isHash = require("../types/isHash");
  ActionResult = function () {
    function ActionResult(name) {
      this.name = name;
    }
    return ActionResult;
  }();
  return Blender = function (superClass) {
    extend(Blender, superClass);
    Blender.subclass = require("../utils/subclass");
    Blender.prototype.inherited = false;
    Blender.prototype.copyProto = false;
    Blender.prototype.pathTerminator = "|";
    Blender.prototype.isExactPath = true;
    Blender.prototype.pathSeparator = ":";
    Blender.prototype.debugLevel = 0;
    Blender.prototype.defaultBBOrder = [
      "src",
      "dst"
    ];
    function Blender() {
      var aClass, bb, bbi, blenderBehaviors, dbb, j, k, lastDBB, len, ref, ref1, typeName;
      blenderBehaviors = 1 <= arguments.length ? slice.call(arguments, 0) : [];
      this.blenderBehaviors = blenderBehaviors;
      this.write = bind(this.write, this);
      this._blend = bind(this._blend, this);
      this.blend = bind(this.blend, this);
      this.getNextAction = bind(this.getNextAction, this);
      this.getAction = bind(this.getAction, this);
      if (_.isArray(this.blenderBehaviors[0])) {
        if (isHash(this.blenderBehaviors[1])) {
          _.extend(this, this.blenderBehaviors[1]);
        }
        this.blenderBehaviors = this.blenderBehaviors[0];
      }
      this.l = new (require("../Logger"))("uberscore/Blender", this.debugLevel);
      ref = this.getClasses();
      for (j = ref.length - 1; j >= 0; j += -1) {
        aClass = ref[j];
        if (aClass.behavior) {
          this.blenderBehaviors.push(aClass.behavior);
        }
      }
      lastDBB = _.last(this.blenderBehaviors);
      for (typeName in lastDBB) {
        dbb = lastDBB[typeName];
        if (_.isUndefined(dbb["*"])) {
          dbb["*"] || (dbb["*"] = lastDBB["*"]["*"]);
        }
      }
      ref1 = this.blenderBehaviors;
      for (bbi = k = 0, len = ref1.length; k < len; bbi = ++k) {
        bb = ref1[bbi];
        this.blenderBehaviors[bbi] = this.adjustBlenderBehavior(bb);
      }
      this.path = [];
    }
    Blender.prototype.adjustBlenderBehavior = function (blenderBehavior) {
      blenderBehavior.order || (blenderBehavior.order = this.defaultBBOrder);
      return this._adjustBbSrcDstPathSpec(blenderBehavior, blenderBehavior.order);
    };
    Blender.prototype._adjustBbSrcDstPathSpec = function (bbSrcDstPathSpec, orderRemaining) {
      var bbOrder, i, j, key, len, newV, p, path, pathItems, short, val;
      if (orderRemaining.length > 0) {
        bbOrder = orderRemaining[0];
        if (bbOrder === "path") {
          for (key in bbSrcDstPathSpec) {
            val = bbSrcDstPathSpec[key];
            if (key === this.pathTerminator) {
              if (isHash(val)) {
                this._adjustBbSrcDstPathSpec(val, orderRemaining.slice(1));
              }
            } else {
              pathItems = this.pathSeparator ? function () {
                var j, len, ref, results;
                ref = key.split(this.pathSeparator);
                results = [];
                for (j = 0, len = ref.length; j < len; j++) {
                  path = ref[j];
                  if (path) {
                    results.push(path.trim());
                  }
                }
                return results;
              }.call(this) : [];
              if (pathItems.length > 1) {
                newV = bbSrcDstPathSpec;
                for (i = j = 0, len = pathItems.length; j < len; i = ++j) {
                  p = pathItems[i];
                  newV[p] || (newV[p] = {});
                  if (i < pathItems.length - 1) {
                    newV = newV[p];
                  } else {
                    newV[p] = val;
                  }
                }
                delete bbSrcDstPathSpec[key];
              } else {
                if (pathItems[0] && key !== pathItems[0]) {
                  bbSrcDstPathSpec[pathItems[0]] = val;
                  delete bbSrcDstPathSpec[key];
                }
              }
              if (isHash(val)) {
                this._adjustBbSrcDstPathSpec(val, orderRemaining);
              }
            }
          }
        } else {
          for (key in bbSrcDstPathSpec) {
            val = bbSrcDstPathSpec[key];
            if (type.isType(key)) {
              short = type.toShort(key);
              if (short && key !== short) {
                bbSrcDstPathSpec[short] = bbSrcDstPathSpec[key];
                delete bbSrcDstPathSpec[key];
              }
            }
            if (isHash(val)) {
              this._adjustBbSrcDstPathSpec(val, orderRemaining.slice(1));
            }
          }
        }
      }
      return bbSrcDstPathSpec;
    };
    Blender.prototype.getAction = function (actionName, belowBlenderBehaviorIndex) {
      var bb, bbi, j, len, ref;
      if (belowBlenderBehaviorIndex == null) {
        belowBlenderBehaviorIndex = this.currentBlenderBehaviorIndex;
      }
      ref = this.blenderBehaviors;
      for (bbi = j = 0, len = ref.length; j < len; bbi = ++j) {
        bb = ref[bbi];
        if (bbi >= belowBlenderBehaviorIndex) {
          if (_.isFunction(bb[actionName])) {
            return _.bind(bb[actionName], this);
          }
        }
      }
      if (_.isFunction(this[actionName])) {
        return _.bind(this[actionName], this);
      } else {
        throw this.l.err("_B.Blender.blend: Error: Invalid BlenderBehavior `actionName` = ", actionName, " - no Function by that name is found in a preceding BlenderBehavior or Blender it self.", " belowBlenderBehaviorIndex=" + belowBlenderBehaviorIndex, " @currentBlenderBehaviorIndex=" + this.currentBlenderBehaviorIndex, " @blenderBehaviors=", this.blenderBehaviors);
      }
    };
    Blender.prototype.getNextAction = function (blenderBehavior, bbi, bbOrderValues) {
      var bbOrder, currentBBSrcDstSpec, j, len, nextBBSrcDstSpec, ref;
      currentBBSrcDstSpec = blenderBehavior;
      ref = blenderBehavior.order;
      for (j = 0, len = ref.length; j < len; j++) {
        bbOrder = ref[j];
        if (currentBBSrcDstSpec === void 0 || _.isString(currentBBSrcDstSpec) || _.isFunction(currentBBSrcDstSpec) || currentBBSrcDstSpec instanceof ActionResult) {
          break;
        }
        if (this.l.deb(80)) {
          this.l.deb("At bbOrder='" + bbOrder + "'", bbOrder === "path" ? " @path=" + this.l.prettify(this.path) : " bbOrderValues[bbOrder]='" + bbOrderValues[bbOrder] + "'", " currentBBSrcDstSpec =\n", currentBBSrcDstSpec);
        }
        if (_.isUndefined(bbOrderValues[bbOrder])) {
          throw this.l.err("_.Blender.blend: Error: Invalid BlenderBehavior `order` '" + bbOrder + "',\nwhile reading BlenderBehavior #" + bbi + " :\n", this.blenderBehaviors[bbi], "\n\nDefault BlenderBehavior order is ", this.defaultBBOrder);
        } else {
          if (bbOrder === "path") {
            this.l.deb("@isExactPath", this.isExactPath, "path=", this.path, "@path[1..]=", this.path.slice(1));
            nextBBSrcDstSpec = getp(currentBBSrcDstSpec, this.path.slice(1), { terminateKey: this.isExactPath ? void 0 : this.pathTerminator });
            this.l.deb(80, "bbOrder is 'path', nextBBSrcDstSpec=\n", nextBBSrcDstSpec);
            if (isHash(nextBBSrcDstSpec)) {
              nextBBSrcDstSpec = nextBBSrcDstSpec[this.pathTerminator];
              this.l.deb(80, "found an {} as nextBBSrcDstSpec, reading pathTerminator `" + this.pathTerminator + "`, nextBBSrcDstSpec=\n", nextBBSrcDstSpec);
            }
          } else {
            nextBBSrcDstSpec = currentBBSrcDstSpec[bbOrderValues[bbOrder]] || currentBBSrcDstSpec["*"];
          }
          if (this.l.deb(70)) {
            this.l.deb(function () {
              if (nextBBSrcDstSpec === void 0) {
                return "Found NO nextBBSrcDstSpec - NEXT BlenderBehavior";
              } else {
                if (bbOrder === "path") {
                  return "Got out of the path, having something!";
                } else if (nextBBSrcDstSpec === currentBBSrcDstSpec[bbOrderValues[bbOrder]]) {
                  return "Found ";
                } else if (nextBBSrcDstSpec === currentBBSrcDstSpec["*"]) {
                  return "Found NOT exact nextBBSrcDstSpec, but a '*'";
                } else if (_.isString(nextBBSrcDstSpec)) {
                  return "Found a String ";
                } else if (_.isFunction(nextBBSrcDstSpec)) {
                  return "Found a Function ";
                } else if (nextBBSrcDstSpec instanceof ActionResult) {
                  return "Found an ActionResult";
                } else {
                  throw "Unknown nextBBSrcDstSpec = " + this.l.prettify(nextBBSrcDstSpec);
                }
              }
            }.call(this), " \nbbOrder='" + bbOrder + "'", " \nbbOrderValues[bbOrder]='" + bbOrderValues[bbOrder] + "'", " \nnextBBSrcDstSpec=\n", nextBBSrcDstSpec);
          }
          currentBBSrcDstSpec = nextBBSrcDstSpec;
        }
      }
      return currentBBSrcDstSpec;
    };
    Blender.prototype.blend = function () {
      var dst, dstObject, j, len, sources, src;
      dst = arguments[0], sources = 2 <= arguments.length ? slice.call(arguments, 1) : [];
      if (_.isEmpty(this.path)) {
        if (_.isUndefined(sources) || _.isEmpty(sources)) {
          sources = [dst];
          dst = this.createAs(dst);
        }
        dstObject = { "$": dst };
        this.dstRoot = dst;
        for (j = 0, len = sources.length; j < len; j++) {
          src = sources[j];
          this.srcRoot = src;
          this._blend(dstObject, { "$": src });
        }
        return dstObject.$;
      } else {
        return this._blend.apply(this, arguments);
      }
    };
    Blender.prototype._blend = function () {
      var action, bb, bbi, dst, j, k, l, len, len1, len2, nextBBSrcDstSpec, prop, props, ref, result, sources, src, visitNextBB;
      dst = arguments[0], sources = 2 <= arguments.length ? slice.call(arguments, 1) : [];
      for (j = 0, len = sources.length; j < len; j++) {
        src = sources[j];
        props = this.properties(src);
        for (k = 0, len1 = props.length; k < len1; k++) {
          prop = props[k];
          this.path.push(prop);
          if (this.l.deb(50)) {
            this.l.deb("@path = /" + this.path.join("/") + "\n'" + type(this.read(dst, prop)) + "'    <--  '" + type(this.read(src, prop)) + "'\n", this.read(dst, prop), "    <--  ", this.read(src, prop));
          }
          visitNextBB = true;
          ref = this.blenderBehaviors;
          for (bbi = l = 0, len2 = ref.length; l < len2; bbi = ++l) {
            bb = ref[bbi];
            if (!visitNextBB) {
              continue;
            }
            if (this.l.deb(60)) {
              this.l.deb("Currently at @blenderBehaviors[" + bbi + "] =\n", bb);
            }
            this.currentBlenderBehaviorIndex = bbi;
            this.currentBlenderBehavior = this.blenderBehaviors[bbi];
            nextBBSrcDstSpec = this.getNextAction(bb, bbi, {
              dst: type(this.read(dst, prop), true),
              src: type(this.read(src, prop), true),
              path: this.path
            });
            if (nextBBSrcDstSpec === void 0) {
              continue;
            } else {
              action = nextBBSrcDstSpec;
              if (!_.isFunction(action)) {
                if (_.isString(action)) {
                  action = this.getAction(action, bbi);
                } else {
                  if (action instanceof ActionResult) {
                    result = action;
                  } else {
                    throw this.l.err("_B.Blender.blend: Invalid `action` (neither 'Function' nor 'String'): ", action);
                  }
                }
              }
            }
            if (!(action instanceof ActionResult)) {
              result = action.call(this, prop, src, dst, this);
            }
            visitNextBB = false;
            if (!(result instanceof ActionResult)) {
              if (_.isArray(result) && result[0] === this.NEXT) {
                result = result[1];
                visitNextBB = true;
              }
              if (this.l.deb(20)) {
                this.l.deb("Result handling: @path =", this.path.join("/"), "\n value =", this.l.prettify(result));
              }
              this.resultHandler(dst, prop, result);
            } else {
              if (this.l.deb(30)) {
                this.l.deb("ActionResult = ", result);
              }
              if (result === this.DELETE || result === this.DELETE_NEXT) {
                this["delete"](dst, prop);
              }
              if (result === this.NEXT || result === this.DELETE_NEXT) {
                visitNextBB = true;
              }
            }
          }
          this.path.pop();
        }
      }
      return dst;
    };
    Blender.prototype.createAs = function (obj) {
      if (_.isArray(obj)) {
        return [];
      } else {
        if (this.copyProto) {
          return Object.create(Object.getPrototypeOf(obj));
        } else {
          return {};
        }
      }
    };
    Blender.prototype.read = function (obj, prop) {
      if (_.isUndefined(prop)) {
        throw "Read without a prop";
      }
      return obj[prop];
    };
    Blender.prototype.write = function (obj, prop, val) {
      if (_.isUndefined(prop)) {
        throw "Write without a prop";
      }
      obj[prop] = val;
      return val;
    };
    Blender.prototype["delete"] = function (obj, prop) {
      if (_.isUndefined(prop)) {
        throw "Delete without a prop";
      }
      return delete obj[prop];
    };
    Blender.prototype.properties = function (obj) {
      var j, len, p, results, results1, results2, v;
      if (_.isArray(obj)) {
        results = [];
        for (p = j = 0, len = obj.length; j < len; p = ++j) {
          v = obj[p];
          results.push(p);
        }
        return results;
      } else {
        if (this.inherited) {
          results1 = [];
          for (p in obj) {
            results1.push(p);
          }
          return results1;
        } else {
          results2 = [];
          for (p in obj) {
            if (!hasProp.call(obj, p))
              continue;
            results2.push(p);
          }
          return results2;
        }
      }
    };
    Blender.prototype.copy = function (dst, src) {
      var j, len, prop, ref;
      ref = this.properties(src);
      for (j = 0, len = ref.length; j < len; j++) {
        prop = ref[j];
        this.write(dst, prop, this.read(src, prop));
      }
      return dst;
    };
    Blender.prototype.resultHandler = Blender.prototype.write;
    Blender.prototype.overwrite = function (prop, src) {
      return this.read(src, prop);
    };
    Blender.prototype.deepOverwrite = function (prop, src, dst) {
      var copiedObjWithProto;
      if (this.copyProto) {
        if ({}.__proto__ === Object.prototype) {
          this.read(dst, prop).__proto__ = this.read(src, prop).__proto__;
        } else {
          copiedObjWithProto = Object.create(Object.getPrototypeOf(this.read(src, prop)));
          this.copy(copiedObjWithProto, this.read(dst, prop));
          this.write(dst, prop, copiedObjWithProto);
        }
      }
      return this.blend(this.read(dst, prop), this.read(src, prop));
    };
    Blender.prototype.arrayAppend = function (prop, src, dst) {
      var dstArr, j, len, ref, s, srcArr;
      ref = [
        this.read(src, prop),
        this.read(dst, prop)
      ], srcArr = ref[0], dstArr = ref[1];
      for (j = 0, len = srcArr.length; j < len; j++) {
        s = srcArr[j];
        dstArr.push(s);
      }
      return dstArr;
    };
    Blender.behavior = {
      order: [
        "dst",
        "src"
      ],
      "*": { "*": "overwrite" },
      "[]": {
        "[]": "deepOverwrite",
        "{}": "deepOverwrite",
        "->": "deepOverwrite"
      },
      "{}": {
        "{}": "deepOverwrite",
        "[]": "deepOverwrite",
        "->": "deepOverwrite"
      },
      "->": {
        "{}": "deepOverwrite",
        "[]": "deepOverwrite",
        "->": "deepOverwrite"
      }
    };
    Blender.SKIP = new ActionResult("SKIP");
    Blender.prototype.SKIP = Blender.SKIP;
    Blender.NEXT = new ActionResult("NEXT");
    Blender.prototype.NEXT = Blender.NEXT;
    Blender.DELETE = new ActionResult("DELETE");
    Blender.prototype.DELETE = Blender.DELETE;
    Blender.DELETE_NEXT = new ActionResult("DELETE_NEXT");
    Blender.prototype.DELETE_NEXT = Blender.DELETE_NEXT;
    return Blender;
  }(CoffeeUtils);


})
}).call(this);