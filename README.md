# EKS GitOps Platform Project

## Overview

This project provisions an AWS EKS platform with Terraform, deploys cluster services with Helm, uses Argo CD for GitOps-based application delivery, and uses Prometheus with Grafana for monitoring and dashboarding. It includes secure pod access to AWS, automated DNS and TLS, and a live application running on a public domain.

### Live Application

<img width="1677" height="962" alt="App" src="https://github.com/user-attachments/assets/69582903-135c-4506-9fab-b18a671dd2e6" />


## What I Used

- Terraform: Provisioned AWS infrastructure including VPC, EKS, IAM, and ECR.
- Helm: Deployed platform tooling and application components into the cluster.
- Kubernetes: Managed workloads, services, ingresses, and namespaces.
- VPC CNI: Provided pod networking inside the EKS cluster.
- NGINX Ingress Controller: Routed traffic to workloads inside the cluster.
- Cert-Manager: Automatically issued and renewed TLS certificates.
- External-DNS: Managed Route 53 DNS records automatically.
- Argo CD: Watched the Git repo and synced the application to the live cluster.
- EBS CSI Driver: Enabled persistent storage support for Kubernetes workloads.
- Pod Identity / IRSA: Gave pods secure IAM access without static credentials.
- Prometheus and Grafana: Collected and visualized cluster metrics.

## Repository Structure

```text
EKS/
├── bootstrap/
├── eks-assignment-v1/
├── helm/
│   ├── helm-provider.tf
│   ├── helm-releases.tf
│   └── values/
│       ├── argo-cd/
│       ├── cert-manager/
│       ├── external-dns.yaml
│       ├── grafana.yaml
│       ├── ingress-nginx.yaml
│       └── prometheus.yaml
├── my-app/
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
│       ├── _helpers.tpl
│       ├── deployment.yaml
│       ├── ingress.yaml
│       ├── service.yaml
│       ├── serviceaccount.yaml
│       └── tests/
├── terraform/
│   ├── main.tf
│   └── module/
│       ├── ECR/
│       ├── EKS/
│       ├── IAM/
│       └── VPC/
└── README.md
```

## Local Setup

### Prerequisites

- AWS CLI
- Terraform
- Helm
- kubectl
- Git

### Setup Steps

1. Clone the repository.

```bash
git clone https://github.com/abdirahman1mohamed2006/eks-project.git
cd eks-project
```

2. Confirm AWS access.

```bash
aws sts get-caller-identity
```

3. Initialize Terraform.

```bash
terraform -chdir=terraform init
terraform -chdir=helm init
```

4. Create infrastructure and platform services.

```bash
terraform -chdir=terraform apply
terraform -chdir=helm apply
```

5. Update kubeconfig and verify the cluster.

```bash
aws eks update-kubeconfig --region eu-west-1 --name eks-assignment
kubectl get nodes
kubectl get pods -A
```

## What I Did

1. Provisioned the VPC, EKS cluster, IAM roles, and ECR with Terraform.
2. Deployed ingress-nginx, cert-manager, external-dns, Prometheus, Grafana, and Argo CD with Helm using Terraform
3. Configured IRSA and pod identity so workloads could access AWS securely.
4. Connected external-dns to Route 53 and cert-manager to Let's Encrypt for automated DNS and TLS.
5. Deployed the sample app with Helm and exposed it through an HTTPS ingress.
6. Configured Argo CD to watch the GitHub repo and sync `my-app` automatically.
7. Enabled Prometheus and Grafana for observability.

## Cluster Health

This project finished with:

- Healthy EKS nodes
- Running application pods
- Working HTTPS ingress
- Argo CD showing `Synced` and `Healthy`
- Prometheus scraping metrics
- Grafana dashboards displaying live data


### Cluster Health Screnshot:



<img width="1506" height="382" alt="Cluster Health" src="https://github.com/user-attachments/assets/710ca817-71be-4f3c-a155-67998d35f038" />




### Healthy Nodes


<img width="1500" height="381" alt="Nodes" src="https://github.com/user-attachments/assets/07a5ee6a-70b9-4e64-b5df-a3da8d389528" />





## Argo CD And Monitoring

Argo CD is used so application changes pushed to GitHub can automatically sync to the cluster without manually redeploying the app each time.

Prometheus collects cluster metrics and Grafana visualizes them through dashboards.

### Argo CD


<img width="1895" height="945" alt="ArgoCD" src="https://github.com/user-attachments/assets/e2db450d-9da3-4bdd-a6e8-ede75315b70a" />


### Grafana


<img width="1877" height="902" alt="Grafana" src="https://github.com/user-attachments/assets/03ea2a23-2efc-4999-8b1e-759d578481ea" />



## Problems I Overcame

- Terraform dependency cycle between EKS, IAM, and EBS CSI related resources
- Helm provider and values path issues
- kubectl and EKS access configuration problems
- IRSA trust and Route 53 permission errors for cert-manager and external-dns
- Duplicate hosted zone confusion in Route 53
- Missing TLS wiring on the application ingress
- Argo CD application manifest not applied to the cluster
- Grafana disabled in monitoring values
- Service and container port mismatch causing `502 Bad Gateway`


## CI/CD Proof


<img width="790" height="97" alt="terraform destroy" src="https://github.com/user-attachments/assets/0e97771e-8019-41f4-b8ee-0448b4a0bada" />
<img width="797" height="92" alt="dockerbuild" src="https://github.com/user-attachments/assets/76009f58-6049-4ae9-a60f-68e9e3d12192" />
<img width="817" height="97" alt="image" src="https://github.com/user-attachments/assets/10d4bb17-cca9-4fff-93e3-3b4371ca52b4" />




## Useful Commands

```bash
kubectl get nodes
kubectl get pods -A
kubectl get ingress -A
kubectl get certificate -A
kubectl get application -n argocd
```

## Access

- Application: https://abdirahman.forum
- Argo CD: https://argocd.abdirahman.forum
- Prometheus: local port-forward
- Grafana: local port-forward
