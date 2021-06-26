#!/bin/sh

echo "aws version"
aws --version

echo "aws configure"

aws configure set aws_access_key_id "$INPUT_AWS_ACCESS_KEY_ID"
aws configure set aws_secret_access_key "$INPUT_AWS_SECRET_ACCESS_KEY"
aws configure set region "$INPUT_AWS_REGION"
aws configure set role_arn "$INPUT_AWS_ROLE_ARN"
aws configure --profile eks-admin set source_profile default
aws configure --profile eks-admin set region "$INPUT_AWS_REGION"

cat ~/.aws/*

echo "Listing Clusters"
aws eks list-clusters --profile eks-admin --region "$INPUT_AWS_REGION"

echo "Attempting to update kubeconfig for aws"
aws eks --region "$INPUT_AWS_REGION" update-kubeconfig --name "$INPUT_CLUSTER_NAME" --profile eks-admin

kubectl "$@"
