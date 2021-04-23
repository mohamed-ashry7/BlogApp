
class PostRemoveWorker
    include Sidekiq::Worker
    sidekiq_options retry: false
    def perform(id)
      Post.find(:id).destroy
    end
end