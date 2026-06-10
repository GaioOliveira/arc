## Introdução aos Sistemas de Monitoramento de Redes 

# Laboratório de Administração de Redes: Zabbix via Containers Docker
**Professor:** Gaio B. Oliveira  
**Semana:** 17  
**Contexto:** Infraestrutura Ágil e Sistemas de Gerência de Redes (NMS)

---

## Apresentação e Introdução ao NMS

Fala, pessoal!

Depois de dominarmos o monitoramento de tráfego em tempo real com o NtopNG, vamos dar o próximo passo lógico na nossa disciplina de Administração de Redes. Agora, vamos entrar no mundo dos **Sistemas de Gerência de Redes (NMS)** corporativos com o **Zabbix**, a ferramenta de monitoramento *open-source* mais utilizada no mercado.

Um **NMS** centraliza a coleta de dados de toda a sua infraestrutura. Em vez de você acessar servidor por servidor ou switch por switch para checar a saúde do ambiente, o NMS puxa essas informações, consolida tudo em um banco de dados e te avisa via alertas (e-mail, Telegram, etc.) antes que o usuário perceba que o serviço caiu.

Para tornar nossa infraestrutura ágil, moderna e fácil de replicar, não vamos fazer a instalação convencional "pesada" direto no sistema operacional da nossa VM. Vamos isolar os serviços utilizando **Containers Docker**.

---

## O Ecossistema e Arquitetura do Zabbix

Para o Zabbix funcionar, precisamos de 3 engrenagens rodando juntas de forma harmoniosa. No nosso laboratório, cada uma dessas engrenagens será um container isolado:

1. **Banco de Dados (Database):** Onde ficam guardados os históricos de monitoramento, usuários, mapas, templates e configurações (usaremos o *PostgreSQL*).
2. **Zabbix Server:** O "cérebro" do sistema. É ele quem processa as regras de monitoramento, calcula os alertas (Triggers), gerencia as checagens e recebe os dados dos ativos de rede.
3. **Zabbix Web Interface:** O painel visual construído em PHP rodando sobre um servidor Nginx. É a interface que acessamos pelo navegador para gerenciar todo o ambiente.

[Imagem da Arquitetura do Zabbix 5.0](arquiteturaZabbix5.jpg)

---

## Passo 1: Preparando o Terreno (Instalação do Docker para PC fora da escola)

Antes de baixarmos os containers, precisamos garantir que o motor do Docker e o plugin do Compose estão instalados e atualizados no seu Linux (Ubuntu ou outro). 

No terminal da sua VM, execute os seguintes comandos:

```bash
# 1. Atualizar a lista de pacotes do sistema
sudo apt update && sudo apt upgrade -y

# 2. Instalar o Docker e o plugin do Docker Compose
sudo apt install docker.io docker-compose-v2 -y

# 3. Adicionar o seu usuário padrão ao grupo do Docker
# (Isso evita que você precise digitar 'sudo' antes de cada comando do docker)
sudo usermod -aG docker $USER
