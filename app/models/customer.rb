class Customer < ApplicationRecord
    validates :dob, :name,  presence: true, length: { maximum: 30 }
    validates :phone, length: { is: 10 }
end
