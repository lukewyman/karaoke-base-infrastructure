resource "aws_ecr_repository" "image_repo" {
    for_each = var.lambda_params

    name = "${local.app_prefix}${terraform.workspace}-${each.key}"
}

resource "docker_registry_image" "image" {
    for_each = var.lambda_params

    name = "${aws_ecr_repository.image_repo[each.key].repository_url}:${each.value["image-tag"]}"

    build {
        context = "${path.module}/artifacts/${each.value["image-tag"]}"
        dockerfile = "Dockerfile"
    }
}

resource "aws_iam_role" "lambda_role" {
    for_each = var.lambda_params

    name = "${local.app_prefix}${terraform.workspace}-${each.key}-role"
    assume_role_policy = data.aws_iam_policy_documennt.lambda_assume_role.json
}

resource "aws_iam_policy" "lambda_logging_policy" {
    name = "${local.app_prefix}${terraform.workspace}-lambda-logging-policy"
}