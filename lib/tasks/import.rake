namespace :import do
  desc "import all images to database"
  task lyrics: :environment do
    s3 = Aws::S3::Client.new
    bucket = ENV['AWS_S3_LYRICS_BUCKET']
    resp = s3.list_objects(bucket: bucket)

    resp.contents.each do |object|
      cue = Cue.find_or_initialize_by(name: object.key)

      signer = Aws::S3::Presigner.new
      url, headers = signer.presigned_request(
        :get_object, 
        bucket: bucket, 
        key: object.key
      )

      cue.update(path: url)
    end
  end
end
