resource "aws_s3_bucket" "songs_bucket" {
    bucket = "${local.app_prefix}${terraform.workspace}-karaoke-tracks"
}

