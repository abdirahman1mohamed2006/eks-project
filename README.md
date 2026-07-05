# EKS GitOps Deployment Project

## Project Overview

This project provisions and operates an AWS EKS environment using Terraform, deploys platform services with Helm, and manages application delivery with Argo CD.

The final platform includes:

- An Amazon EKS cluster in `eu-west-1`
- Networking provisioned with a dedicated VPC and VPC CNI for Kubernetes pod networking
- IAM roles for nodes and workloads using OIDC-based pod identity with IRSA
- NGINX Ingress Controller for external traffic routing
- Cert-Manager for automatic TLS certificate issuance and renewal
- External-DNS for automatic Route 53 DNS record management
- Argo CD for GitOps-based application deployment and sync
- Prometheus and Grafana for observability and dashboarding
- A sample application deployed through Helm and synchronized with Argo CD

## What I Built

This repository was used to:

- Provision core AWS infrastructure for EKS
- Configure cluster add-ons and platform tooling
- Deploy a web application behind an HTTPS ingress
- Automate DNS and certificate management
- Enable GitOps deployments through Argo CD
- Monitor cluster health using Prometheus and Grafana

## Tools Used And Why

- Terraform: Provisioned AWS infrastructure such as VPC, EKS, IAM, ECR, and cluster dependencies.
- Helm: Deployed applications and platform services into the EKS cluster.
- Kubernetes: Orchestrated workloads, services, ingresses, and cluster resources.
- VPC CNI: Provided pod networking inside the EKS cluster.
- NGINX Ingress Controller: Routed HTTP and HTTPS traffic to workloads inside the cluster.
- Cert-Manager: Automatically issued and renewed TLS certificates using Let's Encrypt.
- External-DNS: Automatically created and updated DNS records in Route 53.
- Argo CD: Watched the GitHub repository and kept the live cluster state synchronized with Git.
- EBS CSI Driver: Provided persistent storage support for stateful Kubernetes workloads.
- Pod Identity / IRSA: Assigned IAM access to pods securely without storing static AWS credentials.
- Prometheus: Scraped cluster and workload metrics.
- Grafana: Visualized Prometheus metrics through dashboards.
- Route 53: Hosted the domain and DNS records for the application and platform services.
- Amazon ECR: Stored the container image used by the sample application.

## Repository Structure

```text
EKS/
├── bootstrap/
│   ├── main.tf
│   ├── outputs.tf
│   ├── provider.tf
│   ├── variables.tf
│   └── versions.tf
├── eks-assignment-v1/
│   ├── Dockerfile
│   ├── index.html
│   ├── js/
│   ├── meta/
│   └── style/
├── helm/
│   ├── helm-provider.tf
│   ├── helm-releases.tf
│   ├── cert-manager/
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
│       ├── deployment.yaml
│       ├── ingress.yaml
│       ├── service.yaml
│       ├── serviceaccount.yaml
│       └── tests/
├── terraform/
│   ├── main.tf
│   ├── provider.tf
│   ├── variables.tf
│   └── module/
│       ├── ECR/
│       ├── EKS/
│       ├── IAM/
│       └── VPC/
└── README.md
```

## Architecture Summary

1. Terraform provisions the VPC, IAM, EKS cluster, and supporting AWS resources.
2. Helm deploys ingress-nginx, cert-manager, external-dns, Prometheus, Grafana, and Argo CD.
3. External-DNS manages Route 53 records for application and platform endpoints.
4. Cert-Manager requests and renews TLS certificates for ingress resources.
5. Argo CD watches the Git repository and syncs the `my-app` Helm chart to the cluster.
6. Prometheus scrapes metrics and Grafana displays them through dashboards.

## Local Setup

### Prerequisites

- AWS CLI configured with credentials and access to the target AWS account
- Terraform installed
- Helm installed
- kubectl installed
- Git installed
- Access to Route 53 for the target domain

### Local Environment Preparation

1. Clone the repository.

```bash
git clone https://github.com/abdirahman1mohamed2006/eks-project.git
cd eks-project
```

2. Confirm AWS authentication.

```bash
aws sts get-caller-identity
```

3. Initialize Terraform for infrastructure.

```bash
terraform -chdir=terraform init
```

4. Initialize Terraform for Helm-managed platform tooling.

```bash
terraform -chdir=helm init
```

5. Update kubeconfig for the EKS cluster after creation.

```bash
aws eks update-kubeconfig --region eu-west-1 --name eks-assignment
```

6. Validate access to the cluster.

```bash
kubectl get nodes
kubectl get pods -A
```

## Step-By-Step Implementation

### 1. Provision Core AWS Infrastructure

I used Terraform to provision:

- VPC and subnets
- EKS cluster
- IAM roles and policies
- ECR repository
- Supporting networking and security resources

Example:

```bash
terraform -chdir=terraform apply
```

### 2. Deploy Platform Services With Helm Through Terraform

I deployed:

- NGINX Ingress Controller
- Cert-Manager
- External-DNS
- Kube Prometheus Stack
- Argo CD

