resource "aws_db_instance" "petClinicDB" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0.20"
  instance_class       = "db.t2.micro"
  name                 = "petClinicDB"
<<<<<<< HEAD
  username             = var.db_username
  password             = var.db_password
=======
  username             =  var.db_username
  password             =  var.db_username
>>>>>>> 8b1f36d5248709436b602d27699336d252ccee89
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}