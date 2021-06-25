#!/bin/sh

set -e

export AWS_ACCESS_KEY_ID="$INPUT_AWS_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="$INPUT_AWS_SECRET_ACCESS_KEY"

echo "aws version"
aws --version

echo "aws configure"

aws configure set aws_access_key_id "$INPUT_AWS_ACCESS_KEY_ID"
aws configure set aws_secret_access_key "$INPUT_AWS_SECRET_ACCESS_KEY"
aws configure set region aws configure set region
aws configure set role_arn "$INPUT_AWS_ROLE_ARN"

echo "Listing Clusters"
aws eks list-clusters

echo "Attempting to update kubeconfig for aws"
aws eks --region "$INPUT_AWS_REGION" update-kubeconfig --name "$INPUT_CLUSTER_NAME"

kubectl "$@"
