#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

echo " Listing all S3 buckets in your AWS account..."
echo ""

# Fetch all bucket names
buckets=$(aws s3api list-buckets --query "Buckets[].Name" --output text)

if [ -z "$buckets" ]; then
    echo "No buckets found in this account."
    exit 0
fi

printf "%-40s %-20s\n" "Bucket Name" "Region"
printf "%-40s %-20s\n" "------------" "--------"

# Loop through each bucket
for bucket in $buckets; do
    # Get bucket location (may return "None" for us-east-1)
    location=$(aws s3api get-bucket-location --bucket "$bucket" --query "LocationConstraint" --output text 2>/dev/null)

    # Handle the us-east-1 special case
    if [ "$location" == "None" ] || [ "$location" == "null" ]; then
        location="us-east-1"
    fi

    printf "%-40s %-20s\n" "$bucket" "$location"
done

echo ""
echo " S3 bucket listing completed successfully."
