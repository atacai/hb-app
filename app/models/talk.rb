class Talk < ApplicationRecord
  belongs_to :session
  belongs_to :proposal
end
