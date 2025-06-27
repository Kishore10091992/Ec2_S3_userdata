output "vpc_id" {
 description = "vpc id"
 value = aws_vpc.ec2_s3_vpc.id
}

output "subnet_id" {
 description = "subnet id"
 value = aws_subnet.ec2_s3_sub.id
}

output "IGW_id" {
 description = "internet gateway id"
 value = aws_internet_gateway.ec2_s3_IGW.id
}

output "rt_id" {
 description = "route table id"
 value = aws_route_table.ec2_s3_rt.id
}

output "sg_id" {
 description = "security group id"
 value = aws_security_group.ec2_s3_sg.id
}

output "iam_role_arn" {
 description = "iam role arn"
 value = aws_iam_role.ec2_s3_role.arn
}

output "iam_policy_arn" {
 description = "iam policy arn"
 value = aws_iam_policy.ec2_s3_policy.arn
}

output "ec2_instance_id" {
 description = "ec2_instance id"
 value = aws_instance.ec2_s3_instance.id
}

output "ec2_pub_ip" {
 description = "ec2 public ip"
 value = aws_instance.ec2_s3_instance.public_ip
}

output "ec2_pri_ip" {
 description = "ec2 private ip"
 value = aws_instance.ec2_s3_instance.private_ip
}