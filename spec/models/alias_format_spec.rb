=begin
#Vault HTTP API

#Storing, retrieving, and managing sensitive data within a VGS organization.  **NOTE:** _The Vault API is intended only for environments that are already PCI-compliant. If you want to use this API, but are not yet PCI-compliant, you can use [VGS Collect](https://www.verygoodsecurity.com/docs/vgs-collect/what-is-it) or VGS Proxy with [Inbound Routes](https://www.verygoodsecurity.com/docs/getting-started/quick-integration#securing-inbound-connection) to quickly and seamlessly achieve compliance._  Looking for the old version of the API? Find it [here](https://www.verygoodsecurity.com/docs/api/1/vault).  # Introduction  Each encrypted value stored in a VGS vault has one or multiple _aliases_ associated with it. These aliases are fully opaque and retain no information about the underlying data. The user may safely store aliases without compromising data security.  **NOTE:** The API works with persistent storage only. Unlike volatile storage, this means that the data is stored permanently, without any implicit TTL.  Aliases are not valuable on their own. However, they can be used to decrypt the associated value and pass it to another service via the [forward proxy](https://www.verygoodsecurity.com/docs/guides/outbound-connection).  ## Alias Formats  Each alias corresponds to a certain format. There are several alias formats suitable for different kinds of sensitive data.  For example, `UUID` produces a random Base58-encoded UUID string with an environment-dependent prefix:  ``` tok_sandbox_bhtsCwFUzoJMw9rWUfEV5e ```  This format is generic and suitable for any kind of data.  The tables below contain descriptions of all alias formats recognized by the API.  ### Generic Formats  | Value                   | Description                                           | |-------------------------|-------------------------------------------------------| | `NUM_LENGTH_PRESERVING` | Length-Preserving, Numeric                            | | `RAW_UUID`              | UUID                                                  | | `UUID`                  | UUID (Prefixed, Base58-Encoded)                       | | `GENERIC_T_FOUR`        | UUID (Prefixed, Base58-Encoded, Last four preserving) |  ### Account Number Formats  | Value                             | Description                          | |-----------------------------------|--------------------------------------| | `FPE_ACC_NUM_T_FOUR`              | Length-Preserving, Numeric (A4)      | | `FPE_ALPHANUMERIC_ACC_NUM_T_FOUR` | Length-Preserving, Alphanumeric (A4) |   ### Payment Card Formats  | Value            | Description                                 | |------------------|---------------------------------------------| | `FPE_SIX_T_FOUR` | Format-Preserving, Luhn Valid (6T4)         | | `FPE_T_FOUR`     | Format-Preserving, Luhn Valid (T4)          | | `PFPT`           | Prefixed, Luhn Valid, 19-Digit Fixed Length |  ### SSN Formats  | Value            | Description            | |------------------|------------------------| | `FPE_SSN_T_FOUR` | Format-Preserving (A4) |  # Authentication  This API uses `Basic` authentication.  Credentials to access the API can be generated on the [dashboard](https://dashboard.verygoodsecurity.com) by going to the Settings section of the vault of your choosing.  [Docs » Guides » Access credentials](https://www.verygoodsecurity.com/docs/settings/access-credentials)  # Rate Limiting  The API allows up to 3,000 requests per minute. Requests are associated with the vault, regardless of the access credentials used to authenticate the request.  Your current rate limit is included as HTTP headers in every API response:  | Header Name             | Description                                              | |-------------------------|----------------------------------------------------------| | `x-ratelimit-remaining` | The number of requests remaining in the 1-minute window. |  If you exceed the rate limit, the API will reject the request with HTTP [429 Too Many Requests](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/429).  # Errors  The API uses standard HTTP status codes to indicate whether the request succeeded or not.  In case of failure, the response body will be JSON in a predefined format. For example, trying to create too many aliases at once results in the following response:  ```json {     \"errors\": [         {             \"status\": 400,             \"title\": \"Bad request\",             \"detail\": \"Too many values (limit: 20)\",             \"href\": \"https://api.sandbox.verygoodvault.com/aliases\"         }     ] } ``` 

The version of the OpenAPI document: 1.0.0
Contact: support@verygoodsecurity.com
Generated by: https://openapi-generator.tech
OpenAPI Generator version: 5.0.1-SNAPSHOT

=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for VgsApiClient::AliasFormat
# Automatically generated by openapi-generator (https://openapi-generator.tech)
# Please update as you see appropriate
describe VgsApiClient::AliasFormat do
  let(:instance) { VgsApiClient::AliasFormat.new }

  describe 'test an instance of AliasFormat' do
    it 'should create an instance of AliasFormat' do
      expect(instance).to be_instance_of(VgsApiClient::AliasFormat)
    end
  end
end
