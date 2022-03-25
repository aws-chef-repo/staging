variable "ssh_key_file" {
  type        = string
  default     = "/home/ec2-user/aws-r-goto_osaka_ed25519.pem"
}

variable "user_name" {
  type = string
  default = "ec2-user"
}
