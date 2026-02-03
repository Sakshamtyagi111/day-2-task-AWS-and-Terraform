Multi-Region Web Infrastructure with Terraform  video link :- https://www.loom.com/share/6e6d20ea36bb46768c2e35418263dac5

Author: Saksham Tyagi 
Tools: Terraform, AWS (EC2, VPC, S3, DynamoDB), Git, Bash Regions: us-east-1 (N. Virginia) & us-east-2 (Ohio)

1. Project Overview
The goal of this project was to deploy a robust, multi-region web server architecture using Infrastructure as Code (Terraform). Rather than relying on default settings, I architected a custom network environment to demonstrate deep control over AWS resources, including custom VPCs, secure subnets, and remote state management.

The final result is a consistent, automated deployment of Ubuntu web servers across two distinct geographic regions (Virginia and Ohio), managed by a single Terraform codebase.

2. Architecture Decisions & Design
Custom VPC Design
I chose to move away from the Default VPC to demonstrate proper network isolation.

Design: I architected a custom VPC (10.0.0.0/16) and established a clear subnetting strategy. I assigned specific CIDR blocks to ensure clean routing and logical separation between the resources.

State Management (S3 Backend)
To simulate a professional team environment, I migrated the terraform.tfstate file from my local machine to a remote S3 Bucket with DynamoDB Locking.

Bootstrapping Strategy: I realized I couldn't create the bucket and use it in the same file (the "Chicken and Egg" problem). I implemented a "Bootstrapping" phase using a separate directory to provision the S3 bucket and DynamoDB table first.

Security: I enabled server-side encryption and versioning on the bucket to prevent accidental state loss and ensure data integrity.

3. Key Implementation Challenges Solved
A. The "Amazon Linux vs. Ubuntu" Nuance
I utilized a dynamic data source to fetch the latest Ubuntu AMI. However, I initially encountered issues bootstrapping the web server.

The Issue: My original User Data script was written for Amazon Linux (using dnf and httpd), but the target OS was Ubuntu.

The Solution: I rewrote the script to use apt-get and apache2, and added a custom HTML page ("Hello from Terraform! Deployed by Saksham") to visually verify successful deployment.

B. Multi-Region AMI ID Management
When expanding the infrastructure to Ohio (us-east-2), the deployment initially failed.

The Discovery: I learned that AMI IDs are region-specific—the ID for Ubuntu 22.04 in Virginia does not exist in Ohio.

The Solution: I implemented a multi-provider setup. I added a second data block explicitly pointing to provider = aws.ohio to dynamically fetch the correct Ubuntu AMI ID for that specific region.

C. Modernizing Security Groups
I initially started with inline security rules but realized this isn't scalable for complex applications.

Refactor: I modernized the code to use the aws_vpc_security_group_ingress_rule resource.

Benefit: This modular approach allowed me to decouple the rules from the group itself, preventing cyclic dependencies and making it easier to add specialized ports without disrupting existing HTTP access.

D. The Git "Large File" Hurdle
During the version control process, I encountered a "remote rejected" error from GitHub.

Root Cause: The .terraform/ folder, containing heavy AWS provider binaries (>100MB), was accidentally staged.

Resolution: I implemented a robust .gitignore file to exclude binaries while preserving the .terraform.lock.hcl file (crucial for team consistency). I utilized git rm --cached to scrub the large files from history without deleting my local configuration.

4. Automation & Stability
To ensure the infrastructure remains stable over time, I implemented a Lifecycle Rule:

Terraform
lifecycle {
  ignore_changes = [ ami ]
}
Reasoning: This prevents Terraform from triggering a destructive update (re-creating the server) just because a newer Ubuntu patch is released. This prioritizes system stability over constant updates.

Finally, I created an outputs.tf file to print the Public IPs and URLs directly in the terminal, streamlining the verification process.

5. How to Run This Project
Initialize:

Bash
terraform init
Plan (Dry Run):

Bash
terraform plan
Deploy:

Bash
terraform apply --auto-approve
Verify: Click the URL generated in the output to see the "Hello World" page, or SSH into the instance using the newkey2407 key pair.
image for referance :- <img width="1892" height="863" alt="image" src="https://github.com/user-attachments/assets/8d8156cb-ab47-40f5-b95f-746a6afd710a" />


