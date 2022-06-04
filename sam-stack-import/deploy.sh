#!/bin/sh

set -e

AwsProfile="default"
CloudFormationStackName="sam-stack-import"
Region="us-east-1"
S3BucketName="sam-stack-import-nadtakan-futhoem-$Region"

sam build --parallel

# aws s3 mb s3://$S3BucketName --endpoint-url https://s3.us-east-1.amazonaws.com --profile $AwsProfile --region $Region

aws s3api wait bucket-exists --bucket $S3BucketName --endpoint-url https://s3.us-east-1.amazonaws.com --profile $AwsProfile --region $Region

sam package --output-template-file .\packaged.yaml --s3-bucket $S3BucketName --profile $AwsProfile --region $Region

sam deploy --template-file .\packaged.yaml --stack-name $CloudFormationStackName --capabilities CAPABILITY_IAM --region $Region