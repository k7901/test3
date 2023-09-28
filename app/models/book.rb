class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :title,  presence: true
  validates :body, length: {  maximum: 200 }, presence: true
end
