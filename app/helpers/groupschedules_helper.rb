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


		def render_groups(day_conditions, time_period, n, ownplans)
			found_members = []
	
			ownplans.each do |ownplan|
				if day_conditions.include?(ownplan["day#{n + 1}"])
					found_members << { name: ownplan.user.nickname, wants_solo: ownplan["day#{n + 1}"] == day_conditions.last, id: ownplan.user.id }
				end
			end
	
			solo_members = found_members.select { |member| member[:wants_solo] }
			non_solo_members = found_members.reject { |member| member[:wants_solo] }
			total_members = found_members.size
	
			return "<span>　作成できるグループの組み合わせがありません</span>" if total_members < 2
	
			group_found = false
			output = ""
	
			solo_members.each do |solo_member|
				non_solo_members.each do |non_solo_member|
					all_members = [solo_member[:id], non_solo_member[:id]]
					played_games = Game.where("played LIKE ?", "%#{solo_member[:id]}%").or(Game.where("played LIKE ?", "%#{non_solo_member[:id]}%"))
	
					if Game.where(user_id: all_members).exists?
						unplayed_games = Game.where.not(id: played_games.pluck(:id)).where(user_id: all_members)
	
						next unless Game.where(user_id: all_members).exists?
	
						output << content_tag(:div, class: "schedule_check") do
							concat label_tag "member_#{solo_member[:id]}" do
								content_tag(:h6, "・#{solo_member[:name]}(タイマン希望)、#{non_solo_member[:name]}")
							end
							concat content_tag(:div, check_box_tag("groupschedules[day#{n + 1}_#{time_period}][member_ids][]", "#{solo_member[:id]},#{non_solo_member[:id]}"), class: "check_box")
						end
	
						if unplayed_games.any?
							output << "<span>　未プレイのゲーム:</span><ul>"
							unplayed_games.each do |game|
								output << "<span>#{game.game_name}</span>"
							end
							output << "</ul><br/>"
						else
							output << "<span>　このグループでプレイできるゲームがありません。</span>"
						end
	
						group_found = true
					end
				end
			end
	
			output << "<span>　作成できるグループの組み合わせがありません</span>" unless group_found
			output.html_safe
		end



	end
	