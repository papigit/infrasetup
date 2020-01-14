#!/bin/bash

set -e

rm -Rf .git*
rm -Rf Jenkinsfile


if [ -z "${ENV}" ]; then
     ENV="release"
else
 export ENV=${ENV}

fi

export PROJECT=${PROJECT}
export no_proxy=169.254.169.254,localhost,127.0.0.1

export COMMIT_ID=${GIT_COMMIT}
export DATE_TIMESTAMP="$(date +"%Y%m%d_%H%M%S")"

echo "############################################################"
echo "#       Create version file of build and commit            #"
echo "############################################################"

touch ${PROJECT}-version.txt
echo ${PROJECT}-${DATE_TIMESTAMP}.tar.gz  >> ${PROJECT}-version.txt


echo "############################################################"
echo "#          Creating tagged version of build                #"
echo "############################################################"

mkdir -p /tmp/${PROJECT}
cd /tmp/${PROJECT}
cp -Rf ${WORKSPACE}/* .
cd ..
tar -czf ${PROJECT}-${DATE_TIMESTAMP}.tar.gz ${PROJECT}/*


echo "############################################################"
echo "#       Tagging & Pushing artifacts to Artifactory         #"
echo "############################################################"

curl -k ${ARTI_API_KEY} -T ${PROJECT}-${DATE_TIMESTAMP}.tar.gz "https://artifactory.global..com/artifactory/generic-cloud/com/sc/cloud/deploy/${ENV}/${PROJECT}/${PROJECT}-${DATE_TIMESTAMP}.tar.gz"

echo "Exit code: {$?}"



