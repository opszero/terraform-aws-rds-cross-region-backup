resource "aws_iam_role" "lambda_role" {
  name               = "Basic_Lambda_Function_Role"
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "lambda.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}
resource "aws_iam_policy" "iam_policy_for_lambda" {

  name        = "aws_iam_policy_for_terraform_aws_lambda_role"
  path        = "/"
  description = "AWS IAM Policy for managing aws lambda role"
  policy      = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": [
       "logs:CreateLogGroup",
       "logs:CreateLogStream",
       "logs:PutLogEvents"
     ],
     "Resource": "arn:aws:logs:*:*:*",
     "Effect": "Allow"
   }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
}

resource "aws_lambda_function" "rds_cross_region_backup" {
  filename      = "${path.module}/app.py"
  function_name = "RDSCrossRegionBackup-${var.source_region}-${var.target_region}-${join("-", var.instances)}"
  role          = aws_iam_role.lambda_role.arn
  handler       = "app.handler"
  runtime       = "python3.9"
  depends_on    = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]

  environment {
    variables = {
      SOURCE_REGION = var.source_region,
      TARGET_REGION = var.target_region,
      INSTANCES     = var.instances,
      ACCOUNT       = var.account

    }
  }
}

resource "aws_cloudwatch_event_rule" "every_five_days" {
    name = "every-five-days"
    description = "Fires every five days"
    schedule_expression = "rate(5 days)"
}

resource "aws_cloudwatch_event_target" "rds_cross_region_backup" {
    rule = aws_cloudwatch_event_rule.every_five_days.name
    target_id = "rds_cross_region_backup"
    arn = aws_lambda_function.rds_cross_region_backup.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_rds_cross_region_backup" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.rds_cross_region_backup.function_name
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.every_five_days.arn
}
