resource "aws_lambda_function" "this" {
  function_name = local.lambda_name
  role          = aws_iam_role.lambda_role.arn

  filename         = data.archive_file.lambda_archive.output_path
  package_type     = "Zip"
  source_code_hash = data.archive_file.lambda_archive.output_base64sha256

  handler     = var.lambda_function_handler
  runtime     = var.lambda_function_runtime
  memory_size = var.lambda_function_memory_size
  timeout     = var.lambda_function_timeout

  layers = [local.fis_layer_map[var.region]]

  environment {
    variables = {
      "AWS_FIS_CONFIGURATION_LOCATION" = "${aws_s3_bucket.fis_config_bucket.arn}/FisConfigs/*",
      "AWS_LAMBDA_EXEC_WRAPPER"        = "/opt/aws-fis/bootstrap",
    }

  }
}
