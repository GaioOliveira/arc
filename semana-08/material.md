# 🛠️ Administração de Redes - Scripts de Shell - Semana 08  
**Professor:** Gaio  

Nesta aula, aprenderemos como os scripts deixam de ser uma lista estática de comandos para se tornarem ferramentas capazes de tomar decisões complexas baseadas em condições reais do sistema.

---

## Aula 1: Variáveis e Armazenamento

As variáveis são a memória do seu script. Elas guardam informações para que você não precise digitá-las várias vezes.

### Prática de Atribuição:

```bash
NOME_SERVIDOR="srv-dhcp-01"
IP_LAN="192.168.10.1"
DATA_BACKUP=$(date +%Y-%m-%d)
```

💡 **Dica:** Para ler o valor de uma variável, usamos o prefixo `$`.

Exemplo:
```bash
echo "Conectando ao servidor $NOME_SERVIDOR..."
```

---

## Aula 2: Redirecionadores de Saída

Redirecionar é decidir o destino da informação. No Linux, existem três fluxos:

- Entrada (0)
- Saída (1)
- Erro (2)

| Operador        | Ação                         | Cenário de Uso                         |
|----------------|------------------------------|----------------------------------------|
| `>`            | Cria/Sobrescreve arquivo     | Salvar configuração nova               |
| `>>`           | Anexa ao final               | Registrar evento em log                |
| `2>`           | Redireciona apenas erros     | Separar erros de mensagens comuns      |
| `&> /dev/null` | Silencia o comando           | Evitar poluição da saída               |

---

## Aula 3: O Comando if 

O comando `if` avalia se uma condição é verdadeira ou falsa.

### Sintaxe Fundamental:

```bash
if [ CONDIÇÃO ]; then
    # Verdadeiro
else
    # Falso
fi
```

---

### 1. Comparação de Textos (Strings)

```bash
if [ "$USER" == "root" ]; then
    echo "Acesso total permitido."
else
    echo "Erro: Você precisa de privilégios de root."
fi
```

---

### 2. Verificação de Arquivos e Pastas

- `-f` → Arquivo existe  
- `-d` → Diretório existe  

```bash
if [ -f "/etc/bind/named.conf.local" ]; then
    echo "O arquivo do DNS foi encontrado."
else
    echo "Instalação do BIND9 não detectada!"
fi
```

---

### 3. Comparação Numérica

```bash
TAMANHO=$(du -s /var/log | cut -f1)

if [ $TAMANHO -gt 100000 ]; then
    echo "Alerta: A pasta de logs está muito grande!"
fi
```

**Legenda:**

- `-gt` → maior que  
- `-lt` → menor que  
- `-eq` → igual  
- `-ne` → diferente  

---

### 4. Status de Saída ($?)

O sistema retorna:

- `0` → sucesso  
- `1` → erro  

```bash
ping -c 1 8.8.8.8 &> /dev/null

if [ $? -eq 0 ]; then
    echo "Internet OK"
fi
```

---

## Aula 4: Mãos na Massa (Integração Final)

### Projeto: Monitor de Conectividade

Crie o script `diagnostico.sh`:

```bash
#!/bin/bash

# 1. Variáveis
HOST="8.8.8.8"
LOG_REDE="diagnostico_rede.log"

echo "Verificando conexão com o servidor externo..."

# 2. Teste silencioso
ping -c 1 $HOST &> /dev/null

# 3. Verificação do resultado
if [ $? -eq 0 ]; then
    echo "[OK] A rede está funcionando perfeitamente."
    echo "$(date): $HOST online" >> $LOG_REDE
else
    echo "[FALHA] Não foi possível alcançar o servidor!"
    echo "$(date): $HOST offline" >> $LOG_REDE
fi
```

---

## 🚀 Desafio Técnico

Crie um script que:

- Verifique se o serviço **apache2** está ativo  
- Caso não esteja, tente iniciá-lo com:

```bash
systemctl start apache2
```

---

**IFSP - TMSI**  
Material de Apoio Acadêmico
