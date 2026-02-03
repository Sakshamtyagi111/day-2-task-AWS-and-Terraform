# --- STEP 1: Define the "Container" ---
resource "aws_security_group" "allow_web" {
  name        = "web-server-sg"
  description = "Security group for my web server"
  vpc_id      = aws_vpc.intern_task_vpc.id

  tags = {
    Name = "web-server-sg"
  }
}

# STEP 2: Define INCOMING Rules (Ingress) 
# Use the new 'aws_vpc_security_group_ingress_rule' resource
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.allow_web.id
  
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
  
  description = "Allow SSH from anywhere"
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.allow_web.id
  
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
  
  description = "Allow HTTP for the web page"
}

# --- STEP 3: Define OUTGOING Rules (Egress) ---
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.allow_web.id
  
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1" # "-1" means ALL protocols
  
  description = "Allow server to reach the internet for updates"
}



