class FakeJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    puts "Starting fake job"
    sleep 3
    puts "Finished!"
  end
end
