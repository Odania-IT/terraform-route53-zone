output "certificate-arn" {
  value = "${aws_acm_certificate.certificate.*.arn}"
}

output "zone-id" {
  value = "${aws_route53_zone.zone.*.zone_id}"
}
