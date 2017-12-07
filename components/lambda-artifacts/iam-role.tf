data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "api_lambda_role" {
  name               = "api-lambda-role"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_assume_role_policy.json}"
}

resource "aws_iam_role_policy" "api_lambda_role_policy" {
  name = "api-lambda-role-policy"
  role = "${aws_iam_role.api_lambda_role.id}"
  policy = "${data.aws_iam_policy_document.api_lambda_role_policy.json}"
}

data "aws_iam_policy_document" "api_lambda_role_policy" {

  statement {
    effect = "Allow"
    actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
		]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = ["s3:ListBucket"]
    resources = [
      "$arn:aws:s3:::lambda-artifacts-553201512970"
    ]
  }

  statement {
    effect = "Allow"
    actions = ["s3:GetObject"]
    resources = [
      "arn:aws:s3:::lambda-artifacts-553201512970/*"
    ]
  }
}
