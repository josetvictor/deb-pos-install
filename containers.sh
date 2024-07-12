#!/bin/bash

echo "Criando volume para o portanier"
docker volume create portainer_data

echo "Baixando e instalando POrtainer Server container"
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

clear

echo "Criando volume para MSSQL Server"
docker volume create mssql_data

echo "Baixando imagem do sql server"
docker pull mcr.microsoft.com/mssql/server:2022-latest

echo "Subindo container"
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=MSSql@senha" \
   -p 1433:1433 --name mssql_server --hostname mssql_server \
   -v mssql_data:/var/opt/mssql --restart=always\
   -d \
   mcr.microsoft.com/mssql/server:2022-latest

clear

echo "Criando volume para PostgreSQL"
docker volume create postgres_data

echo "Baixando imagem do PostgreSQL"
docker pull postgres:latest

echo "Subindo container"
docker run -e "POSTGRES_PASSWORD=Postgres@senha" \
   -p 5432:5432 --name postgres_server --hostname postgres_server \
   -v postgres_data:/var/lib/postgresql/data --restart=always\
   -d \
   postgres:latest
