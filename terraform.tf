terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.99"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "5.5.0"
    }
  }
  required_version = ">= 1.12.1"
}
