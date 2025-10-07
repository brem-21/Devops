#!/usr/bin/env bash

# ------------------------------------------------------------------
# Script Name: deploy-s3-buckets.sh
# Description: Deploys S3 buckets in three different regions.
# Loads configuration from .env file.
# ------------------------------------------------------------------

# Exit immediately if a command exits with a non-zero status
set -e

# Load environment variables
if [ -f .env ]; then
    echo "Loading environment variables from .env file..."
    set -a  # automatically export all variables
    source .env
    set +a
else
    echo ".env file not found. Exiting."
    exit 1
fi

# Convert region strings to array
regions=($REGIONS)

# Generate timestamp for unique bucket names
timestamp=$(date +"%H%M%S")

# Check if BASE_NAME is set
if [ -z "$BASE_NAME" ]; then
    echo "BASE_NAME is not set. Exiting."
    exit 1
fi

echo "Deploying S3 buckets"
echo "Base name: $BASE_NAME"
echo "Regions: ${regions[@]}"
echo "Timestamp: $timestamp"
echo ""

for region in "${regions[@]}"; do
    bucket_name="${BASE_NAME}-${region}-${timestamp}"
    echo "Creating bucket: $bucket_name in region: $region"

    # Handle LocationConstraint exception for the primary region
    if [ "$region" == "$loc_cons" ]; then
        aws s3api create-bucket \
            --bucket "$bucket_name" \
            --region "$region"
    else
        aws s3api create-bucket \
            --bucket "$bucket_name" \
            --region "$region" \
            --create-bucket-configuration LocationConstraint="$region"
    fi

    # Enable Versioning
    aws s3api put-bucket-versioning \
        --bucket "$bucket_name" \
        --versioning-configuration Status=Enabled

    # Add Tags
    aws s3api put-bucket-tagging \
        --bucket "$bucket_name" \
        --tagging "TagSet=[{Key=Name,Value=${bucket_name}},{Key=Environment,Value=${ENVIRONMENT}},{Key=Owner,Value=${OWNER}}]"

    echo "Bucket $bucket_name created successfully in region: $region"
    echo ""
done

echo "All buckets created successfully."
