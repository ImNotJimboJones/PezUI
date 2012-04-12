
ArbitCommDB = {
	["profileKeys"] = {
		["Pezzer - Burning Blade"] = "Default",
	},
	["profiles"] = {
		["Default"] = {
			["commands"] = {
				{
					["sub"] = {
						{
							["script"] = "-- Sets the UI Scale to the smallest possible value that provides \n-- pixel-perfect rendering in the current resolution\n\n-- Get all screen resolutions\nlocal screenResolutions = {GetScreenResolutions()};\n\n-- get current resolution\nlocal currentResolution = screenResolutions[GetCurrentResolution()];\n\n-- parse the Y dimension from the current resolution string\nlocal y = string.match(currentResolution, \"%d+x(%d+)\");\n\n-- compute and set scale\nSetCVar(\"uiScale\", 768/y);",
							["menulabel"] = "UI Scale",
						}, -- [1]
						{
							["script"] = "-- Clears all action bars\nfor i = 1,120 do\n    PickupAction(i);\n    ClearCursor();\nend",
							["menulabel"] = "Clear Action Bars",
						}, -- [2]
					},
					["menulabel"] = "Admin",
				}, -- [1]
			},
			["minimap"] = {
				["hide"] = true,
			},
		},
	},
}
