provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "name" {
  ami = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  key_name = "w1"
  security_groups = ["my_security_group"]

  tags = {
    Name = "ins-1"
  }
  provisioner "local-exec" {
    command = "echo \"[nodes]\" > inventory && echo \"node1 ansible_host=${aws_instance.name.public_ip} ansible_connection=ssh ansible_user=ubuntu\" >> inventory"
  }
  provisioner "local-exec" {
    command = "echo '${aws_instance.name.public_ip}'"
  }
}
resource "null_resource" "ansible"{
    depends_on=[aws_instance.name]
    provisioner "local-exec" {
    command ="sleep 10"
  }

  provisioner "local-exec" {
    command ="chmod 400 w1.pem"
  }
      provisioner "local-exec" {
    command ="ansible-playbook main.yml -i inventory --private-key=w1.pem"
          }

}

resource "aws_security_group" "my_security_group" {
  name        = "my_security_group"
  description = "Allow incoming traffic on specified ports"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG-W"
  }
}
