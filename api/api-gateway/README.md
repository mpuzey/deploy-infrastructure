# api-gateway

The following command will create the API Gateway within the api-gateway stack:

```
aws cloudformation deploy --stack-name api-gateway --template-file api-gateway.json --parameter-overrides ApiGatewayStageToDeploy=test --profile azcard
```
