RSpec.shared_examples 'job enqueable', type: :job do |queue_name, job_args|
  it 'enqueues job with provided args' do
    expect do
      described_class.perform_later(*job_args)
    end.to have_enqueued_job(described_class).with(*job_args)
  end

  it "enqueues job on #{queue_name} queue" do
    expect do
      described_class.perform_later(*job_args)
    end.to have_enqueued_job.on_queue(queue_name)
  end
end
