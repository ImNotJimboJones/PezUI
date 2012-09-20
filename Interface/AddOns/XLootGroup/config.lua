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
					'text_time',
					'anchor_pretty'
				},
				{
					'alerts',
					'alert_direction',
					'alert_offset',
					'alert_alpha',
					'alert_scale',
					'alert_skin',

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
				},
				{
					'expiration',
					'expire_won',
					'expire_lost',
				},
				{
					'tooltip',
					--'show_decided',
					'show_undecided',
				},
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
		anchor_pretty = {
			type = 'toggle',
		},
		role_icon = {
			type = 'toggle'
		},
		win_icon = {
			type = 'toggle'
		},
		show_decided = {
			type = 'toggle'
		},
		show_undecided = {
			type = 'toggle'
		},
		alert_skin = {
			type = 'toggle'
		},
		alert_alpha = {
			type = 'range',
			min = 0.1,
			max = 1.0,
			step = 0.1,
			text = L.alpha,
			text_low = L.alpha_low,
			text_high = L.alpha_high
		},
		alert_scale = {
			type = 'range',
			min = 0.1,
			max = 2.0,
			step = 0.1,
			text = L.scale,
			text_low = L.small,
			text_high = L.large
		},
		alert_offset = {
			type = 'range',
			min = 0,
			max = 40,
			step = 1,
			text_low = L.small,
			text_high = L.large
		},
		alert_direction = {
			type = 'select',
			items = directions,
			key = 'alert_anchor',
			subkey = 'direction',
			text = L.direction
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
			requires = 'track_all',
			requires_inverse = true
		},
		track_by_threshold = {
			type = 'toggle',
			requires = 'track_all',
			requires_inverse = true
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