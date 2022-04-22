=begin
#Vault HTTP API

#The VGS Vault HTTP API is used for storing, retrieving, and managing sensitive data (aka Tokenization) within a VGS Vault.  The VGS API is organized around REST. Our API is built with a predictable resource-oriented structure, uses JSON-encoded requests and responses, follows standard HTTP verbs/responses, and uses industry standard authentication.  ## What is VGS  Storing sensitive data on your company’s infrastructure often comes with a heavy compliance burden. For instance, storing payments data yourself greatly increases the amount of work needed to become PCI compliant. It also increases your security risk in general. To combat this, companies will minimize the amount of sensitive information they have to handle or store.  VGS provides multiple methods for minimizing the sensitive information that needs to be stored which allows customers to secure any type of data for any use-case.  **Tokenization** is a method that focuses on securing the storage of data. This is the quickest way to get started and is free. [Get started with Tokenization](https://www.verygoodsecurity.com/docs/tokenization/getting-started).  **Zero Data** is a unique method invented by VGS in 2016 that securely stores data like Tokenization, however it also removes the customer’s environment from PCI scope completely providing maximum security, and minimum compliance scope. [Get started with Zero Data](https://www.verygoodsecurity.com/docs/getting-started/before-you-start).  Additionally, for scenarios where neither technology is a complete solution, for instance with legacy systems, VGS provides a compliance product which guarantees customers are able to meet their compliance needs no matter what may happen. [Get started with Control](https://www.verygoodsecurity.com/docs/control).  ## Learn about Tokenization  - [Create an Account for Free Tokenization](https://dashboard.verygoodsecurity.com/tokenization) - [Try a Tokenization Demo](https://www.verygoodsecurity.com/docs/tokenization/getting-started) - [Install a Tokenization SDK](https://www.verygoodsecurity.com/docs/tokenization/client-libraries)  ### Authentication  This API uses `Basic` authentication.  Credentials to access the API can be generated on the [dashboard](https://dashboard.verygoodsecurity.com) by going to the Settings section of the vault of your choosing.  [Docs » Guides » Access credentials](https://www.verygoodsecurity.com/docs/settings/access-credentials)  ## Resource Limits  ### Data Limits  This API allows storing data up to 32MB in size.  ### Rate Limiting  The API allows up to 3,000 requests per minute. Requests are associated with the vault, regardless of the access credentials used to authenticate the request.  Your current rate limit is included as HTTP headers in every API response:  | Header Name             | Description                                              | |-------------------------|----------------------------------------------------------| | `x-ratelimit-remaining` | The number of requests remaining in the 1-minute window. |  If you exceed the rate limit, the API will reject the request with HTTP [429 Too Many Requests](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/429).  ### Errors  The API uses standard HTTP status codes to indicate whether the request succeeded or not.  In case of failure, the response body will be JSON in a predefined format. For example, trying to create too many aliases at once results in the following response:  ```json {     \"errors\": [         {             \"status\": 400,             \"title\": \"Bad request\",             \"detail\": \"Too many values (limit: 20)\",             \"href\": \"https://api.sandbox.verygoodvault.com/aliases\"         }     ] } ``` 

The version of the OpenAPI document: 1.0.0
Contact: support@verygoodsecurity.com
Generated by: https://openapi-generator.tech
OpenAPI Generator version: 5.4.0

=end

# load the gem
require 'openapi_client'

# The following  was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# The generated `.rspec` file contains `--require spec_helper` which will cause
# this file to always be loaded, without a need to explicitly require it in any
# files.
#
# Given that it is always loaded, you are encouraged to keep this file as
# light-weight as possible. Requiring heavyweight dependencies from this file
# will add to the boot time of your test suite on EVERY test run, even for an
# individual file that may not need all of that loaded. Instead, consider making
# a separate helper file that requires the additional dependencies and performs
# the additional setup, and require it from the spec files that actually need
# it.
#
# The `.rspec` file also contains a few flags that are not defaults but that
# users commonly want.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

# The settings below are suggested to provide a good initial experience
# with RSpec, but feel free to customize to your heart's content.
=begin
  # These two settings work together to allow you to limit a spec run
  # to individual examples or groups you care about by tagging them with
  # `:focus` metadata. When nothing is tagged with `:focus`, all examples
  # get run.
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  # Allows RSpec to persist some state between runs in order to support
  # the `--only-failures` and `--next-failure` CLI options. We recommend
  # you configure your source control system to ignore this file.
  config.example_status_persistence_file_path = "spec/examples.txt"

  # Limits the available syntax to the non-monkey patched syntax that is
  # recommended. For more details, see:
  #   - http://rspec.info/blog/2012/06/rspecs-new-expectation-syntax/
  #   - http://www.teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
  #   - http://rspec.info/blog/2014/05/notable-changes-in-rspec-3/#zero-monkey-patching-mode
  config.disable_monkey_patching!

  # This setting enables warnings. It's recommended, but in some cases may
  # be too noisy due to issues in dependencies.
  config.warnings = true

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = 'doc'
  end

  # Print the 10 slowest examples and example groups at the
  # end of the spec run, to help surface which specs are running
  # particularly slow.
  config.profile_examples = 10

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed
=end
end
