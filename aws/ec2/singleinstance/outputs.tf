output "hostname" {
  description = "hostname of instance"
  value = aws_instance.my-instance[*].tags.name
}
output "private_ip" {
  description = "private ip of instance"
  value = aws_instance.my-instance[*].private_ip
}
output "instance_id" {
  description = "instance id of the instance"
  value = aws_instance.my-instance[*].id
}