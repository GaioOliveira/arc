Fala, pessoal! **Prof. Gaio** aqui.

Depois da pesquisa teórica que vocês fizeram, está na hora de simulação no **Cisco Packet Tracer**. Vocês já entenderam que o SNMP é o "DNA" do monitoramento. Agora, vamos montar um cenário onde vocês são os administradores de uma rede que não pode parar, e para isso, precisam que os ativos "contem" o que está acontecendo com eles.

Para facilitar, vamos usar uma **metáfora**: imagine que o SNMP é um **Exame Médico em Tempo Real**. 
- O **Roteador ou outro dispositivo** é o paciente.
- O **Gerente (Servidor)** é o médico.
- A **MIB** é o prontuário médico com todos os sinais vitais (pressão, batimentos, temperatura).
- O **OID** é o código específico de cada exame (ex: "Pressão Arterial" tem um código, "Frequência Cardíaca" tem outro).

---

# 🧪 Laboratório de Monitoramento Ativo com SNMP
**Disciplina:** Administração de Redes de Computadores (ARC)  
**Ferramenta:** Cisco Packet Tracer  
**Objetivo:** Configurar ativos de rede para serem gerenciáveis e utilizar uma estação de gerência para coletar estatísticas.

---

## 🏗️ Passo 1: Construindo a Topologia Básica

Abra o seu Packet Tracer e monte a seguinte estrutura inicial:

1.  **01 Roteador (Modelo 2911)** - Nosso primeiro "paciente".
2.  **01 Switch (2960)** - Para interconectar a rede.
3.  **01 Servidor (Generic Server)** - Este será o nosso **Gerente (NMS)**.
4.  **01 PC (Laptop ou Desktop)** - Para testar a conectividade.



**Configuração de IP sugerida:**
- **Servidor NMS:** `Defina um IP`
- **Interface Gigabit0/1 do Roteador:** `Use o gateway da mesma rede do servidor`

---

## ⚙️ Passo 2: Configurando o "Paciente" (Roteador)

Para que o roteador aceite conversar com o médico (servidor), precisamos configurar as **Community Strings** (que funcionam como uma senha de acesso ao prontuário).

Acesse a CLI do Roteador e digite:

```bash
Router> enable
Router# configure terminal
Router(config)# hostname R1-IFSP

# Configurando a comunidade para LEITURA (Read-Only)
# Aqui o médico só pode "olhar" os exames.
R1-IFSP(config)# snmp-server community public RO

# Configurando a comunidade para ESCRITA (Read-Write)
# Cuidado: aqui o médico pode alterar configurações!
R1-IFSP(config)# snmp-server community private RW

# Informações de Identificação (Onde o paciente está e quem cuida dele)
R1-IFSP(config)# snmp-server location Laboratorio_Redes_IFSP
# Abaixo, substitua "Prof_Gaio para um nome que você desejar
R1-IFSP(config)# snmp-server contact Prof_Gaio
```

---

## 🩺 Passo 3: O "Exame Médico" (Verificação de Estado)

Agora, vamos ao Servidor NMS para ver se o SNMP está funcionando. O Packet Tracer tem uma ferramenta fantástica chamada **MIB Browser**.

1.  Clique no **Server** -> Aba **Desktop** -> **MIB Browser**.
2.  Clique em **Advanced**.
3.  Preencha os dados:
    - **Address:** (IP do Roteador)
    - **Read Community:** `public`
    - **Write Community:** `private`
    - **SNMP Version:** `v2c`
4.  No painel da esquerda, navegue pela árvore (MIB Tree):
    `mgmt` -> `mib-2` -> `system`
5.  Selecione **sysDescr** e clique no botão **Go** (no topo direito).



> **O que aconteceu?** Você acabou de solicitar o OID `.1.3.6.1.2.1.1.1.0`. O roteador respondeu com o modelo do hardware e a versão do IOS. Você acabou de ler o "prontuário" do equipamento!

---

## 📈 Exemplo Prático de Estatística: Tráfego na Interface

Quer saber se a rede está congestionada? 
1.  Navegue até: `mgmt` -> `mib-2` -> `interfaces` -> `ifTable` -> `ifEntry`.
2.  Procure por **ifInOctets** (Bytes que entraram na interface).
3.  Clique em **Go**.
4.  Faça o PC dar um "ping" pesado no servidor e clique em **Go** novamente. Você verá o número aumentando!

---

## 🚀 Desafio de Expansão

Agora que você dominou o básico, é hora de escalar:

1.  **Adicione um Access Point (AP-PT)** na rede e configure o SNMP nele.
2.  **Adicione um segundo Switch** em cascata.
3.  **No Servidor NMS**, tente descobrir via MIB Browser:
    - O tempo de atividade do dispositivo (**sysUpTime**).
    - O nome que você configurou no hostname (**sysName**).

---

## 📝 O que entregar no seu GitHub?

No seu arquivo `LAB_SNMP.md`, descreva:
1.  O print da sua topologia no Packet Tracer.
2.  Quais foram os valores retornados pelo comando **sysDescr** e **sysLocation**.
3.  **Reflexão:** Por que em uma rede real nós evitamos usar a community string `public` e preferimos o SNMPv3? (Dica: pense na segurança do prontuário médico!).

---
*Mãos à obra, administradores! Se o "paciente" não responder ao ping, o médico não consegue fazer o exame. confiram os IPs primeiro!*
