# static-site

This directory contains all the files needed to set up the infrastructure for a static site found at `https://<domain>` and `https://www.<domain>`.

## Result

![infrastructure diagram](assets/Untitled Diagram.svg)

## Creating a static-site stack

#### Prerequisites
Run the following command to request a certificate for `<domain>` and `*.<domain>`:

```
aws acm request-certificate 
--domain-name <domain> 
--subject-alternative-names *.<domain>
```
Successful execution of the above command will result in an email being sent to `admin@<domain>`. Follow the instructions in the email to verify ownership of the domain before continuing.

#### Running

```
aws cloudformation deploy 
--stack-name <stack-name> 
--template-file ./static-site.json
--parameters ParameterKey=RootDomain,ParameterValue=<domain>
```