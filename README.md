# Global360 Auto-Healing Web Tier on Azure using Terraform

## Overview

This project implements a highly available and auto-healing web tier on Microsoft Azure using Infrastructure as Code (Terraform). The solution ensures that the system can tolerate the failure of any single VM without downtime by leveraging Azure Virtual Machine Scale Sets (VMSS) behind an Azure Load Balancer.

Each virtual machine runs a simple NGINX web server serving a static default welcome page.

---

## Architecture

The architecture consists of the following components:

- Azure Resource Group
- Azure Virtual Network (VNet)
- Subnet for compute resources
- Azure Standard Load Balancer
    - Public IP
    - Backend Pool
    - HTTP Health Probe
    - Load Balancing Rule (port 80)
- Azure Virtual Machine Scale Set (VMSS)
    - Minimum/desired capacity: 2 instances (N+1 design)
    - Ubuntu-based VM images
    - NGINX installed via cloud-init

### High-Level Flow

Internet -> Azure Load Balancer -> VM Scale Set (2+ instances running NGINX)

---

## Key Features

### 1. Self-Healing
Azure VM Scale Sets automatically monitor instance health using load balancer health probes. If an instance becomes unhealthy or is terminated, it is automatically replaced to maintain the desired capacity.

---

### 2. Self-Provisioning (IaC)
The entire infrastructure is defined using Terraform. A single command provisions all resources

terraform apply

Re-running Terraform is idempotent and results in no changes if the desired state is already met.

---

### 3. High Availability (N+1 Design)
The VMSS is configured with a minimum of 2 instances. This ensures that the system continues serving traffic even if one instance fails.

---

### 4. Static Web Application
Each VM runs NGINX and serves a static default welcome page. Installation is handled using cloud-init.

---

## Technology Stack

- Terraform 
- Microsoft Azure
- Azure VM Scale Sets
- Azure Load Balancer
- NGINX
- Ubuntu 22.04 LTS

---

### Project Structure

.
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── modules/
│   ├── network/
│   ├── loadbalancer/
│   └── vmss/
└── environments/
    └── dev.tfvars

---

## How to Deploy

### 1. Initialize Terraform

terraform init

### 2. Review the execution plan

terraform plan -var-file="environments/dev.tfvars"

---

### Outputs

After deployment, Terraform outputs the Load Balancer Public IP:

load_balancer_public_ip = <public-ip-address>

This IP can be used to access the web application in a browser.

---

## Cost Estimation

| Resource | Estimated Cost |
|----------|----------------|
| 2 × B1s VM instances | ~AUD 12–14/month |
| Standard Load Balancer | ~AUD 4–6/month |
| Public IP | ~AUD 1/month |

### Total Estimated Cost: ~AUD 18-20/month

---

## Assumptions

- Single Azure region 
- HTTP only 
- Stateless design
- Minimal configuration for cost efficiency

---

## Design Decisions

### Why Azure?
Azure VM Scale Sets provide native auto-healing and scaling, reducing operational complexity.

### Why VMSS?
- Built-in auto-scaling
- Native load balancer integration
- Simple scaling model

---

## Validation

Validated using:

terraform plan -var-file="environments/dev.tfvars"

No resources were deployed as part of this submission.

---

## Author
Vipeen Sekharan