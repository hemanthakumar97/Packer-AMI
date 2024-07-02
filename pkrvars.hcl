# x86 architecture
# source_ami = "ami-08a0d1e16fc3f61ea" 
# instance_type = "t3.small"
# ami_name = "packer-poc-v3"
# script_file = "fe-dependencies.sh"

# ARM architecture
source_ami = "ami-0c7c372d7193f3428"    # The base AMI to use, using Linux 2 base AMI here
instance_type = "t4g.small"             # Type of instance to launch for AMI creation
ami_name = "packer-ami-arm-linux2"  # AMI Name
script_file = "dependencies-arm.sh"  # Script which has the commands to install dependencies

assume_role_arn = "arn:aws:iam::<ACCOUNT_ID>:role/Packer-Role"  # Assume this role to create AMI with dependencies
aws_region = "us-east-1"
ssh_username = "ec2-user"
subnet_id = <subnet_id>      # The subnet ID where the instance will be launched
security_group_id = <security_group_id>  # The security group ID to attach to the instance
associate_public_ip_address = false
ssh_interface = "private_ip"                            # Use private IP to connect to the
iam_instance_profile = "Packer-EC2-Instance-Profile"    # IAM profile role to attach to the instance
imds_support  = "v2.0"
