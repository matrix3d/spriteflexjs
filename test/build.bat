set FLEX_HOME=d:/sdk/flexjs
set main=TestTMX
start %FLEX_HOME%/js/bin/mxmlc -external-library-path="%FLEX_HOME%\js\libs\js.swc" -compiler.source-path=../src src/%main%.as
pause