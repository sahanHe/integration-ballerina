Example to update the product price in the Salesforce pricebook using Kafka and Salesforce integration.

## Use case
Apache Kafka is a distributed event store and stream-processing platform which is widely used for enterprise messaging applications. By using this integration, we can easily update the product price in the Salesforce pricebook using Kafka and Salesforce integration. This template can be used to update the product price in the Salesforce pricebook when a new message is received in the Kafka topic.

## Prerequisites
* Salesforce account
* Install Kafka

### Setting up Salesforce account
1. Visit [Salesforce](https://www.salesforce.com/) and create a Salesforce Account.
2. Create a connected app and obtain the following credentials:
    *   Base URL (Endpoint)
    *   Access Token
    *   Client ID
    *   Client Secret
    *   Refresh Token
    *   Refresh Token URL
3. When you are setting up the connected app, select the following scopes under Selected OAuth Scopes:
    *   Access and manage your data (api)
    *   Perform requests on your behalf at any time (refresh_token, offline_access)
    *   Provide access to your data via the Web (web)
4. Provide the client ID and client secret to obtain the refresh token and access token. For more information on obtaining OAuth2 credentials, go to [Salesforce documentation](https://help.salesforce.com/articleView?id=remoteaccess_authenticate_overview.htm).
5. Once you obtained all configurations, Replace "" in the `Conf.toml` file with your data.

### Setting up Kafka.
1. To test in local machines, install the kafka to your machine and start the server. You can follow the steps in [here](https://kafka.apache.org/quickstart).

## Configuration
Create a file called `Config.toml` at the root of the project.

### Config.toml 
```
[<ORG_NAME>.kafka_salesforce_pricebook_update]
salesforceBaseUrl = "<SALESFORCE_BASE_URL>"

[<ORG_NAME>.kafka_salesforce_pricebook_update.salesforceOAuthConfig]
clientId = "<SALESFORCE_CLIENT_ID>"
clientSecret = "<SALESFORCE_CLIENT_SECRET>"
refreshToken = "<SALESFORCE_REFRESH_TOKEN>"
refreshUrl = "<SALESFORCE_REFRESH_URL>"
```
> Here   
    * SALESFORCE_REFRESH_URL : https://login.salesforce.com/services/oauth2/token


## Testing
1. First run the kafka_msgProducer to start the kafka producer.

2. Start the kafka subscriber by running the kafka-salesforce-pricebook_update.

3. Then send the required message to kafka producer using `curl http://localhost:9090/orders -H "Content-type:application/json" -d "{\"Name\": \"<PRODUCT_NAME>\", \"UnitPrice\": <UPDATED_PRICE>}"`.

When the new message is published to the kafka topic, it subscriber will update the new price in the Salesforce pricebook.

