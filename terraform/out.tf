output "website_url" {
  description = "Access your Strapi app here"
  value       = "http://${module.lb.alb_dns_name}"
}

output "nat_gateway_ip" {
  value = module.networking.nat_gw_public_ip
}