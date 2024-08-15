#!/bin/bash
#Creando mycluster.yaml
k0sctl init > mycluster.yaml
#Borrando host de ejemplo
yq eval -i '.spec.hosts = []' mycluster.yaml
#Configurando host desde config.json
jq -c '.maquinas[]' config.json | while read -r maquina; do
  nombre=$(echo $maquina | jq -r '.nombre')
  ip=$(echo $maquina | jq -r '.ip')
  key=$(vagrant ssh-config $nombre | awk '/IdentityFile/ {print $2}')
  if [ "$nombre" = "master" ]; then
  	role="controller"
  else
  	role="worker"
  fi
  yq eval -i ".spec.hosts += [{\"ssh\": {\"address\": \"$ip\", \"user\": \"vagrant\", \"port\": 22, \"keyPath\": \"$key\"}, \"role\": \"$role\", \"privateInterface\": \"eth1\"}]" mycluster.yaml
  echo "Configurando $nombre $ip:"
  ssh-keyscan -H $ip >> ~/.ssh/known_hosts  
done
k0sctl apply --config mycluster.yaml
k0sctl kubeconfig  --config mycluster.yaml > kubeconfig