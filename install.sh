#!/bin/bash

# Atualizando sistema, removendo pacotes não utilizados e atualizando a snap store
echo "Atualização de sistema"
#sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean && sudo snap refresh
 sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean

# Instalando apps via snap
#echo "Instalando spotify, vlc, discord"
#sudo snap install spotify
#sudo snap install discord
#sudo snap install vlc

# Instalando gnome tweaks
#echo "Instalar gnome tweaks"
#sudo apt install gnome-tweaks

# Configurar usuário Git global
echo "baixando e configurando usuário Git global"
sudo apt install git
git config --global user.name "<name_here>" && git config --global user.email "<email_here>"

# Instalar NVM e Node.js LTS
echo "Instalando NVM e Node.js LTS"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash || erro "Falha ao instalar NVM"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts || erro "Falha ao instalar Node.js LTS"
npm i --global ntl || erro "Falha ao instalar pacote npm global ntl"

# Instalar .NET Core e 8
#echo "Instalando .NET Core 8..."
#sudo apt install -y dotnet-sdk-8.0

# Instalar Docker e configurar grupo do usuário
clear
echo "Setup instalação do docker"
echo "Unistall all conflicting packages..."
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

echo "Setup docker"
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

echo "Install docker packages"
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

clear
echo "Create the docker group"
sudo groupadd docker

echo "add your user to the docker group"
sudo usermod -aG docker $USER

