RSpec.configure do |config|
  ActiveJob::Base.queue_adapter = :test

  config.after(:each) do
    ActiveJob::Base.queue_adapter.enqueued_jobs = []
    ActiveJob::Base.queue_adapter.performed_jobs = []
  end
end
