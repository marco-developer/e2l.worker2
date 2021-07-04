# event2ledger
Esta aplicação tem como objetivo realizar a coleta de eventos dos contêineres em execução em um ambiente Docker e enviá-los, via POST à API do Hyperledger Fabric.

# Pré-requisitos
- Docker
- Hyperledger Fabric instalada e funcionando
- API Hyperledger rodando

# Instalação e configuração
- mkdir <diretório>
- cd <diretório>
- Clonar o repositório
- Fazer as alterações de ip e token necessárias para ajustar o app.js ao ambiente
- docker build -t event2ledger .
- docker run --name event2ledger -d event2ledger

# Versões  
- 0.2: Implementação para docker Swarm. Neste modelo há um coletor em execução em cada nó, responsável pela coleta de eventos relacionados à contêineres em execução naquele nó. No cenário do trabalho, os coletores pertencem ao provedor, sendo que cada um deles possui uma chave privada específica, com a qual assinam as transações contendo os eventos coletados. Isto garante a irretratabilidade do agente de coleta.
