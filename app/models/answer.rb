class Answer < ActiveRecord::Base
	belongs_to :question
	has_many :comments
	belongs_to :user
	has_many :up_down_answers
	has_many :users, :through => :up_down_answers
end
