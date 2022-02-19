# Project


Deploy backend application on kubernetes cluster using CI/CD jenkins pipeline.

# Setup
* Build simple web application.
* Build full infrastructure with terraform
* Run jnkins master and agent on kubernets using ansible
* Build CI/CD pipeline to build web application's image, push it and deliver the application to production.

## Docker 
The Dockerfile for the application will be build and pushed to image repo during the CI.

## Terraform

 ### The infrastrcure 
 - VPC Network
 - Management subnet
 - Restricted subnet
 - Natgatway
 - VM instance 
 - Fully private k8s cluster
 - Writing script to install ansible 

```bash
terraform init 
terraform plan 
terraform apply
```
## Ansible
### Role
 - Connecting to GCP cluster
 - Creating new namespace for jenkins
 - Creating Jenkins's Deployments and Services.
### notes
 - Jenkins's yaml files are located in /role/test/deployment

- The Role must be uploaded on cloud storage and deliver storage name in vm's metadata to run it automaticly or you can run it manually.



## Jenkins
- Configure jenkins agent and connected it to the master.
- Create pipeline to build and deploy the application

# In real life application
- More than one branch for different environments
- Security test


 
 
***
