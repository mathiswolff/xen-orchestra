#!/bin/sh

[ -e ./build/.build.env ] || { echo ".build.env file not found"; exit 1; }
. ./build/.build.env

export RCLONE_CONFIG_S3_TYPE=s3
export RCLONE_CONFIG_S3_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID"
export RCLONE_CONFIG_S3_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"

if [ -n "$MINIO_ENDPOINT" ]; then
  export RCLONE_CONFIG_S3_PROVIDER=Minio
  export RCLONE_CONFIG_S3_ENDPOINT="$MINIO_ENDPOINT"
else
  if [ -n "$AWS_REGION" ]; then
    export RCLONE_CONFIG_S3_PROVIDER=AWS
    export RCLONE_CONFIG_S3_PROVIDER="$AWS_REGION"
  fi
fi

s3dir="deb/xo-server/$VERSION"

for file in build/*; do
  [ -f "$file" ] || continue
  rclone -v --ignore-existing copy "$file" "s3:${AWS_S3_BUCKET}/${s3dir}/"
done
