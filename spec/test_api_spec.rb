require 'spec_helper'
require 'securerandom'
require 'vgs'

describe 'AliasesApiSpec' do
  before(:all) do
    config = VGS.config(username = ENV["VAULT_API_USERNAME"], password = ENV["VAULT_API_PASSWORD"])
    @aliases_api = VGS::Aliases.new(config)
  end

  describe 'redact' do
    it 'should redact values' do
      data = [
        {
          :format => 'UUID',
          :value => '5201784564572092',
          :classifiers => %w[credit-card number],
          :storage => 'PERSISTENT',
        },
        {
          :format => 'UUID',
          :value => 'Joe Doe',
          :storage => 'VOLATILE',
        }
      ]
      aliases = @aliases_api.redact(data)
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
      data = [
        {
          :format => 'UUID',
          :value => '5201784564572092',
          :classifiers => %w[credit-card number],
          :storage => 'PERSISTENT',
        },
        {
          :format => 'UUID',
          :value => 'Joe Doe',
          :storage => 'VOLATILE',
        }
      ]
      aliases = @aliases_api.redact(data).map { |item| item.aliases[0]._alias }

      response = @aliases_api.reveal(aliases)

      expect(response.length).to eq 2
      original_values = data.map { |i| i[:value] }
      revealed_values = response.values.map { |i| i.value }
      expect(Set.new(original_values)).to eq Set.new(revealed_values)
    end
  end

  describe 'update' do
    it 'should update alias' do
      data = [
        {
          :format => 'UUID',
          :value => SecureRandom.alphanumeric(10),
        }
      ]
      _alias = @aliases_api.redact(data).map { |item| item.aliases[0]._alias }[0]

      @aliases_api.update(_alias = _alias, data = { :classifiers => ["secure"] })

      response = @aliases_api.reveal(_alias)
      expect(response[_alias].classifiers).to eq %w[secure]
    end
  end

  describe 'delete' do
    it 'should delete alias' do
      data = [
        {
          :format => 'UUID',
          :value => '5201784564572092',
        }
      ]
      _alias = @aliases_api.redact(data).map { |item| item.aliases[0]._alias }[0]

      @aliases_api.delete(_alias = _alias)

      expect { @aliases_api.reveal(_alias) }.to raise_error(VGS::VgsApiException)
    end
  end

end
