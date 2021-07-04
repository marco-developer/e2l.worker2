export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/artifacts/channel/crypto-config/ordererOrganizations/labenv.com/orderers/orderer.labenv.com/msp/tlscacerts/tlsca.labenv.com-cert.pem
export PEER0_Provedor_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/provedor.labenv.com/peers/peer0.provedor.labenv.com/tls/ca.crt
export PEER0_Desenvolvedor_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/desenvolvedor.labenv.com/peers/peer0.desenvolvedor.labenv.com/tls/ca.crt
export PEER0_Usuario_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/usuario.labenv.com/peers/peer0.usuario.labenv.com/tls/ca.crt
export FABRIC_CFG_PATH=${PWD}/artifacts/channel/config/

export PRIVATE_DATA_CONFIG=${PWD}/artifacts/private-data/collections_config.json

export CHANNEL_NAME=dockerchannel

CHANNEL_NAME="dockerchannel"
CC_RUNTIME_LANGUAGE="golang"
VERSION="1"
CC_SRC_PATH="./artifacts/src/github.com/eventdb/go"
CC_NAME="eventdb"

setGlobalsForPeer0Provedor() {
    export CORE_PEER_LOCALMSPID="ProvedorMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_Provedor_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/provedor.labenv.com/users/Admin@provedor.labenv.com/msp
    # export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/Provedor.labenv.com/peers/peer0.Provedor.labenv.com/msp
    export CORE_PEER_ADDRESS=localhost:7051
}


if [ $# -ne 12 ]; then
        echo 1>&12 Sintaxe: $0 in out
        exit 1
fi 

setGlobalsForPeer0Provedor
peer chaincode invoke -o localhost:7050 \
    --ordererTLSHostnameOverride orderer.labenv.com \
    --tls $CORE_PEER_TLS_ENABLED \
    --cafile $ORDERER_CA \
    -C $CHANNEL_NAME -n ${CC_NAME} \
    --peerAddresses localhost:7051 --tlsRootCertFiles $PEER0_Provedor_CA \
    --peerAddresses localhost:9051 --tlsRootCertFiles $PEER0_Desenvolvedor_CA \
    --peerAddresses localhost:11051 --tlsRootCertFiles $PEER0_Usuario_CA \
    -c '{"Args":["createEvent", "'$8.$5'", "'$1'", "'$2'", "'$3'", "'$4'", "'$5'", "'$6'", "'$7'", "'$8'", "'$9'", "'$10'", "'$11'"]}' 