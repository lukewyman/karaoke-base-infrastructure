data "aws_ssm_parameter" "mongo_username" {
  name            = "/app/karaoke/MONGO_USERNAME"
  with_decryption = false
}

data "aws_ssm_parameter" "mongo_password" {
  name            = "/app/karaoke/MONGO_PASSWORD"
  with_decryption = true
}