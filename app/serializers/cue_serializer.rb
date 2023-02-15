class CueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id

  attribute :title, &:name
  attribute :src do |object|
    "#{ENV['BASE_URL']}#{object.path}"
  end
end
