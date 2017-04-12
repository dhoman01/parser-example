#!/bin/bash
DARK_GREY='\033[1;30m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

TESTDIR=TestFiles/
RESULTS=Results/
BASE=Base/

EXEDIR=../../build/
BINARY=json

if [ -z $1 ]; then
  pushd . >> /dev/null
  cd ${TESTDIR}
  files=`ls *.json`
  popd >>/dev/null
else
  files=$1
fi


#create these directories if they don't exist already
mkdir -p $ASM $RESULTS

trap on_die SIGINT
trap on_die TERM

for file in $files; do
    filename=$(basename "$file")
    filename="${filename%.*}.json"

    if [[ ! -f ${TESTDIR}${file} ]]; then
        echo -e "${RED}File '${file}' not found${NC}"
        continue
    fi

    ${EXEDIR}${BINARY} ${TESTDIR}${file} -o ${RESULTS}${filename}

    if [ $? -ne 0 ]; then
        echo -e "${RED}Error running: ${EXEDIR}${BINARY} ${TESTDIR}${file} -o ${RESULTS}${filename}${NC}"
        continue
    fi


    cmp ${RESULTS}${file} ${BASE}${file}
    if [ $? -ne 0 ]; then
        echo -e "${DARK_GREY}Comparison failed on ${RESULTS}${file}->${BASE}${file} ${RED}X${NC}"
    else
        echo -e "${DARKE_GREY}${TESTDIR}${file}->${RESULTS}${file} ${GREEN}\u2713${NC}"
    fi
done

exit