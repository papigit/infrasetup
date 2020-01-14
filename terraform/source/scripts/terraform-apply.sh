#!/bin/bash

###################################################
#   terraform-apply.sh
# Author: Satheesh Papisetty
##################################################

set +x
set -e

#export http_proxy="10.192.126.XX:8080"
#export https_proxy="10.192.126.XX:8080"
export no_proxy=169.254.169.254,localhost,127.0.0.1
export PATH=/home/jbossadm:$PATH
##################################################################
# Move to project terraform config directory
##################################################################

echo ${WORKSPACE}/terraform/${ENVNAME}/
cd ${WORKSPACE}/terraform/${ENVNAME}/

##################################################################
# Delete local terraform config and pull from s3 config
##################################################################

rm -rf .terraform

######################################################################################
# Pull remote terraform config then compare and update finally pushing to s3
######################################################################################

echo "########################################################################################"
echo "# Terraform State Bucket = ${S3_BUCKET}/${PROJECT}/terraform.state #"
echo "# Key_id = ${KMS_KEY_ID}                                                               #"
echo "########################################################################################"

terraform version


terraform init \
 #     -backend=true \
 #     -backend-config="bucket=${S3_BUCKET}" \
 #     -backend-config="key=${PROJECT}/terraform.tfstate" \
 ##     -backend-config="region=ap-southeast-1" \
  #    -backend-config="acl=bucket-owner-full-control" \
 #     -backend-config="encrypt=1" \
  #####    -backend-config="kms_key_id=${KMS_KEY_ID}"
 #     -backend-config="profile=${PROFILE}" \
 #     -get-plugins=false \
 #     -plugin-dir=/usr/local/bin/terraform.d/plugins/linux_amd64 \
 #     -get=true \
 #     -input=false \
 #     -force-copy

terraform apply --auto-approve=true
echo "Exit code: {$?}"