###### GRUPO DE SERGURANÇA ######
resource "aws_security_group" "Grupo-Sec-Ubuntu" {
  name        = "Grupo-Sec-Ubuntu"
  description = "Liberar entrada SSH, HTTP e PING"
  vpc_id      = "vpc-0ac0bedd318449b22"

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
########### EC2 ###########
data "template_file" "user_data" {
  template = file("./Scripts/site-ubuntu.sh")
}
resource "aws_instance" "Ubuntu" {
  ami                         = "ami-080e1f13689e07408" #AMI do Ubuntu
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-066eaaa450821136a"
  key_name                    = "TerraKeyVitor"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.Grupo-Sec-Ubuntu.id]
  user_data                   = base64encode(data.template_file.user_data.rendered) #Inicia o BootStraping

  tags = {
    Name = "Linux-Terraform-Site-Ubuntu"
  }
}

output "instance_public_ip" {
  description = "IP Publico da Instancia EC2"
  value       = aws_instance.Ubuntu.public_ip
}