local NAME, addon = ...
local L = addon.L.config

local directions = {
	{ value = 'up', text = 'Up' },
	{ value = 'down', text = 'Down' }
}
-- Item quality dropdown generator
local item_qualities = {}
do
	for k, v in ipairs(ITEM_QUALITY_COLORS) do
		local hex = select(4, GetItemQualityColor(k))
		item_qualities[k] = { text = ('|c%s%s'):format(hex, _G['ITEM_QUALITY'..tostring(k)..'_DESC']), value = k }
	end
end

addon.config = {
	panel_index = {
		'options'
	},
	panel_structure = {
		options = {
			left = {
				{
					'anchor',
					'roll_direction',
					'roll_scale',
					'roll_width',
					'roll_button_size',
					'text_outline',
					'text_time'
				}
			},
			right = {
				{
					'tracking',
					'track_all',
					'track_player_roll',
					'track_by_threshold',
					'track_threshold',
					'role_icon',
					'win_icon',
					'show_undecided',
				},
				{
					'expiration',
					'expire_won',
					'expire_lost',
				}
			}
		}
	},
	options = {
		text_outline = {
			type = 'toggle',
		},
		text_time = {
			type = 'toggle',
		},
		role_icon = {
			type = 'toggle'
		},
		win_icon = {
			type = 'toggle'
		},
		show_undecided = {
			type = 'toggle'
		},
		roll_scale = {
			type = 'range',
			min = 0.1,
			max = 2.0,
			step = 0.1,
			key = 'roll_anchor',
			subkey = 'scale',
			text = L.scale,
			text_low = L.small,
			text_high = L.large
		},
		roll_direction = {
			type = 'select',
			items = directions,
			key = 'roll_anchor',
			subkey = 'direction',
			text = L.direction
		},
		roll_width = {
			type = 'range',
			min = 150,
			max = 400,
			step = 10,
			text_low = L.small,
			text_high = L.large
		},
		roll_button_size = {
			type = 'range',
			min = 16,
			max = 48,
			step = 1,
			text_low = L.small,
			text_high = L.large
		},
		track_all = {
			type = 'toggle',
		},
		track_player_roll = {
			type = 'toggle',
		},
		track_by_threshold = {
			type = 'toggle',
		},
		track_threshold = {
			type = 'select',
			items = item_qualities,
			requires = 'track_by_threshold',
			text = QUALITY,
		},
		expire_won = {
			type = 'range',
			min = 5,
			max = 30,
			step = 1,
			text_low = L.short,
			text_high = L.long
		},
		expire_lost = {
			type = 'range',
			min = 5,
			max = 30,
			step = 1,
			text_low = L.short,
			text_high = L.long
		},
	}
}