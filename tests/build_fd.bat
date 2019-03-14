echo off
for /F tokens^=2^,3^,5delims^=^<^"^= %%a in (%2.as3proj) do (
   if "%%a" equ "compile path" set main=%%b
)

set FLEX_HOME=%1

set ARGS= -source-path+=../src -js-compiler-option="--compilation_level SIMPLE_OPTIMIZATIONS" -js-output-optimization=skipAsCoercions 

if %3==debug (
	set ARGS=%ARGS% -debug=true -source-map
)

echo on
%FLEX_HOME%/js/bin/asjsc.bat %main% %ARGS% -external-library-path+="%FLEX_HOME%\js\libs\js.swc" -external-library-path+="%FLEX_HOME%\js\libs\jasmine.swc" -targets=JSFlex