local line_width = 4

script.on_init(
	function () 
		if global.boxes == nil then
			global.boxes = {}
		end
	end
)

script.on_event({defines.events.on_player_selected_area},
	function (e)
		if e.item == "showme-tool" then
			local player = game.players[e.player_index]
			local lt = e.area.left_top
			local rb = e.area.right_bottom
			local rect_id = rendering.draw_rectangle {
				color = player.color,
				width = line_width,
				filled = false,
				left_top = lt,
				right_bottom = rb,
				surface = "nauvis",
				time_to_live = 120,
				force = player.force
			}
			local line_id = rendering.draw_line {
				color = { r = 1 - player.color.r, g = 1 - player.color.g, b = 1 - player.color.b },
				width = line_width,
				from = {x = lt.x, y = rb.y},
				to = {x = lt.x, y = lt.y},
				surface = "nauvis",
				time_to_live = 120,
				force = player.force
			}
			table.insert(global.boxes, {line_id, rect_id})
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
				local lt = rendering.get_left_top(rect_id).position
				local rb = rendering.get_right_bottom(rect_id).position
				local height = (lt.y - rb.y) * (rendering.get_time_to_live(line_id) / 120.0)
				rendering.set_to(line_id, {x = lt.x, y = rb.y + height})
			else
				table.remove(global.boxes, idx)
			end
		end
	end
)
