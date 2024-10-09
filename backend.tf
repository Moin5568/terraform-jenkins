terraform {
  backend "s3" {
    bucket = "moin-bucket-24"
    region = "ap-south-1"
    key = "moin/terraform.tfstate"
    
  }
}