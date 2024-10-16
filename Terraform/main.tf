provider "aws" {
  region = "us-east-1"  # Change this to your preferred region
}

resource "aws_security_group" "app_sg" {
  name        = "app_security_group1"
  description = "Allow HTTP and SSH traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere, change as needed
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere
  }

ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app" {
  ami           = "ami-0de53d8956e8dcf80"  # Change this to a valid AMI ID in your region
  instance_type = "t2.micro"
  security_groups = [aws_security_group.app_sg.name]

user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install docker -y
              service docker start
              docker run -d -p 8080:8080 rupacepro/webserver-project
              EOF

  tags = {
    Name = "MyAppInstance"
  }
}

output "instance_ip" {
  value = aws_instance.app.public_ip
}
output "instance_dns" {
  value = aws_instance.app.public_dns
}