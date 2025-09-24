terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}

provider "random" {}
provider "local" {}

# Variables
variable "prefix" {
  type    = string
  default = "dev"
}

variable "separator" {
  type    = string
  default = "-"
}

# Nom du pet
resource "random_pet" "pet" {
  length    = 1   # 1 mot
  separator = var.separator
  prefix    = var.prefix
}

# fichier local
resource "local_file" "pet_file" {
  content  = random_pet.pet.id
  filename = "./dist/pet.txt"
  lifecycle {
        postcondition {
            condition     = self.content == random_pet.pet.id
            error_message = "Le fichier ne contient pas le bon nom de pet généré."
        }
    }
}

# outputs
output "pet_name" {
  value = random_pet.pet.id
}

output "filename" {
  value = local_file.pet_file.filename
}