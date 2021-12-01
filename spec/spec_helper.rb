if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start 'rails' do
    minimum_coverage 90
    add_filter [
      %r{app/jobs/.*job\.rb}
    ]
    add_filter do |source_file|
      source_file.lines.count < 6
    end
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
