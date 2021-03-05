#using aws public and security group ID as variables
variable "segment_public" {
  type = string
}
variable "security_group_id" {
  type = string
}
#create aws ec2 instance named nginxPetOne with private subnet
resource "aws_instance" "nginxPetOne" {
  ami                    = "ami-0a91cd140a1fc148a"
  instance_type          = "t2.micro"
  subnet_id              = var.segment_public
  vpc_security_group_ids = [var.security_group_id]
  #key_name = "terraform"
  #user_data = file("configure_mysql.sh")
  tags = {
    Name = "nginxPetOne"
  }

}
#create aws ec2 instance named nginxPetTwo with private subnet
resource "aws_instance" "nginxPetTwo" {
  ami                    = "ami-0a91cd140a1fc148a"
  instance_type          = "t2.micro"
  subnet_id              = var.segment_public
  vpc_security_group_ids = [var.security_group_id]
  #key_name = "terraform"
  #user_data = file("configure_mysql.sh")
  tags = {
    Name = "nginxPetOne"
  }

}