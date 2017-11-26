# Terraform infrastructure
This repository contains the files and scripts needed to create azcard infrastructure with Terraform.

# Installation

```
brew install terraform && brew install tfenv
```

# One time Terraform state setup
Terraform uses the s3 backend to store the tf state of our infrastructure remotely so that multiple engineers can work on the infrastructure simultaneously without causing clashes in the state. In order to use s3 as a backend for Terraform the remote state bucket must first be created in order to store the state of the backend itself as well as all further state files. This bootstrapping process is necessary because backend config is required for a terraform init. If the bucker doesn't exist, we must plan and apply it with a local state and then configure the remote state with our backend config.

```
cd components/remote-state
terraform init
terraform plan -var 'account_id=414155656108'
terraform apply -var 'account_id=414155656108'
```

# Usage

To initialise the repo locally run the following:
```
terraform init -backend-config="key=tf-backend.tf"
```
