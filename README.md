# 🎬 Netflix Clone - Enterprise DevSecOps & GitOps Architecture

![Architecture: Cloud-Native](https://img.shields.io/badge/Architecture-Cloud--Native-blue)
![Deployment: GitOps](https://img.shields.io/badge/Deployment-GitOps-orange)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-EKS-blue?logo=kubernetes)](https://aws.amazon.com/eks/)
[![Terraform](https://img.shields.io/badge/Terraform-IaC-purple?logo=terraform)](https://www.terraform.io/)
![Argo CD](https://img.shields.io/badge/ArgoCD-Self--Healing-green)

A production-grade, fully automated DevSecOps pipeline deploying a MERN-stack Netflix Clone to an AWS Elastic Kubernetes Service (EKS) cluster. This project demonstrates modern infrastructure management using Infrastructure as Code (IaC), shift-left security practices, and a pull-based GitOps continuous delivery model.

## 🏗️ Architecture & Workflow

This project moves away from traditional push-based deployments and embraces a **GitOps** philosophy where Git is the single source of truth for both application code and infrastructure configuration.

1. **Continuous Integration (CI):** Developers push code to GitLab. The CI pipeline triggers, builds the Docker image, and runs critical "Shift-Left" security scans (Trivy, SonarQube, OWASP).
2. **Container Registry:** If security gates pass, the image is pushed to Docker Hub.
3. **The Auto-Updater Bot:** The CI pipeline automatically injects the new Git Commit SHA into the Helm `values.yaml` file using stream editors (`sed`).
4. **Continuous Delivery (GitOps):** Argo CD, residing securely inside the EKS cluster, detects the drift in the Git repository and automatically pulls the new Helm configuration to sync the cluster state.
5. **Observability:** A Prometheus and Grafana stack continuously monitors cluster health, resource utilization, and pod stability.

## 🛠️ Technology Stack

* **Application:** React.js, Node.js, Express (MERN Stack)
* **Cloud Provider:** Amazon Web Services (AWS)
* **Infrastructure as Code (IaC):** Terraform, `eksctl`
* **Containerization:** Docker
* **Container Orchestration:** Kubernetes (Minikube for local dev, AWS EKS for production)
* **Package Management:** Helm
* **CI/CD:** GitLab CI (Shared/Self-Hosted Runners), Argo CD
* **Security & Testing:** Trivy (Container Scanning), SonarQube (Code Quality), OWASP Dependency Check
* **Observability:** Prometheus, Grafana

## 🚀 Implementation Workflow

### 1. Local Development & Containerization
The application was initially developed and tested locally before being packaged into a lightweight, portable Docker container.

```bash
docker build -t netflix-clone .
docker run --rm -p 3000:3000 netflix-clone
```

### 2. Infrastructure Provisioning
AWS infrastructure was provisioned via CLI tools and Terraform, adhering to the principle of least privilege for Security Groups and IAM roles.

```bash
# Provisioning a highly-available EKS cluster with managed nodes
eksctl create cluster --name netflix-cloud-cluster --region ap-south-1 --nodegroup-name netflix-nodes --node-type t3.medium --nodes 2 --managed
```

### 3. Helm Packaging & Dynamic Scaling
Raw Kubernetes YAML manifests were refactored into a dynamic Helm Chart, allowing for easy parameterization of replica counts, image tags, and environments.

```bash
helm upgrade --install netflix-release ./netflix-chart
```

### 4. GitOps Integration (Argo CD)
Argo CD was installed directly into the cluster to provide declarative, pull-based deployments and self-healing capabilities.

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f [https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml](https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml)
```

### 5. Cluster Observability
The kube-prometheus-stack was deployed via Helm to establish real-time visual dashboards for tracking CPU, memory, and application health.

```bash
helm repo add prometheus-community [https://prometheus-community.github.io/helm-charts](https://prometheus-community.github.io/helm-charts)
helm install observability-stack prometheus-community/kube-prometheus-stack --namespace observability --create-namespace
```

## 🔒 Security Implementations

* **Shift-Left Scanning:** Trivy configured with `--severity HIGH,CRITICAL --exit-code 1` to act as a hard gate against vulnerable container images.
* **Network Security:** AWS Security groups strictly managed via Terraform, keeping internal cluster nodes isolated in private subnets.
* **Credential Management:** Cluster secrets handled natively, preventing CI pipelines from requiring direct access to the Kubernetes control plane.

## 👤 Author

**Ashen Maneth**
*Final-year Computer Science Student & Emerging DevSecOps Engineer*
[LinkedIn Profile](https://www.linkedin.com/in/ashen-maneth)

## 🙌 Acknowledgments

Credit and special thanks to the original source repository that provided the application foundation for this DevSecOps pipeline:
* [N4si/DevSecOps-Project](https://github.com/N4si/DevSecOps-Project.git)