echo off
for /F tokens^=2^,3^,5delims^=^<^"^= %%a in (%2.as3proj) do (
   if "%%a" equ "compile path" set main=%%b
)

set ARGS= -external-library-path+=lib\* -source-path+=../src -js-compiler-option="--compilation_level SIMPLE_OPTIMIZATIONS" -js-output-optimization=skipAsCoercions -remove-circulars

if %3==debug (
	set ARGS=%ARGS% -debug=true -source-map
)
set FLEX_HOME=%1
echo on
%FLEX_HOME%/js/bin/asjsc.bat %main% %ARGS% -external-library-path+="%FLEX_HOME%\js\libs\js.swc" -external-library-path+=%FLEX_HOME%\frameworks\js\libs\XMLJS.swc -targets=JSRoyale -define=CONFIG::as_only,false -define=CONFIG::js_only,true