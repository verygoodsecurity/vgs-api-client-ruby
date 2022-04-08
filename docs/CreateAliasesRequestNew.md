# VgsApiClient::CreateAliasesRequestNew

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **classifiers** | **Array&lt;String&gt;** | List of tags to classify the value with. | [optional] |
| **format** | [**AliasFormat**](AliasFormat.md) |  |  |
| **value** | **String** | Raw value to encrypt &amp; store in the vault. |  |

## Example

```ruby
require 'vgs_api_client'

instance = VgsApiClient::CreateAliasesRequestNew.new(
  classifiers: null,
  format: null,
  value: 122105155
)
```

