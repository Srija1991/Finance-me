resource "aws_instance" "production-server" {
 ami = "ami-007855ac798b5175e"
 instance_type = "t2.micro"
 availability_zone = "us-east-1a"
 VPC_security_groups = [aws_security_group.ec2group123.id]
 key_name = "jenkinskey1"
 tags = {
 name = "ansible_instance"
 }
 provisioner "remote-exec" {
 inline = [
     "ansible-playbook bankdeployplaybook.yml"
     ]
     }
     }
