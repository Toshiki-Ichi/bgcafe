class RequireTime < ActiveHash::Base
	self.data = [
		{ id: 1, name: '---' },
		{ id: 2, name: '1時間未満' },
		{ id: 3, name: '1〜2時間' },
		{ id: 4, name: '3〜4時間' },
		{ id: 5, name: '4時間以上' },
	]
		include ActiveHash::Associations
  	has_many :games
end
