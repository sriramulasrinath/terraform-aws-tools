module "jenkins" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "jenkins.tf"

  instance_type          = "t3.small"
  vpc_security_group_ids = ["sg-0b52cba635db55c54"]
  subnet_id              = "subnet-00d1bf02a873408bb"
  ami                    = data.aws_ami.ami_info.id
  user_data = file("jenkins.sh")

  tags = {
        Name = "jenkins.tf"
    }
}

module "jenkins_agent" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "jenkins-agent"
  instance_type          = "t3.small"
  vpc_security_group_ids = ["sg-0b52cba635db55c54"]
  subnet_id              = "subnet-00d1bf02a873408bb"
  ami                    = data.aws_ami.ami_info.id
  user_data = file("jenkins-agent.sh")

  tags = {
        Name = "jenkins-agent"
    }
}

/*
resource "aws_key_pair" "tools" {
  key_name = "tools"
  #public_key =  ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF3/FINvjYpjY9kIAHD9dNsURR4KTBpqdCdmYJjXLSBU
  public_key = file("~/.ssh/tools.pub")
}

module "nexus" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "nexus"

  instance_type          = "t3.medium"
  vpc_security_group_ids = ["sg-0b52cba635db55c54"]
  subnet_id              = "subnet-00d1bf02a873408bb"
  key_name = aws_key_pair.tools.key_name
  ami                    = data.aws_ami.nexus_ami_info.id
  root_block_device = [
    {
      volume_type = "gp3"
      volume_size = 30
    }
  ]
  tags = {
    Name = "nexus"
  }
}
module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_name = var.zone_name

  records = [
    {
      name    = "jenkins"
      type    = "A"
      ttl     = 1
      records = [
        module.jenkins.public_ip
      ]
    },
    {
      name    = "jenkins-agent"
      type    = "A"
      ttl     = 1
      records = [
        module.jenkins_agent.private_ip
      ]
    },
    {
      name    = "nexus"
      type    = "A"
      ttl     = 1
      records = [
        module.nexus.private_ip
      ]
    }
  ]
}
*/
