class CueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id

  attribute :title, &:name
  attribute :src, &:path
end
