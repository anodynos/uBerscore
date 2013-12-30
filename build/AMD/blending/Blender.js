(function() {
    var __bind = function(fn, me) {
        return function() {
            return fn.apply(me, arguments);
        };
    }, __hasProp = {}.hasOwnProperty, __extends = function(child, parent) {
        for (var key in parent) {
            if (__hasProp.call(parent, key)) child[key] = parent[key];
        }
        function ctor() {
            this.constructor = child;
        }
        ctor.prototype = parent.prototype;
        child.prototype = new ctor();
        child.__super__ = parent.prototype;
        return child;
    }, __slice = [].slice;
    define([ "require", "../types/type", "../objects/getp", "../types/isHash", "../utils/CoffeeUtils", "lodash", "../agreement/isAgree", "../utils/subclass", "../Logger" ], function(require, type, getp, isHash, CoffeeUtils, _, isAgree) {
        var ActionResult, Blender;
        isHash = require("../types/isHash");
        ActionResult = function() {
            function ActionResult(name) {
                this.name = name;
            }
            return ActionResult;
        }();
        return Blender = function(_super) {
            __extends(Blender, _super);
            Blender.subclass = require("../utils/subclass");
            Blender.prototype.inherited = false;
            Blender.prototype.copyProto = false;
            Blender.prototype.pathTerminator = "|";
            Blender.prototype.isExactPath = true;
            Blender.prototype.pathSeparator = ":";
            Blender.prototype.debugLevel = 0;
            Blender.prototype.defaultBBOrder = [ "src", "dst" ];
            function Blender() {
                var aClass, bb, bbi, blenderBehaviors, dbb, lastDBB, typeName, _i, _j, _len, _ref, _ref1;
                blenderBehaviors = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
                this.blenderBehaviors = blenderBehaviors;
                this.write = __bind(this.write, this);
                this._blend = __bind(this._blend, this);
                this.blend = __bind(this.blend, this);
                this.getNextAction = __bind(this.getNextAction, this);
                this.getAction = __bind(this.getAction, this);
                this.l = new (require("../Logger"))("uberscore/Blender", this.debugLevel);
                if (_.isArray(this.blenderBehaviors[0])) {
                    if (this.l.deb(20)) {
                        this.l.debug("We might have options:", this.blenderBehaviors);
                    }
                    if (isHash(this.blenderBehaviors[1])) {
                        _.extend(this, this.blenderBehaviors[1]);
                    }
                    this.blenderBehaviors = this.blenderBehaviors[0];
                }
                _ref = this.getClasses();
                for (_i = _ref.length - 1; _i >= 0; _i += -1) {
                    aClass = _ref[_i];
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
                _ref1 = this.blenderBehaviors;
                for (bbi = _j = 0, _len = _ref1.length; _j < _len; bbi = ++_j) {
                    bb = _ref1[bbi];
                    this.blenderBehaviors[bbi] = this.adjustBlenderBehavior(bb);
                }
                this.path = [];
            }
            Blender.prototype.adjustBlenderBehavior = function(blenderBehavior) {
                blenderBehavior.order || (blenderBehavior.order = this.defaultBBOrder);
                return this._adjustBbSrcDstPathSpec(blenderBehavior, blenderBehavior.order);
            };
            Blender.prototype._adjustBbSrcDstPathSpec = function(bbSrcDstPathSpec, orderRemaining) {
                var bbOrder, i, key, newV, p, path, pathItems, short, val, _i, _len;
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
                                pathItems = this.pathSeparator ? function() {
                                    var _i, _len, _ref, _results;
                                    _ref = key.split(this.pathSeparator);
                                    _results = [];
                                    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                                        path = _ref[_i];
                                        if (path) {
                                            _results.push(path.trim());
                                        }
                                    }
                                    return _results;
                                }.call(this) : [];
                                if (pathItems.length > 1) {
                                    newV = bbSrcDstPathSpec;
                                    for (i = _i = 0, _len = pathItems.length; _i < _len; i = ++_i) {
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
            Blender.prototype.getAction = function(actionName, belowBlenderBehaviorIndex) {
                var bb, bbi, _i, _len, _ref;
                if (belowBlenderBehaviorIndex == null) {
                    belowBlenderBehaviorIndex = this.currentBlenderBehaviorIndex;
                }
                _ref = this.blenderBehaviors;
                for (bbi = _i = 0, _len = _ref.length; _i < _len; bbi = ++_i) {
                    bb = _ref[bbi];
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
            Blender.prototype.getNextAction = function(blenderBehavior, bbi, bbOrderValues) {
                var bbOrder, currentBBSrcDstSpec, nextBBSrcDstSpec, _i, _len, _ref;
                currentBBSrcDstSpec = blenderBehavior;
                _ref = blenderBehavior.order;
                for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                    bbOrder = _ref[_i];
                    if (currentBBSrcDstSpec === void 0 || _.isString(currentBBSrcDstSpec) || _.isFunction(currentBBSrcDstSpec) || currentBBSrcDstSpec instanceof ActionResult) {
                        break;
                    }
                    if (this.l.deb(80)) {
                        this.l.debug("At bbOrder='" + bbOrder + "'", bbOrder === "path" ? " @path=" + this.l.prettify(this.path) : " bbOrderValues[bbOrder]='" + bbOrderValues[bbOrder] + "'", " currentBBSrcDstSpec =\n", currentBBSrcDstSpec);
                    }
                    if (_.isUndefined(bbOrderValues[bbOrder])) {
                        throw this.l.err("_.Blender.blend: Error: Invalid BlenderBehavior `order` '" + bbOrder + "',\nwhile reading BlenderBehavior #" + bbi + " :\n", this.blenderBehaviors[bbi], "\n\nDefault BlenderBehavior order is ", this.defaultBBOrder);
                    } else {
                        if (bbOrder === "path") {
                            nextBBSrcDstSpec = getp(currentBBSrcDstSpec, this.path.slice(1), {
                                terminateKey: this.isExactPath ? void 0 : this.pathTerminator
                            });
                            if (_.isObject(nextBBSrcDstSpec)) {
                                nextBBSrcDstSpec = nextBBSrcDstSpec["|"];
                            }
                        } else {
                            nextBBSrcDstSpec = currentBBSrcDstSpec[bbOrderValues[bbOrder]] || currentBBSrcDstSpec["*"];
                        }
                        if (this.l.deb(70)) {
                            this.l.debug(function() {
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
            Blender.prototype.blend = function() {
                var dst, dstObject, sources, src, _i, _len;
                dst = arguments[0], sources = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
                if (_.isEmpty(this.path)) {
                    if (_.isUndefined(sources) || _.isEmpty(sources)) {
                        sources = [ dst ];
                        dst = this.createAs(dst);
                    }
                    dstObject = {
                        $: dst
                    };
                    this.dstRoot = dst;
                    for (_i = 0, _len = sources.length; _i < _len; _i++) {
                        src = sources[_i];
                        this.srcRoot = src;
                        this._blend(dstObject, {
                            $: src
                        });
                    }
                    return dstObject.$;
                } else {
                    return this._blend.apply(this, arguments);
                }
            };
            Blender.prototype._blend = function() {
                var action, bb, bbi, dst, nextBBSrcDstSpec, prop, props, result, sources, src, visitNextBB, _i, _j, _k, _len, _len1, _len2, _ref;
                dst = arguments[0], sources = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
                for (_i = 0, _len = sources.length; _i < _len; _i++) {
                    src = sources[_i];
                    props = this.properties(src);
                    for (_j = 0, _len1 = props.length; _j < _len1; _j++) {
                        prop = props[_j];
                        this.path.push(prop);
                        if (this.l.deb(50)) {
                            this.l.debug("@path = /" + this.path.join("/") + "\n'" + type(this.read(dst, prop)) + "'    <--  '" + type(this.read(src, prop)) + "'\n", this.read(dst, prop), "    <--  ", this.read(src, prop));
                        }
                        visitNextBB = true;
                        _ref = this.blenderBehaviors;
                        for (bbi = _k = 0, _len2 = _ref.length; _k < _len2; bbi = ++_k) {
                            bb = _ref[bbi];
                            if (!visitNextBB) {
                                continue;
                            }
                            if (this.l.deb(60)) {
                                this.l.debug("Currently at @blenderBehaviors[" + bbi + "] =\n", bb);
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
                                    this.l.debug("Result handling: @path =", this.path.join("/"), "\n value =", this.l.prettify(result));
                                }
                                this.resultHandler(dst, prop, result);
                            } else {
                                if (this.l.deb(30)) {
                                    this.l.debug("ActionResult = ", result);
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
            Blender.prototype.createAs = function(obj) {
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
            Blender.prototype.read = function(obj, prop) {
                if (_.isUndefined(prop)) {
                    throw "Read without a prop";
                }
                return obj[prop];
            };
            Blender.prototype.write = function(obj, prop, val) {
                if (_.isUndefined(prop)) {
                    throw "Write without a prop";
                }
                obj[prop] = val;
                return val;
            };
            Blender.prototype["delete"] = function(obj, prop) {
                if (_.isUndefined(prop)) {
                    throw "Delete without a prop";
                }
                return delete obj[prop];
            };
            Blender.prototype.properties = function(obj) {
                var p, v, _i, _len, _results, _results1, _results2;
                if (_.isArray(obj)) {
                    _results = [];
                    for (p = _i = 0, _len = obj.length; _i < _len; p = ++_i) {
                        v = obj[p];
                        _results.push(p);
                    }
                    return _results;
                } else {
                    if (this.inherited) {
                        _results1 = [];
                        for (p in obj) {
                            _results1.push(p);
                        }
                        return _results1;
                    } else {
                        _results2 = [];
                        for (p in obj) {
                            if (!__hasProp.call(obj, p)) continue;
                            _results2.push(p);
                        }
                        return _results2;
                    }
                }
            };
            Blender.prototype.copy = function(dst, src) {
                var prop, _i, _len, _ref;
                _ref = this.properties(src);
                for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                    prop = _ref[_i];
                    this.write(dst, prop, this.read(src, prop));
                }
                return dst;
            };
            Blender.prototype.resultHandler = Blender.prototype.write;
            Blender.prototype.overwrite = function(prop, src) {
                return this.read(src, prop);
            };
            Blender.prototype.deepOverwrite = function(prop, src, dst) {
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
            Blender.prototype.arrayAppend = function(prop, src, dst) {
                var dstArr, s, srcArr, _i, _len, _ref;
                _ref = [ this.read(src, prop), this.read(dst, prop) ], srcArr = _ref[0], dstArr = _ref[1];
                for (_i = 0, _len = srcArr.length; _i < _len; _i++) {
                    s = srcArr[_i];
                    dstArr.push(s);
                }
                return dstArr;
            };
            Blender.behavior = {
                order: [ "dst", "src" ],
                "*": {
                    "*": "overwrite"
                },
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
    });
}).call(this);