resource "aws_route53_zone" "zone" {
  count = "${var.count}"
  name = "${var.domain}"
}

resource "aws_acm_certificate" "certificate" {
  count = "${var.count}"
  domain_name = "${var.domain}"
  validation_method = "DNS"
  subject_alternative_names = [
    "*.${var.domain}"
  ]

  provider = "${var.certificate-provider}"
}

resource "aws_route53_record" "validation" {
  count = "${var.count}"
  name = "${aws_acm_certificate.certificate.domain_validation_options.0.resource_record_name}"
  type = "${aws_acm_certificate.certificate.domain_validation_options.0.resource_record_type}"
  zone_id = "${aws_route53_zone.zone.zone_id}"
  records = [
    "${aws_acm_certificate.certificate.domain_validation_options.0.resource_record_value}"
  ]
  ttl = 60
}

resource "aws_acm_certificate_validation" "validation" {
  count = "${var.count}"
  certificate_arn = "${aws_acm_certificate.certificate.arn}"
  validation_record_fqdns = [
    "${aws_route53_record.validation.fqdn}"
  ]

  provider = "${var.certificate-provider}"
  depends_on = [
    "aws_route53_record.validation",
    "aws_acm_certificate.certificate"
  ]
}
