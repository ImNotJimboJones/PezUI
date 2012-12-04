local _, TMPrivate = ...;
local L = TMPrivate.L;

SLASH_THNANMOD1 = L.slashCommand;

SlashCmdList["THNANMOD"] = function(msg, editBox)

	for pluginName, plugin in pairs(TMPrivate.plugins) do
		local tag = plugin.slashCommandTag;
		local panel = plugin.configPanel;
		local handler = plugin.slashCommandCalled;
		
		if tag == msg then
			if panel then
				InterfaceOptionsFrame_OpenToCategory(panel);
				return;
			elseif handler then
				handler(plugin, "");
				return;
			end
			break;
		end
		
		tag = tag.." ";
		local msgPrefix = msg:sub(1, tag:len());
		
		if tag == msgPrefix then
			if handler then
				handler(plugin, msg:sub(tag:len() + 1));
				return;
			elseif panel then
				InterfaceOptionsFrame_OpenToCategory(panel);
				return;
			end
			break;
		end
	end
	
	if TMPrivate.rootConfigPanel.collapsed then
		local buttons = InterfaceOptionsFrameAddOns.buttons;
		for k, button in pairs(buttons) do
			if button.element == TMPrivate.rootConfigPanel then
				OptionsListButtonToggle_OnClick(button.toggle);
				break;
			end
		end
	end
	
	InterfaceOptionsFrame_OpenToCategory(TMPrivate.rootConfigPanel);
end