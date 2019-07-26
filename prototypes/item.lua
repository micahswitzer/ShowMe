local showmeTool = table.deepcopy(data.raw["copy-paste-tool"]["copy-paste-tool"])

showmeTool.name = "showme-tool"
showmeTool.type = "selection-tool"
showmeTool.selection_mode = {"nothing"}
showmeTool.alt_selection_mode = {"nothing"}
showmeTool.selection_cursor_box_type = "entity"

local giveTool = table.deepcopy(data.raw["shortcut"]["give-upgrade-planner"])

giveTool.name = "give-showme-tool"
giveTool.item_to_create = "showme-tool"
giveTool.technology_to_unlock = nil
giveTool.associated_control_input = ""
giveTool.localised_name = {"item-name.give-showme-tool"}
giveTool.localised_description = {"item-description.give-showme-tool"}

data:extend{showmeTool, giveTool}
