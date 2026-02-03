# backend.tf
terraform {
  backend "s3" {
    # Replace this with the Bucket Name you created in Step 1
    bucket         = "backend-terraform-bucket-1"
    
    # The folder structure inside S3
    key            = "global/s3/terraform.tfstate"
    
    region         = "us-east-1"
    
    # Replace this with the Table Name you created in Step 1
    dynamodb_table = "backend-statelock-terraform"
    encrypt        = true
  }
}