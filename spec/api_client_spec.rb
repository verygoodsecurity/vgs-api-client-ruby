=begin
#Vault HTTP API

#Storing, retrieving, and managing sensitive data within a VGS organization.  **NOTE:** _The Vault API is intended only for environments that are already PCI-compliant. If you want to use this API, but are not yet PCI-compliant, you can use [VGS Collect](https://www.verygoodsecurity.com/docs/vgs-collect/what-is-it) or VGS Proxy with [Inbound Routes](https://www.verygoodsecurity.com/docs/getting-started/quick-integration#securing-inbound-connection) to quickly and seamlessly achieve compliance._  Looking for the old version of the API? Find it [here](https://www.verygoodsecurity.com/docs/api/1/vault).  # Introduction  Each encrypted value stored in a VGS vault has one or multiple _aliases_ associated with it. These aliases are fully opaque and retain no information about the underlying data. The user may safely store aliases without compromising data security.  **NOTE:** The API works with persistent storage only. Unlike volatile storage, this means that the data is stored permanently, without any implicit TTL.  Aliases are not valuable on their own. However, they can be used to decrypt the associated value and pass it to another service via the [forward proxy](https://www.verygoodsecurity.com/docs/guides/outbound-connection).  ## Alias Formats  Each alias corresponds to a certain format. There are several alias formats suitable for different kinds of sensitive data.  For example, `UUID` produces a random Base58-encoded UUID string with an environment-dependent prefix:  ``` tok_sandbox_bhtsCwFUzoJMw9rWUfEV5e ```  This format is generic and suitable for any kind of data.  The tables below contain descriptions of all alias formats recognized by the API.  ### Generic Formats  | Value                   | Description                                           | |-------------------------|-------------------------------------------------------| | `NUM_LENGTH_PRESERVING` | Length-Preserving, Numeric                            | | `RAW_UUID`              | UUID                                                  | | `UUID`                  | UUID (Prefixed, Base58-Encoded)                       | | `GENERIC_T_FOUR`        | UUID (Prefixed, Base58-Encoded, Last four preserving) |  ### Account Number Formats  | Value                             | Description                          | |-----------------------------------|--------------------------------------| | `FPE_ACC_NUM_T_FOUR`              | Length-Preserving, Numeric (A4)      | | `FPE_ALPHANUMERIC_ACC_NUM_T_FOUR` | Length-Preserving, Alphanumeric (A4) |   ### Payment Card Formats  | Value            | Description                                 | |------------------|---------------------------------------------| | `FPE_SIX_T_FOUR` | Format-Preserving, Luhn Valid (6T4)         | | `FPE_T_FOUR`     | Format-Preserving, Luhn Valid (T4)          | | `PFPT`           | Prefixed, Luhn Valid, 19-Digit Fixed Length |  ### SSN Formats  | Value            | Description            | |------------------|------------------------| | `FPE_SSN_T_FOUR` | Format-Preserving (A4) |  # Authentication  This API uses `Basic` authentication.  Credentials to access the API can be generated on the [dashboard](https://dashboard.verygoodsecurity.com) by going to the Settings section of the vault of your choosing.  [Docs » Guides » Access credentials](https://www.verygoodsecurity.com/docs/settings/access-credentials)  # Rate Limiting  The API allows up to 3,000 requests per minute. Requests are associated with the vault, regardless of the access credentials used to authenticate the request.  Your current rate limit is included as HTTP headers in every API response:  | Header Name             | Description                                              | |-------------------------|----------------------------------------------------------| | `x-ratelimit-remaining` | The number of requests remaining in the 1-minute window. |  If you exceed the rate limit, the API will reject the request with HTTP [429 Too Many Requests](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/429).  # Errors  The API uses standard HTTP status codes to indicate whether the request succeeded or not.  In case of failure, the response body will be JSON in a predefined format. For example, trying to create too many aliases at once results in the following response:  ```json {     \"errors\": [         {             \"status\": 400,             \"title\": \"Bad request\",             \"detail\": \"Too many values (limit: 20)\",             \"href\": \"https://api.sandbox.verygoodvault.com/aliases\"         }     ] } ``` 

The version of the OpenAPI document: 1.0.0
Contact: support@verygoodsecurity.com
Generated by: https://openapi-generator.tech
OpenAPI Generator version: 5.0.1-SNAPSHOT

