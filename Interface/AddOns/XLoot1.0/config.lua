local NAME, addon = ...
local L = addon.L

-- Item quality dropdown generator
local item_qualities = {}
do
	for k, v in ipairs(ITEM_QUALITY_COLORS) do
		local hex = select(4, GetItemQualityColor(k))
		item_qualities[k] = { text = ('|c%s%s'):format(hex, _G['ITEM_QUALITY'..tostring(k)..'_DESC']), value = k }
	end
end

-- Skin dropdown generator
local skin_cache = { }
addon.config_skins = function()
	if #skin_cache < 1 then
		for k, v in pairs(addon.skins) do
			table.insert(skin_cache, { text = v.name or k, value = k })
		end
	end
	return skin_cache
end

-- Autoloot times
local autoloot_when = {
	{ value = 'never', text = L.config.when_never },
	{ value = 'solo', text = L.config.when_solo },
	{ value = 'always', text = L.config.when_always }
}

addon.config = {
	panel_index = {
		'options'
	},
	panel_structure = {
		options = {
			left = {
				{
					'size',
					'frame_width_automatic',
					'frame_width',
					'frame_scale',
					'frame_alpha',
					'loot_alpha',
				},
				{
					'general',
					'skin',
					'quality_color_frame',
					'quality_color_loot',
					'loot_texts_info',
					'loot_texts_bind',
					'linkall_show',
					'linkall_threshold',
					'linkall_channel',
				},
			},
			right = {
				{
					'interaction',
					'loot_collapse',
					'loot_highlight',
					'frame_draggable',
					'frame_snap',
					'frame_snap_offset_x',
					'frame_snap_offset_y',
					'autoloot_coin',
					'autoloot_quest',
				},
				{
					'appearance',
					'frame_color_border',
					'frame_color_backdrop',
					'frame_color_gradient',
					'loot_color_border',
					'loot_color_backdrop',
					'loot_color_gradient',
					'loot_color_info',
					'font_size_loot',
					'font_size_info',
				},
			}
		}
	},
	options = {
		frame_scale = {
			type = 'range',
			min = 0.1,
			max = 2.0,
			step = 0.1
		},
		frame_alpha = {
			type = 'range',
			min = 0.0,
			max = 1.0,
			step = .1
		},
		quality_color_frame = {
			type = 'toggle'
		},
		frame_color_border = {
			type = 'color',
			requires = 'quality_color_frame',
			requires_inverse = true
		},
		frame_color_backdrop = {
			type = 'color',
			opacity = true
		},
		frame_color_gradient = {
			type = 'color',
			opacity = true
		},
		frame_snap = {
			type = 'toggle'
		},
		frame_width_automatic = {
			type = 'toggle'
		},
		frame_draggable = {
			type = 'toggle'
		},
		autoloot_coin = {
			type = 'select',
			items = autoloot_when
		},
		autoloot_quest = {
			type = 'select',
			items = autoloot_when
		},
		loot_alpha = {
			type = 'range',
			min = 0.1,
			max = 1.0,
			step = .1
		},
		quality_color_loot = {
			type = 'toggle'
		},
		loot_color_border = {
			type = 'color',
			requires = 'quality_color_loot',
			requires_inverse = 'true'
		},
		loot_color_backdrop = {
			type = 'color',
			opacity = true
		},
		loot_color_gradient = {
			type = 'color',
			opacity = true
		},
		loot_texts_info = {
			type = 'toggle'
		},
		loot_texts_bind = {
			type = 'toggle'
		},
		loot_color_info = {
			type = 'color',
			requires = 'loot_texts_info'
		},
		loot_highlight = {
			type = 'toggle'
		},
		loot_collapse = {
			type = 'toggle'
		},
		frame_width = {
			type = 'range',
			min = 75,
			max = 300,
			step = 5,
			requires = 'frame_width_automatic',
			requires_inverse = true
		},
		font_size_loot = {
			type = 'number',
			length = 2
		},
		font_size_info = {
			type = 'number',
			length = 2
		},
		frame_snap_offset_x = {
			type = 'number',
			length = 5,
			requires = 'frame_snap'
		},
		frame_snap_offset_y = {
			type = 'number',
			length = 5,
			requires = 'frame_snap'
		},
		linkall_show = {
			type = 'select',
			items = {
				{ value = 'auto', text = L.config.when_auto },
				{ value = 'always', text = L.config.when_always },
				{ value = 'never', text = L.config.when_never }
			}
		},
		linkall_threshold = {
			type = 'select',
			items = item_qualities
		},
		linkall_channel = {
			type = 'select',
			items = {
				{ value = 'SAY', text = CHAT_MSG_SAY },
				{ value = 'PARTY', text = CHAT_MSG_PARTY },
				{ value = 'GUILD', text = CHAT_MSG_GUILD },
				{ value = 'OFFICER', text = CHAT_MSG_OFFICER },
				{ value = 'RAID', text = CHAT_MSG_RAID },
				{ value = 'RAID_WARNING', text = RAID_WARNING }
			}
		},
		skin = {
			type = 'select',
			items = addon.config_skins
		}
	}
}