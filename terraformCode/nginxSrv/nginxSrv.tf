
#create aws ec2 instance named nginxPetOne with public subnet
resource "aws_instance" "nginxPetOne" {
  ami                    = "ami-0a91cd140a1fc148a"
  instance_type          = "t2.micro"
  key_name = var.key_pem
  subnet_id              = var.segment_public1
  vpc_security_group_ids = [var.security_group_id]
  user_data = file (var.file)
  tags = {
    Name = "nginxPetOne"
  }
  provisioner "file" {
    source = "./elbMod/output.tf"
    destination = "/home/ubuntu/output.tf"

    connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("C:/Users/KoJoey/Desktop/intjoey2020.pem")
    host        = self.public_dns
    timeout = "30s"
  }
}
}

#create aws ec2 instance named nginxPetTwo with public subnet
resource "aws_instance" "nginxPetTwo" {
  ami                    = "ami-0a91cd140a1fc148a"
  instance_type          = "t2.micro"
  key_name = var.key_pem
  subnet_id              = var.segment_public2
  vpc_security_group_ids = [var.security_group_id]
  user_data = file (var.file)
  tags = {
    Name = "nginxPetTwo"
  }
  provisioner "file" {
    source      = "./elbMod/output.tf"
    destination = "/home/ubuntu/output.tf"

    connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("C:/Users/KoJoey/Desktop/intjoey2020.pem")
    host        = self.public_dns
    timeout = "30s"
  }
  }
}
