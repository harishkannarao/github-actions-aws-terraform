output "bastion_public_ips" {
  value = ["${aws_instance.bastion.*.public_ip}"]
}