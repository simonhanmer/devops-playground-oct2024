resource "aws_iam_role" "fis_role" {
  name = "${var.panda_name}_${local.experiment}_fis_iam_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = [
            "fis.amazonaws.com",
            "delivery.logs.amazonaws.com"
          ]
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_policy" "fis_s3_policy" {
  name        = "${local.resource_suffix}_fis_s3_policy"
  description = "Allow lambda to read FIS bucket"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Sid" : "AllowFisToWriteAndDeleteFaultConfigurations",
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:DeleteObject"
        ],
        "Resource" : "${aws_s3_bucket.fis_config_bucket.arn}/FisConfigs/*"
      },
      {
        "Sid" : "AllowFisToInspectLambdaFunctions",
        "Effect" : "Allow",
        "Action" : [
          "lambda:GetFunction"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "AllowFisToDoTagLookups",
        "Effect" : "Allow",
        "Action" : [
          "tag:GetResources"
        ],
        "Resource" : "*"
    }]
  })
}


resource "aws_iam_role_policy_attachment" "fis_s3_policy_attachment" {
  role       = aws_iam_role.fis_role.name
  policy_arn = aws_iam_policy.fis_s3_policy.arn
}

resource "aws_iam_role" "lambda_role" {
  name = "${var.panda_name}_fis_lambda_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "lambda_logs_policy" {
  name        = "${local.resource_suffix}_logs_policy"
  description = "Allow lambda and fis to write to cloudwatch logs"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:CreateLogDelivery"
      ]
      Effect = "Allow"
      Resource = [
        aws_cloudwatch_log_group.lambda_log_group.arn,
        "${aws_cloudwatch_log_group.lambda_log_group.arn}:*"
      ]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logs_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_logs_policy.arn
}

resource "aws_iam_policy" "lambda_fis_policy" {
  name        = "${local.resource_suffix}_lambda_fis_policy"
  description = "Allow lambda to read FIS bucket"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Sid" : "AllowListingConfigLocation",
        "Effect" : "Allow",
        "Action" : ["s3:ListBucket"],
        "Resource" : [aws_s3_bucket.fis_config_bucket.arn],
        "Condition" : {
          "StringLike" : {
            "s3:prefix" : ["FisConfigs/*"]
          }
        }
      },
      {
        "Sid" : "AllowReadingObjectFromConfigLocation",
        "Effect" : "Allow",
        "Action" : "s3:GetObject",
        "Resource" : ["${aws_s3_bucket.fis_config_bucket.arn}/FisConfigs/*"]
      },
      {
        "Sid" : "AllowListBuckets",
        "Effect" : "Allow",
        "Action" : ["s3:ListAllMyBuckets"],
        "Resource" : ["*"]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_fis_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_fis_policy.arn
}
