variable "count" {
  type = "string"
}

variable "domain" {
  type = "string"
}

variable "certificate-provider" {
  type = "string"
  default = "aws.us-east"
}
