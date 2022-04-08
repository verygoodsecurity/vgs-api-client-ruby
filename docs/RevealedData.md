# VgsApiClient::RevealedData

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **aliases** | [**Array&lt;ModelAlias&gt;**](ModelAlias.md) | List of aliases associated with the value. | [optional] |
| **classifiers** | **Array&lt;String&gt;** | List of tags the value is classified with. | [optional] |
| **created_at** | **Time** | Creation time, in UTC. | [optional] |
| **value** | **String** | Decrypted value stored in the vault. | [optional] |

## Example

```ruby
require 'vgs_api_client'

instance = VgsApiClient::RevealedData.new(
  aliases: null,
  classifiers: null,
  created_at: 2019-05-15T12:30:45Z,
  value: 122105155
)
```

