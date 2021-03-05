
#create aws ec2 instance named nginxPetOne with public subnet
resource "aws_instance" "nginxPetOne" {
  ami                    = "ami-0a91cd140a1fc148a"
  instance_type          = "t2.micro"
  subnet_id              = var.segment_public
  vpc_security_group_ids = [var.security_group_id]
  user_data = file (var.file)
  tags = {
    Name = "nginxPetOne"
  }

}

#create aws ec2 instance named nginxPetTwo with public subnet
resource "aws_instance" "nginxPetTwo" {
  ami                    = "ami-0a91cd140a1fc148a"
  instance_type          = "t2.micro"
  subnet_id              = var.segment_public
  vpc_security_group_ids = [var.security_group_id]
  user_data = file (var.file)
  tags = {
    Name = "nginxPetTwo"
  }

}
