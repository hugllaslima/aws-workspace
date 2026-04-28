# aws-automation

Repositório destinado a centralizar scripts de configuração e automação para ambientes da AWS.

## 📂 Estrutura do Projeto

Atualmente, o projeto está organizado da seguinte forma:

### `ec2/`
Diretório contendo scripts para preparação e configuração de instâncias do Amazon EC2.
- **[setup-ec2-ubuntu.sh](ec2/setup-ec2-ubuntu.sh)**: Script interativo para configuração inicial de instâncias Ubuntu Server 24.04 LTS. Ele automatiza a instalação de dependências, configuração de fuso horário, Docker, Docker Compose, AWS CLI e configuração opcional de login no Amazon ECR.
  - Para mais detalhes sobre o uso, consulte a [Documentação do EC2](ec2/README.md).

### `lambda/`
Diretório destinado ao armazenamento de funções e configurações do AWS Lambda.
- `e-mail/`: Configurações ou funções relacionadas a serviços de e-mail (contém arquivo de teste).

## 📄 Licença

Este projeto é distribuído sob a licença **GPL-3.0**. Para mais detalhes, consulte o arquivo [LICENSE.md](LICENSE.md).

## 🔒 Segurança

Consulte o arquivo [SECURITY.md](SECURITY.md) para obter informações sobre as versões suportadas e como relatar vulnerabilidades de segurança.

## ✍️ Autor

- **Hugllas RS Lima**