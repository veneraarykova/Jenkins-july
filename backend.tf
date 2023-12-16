terraform {
   backend "s3" {
     bucket = "venera-bucket"
     key = "terraform.tfstate"
     region = "us-east-2"
   }
}
