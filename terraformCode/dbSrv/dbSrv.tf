resource "aws_db_instance" "petClinicDB" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0.20"
  instance_class       = "db.t2.micro"
  name                 = "petClinicDB"
  username             =  var.db_username
  password             =  var.db_username
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}