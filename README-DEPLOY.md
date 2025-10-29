# WordPress AKS Deployment

This project includes a Helm chart and GitHub Actions CI/CD pipeline for deploying WordPress to Azure Kubernetes Service (AKS).

## Prerequisites

- An AKS cluster
- Azure Service Principal with appropriate permissions
- GitHub repository secrets configured

## Required GitHub Secrets

Configure the following secrets in your GitHub repository settings:

1. **AZURE_CLIENT_ID** - Service Principal Client ID
2. **AZURE_SUBSCRIPTION_ID** - Azure Subscription ID
3. **AZURE_TENANT_ID** - Azure Tenant ID
4. **AKS_RESOURCE_GROUP** - Resource group name containing your AKS cluster
5. **AKS_CLUSTER_NAME** - Name of your AKS cluster

## Deployment

The GitHub Actions workflow will automatically deploy on:
- Push to `main` or `master` branch
- Manual trigger via workflow_dispatch

The deployment creates the `wordpress` namespace and installs all required resources via Helm.

## Helm Chart

The Helm chart is located in `helm/wordpress/` and includes:

- WordPress Deployment
- MySQL StatefulSet
- Services (WordPress NodePort, MySQL ClusterIP)
- ConfigMaps (nginx, mysql)
- Secrets (mysql credentials)
- NetworkPolicy (mysql network restrictions)
- PersistentVolumeClaims

## Customization

Modify `helm/wordpress/values.yaml` to customize deployment settings such as:
- Resource limits
- Replica counts
- Image versions
- Storage sizes
- Service types

## Manual Deployment

To manually deploy using Helm:

```bash
# Install Helm chart
helm upgrade --install wordpress ./helm/wordpress \
  --namespace wordpress \
  --create-namespace \
  --wait

# Check deployment status
kubectl get pods -n wordpress
kubectl get svc -n wordpress
```

