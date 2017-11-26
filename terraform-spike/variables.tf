variable "environment" {
  type        = "string"
  default     = "build"
}

variable "bucket_name" {
  type        = "string"
  default     = "nonprod-tf-remote-state"
}
