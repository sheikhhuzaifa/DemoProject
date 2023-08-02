# frozen_string_literal: true

# User
class User < ApplicationRecord
  validates :email, presence: true
  validates :password, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :username,presence: true

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_one_attached :image
  has_many :projects, foreign_key: "assigned_manager_id", dependent: :destroy

  enum role: {
    Super_Admin: "Super_Admin",
    Business_Developer: "Business_Developer",
    Technical_Manager: "Technical_Manager",
    Engineer: "Engineer"
  }
end
