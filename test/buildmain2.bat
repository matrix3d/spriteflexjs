set FLEX_HOME=d:/sdk/flexjs
set main=SpriteFlexjsMain
set ARGS=-remove-circulars -js-compiler-option="--compilation_level SIMPLE_OPTIMIZATIONS"
start %FLEX_HOME%/js/bin/compc %ARGS% -external-library-path="%FLEX_HOME%\js\libs\js.swc" -include-sources=../src -include-sources=src/%main%.as -define=CONFIG::as_only,false -define=CONFIG::js_only,true -output bin/js-swc
::java -jar %FLEX_HOME%\js\lib\google\closure-compiler\compiler.jar --js bin/js-swc
pause