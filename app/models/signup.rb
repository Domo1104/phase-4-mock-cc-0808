class Signup < ApplicationRecord
    validates :time, numericality: { in: 0..23 }

    belongs_to :camper
    belongs_to :activity
end
