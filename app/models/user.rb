class User < ActiveRecord::Base
	has_secure_password
	has_many :questions
	has_many :answers
	has_many :comments
	has_many :up_downs
	has_many :questions, :through => :up_downs
	has_many :up_down_answers
	has_many :answers, :through => :up_down_answers
	validates :username, presence: true, uniqueness: true
end
