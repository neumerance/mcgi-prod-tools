class CueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :path
end
