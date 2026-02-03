
resource "aws_route_table" "public-rt-demo" {
  vpc_id = aws_vpc.intern_task_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig-demo-task.id
  }


  tags = {
    Name = "route-table-public-subnet"
  }
}


resource "aws_route_table_association" "rt-association-public" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt-demo.id
}

resource "aws_route_table" "private-rt-demo" {
  vpc_id = aws_vpc.intern_task_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.aws_nat_gateway-demo.id
  }

 
  tags = {
    Name = "route-table-private-subnet"
  }
}



resource "aws_route_table_association" "rt-association-private" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-rt-demo.id
}