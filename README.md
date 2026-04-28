# AWS Automation Suite

<p align="center">
  <img src="https://img.shields.io/github/license/hugllaslima/aws-workspace?style=for-the-badge" alt="Licença">
  <img src="https://img.shields.io/github/stars/hugllaslima/aws-workspace?style=for-the-badge" alt="Estrelas">
  <img src="https://img.shields.io/github/forks/hugllaslima/aws-workspace?style=for-the-badge" alt="Forks">
</p>

Bem-vindo à **AWS Automation Suite**, uma coleção de scripts e configurações de automação projetados para simplificar o gerenciamento, a configuração e a manutenção de recursos na Amazon Web Services (AWS).

---

## 📖 Índice

- [🎯 Por que usar este projeto?](#por-que-usar-este-projeto)
- [📁 Estrutura do Projeto](#estrutura-do-projeto)
- [🚀 Primeiros Passos](#primeiros-passos)
- [💡 Casos de Uso](#casos-de-uso)
- [🛡️ Segurança em Primeiro Lugar](#segurança-em-primeiro-lugar)
- [🤝 Como Contribuir](#como-contribuir)
- [📄 Licença](#licença)
- [👨‍💻 Autor](#autor)

---

## 🎯 Por que usar este projeto?

Gerenciar recursos na nuvem pode envolver muitas tarefas repetitivas. Esta suíte foi criada para resolver esses desafios, oferecendo:

- **Automação Rápida:** Scripts interativos que validam dados e executam preparações complexas em minutos.
- **Padronização:** Garanta que suas instâncias EC2 e funções Lambda sejam configuradas de maneira consistente e reprodutível.
- **Ferramentas Essenciais:** Instalação automatizada de dependências críticas como Docker, Docker Compose e AWS CLI v2.
- **Preparação para CI/CD:** Ambientes prontos para receber pipelines de deploy automatizado.

---

## 📁 Estrutura do Projeto

Os recursos são organizados em diretórios modulares por serviço da AWS.

| Serviço / Categoria | Diretório | Descrição |
| :--- | :--- | :--- |
| **Amazon EC2** | [`ec2/`](./ec2) | Scripts para preparação e configuração inicial de instâncias EC2 (ex: Ubuntu Server). |
| **AWS Lambda** | [`lambda/`](./lambda) | Configurações e funções serverless, incluindo integrações para envio de e-mails. |

---

## 🚀 Primeiros Passos

Siga estes passos para começar a usar as automações em seu ambiente.

### 1. Clone o Repositório

Clone este repositório para o seu ambiente local ou diretamente na instância AWS que deseja configurar.

```bash
git clone https://github.com/hugllaslima/aws-workspace.git
cd aws-workspace
```

### 2. Explore os Scripts

Navegue até o diretório do serviço que você deseja configurar. Por exemplo, para preparar uma nova instância EC2:

```bash
cd ec2
```

Leia o `README.md` específico do diretório para entender os pré-requisitos e funcionalidades daquele script.

### 3. Dê Permissão de Execução

Antes de executar um script Bash, torne-o executável:

```bash
chmod +x setup-ec2-ubuntu.sh
```

### 4. Execute com Segurança

A maioria dos scripts de setup exige privilégios de superusuário. Use `sudo`:

```bash
sudo ./setup-ec2-ubuntu.sh
```

Siga as instruções interativas na tela.

---

## 💡 Casos de Uso

- **Provisionamento Rápido EC2:** Suba uma instância limpa na AWS e, em poucos minutos, tenha Docker, AWS CLI e timezone configurados, pronta para rodar seus containers.
- **Autenticação Automática no ECR:** Realize o login no Amazon Elastic Container Registry de forma automatizada logo no setup inicial da máquina.
- **Gestão de Lambdas:** Estruture suas funções Lambda (como serviços de e-mail) de forma organizada no repositório.

---

## 🛡️ Segurança em Primeiro Lugar

- **Revise o Código:** Sempre leia e entenda o que o script faz antes de executá-lo em suas instâncias de produção.
- **Gestão de Credenciais:** Não hardcode chaves de acesso (`AWS_ACCESS_KEY_ID`, etc.) nos scripts. Utilize roles IAM atreladas à EC2 sempre que possível.
- **Políticas de Segurança:** Consulte o nosso [SECURITY.md](./SECURITY.md) para relatar vulnerabilidades e ver as versões suportadas.

---

## 🤝 Como Contribuir

Contribuições são sempre bem-vindas! Se você tem uma ideia para um novo script ou uma melhoria:

1. **Faça um Fork** do projeto.
2. **Crie uma Nova Branch** (`git checkout -b feature/sua-feature`).
3. **Faça o Commit** de suas alterações (`git commit -m 'Adiciona sua feature'`).
4. **Faça o Push** para a sua branch (`git push origin feature/sua-feature`).
5. **Abra um Pull Request**.

---

## 📄 Licença

Este projeto está licenciado sob a **Licença GPL-3.0**. Veja o arquivo [LICENSE.md](./LICENSE.md) para mais detalhes.

---

## 👨‍💻 Autor

**Hugllas R S Lima**

- **GitHub:** [@hugllaslima](https://github.com/hugllaslima)
- **LinkedIn:** [hugllas-lima](https://www.linkedin.com/in/hugllas-lima/)
