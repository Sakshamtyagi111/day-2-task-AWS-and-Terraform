resource "aws_key_pair" "saksham-ec2-key" {
  key_name   = "newkey2407"
  
  
  public_key = file("C:/Users/Test Machine/saksham-key.pub")
}