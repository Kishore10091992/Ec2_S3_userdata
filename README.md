## Terraform Configuration Overview

This Terraform configuration automates the provisioning of AWS infrastructure for a basic environment, including networking, compute, and storage resources. The setup is modular and parameterized for flexibility across different environments.

### 1. `variable.tf`

Defines all input variables used throughout the configuration. These variables allow customization of the environment without modifying the core code. Key variables include:

- **environment**: The deployment environment (e.g., dev, prod).
- **aws_region**: AWS region for resource deployment.
- **vpc_cidr**: CIDR block for the VPC.
- **subnet_cidr**: CIDR block for the subnet.
- **s3_bucket_name**: Name of the S3 bucket for storing user data scripts.
- **ec2_type**: EC2 instance type (e.g., t2.micro).
- **ec2_user_data**: User data script for EC2, which downloads and executes a script from S3.
- **public_ip**: Whether to assign a public IP to the EC2 instance.
- **default_ip**: Default IP range for security group rules.
- **default_protocol**: Default protocol for security group rules.

### 2. `main.tf`

This file contains the main resource definitions and uses the variables from `variable.tf` to provision AWS resources. Typical resources (based on the variables) include:

- **VPC**: A Virtual Private Cloud using the specified CIDR block.
- **Subnet**: A subnet within the VPC.
- **Security Group**: Allows traffic as defined by `default_ip` and `default_protocol`.
- **S3 Bucket**: Stores user data scripts for EC2 initialization.
- **EC2 Instance**: Launched with the specified type, user data, and network settings. The instance downloads and runs a script from the S3 bucket at startup.

All resources are parameterized, making the configuration reusable and easy to adapt for different environments or requirements.

### 3. `output.tf`

Defines outputs to display after Terraform applies the configuration. These outputs typically include:

- **VPC ID**
- **Subnet ID**
- **EC2 Public IP or DNS**
- **S3 Bucket Name**

Outputs help users quickly find important resource identifiers and connection details after deployment.

---

## Summary

- **Modular**: Uses variables for flexibility.
- **Automated**: Provisions networking, compute, and storage in AWS.
- **Reusable**: Easily adapted for different environments by changing variable values.
- **Transparent**: Outputs key resource information for user reference.

This setup is ideal for quickly spinning up a basic AWS environment for development, testing, or demonstration purposes.

---
