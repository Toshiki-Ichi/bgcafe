class Capacity < ActiveHash::Base
	self.data = [
		{ id: 0, name: '---' },
		{ id: 1, name: '1人' },
		{ id: 2, name: '2人〜' },
		{ id: 3, name: '3人〜' },
		{ id: 4, name: '4人〜' },
	]
		include ActiveHash::Associations
  	has_many :games
end
