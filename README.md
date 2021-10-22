# tech-challenge

## Challenge 1

I'm using terraform to deploy resources based on the following Azure example:

https://docs.microsoft.com/en-us/azure/architecture/example-scenario/infrastructure/multi-tier-app-disaster-recovery

I have made an assumption that there is a storage account to hold the remote state called "stchallenge01tf001" as outlined in the backend.tf file.

Load balancer config and nsgs have been omitted for brevity.

Naming convention based on microsoft recommendations:

https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations

tfvar files have been included to show deployments to different environments when using workspaces

Dev:
```
terraform workspace select dev
terraform plan -var-file="./ukdev.tfvars" -out plan.tfplan
```

Prd:
```
terraform workspace select prd
terraform plan -var-file="./ukprd.tfvars" -out plan.tfplan
```

## Challenge 2

As I dont have easy access to an AWS instance, and the hints included Azure documentation, I am querying the Azure host meta data.
My example uses powershell and I have included some unit tests

To return all data in json
```
.\Get-HostMetadata.ps1 
```
To return specific key value
```
.\Get-HostMetadata.ps1 -KeyName location
```
To invoke unit tests
```
Invoke-Pester .\Get-HostMetadata.tests.ps1 -Output Detailed
```

