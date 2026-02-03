resource "aws_eip" "Nat_Eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "aws_nat_gateway-demo" {
  # This line handles the association automatically!
  allocation_id = aws_eip.Nat_Eip.id
  subnet_id     = aws_subnet.public-subnet.id

  tags = {
    Name = "gw-NAT"
  }

  depends_on = [aws_internet_gateway.ig-demo-task]
}