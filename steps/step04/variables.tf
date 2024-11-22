variable "lambda_function_handler" {
  type    = string
  default = "lambda_function.lambda_handler"
}

variable "lambda_function_memory_size" {
  type    = number
  default = 128
}

variable "lambda_function_runtime" {
  type    = string
  default = "python3.12"
}

variable "lambda_function_timeout" {
  type    = number
  default = 30
}


variable "panda_name" {
  description = "My Panda Name"
  type        = string
}


variable "region" {
  description = "AWS Region for deployment."
  type        = string
  default     = "eu-west-2"
}


variable "retention_period" {
  description = "The number of days to retain logs for"
  type        = number
  default     = 1
}


locals {
  playground_name = "devops_playground_oct2024"

  resource_suffix = "${var.panda_name}_${local.playground_name}"

  domain_name = "devopsplayground.org"

  experiment = "step04"

  lambda_name = "${var.panda_name}_${local.experiment}_lambda"

  fis_layer_map = { # This is based on the info at https://docs.aws.amazon.com/fis/latest/userguide/actions-lambda-extension-arns.html#platform-1
    "af-south-1"     = "arn:aws:lambda:af-south-1:533267331812:layer:aws-fis-extension-x86_64:9",
    "ap-east-1"      = "arn:aws:lambda:ap-east-1:851725607735:layer:aws-fis-extension-x86_64:9",
    "ap-south-1"     = "arn:aws:lambda:ap-south-1:058264376524:layer:aws-fis-extension-x86_64:9",
    "ap-northeast-2" = "arn:aws:lambda:ap-northeast-2:767397675047:layer:aws-fis-extension-x86_64:9",
    "ap-southeast-1" = "arn:aws:lambda:ap-southeast-1:654654492284:layer:aws-fis-extension-x86_64:9",
    "ap-southeast-1" = "arn:aws:lambda:ap-southeast-2:211125361907:layer:aws-fis-extension-x86_64:9",
    "ap-northeast-1" = "arn:aws:lambda:ap-northeast-1:339712942424:layer:aws-fis-extension-x86_64:9",
    "ca-central-1"   = "arn:aws:lambda:ca-central-1:767397945626:layer:aws-fis-extension-x86_64:9",
    "eu-central-1"   = "arn:aws:lambda:eu-central-1:339712832950:layer:aws-fis-extension-x86_64:9",
    "eu-west-1"      = "arn:aws:lambda:eu-west-1:590183974824:layer:aws-fis-extension-x86_64:9",
    "eu-west-2"      = "arn:aws:lambda:eu-west-2:637423427737:layer:aws-fis-extension-x86_64:9",
    "eu-south-1"     = "arn:aws:lambda:eu-south-1:905418048027:layer:aws-fis-extension-x86_64:9",
    "eu-west-3"      = "arn:aws:lambda:eu-west-3:058264341757:layer:aws-fis-extension-x86_64:9",
    "eu-south-2"     = "arn:aws:lambda:eu-south-2:471112920827:layer:aws-fis-extension-x86_64:9",
    "eu-north-1"     = "arn:aws:lambda:eu-north-1:975050131916:layer:aws-fis-extension-x86_64:9",
    "me-south-1"     = "arn:aws:lambda:me-south-1:381492106008:layer:aws-fis-extension-x86_64:9",
    "sa-east-1"      = "arn:aws:lambda:sa-east-1:905418233835:layer:aws-fis-extension-x86_64:9",
    "us-east-1"      = "arn:aws:lambda:us-east-1:211125607513:layer:aws-fis-extension-x86_64:9",
    "us-east-2"      = "arn:aws:lambda:us-east-2:471112953925:layer:aws-fis-extension-x86_64:9",
    "us-west-1"      = "arn:aws:lambda:us-west-1:851725461977:layer:aws-fis-extension-x86_64:9",
    "us-west-2"      = "arn:aws:lambda:us-west-2:975050054544:layer:aws-fis-extension-x86_64:9"
  }
}