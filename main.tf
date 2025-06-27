terraform {
 cloud {
  organization = "1st_Terraform_Cloud"
  
  workspace {
   name = "Ec2_S3_userdata"
  }
 }
 
 required_providers {
  aws {
   source = "hashicorp/aws"
   version = "~>5.0"
  }
 }
}

provider "aws" {
 region = var.aws_region
}

locals {
 project_name = "ec2_s3_userdata"
 full_name = "${local.project_name}-${var.environment}"
}

resource "aws_vpc" "ec2_s3_vpc" {
 cidr_block = var.vpc_cidr
 
 tags = {
  Name = "${local.full_name}-vpc"
 }
}

resource "aws_subnet" "ec2_s3_sub" {
 vpc_id = aws_vpc.ec2_s3_vpc.vpc_id
 cidr_block = var.subnet_cidr
 
 tags = {
  Name = "${local.full_name}-subnet"
 }
}

resource "aws_internet_gateway" "ec2_s3_IGW" {
 vpc_id = aws_vpc.ec2_s3_vpc.id
 
 tags = {
  Name = "${local.full_name}-ec2_s3_IGW"
 }
}

resource "aws_route_table" "ec2_s3_rt" {
 vpc_id = aws_vpc.ec2_s3_vpc.id
 
 route {
  cidr_block = var.default_ip
  gateway_id = aws_internet_gateway.ec2_s3_IGW.id
 }
 
 tags = {
  Name = "${local.full_name}-ec2_s3_rt"
 }
}
 
resource "aws_security_group" "ec2_s3_sg" {
 vpc_id = aws_vpc.ec2_s3_vpc.id
 
 ingress {
  from_port = 0
  to_port = 0
  cidr_block = var.default_ip
  protocol = var.default_protocol
 }
 
 egress {
  from_port = 0
  to_port = 0
  cidr_block = var.default_ip
  protocol = var.default_protocol
 }
 
 tags = {
  Name = "${local.full_name}-sg"
 }
}

data "aws_ami" "ec2_s3_ami" {
 most_recent = true
 owners = ["amazon"]

 filter {
  name = "name"
  values = ["amzn2-ami-hvm-*"]
 }
}

resource "aws_iam_role" "ec2_s3_role" {
 
 assume_role_policy = jsonencode({
  version = "2012-10-17"
  statement = [{
   Action = "sts:AssumeRole",
   Principal = {
    Service = "ec2.amazonaws.com"
   },
   Effect = "Allow",
  }]
 })

 tags = {
  Name = "${local.full_name}-ec2_s3_role"
 }
}

 resource "aws_iam_policy" "ec2_s3_policy" {
  policy = jsonencode({
   version = "2012-10-17"
   statement = [{
    Action = "s3:GetObject"
    Effect = "Allow"
    Resource = "arn:aws:s3:::${var.s3_bucket_name}/*"
   }]
  })

  tags = {
   Name = "${local.full_name}-ec2.s3.policy"
  }
 }

resource "aws_iam_role_policy_attachment" "role_policy_attach" {
 role_arn = aws_iam_role.ec2_s3_role.arn
 policy_arn = aws_iam_policy.ec2_s3_policy.arn
}

resource "aws_iam_instance_profile" "ec2_s3_instance_profile" {
 name = "${local.full_name}-ec2_s3_instance_profile"
 role = aws_iam_role.ec2_s3_role.name
 tags = {
  Name = "${local.full_name}-ec2_s3_instance_profile"
 }
}

resource "aws_instance" "ec2_s3_instance" {
 ami = data.aws_ami.ec2_s3_ami.id
 instance_type = var.ec2_type
 subnet_id = aws_subnet.ec2_s3_sub.id
 vpc_security_group_ids = [aws_security_group.ec2_s3_sg.id]
 iam_instance_profile = aws_iam_instance_profile.ec2_s3_instance_profile.name
 associate_public_ip_address = var.public_ip

 user_data = var.ec2_user_data

 tags = {
  Name = "${local.full_name}-ec2_s3_instance"
 }
}