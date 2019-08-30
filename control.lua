script.on_init(
	function ()
		global.boxes = {}
		global.to_display = {}
	end
)

script.on_event({defines.events.on_player_joined_game},
	function (e)
		local player = game.players[e.player_index]
		if player.gui.screen["showme-name-frame"] ~= nil then
			return
		end
		local showme_name_frame = player.gui.screen.add {
			type = "frame",
			name = "showme-name-frame",
			caption = "Enter a name",
			direction = "horizontal",
			auto_center = true
		}
		showme_name_frame.visible = false
		showme_name_frame.add {
			type = "textfield",
			name = "showme-name-box",
			numeric = false,
			loose_focus_on_confirm = true
		}
		showme_name_frame.add {
			type = "button",
			name = "showme-name-confirm",
			caption = "Ok"
		}
		showme_name_frame.force_auto_center()
	end
)

local function player_selected_area(e, name_text)
	local player = game.players[e.player_index]
	local ttl = settings.get_player_settings(player)["showme-box-duration"].value
	local line_width = settings.get_player_settings(player)["showme-box-line-width"].value
	local lt = e.area.left_top
	local rb = e.area.right_bottom
	local rect_id = rendering.draw_rectangle {
		color = player.color,
		width = line_width,
		filled = false,
		left_top = lt,
		right_bottom = rb,
		surface = player.surface,
		time_to_live = ttl,
		forces = {player.force}
	}
	local line_id = rendering.draw_line {
		color = { r = 1 - player.color.r, g = 1 - player.color.g, b = 1 - player.color.b },
		width = line_width,
		from = {x = lt.x, y = rb.y},
		to = {x = lt.x, y = lt.y},
		surface = player.surface,
		time_to_live = ttl,
		forces = {player.force}
	}
	if name_text ~= nil then
		rendering.draw_text {
			text = name_text,
			surface = player.surface,
			target = {lt.x, rb.y + 0.5},
			color = {r = 1, g = 1, b = 1},
			time_to_live = ttl,
			scale = 2
		}
	end
	table.insert(global.boxes, {line_id, rect_id, e.player_index})
end

script.on_event({defines.events.on_player_selected_area},
	function (e)
		if e.item == "showme-tool" then
			player_selected_area(e, nil)
		end
	end
)

script.on_event({defines.events.on_player_alt_selected_area},
	function (e)
		if e.item == "showme-tool" then
			global.to_display[e.player_index] = e
			local box = game.players[e.player_index].gui.screen["showme-name-frame"]["showme-name-box"]
			box.text = ""
			game.players[e.player_index].gui.screen["showme-name-frame"].visible = true
			box.focus()
		end
	end
)

script.on_event({defines.events.on_tick},
	function (e)
		if #global.boxes == 0 then
			return
		end
		for idx, p in pairs(global.boxes) do
			local line_id = p[1]
			local rect_id = p[2]
			if rendering.is_valid(rect_id) then
				-- this isn't very efficient, but it will suffice for now
				local ttl = settings.get_player_settings(game.players[p[3]])["showme-box-duration"].value
				local lt = rendering.get_left_top(rect_id).position
				local rb = rendering.get_right_bottom(rect_id).position
				local height = (lt.y - rb.y) * (rendering.get_time_to_live(line_id) / (ttl + 0.0))
				rendering.set_to(line_id, {x = lt.x, y = rb.y + height})
			else
				table.remove(global.boxes, idx)
			end
		end
	end
)

script.on_event({defines.events.on_gui_click}, 
	function (e)
		if e.element.name == "showme-name-confirm" then
			player_selected_area(global.to_display[e.player_index], e.element.parent["showme-name-box"].text)
			e.element.parent.visible = false
		end
	end
)

script.on_event({defines.events.on_gui_confirmed},
	function (e)
		if e.element.name == "showme-name-box" then
			player_selected_area(global.to_display[e.player_index], e.element.text)
			e.element.parent.visible = false
		end
	end
)
