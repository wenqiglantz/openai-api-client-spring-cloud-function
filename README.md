# openai-api-client-spring-cloud-function
A demo app to show how to integrate OpenAI API chat completion into Spring Cloud Function.  Check out my Medium article for details: [Going Serverless With Spring Cloud Function, AWS Lambda Java 17 Support, and SnapStart](https://betterprogramming.pub/going-serverless-with-spring-cloud-function-aws-lambda-java-17-support-and-snapstart-d3d8ffd44bbd?sk=46da73f9491b774f5b025b83f2726f74).

### API Key
Be sure to add your OpenAI API Key to your GitHub repo's repository secret.

### Run the app
You can build the app by executing command or use the cicd github actions workflow:
```
mvn clean package
```

### How to access the running app?
Check the output for your Terraform IaC provisioning, the HTTP API Gateway provisioning should have the invoker URL in the output.

Use Postman, you can launch the app by navigating to endpoint:
* [invoker-url]/chat-java17-snapstart

