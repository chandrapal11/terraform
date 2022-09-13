variable "bucket_name" {}

variable "acl_value" {
    description = " Acl value for S3 bucket"
    type        = string
    default = "private"
}

variable "table_name" {
    description = "Dynamodb table name (space is not allowed)"
    type        = string
    default = "Files"
}

variable "table_billing_mode" {
    description = "Controls how you are charged for read and write throughput and how you manage capacity."
    type        = string
    default = "PAY_PER_REQUEST"
}

variable "timeout_minutes" {
    description = "timeout defined for lock in dynamodb"
    type        = number
    default = 1
}

variable "handler_name" {
    description = "Controls how you are charged for read and write throughput and how you manage capacity."
    type        = string
    default = "README.md"
}

variable "runtime" {
    description = "Controls how you are charged for read and write throughput and how you manage capacity."
    type        = string
    default = "python3.6"
}

variable "timeout" {
    description = "Controls how you are charged for read and write throughput and how you manage capacity."
    type        = number
    default = 900
}