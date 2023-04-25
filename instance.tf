resource "aws_instance" "production-server" {
 ami = "ami-02eb7a4783e7e9317"
 instance_type = "t2.micro"
 availability_zone = "ap-south-1a"
 VPC_security_groups = [aws_security_group.sg-0c69f259b0ea97dc0.id]
 key_name = "dec29"
 tags = {
 name = "ansible_instance"
 }
 provisioner "remote-exec" {
 inline = [
     "ansible-playbook bankdeployplaybook.yml"
     ]
     }
     }
