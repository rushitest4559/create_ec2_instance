output "instance_public_ip" {
  description = "Public IP of Strapi EC2 instance"
  value       = module.ec2.public_ip
}

output "strapi_url" {
  description = "Strapi application URL"
  value       = "http://${module.ec2.public_ip}:1337"
}
