call init.bat
set ARGS=-debug=true -remove-circulars
start %FLEX_HOME%/js/bin/mxmlc %ARGS% -external-library-path="%FLEX_HOME%\js\libs\js.swc" -compiler.source-path=../src src/%main%.as -define=CONFIG::as_only,false -define=CONFIG::js_only,true