#!/bin/sh

set -eux

PROJECT_ROOT="/go/src/github.com/${GITHUB_REPOSITORY}"

mkdir -p $PROJECT_ROOT
rmdir $PROJECT_ROOT
ln -s $GITHUB_WORKSPACE $PROJECT_ROOT
cd $PROJECT_ROOT
go get -v ./...

EXT=''

if [ '$GOOS' == 'windows' ]; then
EXT='.exe'
fi

if [ -x "./build.sh" ]; then
  OUTPUT=`./build.sh "${CMD_PATH}"`
else
  go build -v -ldflags="-X 'github.com/shaun-plumb/helloworld/internal/version.Version=${RELEASE_NAME}'" ./...
  OUTPUT="${PROJECT_NAME}${EXT} ${RELEASE_NAME{"
fi

echo ${OUTPUT}
