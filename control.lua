script.on_event({defines.events.on_player_selected_area},
	function (e)
		if e.item == "showme-tool" then
			rendering.draw_rectangle {
				color = {g = 1},
				width = 2,
				filled = false,
				left_top = e.area.left_top,
				right_bottom = e.area.right_bottom,
				surface = "nauvis",
				time_to_live = 120,
				force = game.players[e.player_index].force }
		end
	end
)
