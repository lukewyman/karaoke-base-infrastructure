resource "aws_instance" "bastion" {
    ami = data.aws_ami.ubuntu.id 
    instance_type = "t3.micro"
    associate_public_ip_address = true 
    
}