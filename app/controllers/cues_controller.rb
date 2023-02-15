class CuesController < ApplicationController
  def index
    cues =  if params[:keyword]
              Cue.where("lower(name) LIKE ?", "%#{URI.decode(params[:keyword].downcase)}%").limit(10)
            else
              Cue.limit(10)
            end

    render json: CueSerializer.new(cues).serialized_json
  end
end
