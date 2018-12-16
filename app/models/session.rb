class Session < ApplicationRecord
  belongs_to :track
  has_many :talks
end
