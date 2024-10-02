class Career < ActiveHash::Base
	self.data = [
		{ id: 1, name: '---' },
		{ id: 2, name: '初めて！' },
		{ id: 3, name: '一年未満' },
		{ id: 4, name: '二年未満' },
		{ id: 5, name: '三年未満' },
		{ id: 6, name: '三年以上' },
	]
		include ActiveHash::Associations
  	has_many :users
end
