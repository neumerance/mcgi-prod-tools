class CueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id

  attribute :title, &:name
end
