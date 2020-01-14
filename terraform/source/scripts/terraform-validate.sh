#!/bin/bash

###################################################
#   terraform-validate.sh
#  Author: Satheesh Papisetty
#  
##################################################
set -e
set +x
export PATH=/home/jbossadm:$PATH
check=${WORKSPACE}/terraform/${ENVNAME}
echo $check
cd $check
terraform validate
function log_validation_started {
    echo "Validating $check config..."
}

function log_validation_complete {
    echo "[OK] $check config"
}