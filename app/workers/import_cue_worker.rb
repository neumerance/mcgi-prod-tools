class ImportCueWorker
  include Sidekiq::Worker

  def perform(continuation_token = nil)
    resp = Aws::S3::Client.new.list_objects_v2(
      bucket: ENV['AWS_S3_LYRICS_BUCKET'],
      continuation_token: continuation_token
    )

    resp.contents.each do |object|
      Cue.find_or_create_by(name: object.key)
    end

    if next_cont_token = resp.next_continuation_token
      self.class.perform_async(next_cont_token)
    end
  end
end
