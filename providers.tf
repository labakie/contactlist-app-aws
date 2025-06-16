provider "aws" {
  region  = var.aws_region
  profile = "msi-cebc"
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}