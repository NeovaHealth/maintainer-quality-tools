#!/bin/bash
BASE_BRANCH="develop"
BRANCH=$BASE_BRANCH

NHCLINICAL_BRANCH=$(echo $GO_SCM_NHCLINICAL_PR_BRANCH | sed 's/NeovaHealth://')
OPENEOBS_BRANCH=$(echo $GO_SCM_OPEN_EOBS_PR_BRANCH | sed 's/NeovaHealth://')
CLIENT_BRANCH=$(echo $GO_SCM_CLIENT_MODULES_PR_BRANCH | sed 's/bjss://')

NHCLINICAL_HASH=$GO_SCM_NHCLINICAL_LABEL
cd ../nhclinical
NHCLINICAL_DATE=$(git show "${NHCLINICAL_HASH}" -s --format="%at")

OPENEOBS_HASH=$GO_SCM_OPEN_EOBS_LABEL
cd ../openeobs
OPENEOBS_DATE=$(git show "${OPENEOBS_HASH}" -s --format="%at")

CLIENT_HASH=$GO_SCM_CLIENT_MODULES_LABEL
cd ../client_modules
CLIENT_DATE=$(git show "${CLIENT_HASH}" -s --format="%at")

# Need to then compare all 3 hashes
if [ ${NHCLINICAL_DATE} -gt ${OPENEOBS_DATE} -a ${NHCLINICAL_DATE} -gt ${CLIENT_DATE} ] ; then
    BRANCH=$NHCLINICAL_BRANCH
fi
if [ ${OPENEOBS_DATE} -gt ${NHCLINICAL_DATE} -a ${OPENEOBS_DATE} -gt ${CLIENT_DATE} ] ; then
    BRANCH=$OPENEOBS_BRANCH
fi
if [ ${CLIENT_DATE} -gt ${NHCLINICAL_DATE} -a ${CLIENT_DATE} -gt ${OPENEOBS_DATE} ] ; then
    BRANCH=$CLIENT_BRANCH
fi
cd ../nhclinical
git fetch
git checkout $BASE_BRANCH
git checkout -f $BRANCH || true
cd ../openeobs
git fetch
git checkout $BASE_BRANCH
git checkout -f $BRANCH || true
cd ../client_modules
git fetch
git checkout $BASE_BRANCH
git checkout -f $BRANCH || true
cd ..
echo $BRANCH > version_branch.txt
