#!/usr/bin/env bash
# Deploy the web app to Google App Engine.

# sudo apt install golang
# sudo apt install google-cloud-sdk-app-engine-go
# echo 'export GOROOT=$HOME/go' >>~/.zshrc
# echo 'export PATH=$PATH:$GOROOT/bin' >>~/.zshrc
# echo 'export GOPATH=$GOROOT/bin' >>~/.zshrc
# go get -u google.golang.org/appengine

# Set GCLOUD_PROJECT in .env
export GCLOUD_PROJECT=
. ../../.env

OLD_GOPATH=${GOPATH}
export GOPATH=${OLD_GOPATH}/src/github.com/prometheus/prometheus/vendor

echo GOROOT=${GOROOT}
echo GOPATH=${GOPATH}
echo OLD_GOPATH=${OLD_GOPATH}

echo ========= ${name} ========= mkdir -p ${GOPATH}/github.com/prometheus
mkdir -p ${GOPATH}/github.com/prometheus

echo ========= ${name} ========= ln -s ${OLD_GOPATH}/src/github.com/prometheus/prometheus ${GOPATH}/github.com/prometheus/prometheus
ln -s ${OLD_GOPATH}/src/github.com/prometheus/prometheus ${GOPATH}/github.com/prometheus/prometheus

echo ========= ${name} ========= ln -s ${GOPATH} ${GOPATH}/src
ln -s ${GOPATH} ${GOPATH}/src

# Deploy to Google Cloud.
echo ========= ${name} ========= gcloud config set project ${GCLOUD_PROJECT}
gcloud config set project ${GCLOUD_PROJECT}

echo ========= ${name} ========= gcloud config list project
gcloud config list project

echo ========= ${name} ========= gcloud app deploy app.yaml --quiet --verbosity=info
gcloud app deploy app.yaml --quiet --verbosity=info

echo ========= ${name} Deployed! =========

export GOPATH=${OLD_GOPATH}
echo GOPATH=${GOPATH}
