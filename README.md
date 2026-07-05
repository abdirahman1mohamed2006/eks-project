# EKS GitOps Platform Project

## Overview

This project provisions an AWS EKS platform with Terraform, deploys cluster services with Helm, uses Argo CD for GitOps-based application delivery, and uses Prometheus with Grafana for monitoring and dashboarding. It includes secure pod access to AWS, automated DNS and TLS, and a live application running on a public domain.

### Live Application

![Live App](docs/screenshots/live-app.png)

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

### Healthy Nodes


```markdown
![Healthy Nodes](docs/screenshots/healthy-nodes.png)
```




## Argo CD And Monitoring

Argo CD is used so application changes pushed to GitHub can automatically sync to the cluster without manually redeploying the app each time.

Prometheus collects cluster metrics and Grafana visualizes them through dashboards.

### Argo CD


```markdown
![Argo CD](docs/screenshots/argocd-dashboard.png)
```

### Grafana


```markdown
![Grafana](docs/screenshots/grafana-dashboard.png)
```

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


```markdown
![CI CD Pipeline](docs/screenshots/cicd-pipeline.png)
```

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