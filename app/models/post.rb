class Post < ApplicationRecord
    validates :title, presence: true
    validates :body, presence: true
    has_many :comments, dependent: :destroy
    has_and_belongs_to_many :tags
    belongs_to :user
end
