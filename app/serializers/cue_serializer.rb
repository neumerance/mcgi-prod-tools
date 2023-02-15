class CueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id

  attribute :title, &:name
  attribute :src do |object|
    "http://localhost:5000#{object.path}"
  end
end
