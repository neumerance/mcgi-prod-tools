class CuesController < ApplicationController
  DEFAULT_LINEUP = [
    "001 - Fil, EN, BP, ES - CUT .jpg",
    "MCGI (Kristiyano Ako, Kristiyano Tayo) - Fil, EN, BP, ES.jpg",
    "Ama Salamat (Tanging Maiaalay).jpg",
    "Araw ng Parangal at Pagpupugay (Updated).jpg",
    "Papuri, Luwalhati (ADD anniv)- F.jpg",
    "Alay sa Dakilang Tumawag.jpg",
    "Tayo'y Magsiawit.jpg",
    "Sagot sa Kabalisahan.jpg",
    "Purihin at Pasalamatan - F.jpg",
    "Ito ang Araw.jpg",
    "Awit Ng Pagpapasalamat.jpg",
    "Hallelujah, Amen - F.jpg",
    "Stand Up - F.jpg", 
    "Kaibigan.jpg",
    "Obladi, Oblada.jpg"
  ].freeze
  
  def index
    cues =  if params[:keyword]
              Cue.where("lower(name) LIKE ?", "%#{URI.decode(params[:keyword].downcase)}%")
            else
              Cue.where(name: DEFAULT_LINEUP)
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
