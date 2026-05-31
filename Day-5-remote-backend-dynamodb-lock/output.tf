output "public_ip" {
  value = aws_instance.named.public_ip
}

output "private_ip" {
  value = aws_instance.named.private_ip
}
