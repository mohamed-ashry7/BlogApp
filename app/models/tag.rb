class Tag < ApplicationRecord

    validates :tag, presence: true
    has_and_belongs_to_many :posts
end
