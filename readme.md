# uBerscore v0.0.16

[![Build Status](https://travis-ci.org/anodynos/uBerscore.png)](https://travis-ci.org/anodynos/uBerscore)
[![Up to date Status](https://david-dm.org/anodynos/uBerscore.png)](https://david-dm.org/anodynos/uBerscore.png)

An anorthodox, extensible, overloaded, highly experimental facade of *underscore* facilities & leftovers.

uBerscore.js is an early experiment: a 'higher' level data manipulator for all kinds of js collections (objects+arrays); it offers functionality that underscore doesn't and wouldn't have, and its highly build on the great `_`.

There will be no documentation before 0.1 and consider it likely to change...

But do see:

* [`Gruntfile.coffee`](https://github.com/anodynos/uBerscore/blob/master/Gruntfile.coffee) written with the wicked [uRequire](https://github.com/anodynos/uRequire) configuration, that builds uBerscore's modules in a number of ways, with the most DRY config ever.

Note: [uBerscore-dev.js](https://github.com/anodynos/uBerscore/blob/master/build/dist/uberscore-dev.js) and its minified brother are running on the WEB (both with AMD and as plain `<script/>`) and in nodejs through the single-file 'combined' conversion [uRequire](https://github.com/anodynos/uRequire) with no other dependencies (but 'lodash').

* [`blending/Blender`](https://github.com/anodynos/uBerscore/blob/master/source/code/blending/Blender.coffee) that powers [uRequire](https://github.com/anodynos/uRequire)'s versatile [configuration deriving](http://urequire.org/masterdefaultsconfig.coffee#deriving) to get some ideas.

* The wicked [`isEquals/isIquals/isExact/isLike`](https://github.com/anodynos/uBerscore/blob/master/source/code/objects/isEqual.coffee), that adds options to `_.isEqual`

# License
The MIT License

Copyright (c) 2012 Agelos Pikoulas (agelos.pikoulas@gmail.com)

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.