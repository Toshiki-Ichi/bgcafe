class Frequency < ActiveHash::Base
	self.data = [
		{ id: 0, name: '---' },
		{ id: 1, name: '1回' },
		{ id: 2, name: '2回' },
		{ id: 3, name: '3回' },
		{ id: 4, name: '4回' },
		{ id: 5, name: '5回' },
		{ id: 6, name: '今週は遊べない' },

	]
		include ActiveHash::Associations
  	has_many :ownplans
end
