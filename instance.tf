resource "aws_instance" "production-server" {
 ami = "ami-02eb7a4783e7e9317"
 instance_type = "t2.micro"
 availability_zone = "ap-south-1a"
 key_name = "dec29"
 tags = {
 name = "ansible_instance"
 }
 provisioner "remote-exec" {
 inline = [
     "ansible-playbook playbook.yml"
     ]
     }
     }
