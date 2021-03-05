# output Instance as variable
output "nginxPetTwo" {
  value = aws_instance.nginxPetTwo.id
}
# output Instance as variable
output "nginxPetOne" {
  value = aws_instance.nginxPetOne.id
}