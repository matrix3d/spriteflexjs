#set FLEX_HOME=d:/sdk/flexjs7
FLEX_HOME=/Apache/royale-asjs
MXMLC_PATH="$FLEX_HOME/js/bin/mxmlc"
EXTERN_PATH="$FLEX_HOME/js/libs/js.swc"
main=TestBitmapDraw
# main=TestHungryHero
# main=TestByteArrayVSArray
# main=Main
# main=Test3

ARGS='-remove-circulars'
#ARGS='-debug=true -remove-circulars'
#ARGS='-remove-circulars -js-compiler-option="--compilation_level WHITESPACE_ONLY"'
$MXMLC_PATH $ARGS -targets=JS -warn-public-vars=false -external-library-path="$EXTERN_PATH" -compiler.source-path=../src src/$main.as -define=CONFIG::as_only,false -define=CONFIG::js_only,true