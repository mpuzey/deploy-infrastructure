# publish-version-lambda-role

The following command will create the IAM role to be assumed by the Custom Resource backed Lambda, which will be used to publish new versions of Lambdas. It will be put in the publish-version-lambda-role stack:

```
aws cloudformation deploy --stack-name publish-version-lambda-role --template-file publish-version-lambda-role.json --capabilities CAPABILITY_NAMED_IAM --profile azcard
```
