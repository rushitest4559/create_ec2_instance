# AWS EC2 Launch Task – Manual + Terraform

**Task completed:**  
- Learn core AWS EC2 concepts  
- Launch EC2 instance manually via AWS Console  
- Provision EC2 instance using Terraform  
- Document the process

## Core AWS EC2 Requirement (Must-Have 3 Things)

To launch any EC2 instance, AWS **requires** these three mandatory items:

1. **AMI ID** – defines the OS/image  
2. **Instance Type** – defines CPU, memory, etc. (e.g. t3.micro)  
3. **Subnet ID** – defines network location (VPC + AZ)

Without any one of these, the instance cannot be created.

## Terraform Approach in this Project

- **Instance Type**: Provided via variable (default: `t3.micro`)  
- **AMI ID**: Dynamically fetched using `data "aws_ami"` block → latest Ubuntu 24.04 LTS (official Canonical image) in current region  
- **Subnet ID**: Dynamically fetched → one public subnet from the **default VPC** using `data "aws_vpc"` + `data "aws_subnets"` blocks  

→ **No need to go to AWS Console** to copy-paste AMI ID or Subnet ID — everything is automatic and region-aware.

## Important Prerequisite – Key Pair
Terraform needs an existing key pair in AWS to allow SSH access.
**Before running `terraform apply`**, make sure key pair `"<yourname>_key"` exists in your AWS account.
### Steps to create & upload key pair from Windows:
1. Open **PowerShell** or **Command Prompt**
2. Generate key pair (if not already done):
```powershell
ssh-keygen -t ed25519 -C "<yourname>@work" -f $HOME\.ssh\<yourname>-aws-key
```
→ Creates <yourname>-aws-key (private) and <yourname>-aws-key.pub (public)
3. Upload public key to AWS (rename to match Terraform code):
```powershell
  aws ec2 import-key-pair ^
    --key-name <yourname>_key ^
    --public-key-material fileb://C:\Users\YourUsername\.ssh\<yourname>-aws-key.pub
```
Replace YourUsername with your actual Windows username.

## Outputs

After `terraform apply` succeeds, you will see:
public_ip = "<your-instance-public-ip>"
**Use this IP to SSH:**
```bash
ssh -i ~/.ssh/rushikesh-aws-key ubuntu@<public-ip>
```

## Files in this repo

- `main.tf`       → data blocks + EC2 module  
- `variables.tf`  → instance_name, instance_type  
- `outputs.tf`    → public_ip output  
- `provider.tf`   → provider plugins versions  
- `README.md`     → this file


Done!