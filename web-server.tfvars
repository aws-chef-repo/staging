variable "policy_group" {
  type        = string
  default     = "aws"
}

variable "policy_name" {
  type        = string
  default     = "web-server"
}

variable "instance_count" {
  type        = number
  default     = 2
}