#!/bin/bash
TAG=$1
AWS_ECR_ACCOUNT_URL=$2
AWS_ECR_HELM_REPO_NAME=$3
echo "oci://$AWS_ECR_ACCOUNT_URL/$AWS_ECR_HELM_REPO_NAME"
eksctl create iamidentitymapping --cluster $AWS_EKS_CLUSTER_NAME --region $AWS_CLUSTER_REGION --arn $EKS_ARN --group system:masters --no-duplicate-arns --username $EKS_USER
export KUBECONFIG=/home/circleci/.kube/config
result=$(eval helm ls | grep flask-helm)
if [ $? -ne "0" ]; then
   helm install flask-helm "oci://$AWS_ECR_ACCOUNT_URL/$AWS_ECR_HELM_REPO_NAME" --version $TAG -v 20
else
   helm upgrade flask-helm "oci://$AWS_ECR_ACCOUNT_URL/$AWS_ECR_HELM_REPO_NAME" --version $TAG -v 20
fi
