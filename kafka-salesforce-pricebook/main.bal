import ballerinax/kafka;
import ballerina/log;
import ballerinax/salesforce as sfdc;


configurable SalesforceOAuth2Config salesforceOAuthConfig = ?;
configurable string salesforceBaseUrl = ?;
public type ProductPrice readonly & record {
    string pricebookEntryId;
    float UnitPrice;
};

public type ProductPriceUpdate readonly & record {
    float UnitPrice;
};

listener kafka:Listener orderListener = new (kafka:DEFAULT_URL, {
    groupId: "order-group-id",
    topics: "foobar"
});

type SalesforceOAuth2Config record {
    string clientId;
    string clientSecret;
    string refreshToken;
    string refreshUrl = "https://test.salesforce.com/services/oauth2/token";
};

// Salesforce client
sfdc:Client sfdcClient = check new ({
    baseUrl: salesforceBaseUrl,
    auth: {
        clientId: salesforceOAuthConfig.clientId,
        clientSecret: salesforceOAuthConfig.clientSecret,
        refreshToken: salesforceOAuthConfig.refreshToken,
        refreshUrl: salesforceOAuthConfig.refreshUrl
    }
});

service on orderListener {
    remote function onConsumerRecord(ProductPrice[] prices) returns error? {
        foreach ProductPrice price in prices {
            log:printInfo(string `Received price change ${price.UnitPrice}`);
            ProductPriceUpdate updatedPrice = {UnitPrice: price.UnitPrice};
            check sfdcClient->update("PricebookEntry", price.pricebookEntryId, updatedPrice);
        }
    }
}