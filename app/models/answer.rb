class Answer < ActiveRecord::Base
	belongs_to :question
	has_many :comments
	belongs_to :user
end
