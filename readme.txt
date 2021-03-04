Mid course test task

Tasks
create VMs
    two T2 VM that runs nginx
    two T2 VM that runs pet clinic app
    one RDS VM that runs MySQL
create one S3 Bucket
Create LB
    first to balance the loads from user connection to the nginx server
    second to balance the load between the app servers
Security Group
    the world can connect to the nginx servers only through port 8080
    the nginx servers can connect to the app servers
    the app servers can connect to the RDS DB server
    the RDS server can connect the DB server
write a script that take the data that got to the DB server write it into a file and send it to the Bucket

For more info check the pdf file

add

__________________________________________________________