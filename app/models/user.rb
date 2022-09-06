# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  enum :role, {admin: 0, sports_partner: 1, user: 2}, default:2

  # validates :mobile_number,
  #           uniqueness: true,
  #           # :presence => true,
  #           :numericality => true,
  #           :length => { :minimum => 10, :maximum => 15 }

  #relationships
  has_many :bookings
  has_many :sports_complexes, through: :bookings
  has_many :sports_complexes
  has_many :order_details
  has_many :product_reviews
  has_many :stores
  has_many :transaction_details
  belongs_to :team, optional: true
  has_many :otps

  def email_required?
    false
  end
end
