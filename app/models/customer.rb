class Customer < ApplicationRecord
    validates :dob, :name,  presence: true, length: { maximum: 30 }
end
