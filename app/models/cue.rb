class Cue < ApplicationRecord
  validates :name, :path, presence: true
  validates :name, uniqueness: true
end
