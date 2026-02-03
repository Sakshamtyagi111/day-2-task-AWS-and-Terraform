resource "aws_vpc" "intern_task_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
     name = "intern_task_vpc-demo" 
  }
}