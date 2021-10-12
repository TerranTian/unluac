#!/usr/bin/env bash
# @terran
# set -e -u
# set -e
trap '{ echo "pressed Ctrl-C.  Time to quit." ; exit 1; }' INT
export PATH="/usr/local/bin:$PATH"

dir=$(cd `dirname $0`; pwd);
tmp=$dir/.tmp;mkdir -p $tmp;
function error_exit(){ echo "【ERROR】::${1:-"Unknown Error"}" 1>&2 && exit 1;}

function build(){
    rm -rf build/classes && mkdir  -p build/classes;
    javac -sourcepath src -d build/classes src/unluac/Main.java || error_exit "compile error"
    echo Main-Class: unluac.Main > build/MANIFEST.MF;
    jar -cvmf build/MANIFEST.MF unluac.jar -C build/classes .;


    java -jar unluac.jar
}

if test $# -lt 1; then error_exit "wrong arguments"; fi;
cmd=$1 && shift
echo $cmd $@
$cmd $@