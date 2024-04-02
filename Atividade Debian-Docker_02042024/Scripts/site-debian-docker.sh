#!/bin/bash

# Atualizar pacotes e instalar dependências
apt-get update
apt-get install -y docker.io git

# Clonar o repositório Git que contém o site
git clone https://github.com/FofuxoSibov/sitebike.git /var/www/html/

# Criar o Dockerfile no diretório do site
cat << EOF > /var/www/html/Dockerfile
FROM nginx:latest
COPY . /usr/share/nginx/html
EOF

# Construir a imagem Docker
docker build -t imagemsitebike /var/www/html/

# Executar o contêiner Docker
docker run -d -p 80:80 imagemsitebike
