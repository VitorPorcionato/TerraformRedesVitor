########### EC2 ###########
data "template_file" "user_data_ec2" {
  template = file("./Scripts/Boot-Win.ps1")
}

resource "aws_instance" "Windows-Atividade" {
  ami                         = "ami-03cd80cfebcbb4481"
  instance_type               = "t2.medium"
  subnet_id                   = aws_subnet.SubRede-Pub1.id #alterar subnet
  key_name                    = "TerraFormVitorWin"        #alterar chave
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.Sec-Windows.id]
  user_data                   = base64encode(data.template_file.user_data_ec2.rendered)
  get_password_data           = "true"
  tags = {
    Name = "Windows-Atividade"
  }
}

output "instance_public_ip_ec2" {
  description = "IP Publico da Instancia EC2"
  value       = aws_instance.Windows-Atividade.public_ip
}

output "pass_win" {
  description = "Senha de Admin da Instancia"
  value       = rsadecrypt(aws_instance.Windows-Atividade.password_data, file("./TerraFormVitorWin.pem"))
}

###### GRUPO DE SERGURANÇA ######
resource "aws_security_group" "Sec-Windows" {
  name        = "Sec-Windows"
  description = "Liberar entrada RDP e PING"
  vpc_id      = aws_vpc.ANEIS-VPC.id # Trocar para o ID da sua VPC

  #Liberar porta SSH de Entrada
  ingress {
    from_port   = 3389
    to_port     = 3389
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