# ⚡ One Command, Strapi Live!

Run `terraform apply --auto-approve`, wait ~20 mins, and open the URL in your browser — Strapi magically appears!

## Repo Structure

```text
.
├── modules/
│   ├── ami/             # Fetch latest Ubuntu AMI
│   ├── ec2/             # Launch EC2 instance
│   ├── keypair/         # Generate SSH key pair
│   ├── load-balancer/   # Creates Load balancer and target groups
│   ├── networking/      # VPC, subnets, IGW, NAT route tables
│   └── security-group/  # Security groups for LB and ec2 – Strapi ports
└── terraform/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    ├── provider.tf
    ├── terraform.tfvars
    ├── .terraform.lock.hcl
    └── user_data.sh     # Cloud-init script – installs Strapi
```

## How it Works

1. Configure `terraform.tfvars` (optional).  
2. Run `terraform apply --auto-approve`.  
3. Wait ~20 mins for Strapi setup.  
4. Access Strapi via Load Balancer URL in output.  

🚀 Done! Your Strapi instance is live.

## 🔐 SSH & Access
No manual SSH setup is required. Terraform automatically generates a private key in your `~/.ssh` folder and uploads the public key to AWS. To access instances in the private subnet, simply use a Bastion host; the keys are already configured for a seamless connection.

![terraform apply 1](./images/terraform_apply_1.PNG)
![terraform apply 2](./images/terraform_apply_2.PNG)
![terraform apply 3](./images/terraform_apply_3.PNG)
![aws 1](./images/aws_1.PNG)
![strapi](./images/strapi.PNG)
![strapi 2](./images/strapi_2.PNG)
![user data 1](./images/user_data_1.PNG)
![user data 2](./images/user_data_2.PNG)
