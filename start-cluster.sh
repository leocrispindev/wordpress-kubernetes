#!/bin/bash

# Defina o array com a lista de arquivos YAML
files=(
  "volumes/pv-mysql.yaml"
  "volumes/pv-wordpress.yaml"
  "volumes/pv-claim-mysql.yaml"
  "volumes/pv-claim-wordpress.yaml"
  "secrets/database-secret.yaml"
  "deployments/dp-mysql.yaml"
  "services/svc-mysql.yaml"
  "deployments/dp-wordpress.yaml"
  "hpa/hpa-wordpress.yaml"
  "services/svc-wordpress.yaml"
)

echo "Baixando e instalando K3s"
curl -sfL https://get.k3s.io | sh -

kubectl create namespace microcontainers

# Loop através do array e execute kubectl apply para cada arquivo
for file in "${files[@]}"; do
  if [[ -f "$file" ]]; then
    echo "Aplicando $file"
    kubectl apply -f "$file" -n microcontainers
  else
    echo "Arquivo $file não encontrado!"
  fi
  sleep 3
done
