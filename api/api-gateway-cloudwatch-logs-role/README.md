# api-gateway-cloudwatch-logs-role

The following command creates the IAM role to be assumed by API Gateway for writing logs to CloudWatch. It will be put in the api-gateway-cloudwatch-logs-role stack:

```
aws cloudformation deploy --stack-name api-gateway-cloudwatch-logs-role --template-file cloudwatch-logs-role.json --capabilities CAPABILITY_NAMED_IAM --profile azcard
```
