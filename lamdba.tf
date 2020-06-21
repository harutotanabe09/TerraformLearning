data "aws_iam_policy_document" "lambda_policy" {
  statement {
    sid = "1"
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_policy.json}"
}

resource "aws_iam_role_policy" "ec2_lambda_policy" {
  name   = "ec2_lambda_policy"
  role   = aws_iam_role.iam_for_lambda.id
  policy = "${file("ec2_lambda_policy.json")}"
}

resource "aws_lambda_function" "test_lambdiam_for_lambdaa" {
  filename         = "lambda_function_payload.zip"
  function_name    = "lambda_function_name_terraform"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "lambda_function.lambda_handler"
  source_code_hash = "${filebase64sha256("lambda_function_payload.zip")}"
  runtime          = "python3.7"
  environment {
    variables = {
      foo = "bar"
    }
  }
}