output "lambda_name" {
  description = "Name of our Lambda."
  value       = aws_lambda_function.this.function_name
}

output "fis_experiment_rolename" {
  description = "Name of the IAM role for the FIS experiment."
  value       = aws_iam_role.fis_role.name
}
