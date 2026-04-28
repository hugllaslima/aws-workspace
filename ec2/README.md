# Setup EC2 Ubuntu Server

Este diretório contém o script `setup-ec2-ubuntu.sh`, desenvolvido para automatizar a configuração inicial de instâncias do Amazon EC2 rodando **Ubuntu Server 24.04 LTS**.

## 🚀 Funcionalidades

O script executa interativamente as seguintes etapas de preparação do ambiente:

1. **Teste de Conectividade:** Verifica o acesso à internet antes de iniciar.
2. **Renomeação da Instância:** Permite alterar o *hostname* da máquina de forma rápida.
3. **Fuso Horário:** Configura o *timezone* do servidor para `America/Sao_Paulo`.
4. **Dependências Básicas:** Instala pacotes essenciais (`ca-certificates`, `curl`, `gnupg`, `unzip`, `lsb-release`).
5. **Docker e Docker Compose:** 
   - Instala o Docker Engine a partir do repositório oficial da Docker.
   - Instala os plugins oficiais (`docker-buildx-plugin`, `docker-compose-plugin`).
   - Oferece a opção de instalar também o binário *standalone* mais recente do Docker Compose.
   - Adiciona o usuário atual ao grupo `docker` (permitindo uso do Docker sem `sudo`).
6. **AWS CLI v2:** Faz o download e a instalação oficial da interface de linha de comando da AWS.
7. **Amazon ECR (Opcional):** Permite realizar login automático no Amazon Elastic Container Registry (ECR) fornecendo a região e o endpoint.
8. **Reboot:** Oferece a opção de reiniciar a instância ao final para garantir a aplicação imediata de todas as configurações e permissões.

## 📋 Pré-requisitos

- Instância rodando **Ubuntu Server 24.04 LTS**.
- Privilégios de administrador (usuário com acesso ao `sudo`).

## 🛠️ Como Usar

1. Dê permissão de execução ao script:
   ```bash
   chmod +x setup-ec2-ubuntu.sh
   ```

2. Execute o script com privilégios de administrador:
   ```bash
   sudo ./setup-ec2-ubuntu.sh
   ```

3. Siga as instruções (prompts) exibidas no terminal durante a execução. O script fará perguntas com opções `[s/N]`.

## 📄 Licença

Este projeto é distribuído sob a licença **GPL-3.0**.

## ✍️ Autor

- **Hugllas RS Lima**
