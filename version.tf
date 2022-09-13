terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.25" # Optional but recommended in production
    }
  }
}
