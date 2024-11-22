data "archive_file" "lambda_archive" {
  type       = "zip"
  source_dir = "source"
  excludes = [
    "source/tests",
    "source/lambda_function.zip",
  ]
  output_path = "source/lambda_function.zip"
}
