variable "gcp_credentials" {
  type      = string
  sensitive = true
}

variable "project_id" {
  type = string
  sensitive = true
}

variable "ssh_public_key" {
  type      = string
  sensitive = true
}