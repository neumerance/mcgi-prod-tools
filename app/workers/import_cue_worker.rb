class ImportCueWorker
  include Sidekiq::Worker

  def perform
    s3 = Aws::S3::Client.new
    resp = s3.list_objects(bucket: ENV['AWS_S3_LYRICS_BUCKET'])

    resp.contents.each do |object|
      Cue.find_or_create_by(name: object.key)
    end
  end
end
