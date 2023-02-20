class CuesController < ApplicationController
  def index
    cues =  if params[:keyword]
              Cue.where("lower(name) LIKE ?", "%#{URI.decode(params[:keyword].downcase)}%").limit(5)
            else
              Cue.limit(10)
            end

    render json: CueSerializer.new(cues).serialized_json
  end

  def show
    cue = Cue.find params[:id]

    render json: PreSignedCueSerializer.new(cue).serialized_json
  end

  def generate
    s3 = Aws::S3::Client.new
    resp = s3.list_objects(bucket: ENV['AWS_S3_LYRICS_BUCKET'])

    resp.contents.each do |object|
      Cue.find_or_create_by(name: object.key)
    end
  end
end
