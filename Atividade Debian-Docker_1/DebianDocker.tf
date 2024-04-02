########### EC2 ###########
data "template_file" "user_data_ec2" {
  template = file("./Scripts/site-debian-docker.sh")
}

resource "aws_instance" "Debian" {
  ami                         = "ami-058bd2d568351da34"
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-051ac5a74cbb996fe" #alterar subnet
  key_name                    = "TerraKeyVitor"                #alterar chave
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.Sec-Linux-Debian-Docker.id]
  user_data                   = base64encode(data.template_file.user_data_ec2.rendered)
  tags = {
    Name = "Debian-Docker"
  }
}

output "instance_public_ip_ec2" {
  description = "IP Publico da Instancia EC2"
  value       = aws_instance.Debian.public_ip
}

###### GRUPO DE SERGURANÇA ######
resource "aws_security_group" "Sec-Linux-Debian-Docker" {
  name        = "Sec-Linux-Debian-Docker"
  description = "Liberar entrada SSH, HTTP e PING"
  vpc_id      = "vpc-0ac0bedd318449b22" # Trocar para o ID da sua VPC

  #Liberar porta SSH de Entrada
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Liberar porta HTTP de Entrada
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Liberar Ping de Entrada
  ingress {
    protocol    = "icmp"
    from_port   = -1
    to_port     = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Liberar saida do pacote
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}