resource "aws_internet_gateway" "ig-demo-task" {
  vpc_id = aws_vpc.intern_task_vpc.id

  tags = {
    Name = "internet-gateway-demo"
  }
}