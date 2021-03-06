=begin
#Vault HTTP API

#The VGS Vault HTTP API is used for storing, retrieving, and managing sensitive data (aka Tokenization) within a VGS Vault.  The VGS API is organized around REST. Our API is built with a predictable resource-oriented structure, uses JSON-encoded requests and responses, follows standard HTTP verbs/responses, and uses industry standard authentication.  ## What is VGS  Storing sensitive data on your company’s infrastructure often comes with a heavy compliance burden. For instance, storing payments data yourself greatly increases the amount of work needed to become PCI compliant. It also increases your security risk in general. To combat this, companies will minimize the amount of sensitive information they have to handle or store.  VGS provides multiple methods for minimizing the sensitive information that needs to be stored which allows customers to secure any type of data for any use-case.  **Tokenization** is a method that focuses on securing the storage of data. This is the quickest way to get started and is free. [Get started with Tokenization](https://www.verygoodsecurity.com/docs/tokenization/getting-started).  **Zero Data** is a unique method invented by VGS in 2016 that securely stores data like Tokenization, however it also removes the customer’s environment from PCI scope completely providing maximum security, and minimum compliance scope. [Get started with Zero Data](https://www.verygoodsecurity.com/docs/getting-started/before-you-start).  Additionally, for scenarios where neither technology is a complete solution, for instance with legacy systems, VGS provides a compliance product which guarantees customers are able to meet their compliance needs no matter what may happen. [Get started with Control](https://www.verygoodsecurity.com/docs/control).  ## Learn about Tokenization  - [Create an Account for Free Tokenization](https://dashboard.verygoodsecurity.com/tokenization) - [Try a Tokenization Demo](https://www.verygoodsecurity.com/docs/tokenization/getting-started) - [Install a Tokenization SDK](https://www.verygoodsecurity.com/docs/tokenization/client-libraries)  ### Authentication  This API uses `Basic` authentication.  Credentials to access the API can be generated on the [dashboard](https://dashboard.verygoodsecurity.com) by going to the Settings section of the vault of your choosing.  [Docs » Guides » Access credentials](https://www.verygoodsecurity.com/docs/settings/access-credentials)  ## Resource Limits  ### Data Limits  This API allows storing data up to 32MB in size.  ### Rate Limiting  The API allows up to 3,000 requests per minute. Requests are associated with the vault, regardless of the access credentials used to authenticate the request.  Your current rate limit is included as HTTP headers in every API response:  | Header Name             | Description                                              | |-------------------------|----------------------------------------------------------| | `x-ratelimit-remaining` | The number of requests remaining in the 1-minute window. |  If you exceed the rate limit, the API will reject the request with HTTP [429 Too Many Requests](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/429).  ### Errors  The API uses standard HTTP status codes to indicate whether the request succeeded or not.  In case of failure, the response body will be JSON in a predefined format. For example, trying to create too many aliases at once results in the following response:  ```json {     \"errors\": [         {             \"status\": 400,             \"title\": \"Bad request\",             \"detail\": \"Too many values (limit: 20)\",             \"href\": \"https://api.sandbox.verygoodvault.com/aliases\"         }     ] } ``` 

The version of the OpenAPI document: 1.0.0
Contact: support@verygoodsecurity.com
Generated by: https://openapi-generator.tech
OpenAPI Generator version: 5.4.0

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
    # Given a list of aliases, retrieves all associated values stored in the vault.  **NOTE:** This endpoint may expose sensitive data. Therefore, it is disabled by default. To enable it, please contact your VGS account manager or drop us a line at [support@verygoodsecurity.com](mailto:support@verygoodsecurity.com). 
    # @param q [String] Comma-separated list of aliases to reveal.
    # @param [Hash] opts the optional parameters
    # @return [InlineResponse200]
    def reveal_multiple_aliases(q, opts = {})
      data, _status_code, _headers = reveal_multiple_aliases_with_http_info(q, opts)
      data
    end

    # Reveal multiple aliases
    # Given a list of aliases, retrieves all associated values stored in the vault.  **NOTE:** This endpoint may expose sensitive data. Therefore, it is disabled by default. To enable it, please contact your VGS account manager or drop us a line at [support@verygoodsecurity.com](mailto:support@verygoodsecurity.com). 
    # @param q [String] Comma-separated list of aliases to reveal.
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
