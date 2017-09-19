#!/bin/bash
BASE_BRANCH="develop"
BRANCH=$BASE_BRANCH
if [ $GO_SCM_NHCLINICAL_PR_BRANCH != $BASE_BRANCH ] ; then
    BRANCH=$GO_SCM_NHCLINICAL_PR_BRANCH
fi
if [ $GO_SCM_OPEN_EOBS_PR_BRANCH != $BASE_BRANCH ] ; then
    BRANCH=$GO_SCM_OPEN_EOBS_PR_BRANCH
fi
if [ $GO_SCM_CLIENT_MODULES_PR_BRANCH != $BASE_BRANCH ] ; then
    BRANCH=$GO_SCM_CLIENT_MODULES_PR_BRANCH
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
