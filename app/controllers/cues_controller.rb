class CuesController < ApplicationController
  def index
    cues =  if params[:keyword]
              Cue.where("lower(name) LIKE ?", "%#{URI.decode(params[:keyword].downcase)}%")
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
    ImportCueWorker.perform_async

    render json: { message: 'import is on its way' }
  end
end
