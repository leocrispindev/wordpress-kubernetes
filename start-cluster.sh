#!/bin/bash

# Defina o array com a lista de arquivos YAML
files=(
  "volumes/pv-mysql.yaml"
  "volumes/pv-wordpress.yaml"
  "volumes/pv-clain-mysql.yaml"
  "volumes/pv-clain-wordpress.yaml"
  "secrets/database-secret.yaml"
  "deployments/dp-mysql.yaml"
  "services/svc-mysql.yaml"
  "deployments/dp-wordpress.yaml"
  "services/svc-wordpress.yaml"
)

# Loop através do array e execute kubectl apply para cada arquivo
for file in "${files[@]}"; do
  if [[ -f "$file" ]]; then
    echo "Aplicando $file"
    kubectl apply -f "$file" -n microcontainers
  else
    echo "Arquivo $file não encontrado!"
  fi
done
