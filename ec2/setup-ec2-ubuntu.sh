#!/bin/bash
#
# setup-ec2-ubuntu.sh - Script de Configuração para EC2 (Ubuntu Server 24.04 LTS)
#
# - Autor....................: Hugllas RS Lima
# - Data.....................: 2025-08-12
# - Versão...................: 1.0.0
#
# Etapas:
#    - $ ./setup-ec2-ubuntu.sh
#        - {Função para exibir cabeçalho}
#        - {Testando a conexão com a Internet}
#        - {Renomear a instância}
#        - {Função para configurar o fuso horário para São Paulo}
#        - {Instalando dependências}
#        - {Função para instalar Docker & Docker Compose}
#        - {Função para instalar AWS CLI}
#        - {Função para adicionar usuário ao grupo Docker}
#        - {Função para login opcional no ECR}
#        - {Função de mensagem final}
#        - {Função de reboot}
#        - {Função main}
#
# Histórico:
#    - v1.0.0 2025-08-12, Hugllas RS Lima
#        - Cabeçalho
#        - Descrição
#        - Funções
#
# Uso:
#   - sudo ./setup-ec2-ubuntu.sh
#
# Licença: GPL-3.0
#

set -euo pipefail

## Função para exibir cabeçalho
show_header() {
  clear
  echo "================================================="
  echo " SCRIPT DE PREPARAÇÃO DA INSTÂNCIA EC2 (UBUNTU)"
  echo "================================================="
  echo ""
}

## Testando a conexão com a Internet
test_internet() {
  echo -n "Testando conectividade externa... "
  if ! ping -c 2 8.8.8.8 >/dev/null 2>&1; then
    echo "[ERRO] Sem acesso à internet. Interrompendo script."
    exit 1
  fi
  echo "OK"
}

## Renomear a instância
rename_server() {
  CUR_HOST=$(hostname)
  read -p "Deseja renomear o servidor agora? (hostname atual: $CUR_HOST) [s/N]: " -r WANT_HOST
  if [[ "$WANT_HOST" =~ ^([sS][iI][mM]|[sS])$ ]]; then
    read -p "Digite o NOVO NOME para este servidor (hostname): " -r NEW_HOST
    if [[ -z "$NEW_HOST" ]]; then
      echo "[ERRO] O hostname não pode ser vazio. Pulando renomeação."
      return
    fi
    sudo hostnamectl set-hostname "$NEW_HOST"
    sudo sed -i "s/127.0.1.1.*$CUR_HOST/127.0.1.1\t$NEW_HOST/" /etc/hosts
    echo "Hostname alterado para: $NEW_HOST"
    echo "Será necessário relogar ou reiniciar para refletir totalmente."
  else
    echo "Renomeação do servidor pulada."
  fi
}

## Função para configurar o fuso horário para São Paulo
configure_timezone() {
  echo "[1/6] Configurando timezone para America/Sao_Paulo (São Paulo)..."
  sudo timedatectl set-timezone America/Sao_Paulo
  echo "Timezone atual: $(timedatectl | grep 'Time zone')"
}

## Instalando dependências
install_dependencies() {
  echo "[2/6] Instalando dependências básicas (ca-certificates, curl, gnupg, unzip)..."
  sudo apt-get update -y
  sudo apt-get install -y ca-certificates curl gnupg lsb-release unzip
}

## Função para instalar Docker & Docker Compose
install_docker_official() {
  echo "[3/6] Instalando Docker do repositório oficial..."
  if ! command -v docker &>/dev/null; then
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update -y
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo systemctl enable docker
    sudo systemctl start docker
    echo "Docker instalado com sucesso a partir do repositório oficial!"
  else
    echo "Docker já está instalado."
  fi
  ask_install_compose
}

install_docker_compose() {
  echo "[Opcional] Instalando Docker Compose binário oficial (latest)..."
  LATEST_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d '"' -f4)
  sudo curl -L "https://github.com/docker/compose/releases/download/$LATEST_VERSION/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  if command -v docker-compose &>/dev/null; then
    echo "Docker Compose instalado com sucesso! Versão: $LATEST_VERSION"
    docker-compose --version
  else
    echo "[ERRO] Não foi possível instalar Docker Compose (binário)."
    exit 1
  fi
}

