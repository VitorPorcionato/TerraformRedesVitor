
#Configuracao do Terraform
terraform {
  required_version = ">=1.6.0" #Versao do Terrafom

#Provedores utilizados
  required_providers {

    aws ={
        source = "hashicorp/aws"
        version = "5.40.0" #Versao do AWS no terraform
    }
  }
}

provider "aws" {
    region = "us-east-1"  
    shared_config_files = ["C:/Users/47423415898/.aws/config"]
    shared_credentials_files =  ["C:/Users/47423415898/.aws/credentials"]

    default_tags {
      tags = {
        owner = "Vitor"
        managed-by = "Terraform134"
      }
    }
}