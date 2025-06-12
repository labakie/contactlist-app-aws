provider "aws" {
  region = "us-east-1"
  # region = "ap-southeast-3"
  profile = "msi-cebc"
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}