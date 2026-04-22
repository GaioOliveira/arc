# 📑 Aula da Semana 10: Administração de Redes de Computadores (ARC)
**Tema:** Processamento de Arquivos e Automação de Fluxos com Filtros

Olá, pessoal!

Na aula de hoje, vamos aprender a processar listas de usuários vindas de arquivos externos (como um `.csv`). 
---

## As Ferramentas de Processamento

Para manipular dados em lote, utilizaremos o conceito de **Pipeline**, conectando quatro ferramentas:

### 1. O Pipe (`|`) - O Encanamento do Linux
O "Pipe" conecta comandos. A saída de um comando é enviada diretamente como entrada para o próximo, permitindo criar "linhas de montagem" de dados.

### 2. `grep` - O Filtro de Linhas
Utilizado para buscar padrões. No nosso caso, servirá para filtrar apenas as linhas que pertencem a um departamento específico, ignorando o restante do arquivo.

### 3. `cut` - O Cortador de Colunas
Extrai colunas específicas de um arquivo delimitado.
- **`-d` (delimiter):** Define o separador (ex: `;`).
- **`-f` (field):** Define qual coluna desejamos isolar.

### 4. `while read VAR` - O Laço de Leitura Robusto
Diferente do `for`, o `while read` é a forma mais segura de ler arquivos linha por linha no Shell, pois ele lida corretamente com espaços e caracteres especiais sem quebrar a lógica do script.

---

## Prática: Automação de Contas via CSV

Nosso arquivo de dados, `rh_lista.csv`, segue agora o padrão recomendado para administradores de sistemas: `nome_sobrenome;departamento;cargo`.

**Exemplo de conteúdo do `rh_lista.csv`:**
```text
paulo_silva;TI;Suporte
ana_souza;RH;Analista
marcos_oliveira;TI;Desenvolvedor
```

### O Script: `new_users.sh`

```bash
#!/bin/bash

# =================================================================
# ARC - Semana 10: Automação de Usuários via CSV (Padrão Seguro)
# Prof. Gaio | IFSP
# =================================================================

ARQUIVO="rh_lista.csv"
SETOR_ALVO="TI"

# Verificação: o arquivo existe e temos permissão de root?
if [ ! -f "$ARQUIVO" ]; then
    echo "[ERRO] Arquivo $ARQUIVO não encontrado!"
    exit 1
fi

if [ "$EUID" -ne 0 ]; then
    echo "[ERRO] Execute como root (sudo)."
    exit 1
fi

echo "--- Iniciando provisionamento para o setor: $SETOR_ALVO ---"

# -----------------------------------------------------------------
# FLUXO DE DADOS:
# 1. 'grep' filtra as linhas do setor alvo
# 2. 'cut' isola a primeira coluna (nome_sobrenome)
# 3. 'while' processa cada nome resultante
# -----------------------------------------------------------------

grep "$SETOR_ALVO" "$ARQUIVO" | cut -d ";" -f 1 | while read LOGIN; do

    # Verificação de existência
    if id "$LOGIN" &> /dev/null; then
        echo "[PULANDO] O usuário $LOGIN já existe."
    else
        # Criação seguindo as boas práticas
        useradd -m -s /bin/bash "$LOGIN"
        
        # Senha padrão com expiração imediata para o 1º login
        echo "$LOGIN:Mudar@123" | chpasswd
        chage -d 0 "$LOGIN"
        
        echo "[SUCESSO] Usuário $LOGIN criado (Setor: $SETOR_ALVO)."
    fi

done

echo "--- Processamento finalizado! ---"
```

---

## Resumo da Lógica para o Repositório

* **Padronização:** Nomes de usuário devem ser simples (letras, números e `_`).
* **Eficiência:** O uso do `grep` direto no arquivo CSV evita que o script processe linhas desnecessárias, economizando recursos.
* **Segurança:** A combinação de `chpasswd` e `chage -d 0` garante que o administrador defina uma senha inicial, mas o usuário seja o único a saber a senha final.

### Exercícios de Revisão

1. Crie o arquivo `rh_lista.csv` com  mais pessoas, departamentos e cargos que o exemplo dado. Tente modificar o script para que ele também adicione o usuário a um grupo secundário (se necessário, crie o grupo antes de executar o script).
2. A exibição de todos os nomes de usuários criados no Linux fica no arquivo "/etc/passwd". Mas existem outras informações nesse arquivo. Crie um script para "extrair" apenas as o nome dos usuários que estão na primeira coluna desse arquivo cujos campos são separados pelo símbolo ":" (dois-pontos). 
   
