import ballerina/log;
import ballerinax/googleapis.sheets;
import ballerinax/salesforce as sfdc;

// Types
type GSheetOAuth2Config record {
    string clientId;
    string clientSecret;
    string refreshToken;
    string refreshUrl = "https://www.googleapis.com/oauth2/v3/token";
};

type SalesforceOAuth2Config record {
    string clientId;
    string clientSecret;
    string refreshToken;
    string refreshUrl = "https://login.salesforce.com/services/oauth2/token";
};

// Constants
const int HEADINGS_ROW = 1;

// Google sheets configuration parameters
configurable string spreadsheetId = ?;
configurable string worksheetName = ?;
configurable GSheetOAuth2Config GSheetOAuthConfig = ?;

// Salesforce configuration parameters
configurable SalesforceOAuth2Config salesforceOAuthConfig = ?;
configurable string salesforceBaseUrl = ?;



sheets:Client sheetsClient = check new ({ 
        auth: {
            clientId: GSheetOAuthConfig.clientId,
            clientSecret: GSheetOAuthConfig.clientSecret,
            refreshToken: GSheetOAuthConfig.refreshToken,
            refreshUrl: GSheetOAuthConfig.refreshUrl
        }
    });

sfdc:Client sfdcClient = check new ({
    baseUrl: salesforceBaseUrl,
    auth: {
        clientId: salesforceOAuthConfig.clientId,
        clientSecret: salesforceOAuthConfig.clientSecret,
        refreshToken: salesforceOAuthConfig.refreshToken,
        refreshUrl: salesforceOAuthConfig.refreshUrl
    }
});



public function main() returns error? {
    sheets:Range range = check sheetsClient->getRange(spreadsheetId, worksheetName, "A1:G5");
    (int|string|decimal)[] headers = range.values[0];
    foreach (int|string|decimal)[] item in range.values.slice(1) {
        map<json> newLead = {};
        foreach int|string|decimal header in headers {
            newLead[header.toString()] = item[<int>headers.indexOf(header)];
        }
        string createLeadResponse = check sfdcClient->createLead(newLead);
        log:printInfo(string `Lead created successfully!. Lead ID : ${createLeadResponse}`);
    
    }
        
}
