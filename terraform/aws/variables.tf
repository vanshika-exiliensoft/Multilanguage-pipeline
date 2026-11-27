
variable "aws_region" {
  description = "AWS deployment region"
  type        = string
  default     = "ap-south-1"
}

variable "ecr_repository_name" {
  description = "ECR repository name"
  type        = string
  default     = "multilanguage-pipeline"
}

variable "image_tag" {
  description = "Docker image tag already pushed to ECR"
  type        = string
  default     = "build-20261127-162252"
}

variable "allowed_cidr" {
  description = "Public IP allowed to access the application"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR range for the application VPC"
  type        = string
  default     = "10.0.0.0/16"
}
