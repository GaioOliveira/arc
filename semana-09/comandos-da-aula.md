## Glossário Técnico: O Script de Criação de Usuários ##

Professor: Gaio | Disciplina: Administração de Redes de Computadores

Neste documento, detalhamos os comandos e variáveis especiais utilizados no script **criaUsuario**, explicando sua finalidade e aplicação prática no contexto de administração de sistemas Linux.

### A Variável Especial $EUID ### 

O que é: Uma variável de ambiente do sistema que armazena o Effective User ID (ID do usuário que está executando o script).
Por que usamos: No Linux, o superusuário (root) sempre possui o ID 0.

No Script: Usamos if [ "$EUID" -ne 0 ] para garantir que o script pare imediatamente se não for executado com sudo. Sem isso, o comando useradd falharia silenciosamente por falta de permissão.

### O Comando exit ###

O que é: Finaliza a execução do script. Por que usamos: Para interromper o fluxo quando algo dá errado.

No Script: Usamos exit 1. O número 1 indica ao sistema que o script terminou com um erro. Se tudo desse certo, usaríamos exit 0.

### O Comando read -p ###

O que é: Lê uma entrada do teclado e a armazena em uma variável.
Por que usamos: Para tornar o script interativo. O parâmetro -p (prompt) permite escrever uma mensagem antes de esperar a digitação.

No Script: read -p "Digite o nome..." NOVO_USUARIO guarda o nome digitado na variável $NOVO_USUARIO.

### O Teste -z ###

O que é: Um operador de teste para strings.
Por que usamos: Para verificar se uma variável está vazia (zero characters).

No Script: if [ -z "$NOVO_USUARIO" ] serve para evitar que o administrador aperte "Enter" sem digitar nada, o que causaria erro nos comandos seguintes.

### O Comando id ###

O que é: Exibe informações de usuário e grupo.

Por que usamos: É a forma mais limpa de verificar se um usuário já existe. Se o id encontrar o usuário, ele retorna Status 0; se não encontrar, retorna erro.

No Script: Usamos id "$USUARIO" &> /dev/null para checar a existência sem mostrar os detalhes técnicos na tela para o usuário.

### O Comando useradd ###

O que é: O comando padrão para criação de novas contas.

Por que usamos: Ele automatiza a criação técnica da conta.

Parâmetros utilizados:

-m: Cria automaticamente o diretório pessoal em /home/usuario.

-s /bin/bash: Define que o interpretador de comandos padrão será o Bash.

### O Comando chpasswd ###

O que é: Atualiza senhas de usuários em lote (modo não interativo).

Por que usamos: O comando passwd comum pede que você digite a senha duas vezes no teclado. Isso trava a automação. O chpasswd aceita a senha via "pipe" (|), permitindo que o script defina a senha sem intervenção humana.

No Script: echo "$USUARIO:$SENHA" | chpasswd.

### O Comando chage ###

O que é: Altera informações de expiração de senha.
Por que usamos: Para aplicar políticas de segurança.

No Script: chage -d 0 "$USUARIO". O -d 0 (last day = 0) "engana" o sistema fazendo-o acreditar que a senha não é trocada desde 1970. Isso força o Linux a exigir uma nova senha no exato momento do primeiro login.

IFSP - Material de apoio para a disciplina de Administração de Redes.
