#!/bin/bash

aws sso login

JSON_BASEPATH="${HOME}/.aws/cli/cache"
AWS_CREDENTIALS_PATH="${HOME}/.aws/credentials"

if [ -f ${AWS_CREDENTIALS_PATH} ]; then
        echo "backing up existing credentials"
	cp -rf ${AWS_CREDENTIALS_PATH} "${AWS_CREDENTIALS_PATH}-"$(date +"%s")
fi

json_file=$(ls -tr "${JSON_BASEPATH}" | tail -n1)

# use jq to dump stuff in the right place

aws_access_key_id=$(cat ${JSON_BASEPATH}/${json_file} | jq -r '.Credentials.AccessKeyId')
aws_secret_access_key=$(cat ${JSON_BASEPATH}/${json_file} | jq -r '.Credentials.SecretAccessKey')
aws_session_token=$(cat ${JSON_BASEPATH}/${json_file} | jq -r '.Credentials.SessionToken')

echo "[default]" > ${AWS_CREDENTIALS_PATH}

echo "aws_access_key_id = ${aws_access_key_id}" >> ${AWS_CREDENTIALS_PATH}
echo "aws_secret_access_key = ${aws_secret_access_key}" >> ${AWS_CREDENTIALS_PATH}
echo "aws_session_token = ${aws_session_token}" >> ${AWS_CREDENTIALS_PATH}

echo "DONE"
