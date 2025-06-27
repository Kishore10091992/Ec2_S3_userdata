variable "environment" {
 description = "project environment"
 type = string
 default = "dev-env"
}

variable "aws_region" {
 description = "project region"
 type = string
 default = "us-east-1"
}

variable "vpc_cidr" {
 description = "cidr for vpc"
 type = string
 default = "172.168.0.0/16"
}

variable "subnet_cidr" {
 description = "cidr for subnet"
 type = string
 default = "172.168.0.0/24"
}

variable "s3_bucket_name" {
 description = "name for s3 bucket"
 type = string
 default = "ec2_s3_userdata"
}

variable "ec2_type" {
 description = "ec2 instance type"
 type = string
 default = "t2.micro"
}

variable "ec2_user_data" {
 description = "user data for ec2"
 type = string
 default = <<-EOF
           #!/bin/bash
           aws s3 cp s3://${var.s3_bucket_name}/userdata.sh /tmp/userdata.sh
           chmod +x /tmp/userdata.sh
           /tmp/userdata.sh
           EOF
}

variable "public_ip" {
 description = "assign public ip"
 type = bool
 default = true
}

variable "default_ip" {
 description = "default ip address"
 type = string
 default = "0.0.0.0/0"
}

variable "default_protocol" {
 description = "default protocol"
 type = string
 default = "-1"
}