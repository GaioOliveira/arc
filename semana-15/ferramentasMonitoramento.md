# Explorando Ferramentas de Monitoramento de Redes 

## Laboratório 04: Ferramentas de Diagnóstico e Monitoramento 
**Professor:** Gaio B. Oliveira  
**Período de Execução:** Aulas de 27/05 e 03/06/2026  
**Prazo de Entrega e Apresentação:** 03/06/2026  

---

### 📅 Apresentação e Contexto

Até agora, nós focamos muito em configurar e automatizar processos de gerência no terminal e em simulações. Mas na vida real, um bom administrador de redes precisa saber o que está acontecendo na infraestrutura **em tempo real**: *A banda está saturada? Quem é o vilão que está consumindo o link? O pacote de teste está chegando ao destino?*

Neste laboratório, vocês vão assumir o papel de analistas de infraestrutura. Nós vamos instalar, testar e comparar **4 ferramentas essenciais** de diagnóstico e monitoramento de tráfego diretamente nas nossas máquinas virtuais.

---

### 👥 1. Organização e Formação de Grupos

* A turma deverá ser dividida em equipes de **2 a 3 estudantes**.
* **Atenção:** Não há divisão de tarefas interna. Todos os membros do grupo devem instalar, testar e dominar as quatro ferramentas, pois a avaliação da apresentação será individualizada.

---

### 🔍 2. Roteiro de Pesquisa Guiada

Cada grupo deve produzir um material de fundamentação teórica (em formato Markdown, PDF ou Slides) contendo os seguintes tópicos para cada uma das ferramentas investigadas:

* **a) Identificação e Objetivo:** Nome da ferramenta, foco principal de monitoramento e o problema que ela resolve.
* **b) Procedimento de Instalação:** Passos exatos para instalação no **Ubuntu 24.04 LTS (Server ou Desktop)**, listando dependências ou repositórios extras necessários.
* **c) Comandos Fundamentais:** Explicação dos parâmetros mais comuns e exemplos de sintaxe de uso.
* **d) Cenários de Aplicação Prática:** Em qual situação do dia a dia da administração de redes você utilizaria essa ferramenta?
* **e) Análise Comparativa:** Pontos fortes e fracos de cada uma (quando usar uma em detrimento da outra?).

---

### 💻 3. Execução Prática nas VMs (Laboratório)

Utilizando o ambiente de Máquinas Virtuais (VMs) Linux do laboratório, cada equipe deverá executar as seguintes rotinas práticas e gerar um **Relatório de Evidências** com os comandos executados e capturas de tela (prints).

### 🛠️ As 4 Ferramentas Objeto de Estudo:

#### 1. IPTraf-NG (`iptraf-ng`)
* **Missão:** Analisar o tráfego de rede interativo em modo texto.
* **Prática:** Gerar tráfego na rede e capturar a tela do painel mostrando as conexões TCP ativas e as estatísticas por interface de rede.

#### 2. Iperf3 (`iperf3`)
* **Missão:** Medir a largura de banda e throughput máximo entre dois nós.
* **Prática:** Configurar uma VM como servidor (`iperf3 -s`) e outra como cliente (`iperf3 -c`), executando testes de banda em protocolos TCP e UDP.

#### 3. NtopNG (`ntopng`)
* **Missão:** Análise de tráfego baseada em interface web com gráficos avançados.
* **Prática:** Instalar o serviço, acessar o painel via navegador (`http://localhost:3000` ou IP da VM) e extrair um relatório dos principais protocolos trafegados na interface.

#### 4. TCPDump (`tcpdump`)
* **Missão:** Captura e análise de pacotes (Sniffer) via CLI.
* **Prática:** Filtrar e capturar pacotes de uma comunicação específica (ex: capturar apenas pacotes ICMP/Ping ou tráfego de uma porta específica) e salvar a saída em um arquivo `.pcap`.

---

### 📤 Diretrizes de Entrega e Prazos

Toda a documentação deve ser versionada ou compilada para entrega até o dia **03/06/2026**:

1.  **Material de Pesquisa:** PDF ou Slides com o estudo conceitual das ferramentas.
2.  **Relatório Técnico Prático:** Documento com as evidências de execução (comandos utilizados, prints das telas de monitoramento e interpretação dos resultados obtidos).
3.  **Apresentação:** No dia 03/06, cada grupo fará uma demonstração prática rápida das ferramentas em funcionamento para o professor.

---

## 🎯 Critérios de Avaliação (Nota: 0,0 a 10,0)

| Critério | Descrição | Pontuação Máxima |
| :--- | :--- | :---: |
| **Clareza e Profundidade** | Qualidade conceitual da pesquisa teórica e respostas do roteiro. | 2,0 |
| **Correção da Execução** | Instalação correta e funcionamento das ferramentas nas VMs. | 2,5 |
| **Relatório de Evidências** | Organização dos prints, comandos e qualidade das análises técnicas. | 2,0 |
| **Contextualização Prática** | Capacidade de comparar as ferramentas e indicar os cenários de uso corretos. | 2,0 |
| **Organização e Apresentação** | Postura técnica, clareza na demonstração prática e cumprimento dos prazos. | 1,5 |
| **TOTAL** | | **10,0** |

---
*IFSP - Campus São João da Boa Vista | Material de Apoio Prático para ARC.*
