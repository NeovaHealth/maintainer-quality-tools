#!/bin/bash
BASE_BRANCH="develop"
BRANCH=$BASE_BRANCH
NHCLINICAL_BRANCH=$(echo $GO_SCM_NHCLINICAL_PR_BRANCH | sed 's/NeovaHealth://')
OPENEOBS_BRANCH=$(echo $GO_SCM_OPEN_EOBS_PR_BRANCH | sed 's/NeovaHealth://')
CLIENT_BRANCH=$(echo $GO_SCM_CLIENT_MODULES_PR_BRANCH | sed 's/bjss://')
if [ "${NHCLINICAL_BRANCH}" != "${BASE_BRANCH}" ] ; then
    BRANCH=$NHCLINICAL_BRANCH
fi
if [ "${OPENEOBS_BRANCH}" != "${BASE_BRANCH}" ] ; then
    BRANCH=$OPENEOBS_BRANCH
fi
if [ "${CLIENT_BRANCH}" != "${BASE_BRANCH}" ] ; then
    BRANCH=$CLIENT_BRANCH
fi
cd ../nhclinical
git fetch
git checkout -f $BRANCH || true
cd ../openeobs
git fetch
git checkout -f $BRANCH || true
cd ../client_modules
git fetch
git checkout -f $BRANCH || true
cd ..
echo "${BRANCH}" > version_branch.txt
