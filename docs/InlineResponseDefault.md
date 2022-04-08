# VgsApiClient::InlineResponseDefault

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **errors** | [**Array&lt;ApiError&gt;**](ApiError.md) | List of errors that occurred while processing the request. | [optional] |

## Example

```ruby
require 'vgs_api_client'

instance = VgsApiClient::InlineResponseDefault.new(
  errors: null
)
```

