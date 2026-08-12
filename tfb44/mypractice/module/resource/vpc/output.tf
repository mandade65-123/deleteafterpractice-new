output "subnet_id" {
  value = aws_subnet.your_subnet_resource_name.id
}


output "vpc_id" {
    value = aws_vpc.ws_vpc.id
}