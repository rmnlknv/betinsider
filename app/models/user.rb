class User < ActiveRecord::Base
	has_many :purchases
  has_many :predictions, through: :purchases

  has_many :subscribes
  has_many :subscriptions, through: :subscribes

	validates :terms, :acceptance => true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, 
         :rememberable, 
         :trackable, 
         :validatable
         #:confirmable



end
