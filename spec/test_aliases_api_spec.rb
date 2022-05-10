require 'spec_helper'
require 'securerandom'
require 'vgs_api_client'

describe 'AliasesApiSpec' do
  before(:each) do
    config = VGS.config(username = ENV['VAULT_API_USERNAME'], password = ENV['VAULT_API_PASSWORD'])
    @api = VGS::Aliases.new config
  end

  describe 'invalid auth' do
    it 'should fail if invalid auth provided' do
      invalid_config = VGS.config(username = 'Invalid', password = 'Invalid')
      api = VGS::Aliases.new invalid_config
      data = [{
                format: 'UUID',
                value: 'Joe Doe'
              }]

      expect { api.redact data }.to raise_error(VGS::UnauthorizedError)
    end
  end

  describe 'invalid config' do
    it 'should fail if invalid config provided' do
      expect { VGS::Aliases.new nil }.to raise_error(ArgumentError)
    end
  end

  describe 'invalid host' do
    it 'should fail if invalid host provided' do
      config = VGS.config(
        username = ENV['VAULT_API_USERNAME'],
        password = ENV['VAULT_API_PASSWORD'],
        host = 'https://echo.apps.verygood.systems')
      api = VGS::Aliases.new config
      data = [{
                format: 'UUID',
                value: 'Joe Doe'
              }]
      expect { api.redact data }.to raise_error(VGS::NotFoundError)
    end
  end

  describe 'redact' do
    it 'should redact values' do
      data = [{
                format: 'UUID',
                value: '5201784564572092',
                classifiers: %w[credit-card number],
                storage: 'PERSISTENT'
              },
              {
                format: 'UUID',
                value: 'Joe Doe',
                storage: 'VOLATILE'
              }]
      aliases = @api.redact data
      expect(aliases.length).to eq 2
      data.each_with_index do |item, index|
        expect(aliases[index].value).to eq item[:value]
        expect(aliases[index].storage).to eq item[:storage]
        expect(aliases[index].aliases[0]._alias).to start_with "tok_"
      end
      expect(Set.new(aliases[0].classifiers)).to eq Set.new(%w[credit-card number])
      expect(Set.new(aliases[1].classifiers)).to eq Set.new
    end
  end

  describe 'reveal' do
    it 'should reveal aliases' do
      data = [{
                format: 'UUID',
                value: '5201784564572092',
                classifiers: %w[credit-card number],
                storage: 'PERSISTENT'
              },
              {
                format: 'UUID',
                value: 'Joe Doe',
                storage: 'VOLATILE'
              }]
      aliases = @api.redact(data).map { |item| item.aliases[0]._alias }

      response = @api.reveal aliases

      expect(response.length).to eq 2
      original_values = data.map { |i| i[:value] }
      revealed_values = response.values.map { |i| i.value }
      expect(Set.new original_values).to eq Set.new revealed_values
    end
  end

  describe 'update' do
    it 'should update alias' do
      data = [{
                format: 'UUID',
                value: SecureRandom.alphanumeric(10)
              }]
      _alias = @api.redact(data).map { |item| item.aliases[0]._alias }[0]

      @api.update _alias, classifiers: %w[secure]

      response = @api.reveal _alias
      expect(response[_alias].classifiers).to eq %w[secure]
    end
  end

  describe 'delete' do
    it 'should delete alias' do
      data = [{
                format: 'UUID',
                value: '5201784564572092'
              }]
      _alias = @api.redact(data).map { |item| item.aliases[0]._alias }[0]

      @api.delete _alias

      expect { @api.reveal _alias }.to raise_error(VGS::VgsApiError)
    end
  end

end
