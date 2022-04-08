# VgsApiClient::ApiError

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **detail** | **String** | Explanation of what exactly went wrong. | [optional] |
| **href** | **String** | Request URL. | [optional] |
| **status** | **Integer** | HTTP status code. | [optional] |
| **title** | **String** | High-level reason of why the request failed. | [optional] |

## Example

```ruby
require 'vgs_api_client'

instance = VgsApiClient::ApiError.new(
  detail: null,
  href: null,
  status: null,
  title: null
)
```

