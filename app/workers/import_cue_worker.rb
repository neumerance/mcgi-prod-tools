class ImportCueWorker
  include Sidekiq::Worker

  def perform
    resp = s3.list_objects_v2(bucket: ENV['AWS_S3_LYRICS_BUCKET'])

    resp.contents.each do |object|
      Cue.find_or_create_by(name: object.key)
    end
  end

  private

  def import_cues(continuation_token = nil)
    resp = s3.list_objects_v2(
      bucket: ENV['AWS_S3_LYRICS_BUCKET'],
      continuation_token: continuation_token
    )

    resp.contents.each do |object|
      Cue.find_or_create_by(name: object.key)
    end

    if next_cont_token = resp.next_continuation_token
      import_cues(next_cont_token)
    end
  end

  def s3
    @s3 = Aws::S3::Client.new
  end
end
