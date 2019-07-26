local showmeTool = table.deepcopy(data.raw["copy-paste-tool"]["copy-paste-tool"])

showmeTool.name = "showme-tool"
showmeTool.type = "selection-tool"
showmeTool.selection_mode = {"nothing"}
showmeTool.alt_selection_mode = {"nothing"}
showmeTool.selection_cursor_box_type = "entity"
showmeTool.show_in_library = true

data:extend{showmeTool}

