#!/bin/bash

echo "Baixando e instalando K3s"
curl -sfL https://get.k3s.io | sh -

echo "Mudando permissão de arquivos de configuração do ambiente K3s"
sudo chmod 644 /etc/rancher/k3s/k3s.yaml

echo "Executando arquivo Kustomize - aplicando configurações do kubernetes"
kubectl apply -k .

wait

kubectl get pod -n microcontainers -w