ask_install_compose() {
  read -p "Deseja instalar o Docker Compose binário oficial mais recente? [s/N]: " -r INSTALL_COMPOSE
  if [[ "$INSTALL_COMPOSE" =~ ^([sS][iI][mM]|[sS])$ ]]; then
    install_docker_compose
  else
    echo "Instalação do Docker Compose pulada."
  fi
}

## Função para instalar AWS CLI
install_awscli() {
  echo "[4/6] Instalando AWS CLI pelo instalador oficial da Amazon..."
  if ! command -v aws &> /dev/null; then
    tmpdir=$(mktemp -d)
    cd "$tmpdir"
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip -q awscliv2.zip
    sudo ./aws/install
    cd -
    rm -rf "$tmpdir"
    if command -v aws &> /dev/null; then
      echo "AWS CLI v2 instalado com sucesso!"
    else
      echo "[ERRO] Não foi possível instalar o AWS CLI." >&2
      exit 1
    fi
  else
    echo "AWS CLI já está instalado."
  fi
}

## Função para adicionar usuário ao grupo Docker
add_user_to_docker_group() {
  echo "[5/6] Garantindo que o usuário '$USER' está no grupo docker..."
  if groups $USER | grep &>/dev/null '\bdocker\b'; then
    echo "Usuário já faz parte do grupo docker."
  else
    sudo usermod -aG docker $USER
    echo "Usuário adicionado ao grupo docker. (É necessário RELOGAR para efetivar)"
  fi
}

## Função para login opcional no ECR
ecr_login() {
  echo "[6/6] Login opcional no Amazon ECR"
  read -p "Deseja realizar login automático no Amazon ECR agora? [s/N]: " -r LOGIN_ECR
  if [[ "$LOGIN_ECR" =~ ^([sS][iI][mM]|[sS])$ ]]; then
    read -p "Informe a REGIÃO AWS (ex: us-east-1): " -r AWS_REGION
    read -p "Informe o ENDPOINT ECR (ex: 1234.dkr.ecr.us-east-1.amazonaws.com): " -r ECR_REPO
    aws ecr get-login-password --region "$AWS_REGION" | docker login --username AWS --password-stdin "$ECR_REPO"
    echo "Login no ECR realizado!"
  else
    echo "Login no ECR não realizado. Pule para o próximo passo da pipeline por SSH."
  fi
}

## Função de mensagem final
show_final_message() {
  echo ""
  echo "========================================================================================="
  echo "Setup concluído! Se adicionou usuário ao grupo docker, faça LOGOUT e LOGIN novamente."
  echo "Agora sua EC2 está pronta para deploy automático via pipeline!"
  echo "========================================================================================="
}

## Função de reboot
ask_reboot() {
  show_final_message
  read -p "Deseja REINICIAR a instância EC2 agora para aplicar todas as permissões? [s/N]: " -r REBOOT
  if [[ "$REBOOT" =~ ^([sS][iI][mM]|[sS])$ ]]; then
    echo ""
    echo "🎉 Configuração realizada com sucesso! Reiniciando em 5 segundos..."
    sleep 5
    sudo reboot
  else
    echo "Reinicialização pulada. Servidor pronto!"
  fi
}

## Função main
main() {
  show_header

  read -p "Esse script vai PREPARAR esta EC2 para deploy (Docker, AWS CLI, TZ). Continuar? [s/N]: " -r CONT
  if [[ ! "$CONT" =~ ^([sS][iI][mM]|[sS])$ ]]; then
    echo "Cancelado pelo usuário. Nenhuma ação executada."
    exit 0
  fi

  test_internet
  rename_server
  configure_timezone
  install_dependencies
  install_docker_official
  install_awscli
  add_user_to_docker_group
  ecr_login
  ask_reboot
}

main
