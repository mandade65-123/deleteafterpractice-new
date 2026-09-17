 output "instaneip" {
  value = aws_instance.webserver[0].public_ip
}

output "pubdns" {
  value = aws_instance.webserver[0].public_dns
}