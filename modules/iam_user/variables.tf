variable "region" {
  type    = string
  default = "us-east-1"
}

variable "path" {
  type    = string
  default = "/"
}

variable "create_access_key" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(string)
  default = {}
}
