terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-3"
}

resource "aws_instance" "instance" {
  count         = 5
  ami           = "ami-066136c75998a0ef3"
  instance_type = "t2.large"
  # vpc_security_group_ids = "vpc-87610aee"
  subnet_id = "subnet-130aaf5e"
  key_name = "r-goto_osaka_ed25519"
  tags = {
    Owner = "r-goto"
    Name = format("chef-RHEL8-node%02d", count.index + 1)
    Project = "chef-demo"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname AWS-node_`uuidgen | grep -o '..$'`",
      "sudo chef-client"
    ]
    connection {
      host = self.public_ip
      user = "ec2-user"
      type = "ssh"
      private_key = file("/home/ec2-user/aws-r-goto_osaka_ed25519.pem")
      timeout = "10m"
    }
  }
}

output "instance_public_ip" {
  description = "Public IP address of the created EC2 instance"
  value       = aws_instance.instance.*.public_ip
}
