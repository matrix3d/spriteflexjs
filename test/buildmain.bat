set FLEX_HOME=d:/sdk/flexjs
set main=SpriteFlexjsMain
::set ARGS=-remove-circulars -js-compiler-option="--compilation_level WHITESPACE_ONLY"
set ARGS=-remove-circulars -js-compiler-option="--compilation_level SIMPLE_OPTIMIZATIONS"
start %FLEX_HOME%/js/bin/mxmlc %ARGS% -external-library-path="%FLEX_HOME%\js\libs\js.swc" -compiler.source-path=../src src/%main%.as -define=CONFIG::as_only,false -define=CONFIG::js_only,true