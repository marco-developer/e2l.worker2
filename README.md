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

# e2l.worker2
