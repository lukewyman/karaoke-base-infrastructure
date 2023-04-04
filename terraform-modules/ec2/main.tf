resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.profile.id
  subnet_id                   = var.subnet_ids[0]
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = data.aws_key_pair.bastion.key_name
  user_data = data.template_cloudinit_config.config.rendered 

  tags = {
    "Name" = "${local.app_prefix}${terraform.workspace}-bastion"
  }
}

resource "aws_iam_instance_profile" "profile" {
  name = "${local.app_prefix}${terraform.workspace}-bastion-profile"
  role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name                = "${local.app_prefix}${terraform.workspace}-bastion-role"
  assume_role_policy  = data.aws_iam_policy_document.assume_role_policy.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
}