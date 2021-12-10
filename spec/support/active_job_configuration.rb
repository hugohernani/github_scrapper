module JobTransactionAdapter
  def perform_enqueue_jobs
    around do |example|
      perform_enqueued_jobs do
        example.run
      end
    end
  end
end

RSpec.configure do |config|
  config.extend JobTransactionAdapter
  config.include ActiveJob::TestHelper
end
