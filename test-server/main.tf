resource "aws_instance" "test-server" {
  ami           = "ami-06984ea821ac0a879" 
  instance_type = "t2.micro" 
  key_name = "dec29"
  vpc_security_group_ids= ["sg-0b97b07ee56ddea6a"]
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("./dec29.ppk")
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [ "echo 'wait to start instance' "]
  }
  tags = {
    Name = "test-server"
  }
  provisioner "local-exec" {
        command = " echo ${aws_instance.test-server.public_ip} > inventory "
  }
   provisioner "local-exec" {
  command = "ansible-playbook /var/lib/jenkins/workspace/Finance-me/test-server/finance-playbook.yml "
  } 
}
