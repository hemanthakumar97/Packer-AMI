packer {
  required_plugins {
    amazon = {
      version = "= 1.3.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "assume_role_arn" {
  type    = string
}

variable "aws_region" {
  type    = string
}

variable "instance_type" {
  type    = string
}

variable "source_ami" {
  type    = string
}

variable "ami_name" {
  type    = string
}

variable "ssh_username" {
  type    = string
}

variable "script_file" {
  type    = string
}

variable "subnet_id" {
  type    = string
}

variable "security_group_id" {
  type    = string
}

variable "associate_public_ip_address" {
  type    = bool
}

variable "ssh_interface" {
  type    = string
}

variable "iam_instance_profile" {
  type    = string
}

variable "imds_support" {
  type    = string
}

source "amazon-ebs" "golden-ami" {
  assume_role {
      role_arn     = var.assume_role_arn
  }  
  region           = var.aws_region
  instance_type    = var.instance_type
  source_ami       = var.source_ami
  ssh_username     = var.ssh_username
  ami_name         = var.ami_name
  subnet_id        = var.subnet_id
  security_group_id = var.security_group_id
  associate_public_ip_address = var.associate_public_ip_address
  ssh_interface     = var.ssh_interface
  iam_instance_profile = var.iam_instance_profile
  imds_support  = var.imds_support
}

build {
  sources = ["source.amazon-ebs.golden-ami"]

  provisioner "shell" {
    script = var.script_file
  }
}
