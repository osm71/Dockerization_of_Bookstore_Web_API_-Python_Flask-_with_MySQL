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
variable "instance_type" {
        default = "t2.micro"
}
variable "github_repo_url" {
  description = "GitHub repository URL for the application"
  type        = string
 }
    
variable "github_token" {
  description = "GitHub PAT for private repo clone"
  type        = string
  sensitive   = true
 }

    resource "aws_instance" "web" {
        ami= data.aws_ami.amazon_linux.id
        instance_type = var.instance_type}