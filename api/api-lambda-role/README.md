# api-lambda-role

The following command will create the custom named IAM role within the api-lambda-role stack:

```
aws cloudformation deploy --stack-name api-lambda-role --template-file api-lambda-role.json --capabilities CAPABILITY_NAMED_IAM --profile azcard
```
