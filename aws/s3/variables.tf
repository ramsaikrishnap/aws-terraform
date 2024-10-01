
variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to the S3 bucket"
  type        = map(string)
  default     = {}
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket"
  type        = bool
  default     = true
}

variable "enable_versioning" {
  description = "Whether to enable versioning on the S3 bucket"
  type        = bool
  default     = false
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}