=end

require 'spec_helper'

describe VgsApiClient::ApiClient do
  context 'initialization' do
    context 'URL stuff' do
      context 'host' do
        it 'removes http from host' do
          VgsApiClient.configure { |c| c.host = 'http://example.com' }
          expect(VgsApiClient::Configuration.default.host).to eq('example.com')
        end

        it 'removes https from host' do
          VgsApiClient.configure { |c| c.host = 'https://wookiee.com' }
          expect(VgsApiClient::ApiClient.default.config.host).to eq('wookiee.com')
        end

        it 'removes trailing path from host' do
          VgsApiClient.configure { |c| c.host = 'hobo.com/v4' }
          expect(VgsApiClient::Configuration.default.host).to eq('hobo.com')
        end
      end

      context 'base_path' do
        it "prepends a slash to base_path" do
          VgsApiClient.configure { |c| c.base_path = 'v4/dog' }
          expect(VgsApiClient::Configuration.default.base_path).to eq('/v4/dog')
        end

        it "doesn't prepend a slash if one is already there" do
          VgsApiClient.configure { |c| c.base_path = '/v4/dog' }
          expect(VgsApiClient::Configuration.default.base_path).to eq('/v4/dog')
        end

        it "ends up as a blank string if nil" do
          VgsApiClient.configure { |c| c.base_path = nil }
          expect(VgsApiClient::Configuration.default.base_path).to eq('')
        end
      end
    end
  end

  describe 'params_encoding in #build_request' do
    let(:config) { VgsApiClient::Configuration.new }
    let(:api_client) { VgsApiClient::ApiClient.new(config) }

    it 'defaults to nil' do
      expect(VgsApiClient::Configuration.default.params_encoding).to eq(nil)
      expect(config.params_encoding).to eq(nil)

      request = api_client.build_request(:get, '/test')
      expect(request.options[:params_encoding]).to eq(nil)
    end

    it 'can be customized' do
      config.params_encoding = :multi
      request = api_client.build_request(:get, '/test')
      expect(request.options[:params_encoding]).to eq(:multi)
    end
  end

  describe 'timeout in #build_request' do
    let(:config) { VgsApiClient::Configuration.new }
    let(:api_client) { VgsApiClient::ApiClient.new(config) }

    it 'defaults to 0' do
      expect(VgsApiClient::Configuration.default.timeout).to eq(0)
      expect(config.timeout).to eq(0)

      request = api_client.build_request(:get, '/test')
      expect(request.options[:timeout]).to eq(0)
    end

    it 'can be customized' do
      config.timeout = 100
      request = api_client.build_request(:get, '/test')
      expect(request.options[:timeout]).to eq(100)
    end
  end

  describe '#deserialize' do
    it "handles Array<Integer>" do
      api_client = VgsApiClient::ApiClient.new
      headers = { 'Content-Type' => 'application/json' }
      response = double('response', headers: headers, body: '[12, 34]')
      data = api_client.deserialize(response, 'Array<Integer>')
      expect(data).to be_instance_of(Array)
      expect(data).to eq([12, 34])
    end

    it 'handles Array<Array<Integer>>' do
      api_client = VgsApiClient::ApiClient.new
      headers = { 'Content-Type' => 'application/json' }
      response = double('response', headers: headers, body: '[[12, 34], [56]]')
      data = api_client.deserialize(response, 'Array<Array<Integer>>')
      expect(data).to be_instance_of(Array)
      expect(data).to eq([[12, 34], [56]])
    end

    it 'handles Hash<String, String>' do
      api_client = VgsApiClient::ApiClient.new
      headers = { 'Content-Type' => 'application/json' }
      response = double('response', headers: headers, body: '{"message": "Hello"}')
      data = api_client.deserialize(response, 'Hash<String, String>')
      expect(data).to be_instance_of(Hash)
      expect(data).to eq(:message => 'Hello')
    end
  end

  describe "#object_to_hash" do
    it 'ignores nils and includes empty arrays' do
      # uncomment below to test object_to_hash for model
      # api_client = VgsApiClient::ApiClient.new
      # _model = VgsApiClient::ModelName.new
      # update the model attribute below
      # _model.id = 1
      # update the expected value (hash) below
      # expected = {id: 1, name: '', tags: []}
      # expect(api_client.object_to_hash(_model)).to eq(expected)
    end
  end

  describe '#build_collection_param' do
    let(:param) { ['aa', 'bb', 'cc'] }
    let(:api_client) { VgsApiClient::ApiClient.new }

    it 'works for csv' do
      expect(api_client.build_collection_param(param, :csv)).to eq('aa,bb,cc')
    end

    it 'works for ssv' do
      expect(api_client.build_collection_param(param, :ssv)).to eq('aa bb cc')
    end

    it 'works for tsv' do
      expect(api_client.build_collection_param(param, :tsv)).to eq("aa\tbb\tcc")
    end

    it 'works for pipes' do
      expect(api_client.build_collection_param(param, :pipes)).to eq('aa|bb|cc')
    end

    it 'works for multi' do
      expect(api_client.build_collection_param(param, :multi)).to eq(['aa', 'bb', 'cc'])
    end

    it 'fails for invalid collection format' do
      expect { api_client.build_collection_param(param, :INVALID) }.to raise_error(RuntimeError, 'unknown collection format: :INVALID')
    end
  end

  describe '#json_mime?' do
    let(:api_client) { VgsApiClient::ApiClient.new }

    it 'works' do
      expect(api_client.json_mime?(nil)).to eq false
      expect(api_client.json_mime?('')).to eq false

      expect(api_client.json_mime?('application/json')).to eq true
      expect(api_client.json_mime?('application/json; charset=UTF8')).to eq true
      expect(api_client.json_mime?('APPLICATION/JSON')).to eq true

      expect(api_client.json_mime?('application/xml')).to eq false
      expect(api_client.json_mime?('text/plain')).to eq false
      expect(api_client.json_mime?('application/jsonp')).to eq false
    end
  end

  describe '#select_header_accept' do
    let(:api_client) { VgsApiClient::ApiClient.new }

    it 'works' do
      expect(api_client.select_header_accept(nil)).to be_nil
      expect(api_client.select_header_accept([])).to be_nil

      expect(api_client.select_header_accept(['application/json'])).to eq('application/json')
      expect(api_client.select_header_accept(['application/xml', 'application/json; charset=UTF8'])).to eq('application/json; charset=UTF8')
      expect(api_client.select_header_accept(['APPLICATION/JSON', 'text/html'])).to eq('APPLICATION/JSON')

      expect(api_client.select_header_accept(['application/xml'])).to eq('application/xml')
      expect(api_client.select_header_accept(['text/html', 'application/xml'])).to eq('text/html,application/xml')
    end
  end

  describe '#select_header_content_type' do
    let(:api_client) { VgsApiClient::ApiClient.new }

    it 'works' do
      expect(api_client.select_header_content_type(nil)).to eq('application/json')
      expect(api_client.select_header_content_type([])).to eq('application/json')

      expect(api_client.select_header_content_type(['application/json'])).to eq('application/json')
      expect(api_client.select_header_content_type(['application/xml', 'application/json; charset=UTF8'])).to eq('application/json; charset=UTF8')
      expect(api_client.select_header_content_type(['APPLICATION/JSON', 'text/html'])).to eq('APPLICATION/JSON')
      expect(api_client.select_header_content_type(['application/xml'])).to eq('application/xml')
      expect(api_client.select_header_content_type(['text/plain', 'application/xml'])).to eq('text/plain')
    end
  end

  describe '#sanitize_filename' do
    let(:api_client) { VgsApiClient::ApiClient.new }

    it 'works' do
      expect(api_client.sanitize_filename('sun')).to eq('sun')
      expect(api_client.sanitize_filename('sun.gif')).to eq('sun.gif')
      expect(api_client.sanitize_filename('../sun.gif')).to eq('sun.gif')
      expect(api_client.sanitize_filename('/var/tmp/sun.gif')).to eq('sun.gif')
      expect(api_client.sanitize_filename('./sun.gif')).to eq('sun.gif')
      expect(api_client.sanitize_filename('..\sun.gif')).to eq('sun.gif')
      expect(api_client.sanitize_filename('\var\tmp\sun.gif')).to eq('sun.gif')
      expect(api_client.sanitize_filename('c:\var\tmp\sun.gif')).to eq('sun.gif')
      expect(api_client.sanitize_filename('.\sun.gif')).to eq('sun.gif')
    end
  end
end
