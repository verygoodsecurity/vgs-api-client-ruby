=begin
#Vault HTTP API

#Storing, retrieving, and managing sensitive data within a VGS organization.  **NOTE:** _The Vault API is intended only for environments that are already PCI-compliant. If you want to use this API, but are not yet PCI-compliant, you can use [VGS Collect](https://www.verygoodsecurity.com/docs/vgs-collect/what-is-it) or VGS Proxy with [Inbound Routes](https://www.verygoodsecurity.com/docs/getting-started/quick-integration#securing-inbound-connection) to quickly and seamlessly achieve compliance._  Looking for the old version of the API? Find it [here](https://www.verygoodsecurity.com/docs/api/1/vault).  # Introduction  Each encrypted value stored in a VGS vault has one or multiple _aliases_ associated with it. These aliases are fully opaque and retain no information about the underlying data. The user may safely store aliases without compromising data security.  **NOTE:** The API works with persistent storage only. Unlike volatile storage, this means that the data is stored permanently, without any implicit TTL.  Aliases are not valuable on their own. However, they can be used to decrypt the associated value and pass it to another service via the [forward proxy](https://www.verygoodsecurity.com/docs/guides/outbound-connection).  ## Alias Formats  Each alias corresponds to a certain format. There are several alias formats suitable for different kinds of sensitive data.  For example, `UUID` produces a random Base58-encoded UUID string with an environment-dependent prefix:  ``` tok_sandbox_bhtsCwFUzoJMw9rWUfEV5e ```  This format is generic and suitable for any kind of data.  The tables below contain descriptions of all alias formats recognized by the API.  ### Generic Formats  | Value                   | Description                                           | |-------------------------|-------------------------------------------------------| | `NUM_LENGTH_PRESERVING` | Length-Preserving, Numeric                            | | `RAW_UUID`              | UUID                                                  | | `UUID`                  | UUID (Prefixed, Base58-Encoded)                       | | `GENERIC_T_FOUR`        | UUID (Prefixed, Base58-Encoded, Last four preserving) |  ### Account Number Formats  | Value                             | Description                          | |-----------------------------------|--------------------------------------| | `FPE_ACC_NUM_T_FOUR`              | Length-Preserving, Numeric (A4)      | | `FPE_ALPHANUMERIC_ACC_NUM_T_FOUR` | Length-Preserving, Alphanumeric (A4) |   ### Payment Card Formats  | Value            | Description                                 | |------------------|---------------------------------------------| | `FPE_SIX_T_FOUR` | Format-Preserving, Luhn Valid (6T4)         | | `FPE_T_FOUR`     | Format-Preserving, Luhn Valid (T4)          | | `PFPT`           | Prefixed, Luhn Valid, 19-Digit Fixed Length |  ### SSN Formats  | Value            | Description            | |------------------|------------------------| | `FPE_SSN_T_FOUR` | Format-Preserving (A4) |  # Authentication  This API uses `Basic` authentication.  Credentials to access the API can be generated on the [dashboard](https://dashboard.verygoodsecurity.com) by going to the Settings section of the vault of your choosing.  [Docs » Guides » Access credentials](https://www.verygoodsecurity.com/docs/settings/access-credentials)  # Rate Limiting  The API allows up to 3,000 requests per minute. Requests are associated with the vault, regardless of the access credentials used to authenticate the request.  Your current rate limit is included as HTTP headers in every API response:  | Header Name             | Description                                              | |-------------------------|----------------------------------------------------------| | `x-ratelimit-remaining` | The number of requests remaining in the 1-minute window. |  If you exceed the rate limit, the API will reject the request with HTTP [429 Too Many Requests](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/429).  # Errors  The API uses standard HTTP status codes to indicate whether the request succeeded or not.  In case of failure, the response body will be JSON in a predefined format. For example, trying to create too many aliases at once results in the following response:  ```json {     \"errors\": [         {             \"status\": 400,             \"title\": \"Bad request\",             \"detail\": \"Too many values (limit: 20)\",             \"href\": \"https://api.sandbox.verygoodvault.com/aliases\"         }     ] } ``` 

The version of the OpenAPI document: 1.0.0
Contact: support@verygoodsecurity.com
Generated by: https://openapi-generator.tech
OpenAPI Generator version: 6.0.0-SNAPSHOT

=end

require 'cgi'

