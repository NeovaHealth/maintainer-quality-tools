#!/bin/bash
BASE_BRANCH="develop"
BRANCH=$BASE_BRANCH
NHCLINICAL_BRANCH=$(echo $GO_SCM_NHCLINICAL_PR_BRANCH | sed 's/bjss://')
OPENEOBS_BRANCH=$(echo $GO_SCM_OPEN_EOBS_PR_BRANCH | sed 's/bjss://')
CLIENT_BRANCH=$(echo $GO_SCM_CLIENT_MODULES_PR_BRANCH | sed 's/bjss://')
if [ $NHCLINICAL != $BASE_BRANCH ] ; then
    BRANCH=$NHCLINICAL
fi
if [ $OPENEOBS_BRANCH != $BASE_BRANCH ] ; then
    BRANCH=OPENEOBS_BRANCH
fi
if [ $CLIENT_BRANCH != $BASE_BRANCH ] ; then
    BRANCH=$CLIENT_BRANCH
fi
cd ../nhclinical
git fetch
git checkout $BRANCH || true
cd ../openeobs
git fetch
git checkout $BRANCH || true
cd ../client_modules
git fetch
git checkout $BRANCH || true
cd ..
echo $BRANCH > version_branch.txt
