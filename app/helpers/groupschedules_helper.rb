module GroupschedulesHelper
		def render_group(schedule, group_number, time, day)
			user_ids = schedule["group#{group_number}_#{time}"]&.split(',') || []
			
			# 全てのグループが空の場合だけ「休み」を表示
			if user_ids.empty? && (1..3).all? { |i| schedule["group#{i}_#{time}"].nil? }
				if group_number == 3 && user_ids.empty?
				content_tag(:p, "この時間帯は休みです。")
				end
			else
				content = ''.html_safe
	
				# グループごとのユーザーを表示
				if user_ids.any?
					content << content_tag(:div, class: 'edit_groups') do
						group_content = ''.html_safe
						group_content << content_tag(:span, "<b>グループ#{group_number}　</b>".html_safe)
	
						user_ids.each do |user_id|
							user = User.find_by(id: user_id.strip)
							if user
								group_content << content_tag(:span, "#{user.nickname},")
							else
								group_content << content_tag(:p, "ユーザーが見つかりません。")
							end
						end
						games = Game.where(room_id: @room.id).order(capacity_id: :asc)

						# capacity_idに応じた説明用オプションを追加するためのフラグ
						capacity_labels = { 1 => '-- 1人用ゲーム --', 2 => '-- 2人用ゲーム --', 3 => '-- 3人用ゲーム --', 4 => '-- 4人以上 --' }
						added_capacity = { 1 => false, 2 => false, 3 => false, 4 => false }  # 各capacity_idのフラグ

						game_options = games.map do |game|
  					if capacity_labels[game.capacity_id] && !added_capacity[game.capacity_id]
   					 added_capacity[game.capacity_id] = true
 						 content_tag(:option, capacity_labels[game.capacity_id], value: '') + content_tag(:option, game.game_name, value: game.id)
  					else
   					 content_tag(:option, game.game_name, value: game.id)
  					end
						end
						 all_options = game_options.join.html_safe
						 group_content << select_tag("group#{group_number}_#{time}_day#{day + 1}",all_options,prompt: 'このグループのゲームを選択',class: 'small-select')
						 group_content
					end
				end
	
				# 未プレイのゲームを表示
				if user_ids.any?
					content << content_tag(:div, class: 'edit_unplay_games') do
						unplayed_games_content = ''.html_safe
						unplayed_games_content << content_tag(:span, "<b>未プレイのゲーム　</b>".html_safe)
	
						games = Game.where(user_id: user_ids).select { |game| (game.played.to_s.split(',') & user_ids).empty? }
						if games.any?
							unplayed_games_content << content_tag(:ul) do
								games.map { |game| content_tag(:span, "#{game.game_name},") }.join.html_safe
							end
						else
							unplayed_games_content << content_tag(:p, "未プレイのゲームはありません。")
						end
	
						unplayed_games_content
					end
				end
	
				content
			end
		end

		
	end
	