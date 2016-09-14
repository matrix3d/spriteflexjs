set FLEX_HOME=d:/sdk/flexjs
set main=SpriteFlexjsMain
java -jar %FLEX_HOME%\js\lib\google\closure-compiler\compiler.jar --js bin\js-swc --js %FLEX_HOME%\frameworks\js\FlexJS\generated-sources\org\apache\flex\utils\Language.js --js %FLEX_HOME%\js\lib\google\closure-library\closure\goog\base.js --compilation_level SIMPLE_OPTIMIZATIONS --js_output_file SpriteFlexjsMain.js
pause