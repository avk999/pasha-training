 output "master_public_ip_addr" {
  value       = aws_instance.k3s_master.public_ip
  description = "Master public ip."
} 