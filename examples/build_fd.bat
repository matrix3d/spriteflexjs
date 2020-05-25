@echo off
set FLEX_HOME=%1
::set JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8 -Xmx1024m
set "foundLibrary="
set "foundExternalLibrary="

setlocal enabledelayedexpansion
for /F tokens^=2^,3^,5delims^=^<^"^= %%a in (%2) do (
   if "%%a" equ "compile path" set main=%%b
   if "%%a" equ "class path" set sources=!sources! -source-path+=%%b
   if "%%a" equ "libraryPaths>" set foundLibrary=true
   if "%%a" equ "externalLibraryPaths>" set foundExternalLibrary=true
   if "%%a" equ "element path" if defined foundLibrary if not defined foundExternalLibrary set libraries=!libraries! -library-path+=%%b
   if "%%a" equ "element path" if defined foundExternalLibrary set externalLibraries=!externalLibraries! -external-library-path+=%%b
)

set ARGS=-js-output-optimization=skipAsCoercions !libraries! !externalLibraries! !sources! -warn-public-vars=false -remove-circulars=true

	::set ARGS=%ARGS% -js-compiler-option+="--compilation_level WHITESPACE_ONLY"
	::set ARGS=%ARGS% -js-compiler-option+="--compilation_level ADVANCED_OPTIMIZATIONS"
	::set ARGS=%ARGS% -js-compiler-option+="--compilation_level SIMPLE_OPTIMIZATIONS"
if %3==release (
	set ARGS=%ARGS% -js-compiler-option+="--compilation_level SIMPLE_OPTIMIZATIONS"
)
 
if %3==debug (
	set ARGS=%ARGS% -debug=true -source-map=false
)
@echo on

%FLEX_HOME%/js/bin/asjsc.bat %main% %ARGS% -targets=JSRoyale -define=CONFIG::as_only,false -define=CONFIG::js_only,true -define=COMPILE::JS,true -warnings=false