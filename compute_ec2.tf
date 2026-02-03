# --- Data Sources ---

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] 

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

data "aws_ami" "ubuntu_ohio" {
  provider    = aws.ohio
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# --- Resources ---

resource "aws_instance" "web_server" {
  ami           = data.aws_ami.ubuntu.id 
  instance_type = "t3.micro"
  
  subnet_id                   = aws_subnet.public-subnet.id
  vpc_security_group_ids      = [aws_security_group.allow_web.id]
  associate_public_ip_address = true 
  key_name                    = aws_key_pair.saksham-ec2-key.key_name

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
    encrypted   = true
    tags = {
      Name = "root-volume-123"
    }
  }

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>Hello from Terraform! Deployed by Saksham tyagi.</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name    = "Intern-Task-Web-Server-1"
    Project = "Terraform-Demo"
  }

  lifecycle {
    ignore_changes = [ ami ]
  }
}

resource "aws_instance" "instance-2" {
  provider      = aws.ohio
  ami           = data.aws_ami.ubuntu_ohio.id
  instance_type = "t2.micro"

  tags = {
    name = "Inter-task-web-server-2-ohio"
  }
  
  lifecycle {
    ignore_changes = [ ami ]
  }
}