Example:

```bash
terraform -chdir=helm apply
```

### 3. Configure Secure Pod Access To AWS

I used OIDC and IRSA so workloads such as cert-manager, external-dns, and storage-related services could access AWS securely without hardcoded credentials.

This solved:

- Route 53 access for DNS changes
- Route 53 access for ACME DNS challenges
- Secure service-to-AWS authentication for cluster workloads

### 4. Configure DNS And TLS

I configured:

- External-DNS to manage Route 53 records automatically
- Cert-Manager to issue TLS certificates using Let's Encrypt
- Ingress resources for HTTPS access to the application and Argo CD

This solved:

- Manual DNS record management
- Manual certificate creation
- Browser security errors once the certificate became ready

### 5. Deploy The Application

I deployed the sample application using the Helm chart in `my-app/`.

The deployment includes:

- Deployment
- Service
- Service account
- Ingress
- TLS secret integration through Cert-Manager

### 6. Enable GitOps With Argo CD

I configured an Argo CD `Application` to watch this repository and sync the `my-app` path automatically.

This means:

- Push to GitHub
- Argo CD detects the change
- Argo CD syncs the application to the cluster
- No manual application redeploy is needed for app-level changes

### 7. Enable Monitoring

I deployed:

- Prometheus for metric collection
- Grafana for dashboards

This provides:

- Cluster visibility
- Node and workload health monitoring
- Dashboard-based operational insight

## Issues I Overcame

- Terraform dependency cycle between EKS, IAM, and EBS CSI related resources
- Helm provider schema and values path issues
- EKS access and kubectl authentication problems
- IRSA trust policy issues for cert-manager and external-dns
- Route 53 permission errors for `AssumeRoleWithWebIdentity`, `GetChange`, and hosted zone actions
- Duplicate Route 53 hosted zone confusion
- Missing TLS mapping on the application ingress
- Application certificate not being created initially
- Argo CD application manifest not applied to the cluster
- Grafana initially disabled in monitoring values
- Service and container port mismatch causing `502 Bad Gateway`

## Key Fixes Applied

- Broke the Terraform cycle by moving the EBS CSI addon handling out of the conflicting dependency path
- Corrected Helm provider configuration and values references
- Fixed IAM policies and IRSA trust relationships for Route 53 access
- Constrained External-DNS to the correct hosted zone
- Enabled and validated Cert-Manager certificate issuance
- Updated the application ingress to include TLS and the NGINX ingress class
- Corrected the live application service target port to match the actual container listener
- Applied the correct Argo CD `Application` manifest for `my-app`
- Enabled Grafana in the Prometheus stack

## Validation Results

At the end of the deployment, the platform was validated with:

- Healthy EKS worker nodes
- Running application pods in `my-app`
- HTTPS access for the application domain
- Argo CD reporting `Synced` and `Healthy`
- Prometheus returning live metrics
- Grafana dashboards showing cluster data

## Access Summary

- Application: `https://abdirahman.forum`
- Argo CD: `https://argocd.abdirahman.forum`
- Prometheus: local port-forward access
- Grafana: local port-forward access

### Useful Commands

```bash
kubectl get nodes
kubectl get pods -A
kubectl get ingress -A
kubectl get certificate -A
kubectl get application -n argocd
```

### Monitoring Port Forward Commands

```bash
kubectl port-forward -n monitoring svc/kube-prometheus-stack-prometheus 19090:9090
kubectl port-forward -n monitoring svc/kube-prometheus-stack-grafana 13000:80
```

## GitOps Flow Example

1. Update the application Helm values in Git.
2. Commit and push the change.
3. Argo CD detects the new commit.
4. Argo CD syncs the application automatically.
5. The cluster matches the repository state without manually running Terraform for app-only updates.

## Screenshot Placeholders

Add your screenshots in the sections below. You can either paste them directly in GitHub after uploading images, or store them under a folder such as `docs/screenshots/` and reference them here.

### Live Application

Add screenshot here.

```markdown
![Live App](docs/screenshots/live-app.png)
```

### Argo CD Dashboard

Add screenshot here.

```markdown
![Argo CD](docs/screenshots/argocd-dashboard.png)
```

### Grafana Dashboard

Add screenshot here.

```markdown
![Grafana](docs/screenshots/grafana-dashboard.png)
```

### Healthy EKS Nodes

Add screenshot here.

```markdown
![Healthy Nodes](docs/screenshots/healthy-nodes.png)
```

### Healthy Cluster Resources

Add screenshot here.

```markdown
![Cluster Health](docs/screenshots/cluster-health.png)
```

### Successful CI/CD Pipeline

Add screenshot here.

```markdown
![CI CD Pipeline](docs/screenshots/cicd-pipeline.png)
```

## Conclusion

This project demonstrates end-to-end EKS platform delivery using Terraform, Helm, Kubernetes, Route 53, TLS automation, GitOps, and observability tooling. It also documents the operational issues encountered during deployment and how they were resolved to reach a stable, healthy, and observable cluster.