module VgsApiClient
  class AliasesApi
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end
    # Create aliases
    # Stores multiple values at once & returns their aliases.  Alternatively, this endpoint may be used to associate additional (i.e. secondary) aliases with the same underlying data as the reference alias specified in the request body.  **NOTE:** You cannot reference the same alias more than once in a single request. 
    # @param [Hash] opts the optional parameters
    # @option opts [CreateAliasesRequest] :create_aliases_request 
    # @return [InlineResponse201]
    def create_aliases(opts = {})
      data, _status_code, _headers = create_aliases_with_http_info(opts)
      data
    end

    # Create aliases
    # Stores multiple values at once &amp; returns their aliases.  Alternatively, this endpoint may be used to associate additional (i.e. secondary) aliases with the same underlying data as the reference alias specified in the request body.  **NOTE:** You cannot reference the same alias more than once in a single request. 
    # @param [Hash] opts the optional parameters
    # @option opts [CreateAliasesRequest] :create_aliases_request 
    # @return [Array<(InlineResponse201, Integer, Hash)>] InlineResponse201 data, response status code and response headers
    def create_aliases_with_http_info(opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: AliasesApi.create_aliases ...'
      end
      # resource path
      local_var_path = '/aliases'

      # query parameters
      query_params = opts[:query_params] || {}

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      content_type = @api_client.select_header_content_type(['application/json'])
      if !content_type.nil?
          header_params['Content-Type'] = content_type
      end

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:debug_body] || @api_client.object_to_http_body(opts[:'create_aliases_request'])

      # return_type
      return_type = opts[:debug_return_type] || 'InlineResponse201'

      # auth_names
      auth_names = opts[:debug_auth_names] || ['basicAuth']

      new_options = opts.merge(
        :operation => :"AliasesApi.create_aliases",
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type
      )

      data, status_code, headers = @api_client.call_api(:POST, local_var_path, new_options)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: AliasesApi#create_aliases\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Delete alias
    # Removes a single alias. 
    # @param _alias [String] Alias to operate on.
    # @param [Hash] opts the optional parameters
    # @return [nil]
    def delete_alias(_alias, opts = {})
      delete_alias_with_http_info(_alias, opts)
      nil
    end

    # Delete alias
    # Removes a single alias. 
    # @param _alias [String] Alias to operate on.
    # @param [Hash] opts the optional parameters
    # @return [Array<(nil, Integer, Hash)>] nil, response status code and response headers
    def delete_alias_with_http_info(_alias, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: AliasesApi.delete_alias ...'
      end
      # verify the required parameter '_alias' is set
      if @api_client.config.client_side_validation && _alias.nil?
        fail ArgumentError, "Missing the required parameter '_alias' when calling AliasesApi.delete_alias"
      end
      # resource path
      local_var_path = '/aliases/{alias}'.sub('{' + 'alias' + '}', CGI.escape(_alias.to_s))

      # query parameters
      query_params = opts[:query_params] || {}

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:debug_body]

      # return_type
      return_type = opts[:debug_return_type]

      # auth_names
      auth_names = opts[:debug_auth_names] || ['basicAuth']

      new_options = opts.merge(
        :operation => :"AliasesApi.delete_alias",
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type
      )

      data, status_code, headers = @api_client.call_api(:DELETE, local_var_path, new_options)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: AliasesApi#delete_alias\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Reveal single alias
    # Retrieves a stored value along with its aliases.  **NOTE:** This endpoint may expose sensitive data. Therefore, it is disabled by default. To enable it, please contact your VGS account manager or drop us a line at [support@verygoodsecurity.com](mailto:support@verygoodsecurity.com). 
    # @param _alias [String] Alias to operate on.
    # @param [Hash] opts the optional parameters
    # @return [InlineResponse2001]
    def reveal_alias(_alias, opts = {})
      data, _status_code, _headers = reveal_alias_with_http_info(_alias, opts)
      data
    end

    # Reveal single alias
    # Retrieves a stored value along with its aliases.  **NOTE:** This endpoint may expose sensitive data. Therefore, it is disabled by default. To enable it, please contact your VGS account manager or drop us a line at [support@verygoodsecurity.com](mailto:support@verygoodsecurity.com). 
    # @param _alias [String] Alias to operate on.
    # @param [Hash] opts the optional parameters
    # @return [Array<(InlineResponse2001, Integer, Hash)>] InlineResponse2001 data, response status code and response headers
    def reveal_alias_with_http_info(_alias, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: AliasesApi.reveal_alias ...'
      end
      # verify the required parameter '_alias' is set
      if @api_client.config.client_side_validation && _alias.nil?
        fail ArgumentError, "Missing the required parameter '_alias' when calling AliasesApi.reveal_alias"
      end
      # resource path
      local_var_path = '/aliases/{alias}'.sub('{' + 'alias' + '}', CGI.escape(_alias.to_s))

      # query parameters
      query_params = opts[:query_params] || {}

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:debug_body]

      # return_type
      return_type = opts[:debug_return_type] || 'InlineResponse2001'

      # auth_names
      auth_names = opts[:debug_auth_names] || ['basicAuth']

      new_options = opts.merge(
        :operation => :"AliasesApi.reveal_alias",
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type
      )

      data, status_code, headers = @api_client.call_api(:GET, local_var_path, new_options)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: AliasesApi#reveal_alias\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Reveal multiple aliases
    # Given a comma separated aliases string, retrieves all associated values stored in the vault.  **NOTE:** This endpoint may expose sensitive data. Therefore, it is disabled by default. To enable it, please contact your VGS account manager or drop us a line at [support@verygoodsecurity.com](mailto:support@verygoodsecurity.com). 
    # @param q [String] Comma-separated aliases string
    # @param [Hash] opts the optional parameters
    # @return [InlineResponse200]
    def reveal_multiple_aliases(q, opts = {})
      data, _status_code, _headers = reveal_multiple_aliases_with_http_info(q, opts)
      data
    end

    # Reveal multiple aliases
    # Given a comma separated aliases string, retrieves all associated values stored in the vault.  **NOTE:** This endpoint may expose sensitive data. Therefore, it is disabled by default. To enable it, please contact your VGS account manager or drop us a line at [support@verygoodsecurity.com](mailto:support@verygoodsecurity.com). 
    # @param q [String] Comma-separated aliases string
    # @param [Hash] opts the optional parameters
    # @return [Array<(InlineResponse200, Integer, Hash)>] InlineResponse200 data, response status code and response headers
    def reveal_multiple_aliases_with_http_info(q, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: AliasesApi.reveal_multiple_aliases ...'
      end
      # verify the required parameter 'q' is set
      if @api_client.config.client_side_validation && q.nil?
        fail ArgumentError, "Missing the required parameter 'q' when calling AliasesApi.reveal_multiple_aliases"
      end
      # resource path
      local_var_path = '/aliases'

      # query parameters
      query_params = opts[:query_params] || {}
      query_params[:'q'] = q

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:debug_body]

      # return_type
      return_type = opts[:debug_return_type] || 'InlineResponse200'

      # auth_names
      auth_names = opts[:debug_auth_names] || ['basicAuth']

      new_options = opts.merge(
        :operation => :"AliasesApi.reveal_multiple_aliases",
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type
      )

      data, status_code, headers = @api_client.call_api(:GET, local_var_path, new_options)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: AliasesApi#reveal_multiple_aliases\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Update data classifiers
    # Apply new classifiers to the value that the specified alias is associated with. 
    # @param _alias [String] Alias to operate on.
    # @param [Hash] opts the optional parameters
    # @option opts [UpdateAliasRequest] :update_alias_request 
    # @return [nil]
    def update_alias(_alias, opts = {})
      update_alias_with_http_info(_alias, opts)
      nil
    end

    # Update data classifiers
    # Apply new classifiers to the value that the specified alias is associated with. 
    # @param _alias [String] Alias to operate on.
    # @param [Hash] opts the optional parameters
    # @option opts [UpdateAliasRequest] :update_alias_request 
    # @return [Array<(nil, Integer, Hash)>] nil, response status code and response headers
    def update_alias_with_http_info(_alias, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: AliasesApi.update_alias ...'
      end
      # verify the required parameter '_alias' is set
      if @api_client.config.client_side_validation && _alias.nil?
        fail ArgumentError, "Missing the required parameter '_alias' when calling AliasesApi.update_alias"
      end
      # resource path
      local_var_path = '/aliases/{alias}'.sub('{' + 'alias' + '}', CGI.escape(_alias.to_s))

      # query parameters
      query_params = opts[:query_params] || {}

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      content_type = @api_client.select_header_content_type(['application/json'])
      if !content_type.nil?
          header_params['Content-Type'] = content_type
      end

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:debug_body] || @api_client.object_to_http_body(opts[:'update_alias_request'])

      # return_type
      return_type = opts[:debug_return_type]

      # auth_names
      auth_names = opts[:debug_auth_names] || ['basicAuth']

      new_options = opts.merge(
        :operation => :"AliasesApi.update_alias",
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type
      )

      data, status_code, headers = @api_client.call_api(:PUT, local_var_path, new_options)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: AliasesApi#update_alias\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
  end
end
