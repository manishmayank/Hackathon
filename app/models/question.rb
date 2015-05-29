class Question < ActiveRecord::Base
	has_many :answers
	belongs_to :user
	has_many :comments
	has_and_belongs_to_many :tags
	has_many :up_downs
	has_many :users, :through => :up_downs
	self.per_page = 10
end
