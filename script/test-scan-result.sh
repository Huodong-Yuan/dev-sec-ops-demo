#!/bin/sh

set -e
die () {
    echo >&2 "$@"
    exit 1
}

### Expect argument to be provided with the ECR repository name
[ "$#" -eq 2 ] || die "Usage: $0 [ecr_repo]"
ECR_REPO=$1
IMAGE_TAG=$2

isHigh=$(aws ecr describe-image-scan-findings --repository-name $ECR_REPO --image-id imageTag=$IMAGE_TAG --region ap-east-1 | grep "\"severity\": \"HIGH\"");

if [ -z "$isHigh" ]; then 
    echo "Not high"
else 
    echo "$isHigh"
    exit 0
fi