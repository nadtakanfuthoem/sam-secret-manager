#!/bin/sh

set -e

sam build

sam deploy --stack-name sam-secret-manager --profile default --region us-east-1