output "lb_dns" {
  value = aws_lb.petClinicPrivateALB.dns_name
}