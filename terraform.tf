provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "example" {
  ami           = "ami-05fb0b8c1424f266b"
  instance_type = "t2.micro"
  key_name      = "ohio"

  # Security group allowing SSH access
  security_groups = ["ssh-access"]


    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("/home/localuser/Downloads")
      host        = self.public_ip
    }
  }


# Security group allowing SSH access
resource "aws_security_group" "ssh-access" {
  name        = "ssh-access"
  description = "Allow SSH traffic"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Output the public IP address of the instance
output "instance_public_ip" {
  value = aws_instance.example.public_ip
}

