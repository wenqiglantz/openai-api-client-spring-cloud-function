# openai-api-client-spring-cloud-function
A demo app to show how to integrate OpenAI API chat completion into Spring Cloud Function.  

### API Key
Be sure to add your OpenAI API Key to your GitHub repo's repository secret.

### Run the app
You can build the app by executing command or use the cicd github actions workflow:
```
mvn clean package
```

### How to access the running app?
Check the output for your Terraform IaC provisioning, the HTTP API Gateway provisioning should have output the invoker URL

Use Postman, you can launch the app by navigating to endpoint:
* <invoker-url>/chat

