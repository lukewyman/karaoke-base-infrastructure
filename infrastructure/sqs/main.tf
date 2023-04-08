resource "aws_sqs_queue" "terraform_queue" {
    name = "${local.app_prefix}${terraform.workspace}-songs-queue"
}