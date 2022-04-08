# VgsApiClient::CreateAliasesRequestExisting

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **_alias** | **String** | Existing alias to use as a reference. |  |
| **format** | [**AliasFormat**](AliasFormat.md) |  |  |

## Example

```ruby
require 'vgs_api_client'

instance = VgsApiClient::CreateAliasesRequestExisting.new(
  _alias: tok_sandbox_bhtsCwFUzoJMw9rWUfEV5e,
  format: null
)
```

