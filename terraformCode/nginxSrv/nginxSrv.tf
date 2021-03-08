
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
  provisioner "local-exec" {
   working_dir = "./terraformCode"
   command = "terraform output | cut -d ' ' -f3 >> lb_name.txt"
  
  }
  provisioner "file" {
    source      = "./terraformcode/lb_name.txt"
    destination = "/home/ubuntu/lb_name.txt"

    connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("/mnt/c/Users/Bamb4Boy/pem/clusterkey.pem")
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
  provisioner "local-exec" {
   working_dir = "./terraformCode"
   command = "terraform output | cut -d ' ' -f3 >> lb_name.txt"
  
  }
  provisioner "file" {
    source      = "./terraformcode/lb_name.txt"
    destination = "/home/ubuntu/lb_name.txt"

    connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("/mnt/c/Users/Bamb4Boy/pem/clusterkey.pem")
    host        = self.public_dns
    timeout = "30s"
  }
  }
}
