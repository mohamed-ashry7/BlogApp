class User < ApplicationRecord

    has_secure_password
    validates :name, presence: true
    validates :email, presence: true
    validates :password, presence: true
    validates :image, presence: true
    has_many :comments, dependent: :destroy
    has_many :posts, dependent: :destroy


end