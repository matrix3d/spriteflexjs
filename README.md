# spriteflexjs

a html5 engine build with apache-royale.
------------------------------

the spriteflexjs support most flash runtime api.

support canvas and webgl.

100% ActionScript written code base

Quick Links
-----------

* [Official Homepage](http://spriteflexjs.com/)
* [spriteflexjs Wiki](https://github.com/matrix3d/spriteflexjs/wiki)
  * [Showcase](http://matrix3d.github.io/assets/html5/flexjsstage3d/bin/js-release/)
  * [jsmin](https://codepen.io/matrix3d/pen/mAZmVy)

微信小游戏适配
-----------
更改game.js

 ```as3
 import './js/libs/weapp-adapter'
 import "TestMinGame"
 var canvas = window.canvas;
 canvas.id = "spriteflexjsstage";//小游戏只有一个画布显示 如果是stage3d用这个id "spriteflexjsstage3d0"
 new TestMinGame();
 ```

更改代码的  xxx=this ,变成 xxx=window

因为小游戏this为null

代码要大于500k，如果小于500k。小游戏进行es6转换，会导致编辑器卡死

视频教程
-----------
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/6mKdmKJqEK4/0.jpg)](https://www.youtube.com/watch?v=6mKdmKJqEK4)

