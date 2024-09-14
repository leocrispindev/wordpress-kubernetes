# Wordpress no Kubernetes

## Introdução
Os arquivos YAML neste repositório são usados para definir diversos tipos de objetos Kubernetes, como Pods, Deployments, Services, ConfigMaps, Secrets, entre outros. Ao utilizar esses arquivos, você pode facilmente criar, atualizar e remover recursos em seu cluster Kubernetes.

## Passo a passo

1. Criar o namespace dentro do cluster Kubernetes:
```bash
kubectl create namespace microcontainers
```

2. Criar os volumes utilizados pelas PODs:
* PersistentVolume(PV): volume de armazenamento fisico, e é idependente do ciclo de vida da pod ou do namespace
* PersistentVolumeClaim(PVC): solicitação de armazenamento persistente feito pela pod, é feito um bind junto a PV

2.1 Criar PV e PVC do banco de dados MYSQL:
```bash
kubectl apply -f volumes/pv-mysql.yaml -n microcontainers
kubectl apply -f volumes/pv-claim-mysql.yaml -n microcontainers
```
2.2 Criar PV e PVC do Wordpress:
```bash
kubectl apply -f volumes/pv-wordpress.yaml -n microcontainers
kubectl apply -f volumes/pv-claim-wordpress.yaml -n microcontainers
```
3. Criar Secret com credenciais de acesso ao banco de dados:
```bash
kubectl apply -f secrets/database-secret.yaml -n microcontainers
```
4. Deploy do banco de dados MySQL:
```bash
kubectl apply -f deployments/dp-mysql.yaml -n microcontainers
```

5. Criar service do MySQL:
* Service do tipo ClusterIP: permite acesso somente de dentro do cluster
```bash
kubectl apply -f services/svc-mysql.yaml -n microcontainers
```

6. Deploy do Wordpress:
```bash
kubectl apply -f deployments/dp-wordpress.yaml -n microcontainers
```

7. Regra de escalabilidade das PODs do Wordpress:
```bash
kubectl apply -f hpa/hpa-wordpress.yaml -n microcontainers
```

8. Criar service do Wordpress:
* Service do tipo LoadBalancer: permite acesso externo
```bash
kubectl apply -f services/svc-wordpress.yaml -n microcontainers
```