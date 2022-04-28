require 'openapi_client'

module VGS
  class VgsApiException < StandardError
  end

  class Aliases
    def initialize(config)
      @aliases_api = VgsApiClient::AliasesApi.new(VgsApiClient::ApiClient.new(config))
    end

    def redact(data)
      begin
        requests = data.map do |item|
          VgsApiClient::CreateAliasesRequestNew.new(attributes = {
            :format => VgsApiClient::AliasFormat.build_from_hash(item[:format]),
            :classifiers => item[:classifiers],
            :value => item[:value],
            :storage => item[:storage]
          })
        end

        create_aliases_request = VgsApiClient::CreateAliasesRequest.new(attributes = {
          :data => requests
        })
        response = @aliases_api.create_aliases(opts = {
          :create_aliases_request => create_aliases_request.to_hash
        })

      rescue
        raise VgsApiException, "Failed to redact data #{ data }"
      else
        response.data
      end
    end

    def reveal(aliases)
      begin
        query = aliases.kind_of?(Array) ? aliases.join(",") : aliases
        response = @aliases_api.reveal_multiple_aliases(q = query)
      rescue
        raise VgsApiException, "Failed to reveal aliases #{ aliases }"
      else
        response.data
      end
    end

    def delete(_alias)
      begin
        @aliases_api.delete_alias(_alias = _alias)
      rescue
        raise VgsApiException, "Failed to delete alias #{ _alias }"
      end
    end

    def update(_alias, data)
      begin
        update_alias_request = VgsApiClient::UpdateAliasRequest.new(attributes = {
          :data => VgsApiClient::UpdateAliasRequestData.new(attributes = {
            :classifiers => data[:classifiers]
          })
        })
        @aliases_api.update_alias(_alias = _alias, opts = {
          :update_alias_request => update_alias_request.to_hash
        })
      rescue
        raise VgsApiException, "Failed to update alias #{ _alias }"
      end
    end
  end

  def self.config(username, password, host = 'https://api.sandbox.verygoodvault.com')
    raise ArgumentError, 'username is nil' if username.nil?
    raise ArgumentError, 'password is nil' if password.nil?

    config = VgsApiClient::Configuration.default
    config.username = username
    config.password = password
    config.host = host
    config
  end
end
