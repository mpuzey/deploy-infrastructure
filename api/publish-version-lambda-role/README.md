# publish-version-lambda-role

The following command will create the custom named IAM role within the publish-version-lambda-role stack:

```
aws cloudformation deploy --stack-name publish-version-lambda-role --template-file publish-version-lambda-role.json --capabilities CAPABILITY_NAMED_IAM --profile azcard
```
