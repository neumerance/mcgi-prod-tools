class PreSignedCueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id

  attribute :title, &:name
  attribute :src do |object|
    signer = Aws::S3::Presigner.new
    url, headers = signer.presigned_request(
      :get_object, 
      bucket: ENV['AWS_S3_LYRICS_BUCKET'], 
      key: object.name
    )

    url
  end
end
