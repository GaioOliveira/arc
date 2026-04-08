🛠️ Laboratório de Administração de Redes - Semana 08

Professor: Gaio

Nesta aula, aprenderemos como os scripts deixam de ser uma lista estática de comandos para se tornarem ferramentas capazes de tomar decisões complexas baseadas em condições reais do sistema.

Aula 1: Variáveis e Armazenamento

As variáveis são a memória do seu script. Elas guardam informações para que você não precise digitá-las várias vezes.

Prática de Atribuição:

NOME_SERVIDOR="srv-dhcp-01"
IP_LAN="192.168.10.1"
DATA_BACKUP=$(date +%Y-%m-%d)


💡 Dica: Para ler o valor de uma variável, usamos o prefixo $.
Exemplo: echo "Conectando ao servidor $NOME_SERVIDOR..."

Aula 2: Redirecionadores de Saída

Redirecionar é decidir o destino da informação. No Linux, existem três fluxos: Entrada (0), Saída (1) e Erro (2).

Operador

Ação

Cenário de Uso

>

Cria/Sobrescreve arquivo

Salvar configuração nova.

>>

Anexa ao final

Registrar um evento em um LOG.

2>

Redireciona apenas erros

Separar erros de mensagens comuns.

&> /dev/null

Silencia o comando

Rodar testes sem poluir a tela.

O Comando IF (Domínio Completo)

O comando if avalia se uma condição é verdadeira ou falsa. No Shell, os colchetes [ ] são um comando que realiza testes.

A Sintaxe Fundamental:

if [ CONDIÇÃO ]; then
    # O que fazer se for VERDADEIRO
else
    # O que fazer se for FALSO
fi


1. Comparação de Textos (Strings)

Verificando se o usuário atual tem permissão de administrador:

if [ "$USER" == "root" ]; then
    echo "Acesso total permitido."
else
    echo "Erro: Você precisa de privilégios de root."
fi


2. Verificação de Arquivos e Pastas

Antes de configurar um serviço, o administrador deve checar se os arquivos de configuração existem:

-f (file): O arquivo existe e é comum?

-d (directory): A pasta existe?

if [ -f "/etc/bind/named.conf.local" ]; then
    echo "O arquivo do DNS foi encontrado."
else
    echo "Instalação do BIND9 não detectada!"
fi


3. Comparação Numérica

Scripts podem monitorar o uso de recursos. Note que usamos siglas para números:

TAMANHO=$(du -s /var/log | cut -f1) # Pega o tamanho da pasta de logs

if [ $TAMANHO -gt 100000 ]; then
    echo "Alerta: A pasta de logs está muito grande!"
fi


Legenda: -gt (Greater Than), -lt (Less Than), -eq (Equal), -ne (Not Equal).

4. O Caso Especial: Status de Saída ($?)

Finalmente, podemos usar o if para testar se um comando (como o ping) funcionou. O sistema guarda 0 para sucesso e 1 para erro na variável $?.

ping -c 1 8.8.8.8 &> /dev/null
if [ $? -eq 0 ]; then
    echo "Internet OK"
fi


Mãos na Massa (Integração Final)

Agora vamos usar o if para testar o Status de Saída ($?) de um comando de rede de forma integrada.

O Projeto: Monitor de Conectividade

Crie o script diagnostico.sh que utiliza variáveis para o alvo, redirecionadores para o silêncio e o if para a decisão.

#!/bin/bash

# 1. Definindo as variáveis
HOST="8.8.8.8"
LOG_REDE="diagnostico_rede.log"

echo "Verificando conexão com o servidor externo..."

# 2. Executando o teste em silêncio
ping -c 1 $HOST &> /dev/null

# 3. Analisando o resultado do comando anterior ($?)
if [ $? -eq 0 ]; then
    echo "[OK] A rede está funcionando perfeitamente."
    echo "$(date): $HOST online" >> $LOG_REDE
else
    echo "[FALHA] Não foi possível alcançar o servidor!"
    echo "$(date): $HOST offline" >> $LOG_REDE
fi


🚀 Desafio Técnico

Crie um script que verifique se o serviço apache2 está ativo. Caso não esteja, o script deve tentar iniciá-lo usando systemctl start.

IFSP - Campus de Redes | Material de Apoio Acadêmico
