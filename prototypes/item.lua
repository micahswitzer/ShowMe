local showmeTool = table.deepcopy(data.raw["copy-paste-tool"]["copy-paste-tool"])

showmeTool.name = "showme-tool"
showmeTool.type = "selection-tool"
showmeTool.selection_mode = {"nothing"}
showmeTool.alt_selection_mode = {"nothing"}
showmeTool.icon = "__ShowMe__/graphics/icons/showme-tool.png"
showmeTool.icon_size = 32

local giveTool = table.deepcopy(data.raw["shortcut"]["give-upgrade-planner"])

giveTool.name = "give-showme-tool"
giveTool.item_to_create = "showme-tool"
giveTool.technology_to_unlock = nil
giveTool.associated_control_input = ""
giveTool.localised_name = {"item-name.give-showme-tool"}
giveTool.localised_description = {"item-description.give-showme-tool"}

local dark_icon = {
	filename = "__ShowMe__/graphics/icons/showme-tool-x24.png",
	size = {24,24}
}
local light_icon = {
	filename = "__ShowMe__/graphics/icons/showme-tool-x24-white.png",
	size = {24,24}
}
giveTool.icon = light_icon
giveTool.disabled_icon = light_icon
giveTool.small_icon = dark_icon
giveTool.disabled_small_icon = light_icon

data:extend{showmeTool, giveTool}
