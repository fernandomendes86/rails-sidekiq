class AddEndangeredWorker
  require 'csv'
  include Sidekiq::Worker 
  sidekiq_options retry: false

  def perform(csv_file)  
    CSV.foreach(csv_file, headers: true) do |shark|
      10.times do |i|
        Endangered.create(name: "#{shark[0]} - #{i}", iucn: shark[1])
      end
    end
  end
end