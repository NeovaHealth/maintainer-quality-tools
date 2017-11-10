#!/bin/bash
set -e
set -x
# If no BRANCH environment variable provided, then being run on GoCD, so
# determine which PR branch was actually the one that triggered the build.
# Otherwise just use the existing BRANCH environment variable.
if [[ -z "${BRANCH}" ]]
  then
	NHCLINICAL_BRANCH=$(echo $GO_SCM_NHCLINICAL_PR_BRANCH | sed 's/NeovaHealth://')
	OPENEOBS_BRANCH=$(echo $GO_SCM_OPEN_EOBS_PR_BRANCH | sed 's/NeovaHealth://')
	CLIENT_BRANCH=$(echo $GO_SCM_CLIENT_MODULES_PR_BRANCH | sed 's/bjss://')

	NHCLINICAL_HASH=$GO_SCM_FEATURE_LIVEOBS_NHCLINICAL_LABEL
	NHCLINICAL_DATE=$(git --git-dir=../nhclinical/.git show "${NHCLINICAL_HASH}" -s --format="%at")

	OPENEOBS_HASH=$GO_SCM_FEATURE_LIVEOBS_OPENEOBS_LABEL
	OPENEOBS_DATE=$(git --git-dir=../openeobs/.git show "${OPENEOBS_HASH}" -s --format="%at")

	CLIENT_HASH=$GO_SCM_FEATURE_LIVEOBS_CLIENT_MODULES_LABEL
	CLIENT_DATE=$(git --git-dir=../BJSS_liveobs_client_modules/.git show "${CLIENT_HASH}" -s --format="%at")

	# Need to then compare all 3 hashes. Which one is the latest?
	if [ ${NHCLINICAL_DATE} -gt ${OPENEOBS_DATE} -a ${NHCLINICAL_DATE} -gt ${CLIENT_DATE} ] ; then
		BRANCH=$NHCLINICAL_BRANCH
	fi
	if [ ${OPENEOBS_DATE} -gt ${NHCLINICAL_DATE} -a ${OPENEOBS_DATE} -gt ${CLIENT_DATE} ] ; then
		BRANCH=$OPENEOBS_BRANCH
	fi
	if [ ${CLIENT_DATE} -gt ${NHCLINICAL_DATE} -a ${CLIENT_DATE} -gt ${OPENEOBS_DATE} ] ; then
		BRANCH=$CLIENT_BRANCH
	fi
fi

# Checkout branch. If branch does not exist fall back to develop.
BASE_BRANCH="develop"

(cd ../nhclinical && \
	git fetch && \
	git checkout -f $BRANCH || git checkout $BASE_BRANCH)
(cd ../openeobs && \
	git fetch && \
	git checkout -f $BRANCH || git checkout $BASE_BRANCH)
(cd ../BJSS_liveobs_client_modules && \
	git fetch && \
	git checkout -f $BRANCH || git checkout $BASE_BRANCH)

VERSION_NAME=$BRANCH
VERSION_NAME+=_
VERSION_NAME+=$GO_PIPELINE_LABEL

echo $VERSION_NAME > version_branch.txt