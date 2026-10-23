terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "web-ec2-sg"
  description = "Allow HTTP and SSH traffic"
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port= 80
        to_port= 80
        protocol= "tcp"
        cidr_blocks= ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "web" {
    ami= data.aws_ami.amazon_linux.id
    instance_type = var.instance_type
    security_groups = [aws_security_group.ec2_sg.name]
    tags={
        Name = var.tag_name
    }
    user_data=base64encode(templatefile("${path.module}/userdata.sh", {
    github_repo_url = var.github_repo_url
    github_token    = var.github_token
    root_password=var.db_root_password
    user_password=var.db_user_password
    }))
}