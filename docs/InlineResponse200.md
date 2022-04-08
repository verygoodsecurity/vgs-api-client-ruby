# VgsApiClient::InlineResponse200

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **data** | [**Hash&lt;String, RevealedData&gt;**](RevealedData.md) |  | [optional] |

## Example

```ruby
require 'vgs_api_client'

instance = VgsApiClient::InlineResponse200.new(
  data: {&quot;tok_sandbox_5UpnbMvaihRuRwz5QXwBFw&quot;:{&quot;aliases&quot;:[{&quot;format&quot;:&quot;UUID&quot;,&quot;value&quot;:&quot;tok_sandbox_5UpnbMvaihRuRwz5QXwBFw&quot;}],&quot;classifiers&quot;:[&quot;bank-account&quot;],&quot;created_at&quot;:&quot;2019-08-10T11:45:30Z&quot;,&quot;value&quot;:&quot;476673481&quot;},&quot;tok_sandbox_9ToiJHedw1nE1Jfx1qYYgz&quot;:{&quot;aliases&quot;:[{&quot;format&quot;:&quot;UUID&quot;,&quot;value&quot;:&quot;tok_sandbox_9ToiJHedw1nE1Jfx1qYYgz&quot;}],&quot;classifiers&quot;:[&quot;bank-account&quot;],&quot;created_at&quot;:&quot;2019-08-10T11:45:30Z&quot;,&quot;value&quot;:&quot;750360025&quot;}}
)
```

