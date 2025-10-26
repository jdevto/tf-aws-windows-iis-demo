# terraform-aws-windows-iis-demo

Terraform demo that deploys a Windows Server instance with IIS for hosting a simple web application or static site.

## Architecture

- VPC with public and private subnets
- NAT Gateway for private subnet internet access
- Windows Server 2025 EC2 instance with IIS
- Security group allowing HTTP (port 80) from your current public IP
- SSM Session Manager for secure instance access
- Automated web page showing instance metadata

## Features

- Automatically fetches your current public IP for security group rules
- Installs and configures IIS via user data script
- Creates a styled HTML page displaying instance details dynamically
- IAM role with SSM permissions for secure access
- Latest Windows Server 2025 AMI
- User data script extracted to separate file for maintainability

## Usage

1. Initialize Terraform:

   ```bash
   terraform init
   ```

2. Review and apply:

   ```bash
   terraform plan
   terraform apply
   ```

3. Access the web server:
   - The output will provide the public IP and HTTP URL
   - Wait 5-10 minutes for Windows to boot and configure IIS
   - Open the URL in your browser
   - The page will display instance metadata including ID, AZ, private IP, hostname, and OS version

4. Connect to the instance via SSM:

   ```bash
   aws ssm start-session --target <instance-id>
   ```

## Outputs

- `windows_instance_public_ip` - Public IP of the Windows instance
- `windows_instance_id` - Instance ID
- `iis_url` - HTTP URL to access the web server

## Requirements

- AWS CLI configured with appropriate credentials
- Terraform >= 1.0
- AWS provider >= 6.0
- HTTP provider >= 3.4
