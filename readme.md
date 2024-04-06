# Infrastructure as Code Capstone Project

## Overview

This capstone project applies various Infrastructure as Code (IaC) principles to deploy Azure resources for the Remix Weather Application using Terraform. The project includes the setup of Azure Kubernetes Service (AKS) clusters and managed Redis DB instances to support the application. GitHub Actions is utilized to automate Terraform workflows.

### Project Structure

The project repository follows a structured layout:

```
.
├── remix-weather-app
│   ├── src
│   ├── package.json
│   └── Dockerfile
├── infrastructure
│   ├── backend
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── network
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── aks
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── app
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── .github
│   └── workflows
│       ├── terraform-static-checks.yml
│       ├── terraform-plan.yml
│       ├── terraform-apply.yml
│       ├── docker-build-push.yml
│       └── app-deploy.yml
└── terraform.tf
```




## Requirements

### Collaboration

- **GitHub Repository:** [Repository Name]
- **Collaborators:** Professor (rlmckenney) and Team Members
- **Branch Protection Rules:** Main branch requires pull request reviews, passing status checks, and up-to-date branches. At least one approving review is necessary before merging.

### Define Resources

The infrastructure code and application code reside in the same repository. Key modules include:

- **Terraform Backend Module:** Configures Azure Blob Storage.
- **Base Network Infrastructure Module:** Sets up resource groups, virtual networks, and subnets for different environments.
- **AKS Clusters Module:** Creates AKS clusters for test and production environments.
- **Remix Weather Application Module:** Deploys Azure Container Registry, AKS clusters, managed Redis DB instances, and Kubernetes deployments/services.

### Automate Workflows

GitHub Actions workflows automate various tasks:

- **Static Code Analysis:** Terraform static code analysis tasks (fmt, validate, tfsec) run on any push to any branch.
- **Terraform Plan and Tflint:** Executed on pull requests to the main branch.
- **Terraform Apply:** Triggered on push to the main branch.
- **Docker Build and Push:** Builds and pushes the Docker image for the Weather App to ACR on pull requests to the main branch.
- **Application Deployment:** Deploys the Remix Weather Application to AKS clusters based on events.

## Team Members

- Rabbikali Dhuka


## Special Instructions


