require 'openapi_client'

module VGS
  class VgsApiError < StandardError
  end

  class UnauthorizedError < VgsApiError
  end

  class NotFoundError < VgsApiError
  end

  class ForbiddenError < VgsApiError
  end

  class Aliases
    def initialize(config)
      raise ArgumentError, 'config is nil' if config.nil?
      @aliases_api = VgsApiClient::AliasesApi.new(VgsApiClient::ApiClient.new(config))
    end

    private def map_exception(message, error)
      error_message = message
      if error.is_a? VgsApiClient::ApiError
        error_message += ". Details: #{error.message}"
        case error.code
        when 401
          UnauthorizedError.new error_message
        when 403
          ForbiddenError.new error_message
        when 404
          NotFoundError.new error_message
        else
          VgsApiError.new error_message
        end
      else
        VgsApiError.new error_message
      end
    end

    def redact(data)
      begin
        requests = data.map do |item|
          VgsApiClient::CreateAliasesRequestNew.new(attributes = {
            :format => VgsApiClient::AliasFormat.build_from_hash(item[:format] || "UUID"),
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
      rescue Exception => e
        raise map_exception("Failed to redact data #{ data }", e)
      else
        response.data
      end
    end

    def reveal(aliases)
      begin
        query = aliases.kind_of?(Array) ? aliases.join(",") : aliases
        response = @aliases_api.reveal_multiple_aliases(q = query)
      rescue Exception => e
        raise map_exception("Failed to reveal aliases #{ aliases }", e)
      else
        response.data
      end
    end

    def delete(_alias)
      begin
        @aliases_api.delete_alias(_alias = _alias)
      rescue Exception => e
        raise map_exception("Failed to delete alias #{ _alias }", e)
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
      rescue Exception => e
        raise map_exception("Failed to update alias #{ _alias }", e)
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
    config.server_index = nil
    config
  end
end
