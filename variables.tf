variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "windows-iis"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-2"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["ap-southeast-2a", "ap-southeast-2b"]
}

variable "one_nat_gateway_per_az" {
  description = "Should be true if you want one NAT Gateway per availability zone. Otherwise, one NAT Gateway will be used for all AZs."
  type        = bool
  default     = false
}

variable "windows_instance_type" {
  description = "EC2 instance type for Windows IIS server"
  type        = string
  default     = "t3.medium"
}
