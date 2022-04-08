# VgsApiClient::AliasesApi

All URIs are relative to *https://api.sandbox.verygoodvault.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**create_aliases**](AliasesApi.md#create_aliases) | **POST** /aliases | Create aliases |
| [**delete_alias**](AliasesApi.md#delete_alias) | **DELETE** /aliases/{alias} | Delete alias |
| [**reveal_alias**](AliasesApi.md#reveal_alias) | **GET** /aliases/{alias} | Reveal single alias |
| [**reveal_multiple_aliases**](AliasesApi.md#reveal_multiple_aliases) | **GET** /aliases | Reveal multiple aliases |
| [**update_alias**](AliasesApi.md#update_alias) | **PUT** /aliases/{alias} | Update data classifiers |


## create_aliases

> <InlineResponse201> create_aliases(opts)

Create aliases

Stores multiple values at once & returns their aliases.  Alternatively, this endpoint may be used to associate additional (i.e. secondary) aliases with the same underlying data as the reference alias specified in the request body.  **NOTE:** You cannot reference the same alias more than once in a single request. 

### Examples

```ruby
require 'time'
require 'vgs_api_client'
# setup authorization
VgsApiClient.configure do |config|
  # Configure HTTP basic authorization: basicAuth
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = VgsApiClient::AliasesApi.new
opts = {
  create_aliases_request: VgsApiClient::CreateAliasesRequest.new({data: [TODO]}) # CreateAliasesRequest | 
}

begin
  # Create aliases
  result = api_instance.create_aliases(opts)
  p result
rescue VgsApiClient::ApiError => e
  puts "Error when calling AliasesApi->create_aliases: #{e}"
end
```

#### Using the create_aliases_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<InlineResponse201>, Integer, Hash)> create_aliases_with_http_info(opts)

```ruby
begin
  # Create aliases
  data, status_code, headers = api_instance.create_aliases_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <InlineResponse201>
rescue VgsApiClient::ApiError => e
  puts "Error when calling AliasesApi->create_aliases_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **create_aliases_request** | [**CreateAliasesRequest**](CreateAliasesRequest.md) |  | [optional] |

### Return type

[**InlineResponse201**](InlineResponse201.md)

### Authorization

[basicAuth](../README.md#basicAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## delete_alias

> delete_alias(_alias)

Delete alias

Removes a single alias. 

### Examples

```ruby
require 'time'
require 'vgs_api_client'
# setup authorization
VgsApiClient.configure do |config|
  # Configure HTTP basic authorization: basicAuth
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = VgsApiClient::AliasesApi.new
_alias = 'tok_sandbox_bhtsCwFUzoJMw9rWUfEV5e' # String | Alias to operate on.

begin
  # Delete alias
  api_instance.delete_alias(_alias)
rescue VgsApiClient::ApiError => e
  puts "Error when calling AliasesApi->delete_alias: #{e}"
end
```

#### Using the delete_alias_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> delete_alias_with_http_info(_alias)

```ruby
begin
  # Delete alias
  data, status_code, headers = api_instance.delete_alias_with_http_info(_alias)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue VgsApiClient::ApiError => e
  puts "Error when calling AliasesApi->delete_alias_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **_alias** | **String** | Alias to operate on. |  |

### Return type

nil (empty response body)

### Authorization

[basicAuth](../README.md#basicAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## reveal_alias

> <InlineResponse2001> reveal_alias(_alias)

Reveal single alias

Retrieves a stored value along with its aliases.  **NOTE:** This endpoint may expose sensitive data. Therefore, it is disabled by default. To enable it, please contact your VGS account manager or drop us a line at [support@verygoodsecurity.com](mailto:support@verygoodsecurity.com). 

### Examples

```ruby
require 'time'
require 'vgs_api_client'
# setup authorization
VgsApiClient.configure do |config|
  # Configure HTTP basic authorization: basicAuth
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = VgsApiClient::AliasesApi.new
_alias = 'tok_sandbox_bhtsCwFUzoJMw9rWUfEV5e' # String | Alias to operate on.

begin
  # Reveal single alias
  result = api_instance.reveal_alias(_alias)
  p result
rescue VgsApiClient::ApiError => e
  puts "Error when calling AliasesApi->reveal_alias: #{e}"
end
```

#### Using the reveal_alias_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<InlineResponse2001>, Integer, Hash)> reveal_alias_with_http_info(_alias)

```ruby
begin
  # Reveal single alias
  data, status_code, headers = api_instance.reveal_alias_with_http_info(_alias)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <InlineResponse2001>
rescue VgsApiClient::ApiError => e
  puts "Error when calling AliasesApi->reveal_alias_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **_alias** | **String** | Alias to operate on. |  |

### Return type

[**InlineResponse2001**](InlineResponse2001.md)

### Authorization

[basicAuth](../README.md#basicAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## reveal_multiple_aliases

> <InlineResponse200> reveal_multiple_aliases(q)

Reveal multiple aliases

Given a comma separated aliases string, retrieves all associated values stored in the vault.  **NOTE:** This endpoint may expose sensitive data. Therefore, it is disabled by default. To enable it, please contact your VGS account manager or drop us a line at [support@verygoodsecurity.com](mailto:support@verygoodsecurity.com). 

### Examples

```ruby
require 'time'
require 'vgs_api_client'
# setup authorization
VgsApiClient.configure do |config|
  # Configure HTTP basic authorization: basicAuth
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = VgsApiClient::AliasesApi.new
q = 'tok_sandbox_5UpnbMvaihRuRwz5QXwBFw, tok_sandbox_9ToiJHedw1nE1Jfx1qYYgz' # String | Comma-separated aliases string

begin
  # Reveal multiple aliases
  result = api_instance.reveal_multiple_aliases(q)
  p result
rescue VgsApiClient::ApiError => e
  puts "Error when calling AliasesApi->reveal_multiple_aliases: #{e}"
end
```

#### Using the reveal_multiple_aliases_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<InlineResponse200>, Integer, Hash)> reveal_multiple_aliases_with_http_info(q)

```ruby
begin
  # Reveal multiple aliases
  data, status_code, headers = api_instance.reveal_multiple_aliases_with_http_info(q)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <InlineResponse200>
rescue VgsApiClient::ApiError => e
  puts "Error when calling AliasesApi->reveal_multiple_aliases_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **q** | **String** | Comma-separated aliases string |  |

### Return type

[**InlineResponse200**](InlineResponse200.md)

### Authorization

[basicAuth](../README.md#basicAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## update_alias

> update_alias(_alias, opts)

Update data classifiers

Apply new classifiers to the value that the specified alias is associated with. 

### Examples

```ruby
require 'time'
require 'vgs_api_client'
# setup authorization
VgsApiClient.configure do |config|
  # Configure HTTP basic authorization: basicAuth
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = VgsApiClient::AliasesApi.new
_alias = 'tok_sandbox_bhtsCwFUzoJMw9rWUfEV5e' # String | Alias to operate on.
opts = {
  update_alias_request: VgsApiClient::UpdateAliasRequest.new({data: VgsApiClient::UpdateAliasRequestData.new({classifiers: ['bank-account']})}) # UpdateAliasRequest | 
}

begin
  # Update data classifiers
  api_instance.update_alias(_alias, opts)
rescue VgsApiClient::ApiError => e
  puts "Error when calling AliasesApi->update_alias: #{e}"
end
```

#### Using the update_alias_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> update_alias_with_http_info(_alias, opts)

```ruby
begin
  # Update data classifiers
  data, status_code, headers = api_instance.update_alias_with_http_info(_alias, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue VgsApiClient::ApiError => e
  puts "Error when calling AliasesApi->update_alias_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **_alias** | **String** | Alias to operate on. |  |
| **update_alias_request** | [**UpdateAliasRequest**](UpdateAliasRequest.md) |  | [optional] |

### Return type

nil (empty response body)

### Authorization

[basicAuth](../README.md#basicAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

