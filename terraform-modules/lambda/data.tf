data "aws_caller_identity" "current" {}

data "aws_ecr_authorization_token" "token" {}

data "aws_iam_policy_document" "lambda_assume_role" {

    statement {
        effect = "Allow"
        actions = ["sts:AssumeRole"]
        sid = "SidToOverride"

        principals {
            type = "Service"
            identifiers = ["lambda.amazonaws.com"]
        }
    }
}

data "aws_iam_policy_document" "lambda_logging_policy" {

    statement {
        effect = "Allow"
        actions = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
        ]

        resources = [ 
            "arn:aws:logs:*:*:*"
        ]
    }
}

data "aws_iam_policy_document" "sqs_write_policy" {

    statement {
        sid = "sqswritepolicy"

        effect = "Allow"

        actions = [
            "sqs:GetQueueAttributes",
            "sqs:SendMessage"
        ]
    }
}

data "aws_iam_policy_document" "sqs_read_policy" {

    statement {
        sid = "sqsreadpolicy"

        effect = "Allow"

        actions = [
            "sqs:GetQueueAttributes",
            "sqs:ReceiveMessage",
            "sqs:DeleteMessage"
        ]
    }
}

# Will this policy be needed with a vpc domain and security group?
data "aws_iam_policy_document" "opensearch_policy" {

    statement {
        sid = "opensearchpolicy"

        effect = "Allow"

        actions = [
            "es:ESHttpDelete",
            "es:ESHttpGet",
            "es:ESHttpPost",
            "es:ESHttpPut"
        ]

        resources = ["arn:aws:es:${var.aws_region}:${data.aws_caller_identity.current.account_id}:domain/songs/*"]
    }
}