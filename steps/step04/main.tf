terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.70.0"
    }

    archive = {
      source  = "hashicorp/archive"
      version = ">=2.6.0"
    }
  }

  backend "local" {
    path = "../../statefiles/step04_config.tfstate"
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project    = local.playground_name
      Panda      = var.panda_name
      experiment = local.experiment
    }
  }
}
