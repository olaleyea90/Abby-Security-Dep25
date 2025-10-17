variable "group_name"          { type = string }
variable "path"                { type = string, default = "/" }
variable "managed_policy_arns" { type = list(string), default = [] }
variable "user_names"          { type = list(string),  default = [] }
variable "tags"                { type = map(string),   default = {} }
