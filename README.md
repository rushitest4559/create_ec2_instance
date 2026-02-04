```markdown
# ⚡ One Command, Strapi Live!  

Run `terraform apply --auto-approve`, wait ~20 mins, and open the URL in your browser — Strapi magically appears!  

## Repo Structure

```

.
├── modules/
│   ├── ami/                 # Fetch latest Ubuntu AMI
│   ├── ec2/                 # Launch EC2 instance
│   ├── keypair/             # Generate SSH key pair
│   ├── networking/          # VPC, subnet, IGW, route table
│   └── security-group/      # Security group – Strapi ports
└── terraform/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    ├── provider.tf
    ├── terraform.tfvars
    ├── .terraform.lock.hcl
    └── user_data.sh          # Cloud-init script – installs Strapi
```

## How it Works

1. Configure `terraform.tfvars` (optional).  
2. Run `terraform apply --auto-approve`.  
3. Wait ~20 mins for Strapi setup.  
4. Access Strapi via instance URL in output.  

🚀 Done! Your Strapi instance is live.
```
