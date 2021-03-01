#! /usr/bin/env bash

# working reference:
# aws  s3 cp file_name s3://bucket_name/dump_file_name --endpoint-url=https://s3.mydomain.ru      

ERRORCOUNT=0

function dump {
    pg_dump -Fc --dbname=postgresql://"$PG_USER":"$PG_PASSWORD"@"$PG_HOST":5432/"$PG_DBNAME"
}

function compress {
    gzip
}

function upload {
    aws s3 cp - s3://"$AWS_BUCKET_NAME"/dump_"$PG_DBNAME"_$(date '+%d-%m-%Y_%H:%M:%S_%N').gz --endpoint-url="$AWS_HOST" --region="$AWS_REGION"
}

set -x
dump | compress | upload
[[ ${PIPESTATUS[0]} != 0 || ${PIPESTATUS[1]} != 0 || ${PIPESTATUS[2]} != 0 ]] && (( ERRORCOUNT += 1 ))

exit "$ERRORCOUNT"
