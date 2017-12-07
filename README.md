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
terraform plan -var 'account_id=<account_id>'
terraform apply -var 'account_id=<account_id>
```

 The naming convention for backend tf state file under the remote state is `s3://tf-state-${account_id}-${region}/${project}/${account_id}/${region}/remote-state.tfstate`.

The state file for the remote state bucket component should be pushed into the newly configured s3 backend.
```
cd components/remote-state
terraform push
```

# Usage

To perform a Terraform action, such as plan, for a particular Terraform component run the following:
```
 python terraform.py --action=plan --environment=<environment> --component=<component>
```
The primary purpose of this is to prepare the Terraform backend to store the tfstate file in s3 for a given component. This places the state under an appropriate key in s3 to be versioned off. 
The naming convention for tf state files under the remote state is `s3://tf-state-${account_id}-${region}/${project}/${account_id}/${region}/${environment}/${component}.tfstate`.

The `--region` and `--project` parameters can optionally be specified as there are defaults for these. 
