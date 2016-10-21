set FLEX_HOME=d:/sdk/flexjs
::set main=TestBitmapDraw
::set main=TestHungryHero
::set main=TestByteArrayVSArray
::set main=Main
set main=PixiTest

::set ARGS=-remove-circulars
::set ARGS=-debug=true -remove-circulars
::set ARGS=-remove-circulars -js-compiler-option="--compilation_level WHITESPACE_ONLY"
set ARGS=-remove-circulars -js-output-optimization=skipAsCoercions -js-compiler-option="--compilation_level SIMPLE_OPTIMIZATIONS"
start %FLEX_HOME%/js/bin/mxmlc %ARGS% -external-library-path="%FLEX_HOME%\js\libs\js.swc" -external-library-path="lib\pixijs.swc" -compiler.source-path=../src src/%main%.as -define=CONFIG::as_only,false -define=CONFIG::js_only,true