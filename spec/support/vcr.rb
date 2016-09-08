VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.default_cassette_options = {
    record: :new_episodes,
    match_requests_on: [
      :method,
      VCR.request_matchers.uri_without_params(:timestamp, :key)
    ]
  }
  config.configure_rspec_metadata!
  config.ignore_localhost = true
end
