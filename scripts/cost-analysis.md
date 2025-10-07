# S3 Cost Analysis

This document provides a cost estimation for S3 storage across the three regions used in this project.

## Standard S3 Storage Pricing by Region

### US East 1 (N. Virginia)
- **Storage**: $0.023 per GB/month
- **PUT/COPY/POST/LIST requests**: $0.0005 per 1,000 requests
- **GET/SELECT requests**: $0.0004 per 1,000 requests

### EU West 1 (Ireland)
- **Storage**: $0.025 per GB/month
- **PUT/COPY/POST/LIST requests**: $0.0005 per 1,000 requests
- **GET/SELECT requests**: $0.0004 per 1,000 requests

### AP Southeast 1 (Singapore)
- **Storage**: $0.025 per GB/month
- **PUT/COPY/POST/LIST requests**: $0.00055 per 1,000 requests
- **GET/SELECT requests**: $0.00044 per 1,000 requests

## Monthly Cost Estimation for 100GB Storage

### Assumptions
- 100GB of data stored for one month
- 1,000 PUT requests per month
- 10,000 GET requests per month
- Standard storage class

### Cost Breakdown by Region

#### US East 1 (N. Virginia)
- Storage: 100GB × $0.023 = **$2.30**
- PUT requests: 1 × $0.0005 = **$0.0005**
- GET requests: 10 × $0.0004 = **$0.004**
- **Total Monthly Cost: $2.30**

#### EU West 1 (Ireland)
- Storage: 100GB × $0.025 = **$2.50**
- PUT requests: 1 × $0.0005 = **$0.0005**
- GET requests: 10 × $0.0004 = **$0.004**
- **Total Monthly Cost: $2.50**

#### AP Southeast 1 (Singapore)
- Storage: 100GB × $0.025 = **$2.50**
- PUT requests: 1 × $0.00055 = **$0.00055**
- GET requests: 10 × $0.00044 = **$0.0044**
- **Total Monthly Cost: $2.51**

## Data Transfer Costs

### Inter-Region Data Transfer
- **From US East 1 to other regions**: $0.02 per GB
- **From EU West 1 to other regions**: $0.02 per GB
- **From AP Southeast 1 to other regions**: $0.02 per GB

### Internet Data Transfer (Outbound)
- **US East 1**: First 1GB free, then $0.09 per GB
- **EU West 1**: First 1GB free, then $0.09 per GB
- **AP Southeast 1**: First 1GB free, then $0.12 per GB

## Pricing Differences Observed

### Storage Costs
- **US East 1** is the most cost-effective at $0.023/GB
- **EU West 1** and **AP Southeast 1** are 8.7% more expensive at $0.025/GB

### Request Costs
- **US East 1** and **EU West 1** have identical request pricing
- **AP Southeast 1** has 10% higher request costs

### Data Transfer
- Inter-region transfer costs are consistent at $0.02/GB
- Internet outbound costs vary, with AP Southeast 1 being 33% more expensive

## Cost Optimization Recommendations

1. **Primary Storage**: Use US East 1 for cost-sensitive workloads
2. **Regional Compliance**: Use local regions when data residency is required
3. **Request Optimization**: Minimize PUT/GET requests in AP Southeast 1
4. **Data Transfer**: Plan cross-region transfers carefully due to additional costs

## Total Project Cost Estimate

For 100GB stored across all three regions:
- **US East 1**: $2.30/month
- **EU West 1**: $2.50/month  
- **AP Southeast 1**: $2.51/month
- **Total**: $7.31/month
