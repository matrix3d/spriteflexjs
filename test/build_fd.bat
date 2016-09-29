echo off
for /F tokens^=2^,3^,5delims^=^<^"^= %%a in (%2.as3proj) do (
   if "%%a" equ "compile path" set main=%%b
)
set ARGS=-remove-circulars -js-output-optimization=skipAsCoercions
::set ARGS=-remove-circulars -js-compiler-option="--compilation_level WHITESPACE_ONLY"
if %3==debug (
	set ARGS=%ARGS% -debug=true
)
set FLEX_HOME=%1
echo on
%FLEX_HOME%/js/bin/mxmlc %ARGS% -external-library-path="%FLEX_HOME%\js\libs\js.swc" -compiler.source-path=../src %main% -define=CONFIG::as_only,false -define=CONFIG::js_only,true