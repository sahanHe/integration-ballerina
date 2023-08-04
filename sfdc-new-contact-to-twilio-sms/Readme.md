Example to send a Twilio SMS for every new Salesforce Contact.

## Use case
A customer can use Twilio to send internal notifications to a specific person based on the new contact information in
Salesforce. There might be a specific person who needs to be alerted once a new contact is added in Salesforce. Once a
new contact is created in Salesforce, a Twilio SMS containing all the defined fields in the contact SObject will be sent.
Any time you create a new contact in Salesforce, an SMS message will automatically send to the specific person via Twilio.
This template is used for the scenario that once a contact is created in Salesforce, Twilio SMS containing all the
defined fields in contact SObject will be sent.

## Prerequisites
* Pull the template from central  
  `bal new -t choreo/sfdc_new_contact_to_twilio_sms <newProjectName>`
* Twilio account
* Salesforce account

### Setting up Salesforce account
1. Create a Salesforce account and create a connected app by visiting [Salesforce](https://www.salesforce.com).
2. Salesforce username, password will be needed for initializing the listener.
3. Once you obtained all configurations, Replace relevant places in the `Config.toml` file with your data.
4. [Select Objects](https://developer.salesforce.com/docs/atlas.en-us.change_data_capture.meta/change_data_capture/cdc_select_objects.htm) for Change Notifications in the User Interface of Salesforce account.

### Setting up Twilio account
1. Create a [Twilio developer account](https://www.twilio.com/).
2. Obtain the Account SID and Auth Token from the project dashboard.
3. Obtain the phone number from the project dashboard and set as the value of the `fromNumber` variable in the `Config.toml`.
4. Give a mobile number where the SMS should be sent as the value of the `toNumber` variable in the `Config.toml`.
5. Once you obtained all configurations, Replace relevant places in the `Config.toml` file with your data.

## Configuration
Create a file called `Config.toml` at the root of the project.

## Config.toml
```
[<ORG_NAME>.sfdc_new_contact_to_twilio_sms]
fromNumber = "<TWILIO_FROM_MOBILE_NUMBER>"  
toNumber = "<TWILIO_TO_MOBILE_NUMBER>"  

[<ORG_NAME>.sfdc_new_contact_to_twilio_sms.salesforceListenerConfig]
sfdcUsername = "<SALESFORCE_USERNAME>"  
sfdcPassword = "<SALESFORCE_PASSWORD>" 

[<ORG_NAME>.sfdc_new_contact_to_twilio_sms.twilioClientConfig]
twilioAccountSid = "<TWILIO_ACCOUNT_SID>"  
twilioAuthToken = "<TWILIO_AUTH_TOKEN>"

```
Phone numbers must be provided in E.164 format: +<country code><number>, for example: +16175551212
## Testing
Run the Ballerina project created by the integration template by executing `bal run` from the root.

You can check the Twilio SMS for information related to the new Salesforce Contact.
