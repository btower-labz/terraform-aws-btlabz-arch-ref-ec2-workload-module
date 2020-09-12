variable "ami" {
  description = "Workload AMI identifier"
  type        = string
  default     = ""
}

data "aws_ami" "app" {
  most_recent = true

  filter {
    name   = "name"
    values = ["aws-ec2-reference-application-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # TODO: hardcode
  owners = ["725949405513"] # Private
}

locals {
  ami = "${var.ami == "" ? data.aws_ami.app.id : var.ami}"
}

output "latest_ami" {
  description = "The latest AMI"
  value       = "${local.ami}"
}
