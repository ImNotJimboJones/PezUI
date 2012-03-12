local tool
tool = BrokerToolBox:NewTool("newMail",{
	author="Sanori",
	version="1.0 15/02/12",
	defaultON=false,	
	events={
		["UPDATE_PENDING_MAIL"] = function(self)
			if ( HasNewMail() ) then
				self.broker.icon = "Interface\\AddOns\\BrokerToolBox\\tools\\newMail\\new_mail.tga"
				self.broker.text = "1"
				self:MinimapMailFrameUpdate()
			else
				self.broker.icon = "Interface\\AddOns\\BrokerToolBox\\tools\\newMail\\no_mail.tga"
				self.broker.text = "0"
				self.toolText = nil;
			end
		end,
		["PLAYER_ENTERING_WORLD"] = function(self)
			MiniMapMailFrame:UnregisterEvent("UPDATE_PENDING_MAIL")
			MiniMapMailFrame:Hide()
		end
	},
	-- Blizzard Code (modified): FrameXML\Minimap.lua
	MinimapMailFrameUpdate = function(self)
    	local sender1,sender2,sender3 = GetLatestThreeSenders();
    	self.toolText = nil;
     
    	if( sender1 or sender2 or sender3 ) then
        	self.toolText = HAVE_MAIL_FROM;
    	else
        	self.toolText = HAVE_MAIL;
    	end
     
    	if( sender1 ) then
        	self.toolText = self.toolText.."\n"..sender1;
    	end
    	if( sender2 ) then
        	self.toolText = self.toolText.."\n"..sender2;
    	end
    	if( sender3 ) then
        	self.toolText = self.toolText.."\n"..sender3;
    	end
	end,
	--
	broker = {											--Broker
		type = "data source",
		text = "0",
		icon = "Interface\\AddOns\\BrokerToolBox\\tools\\newMail\\no_mail.tga",
		OnTooltipShow = function(self)
			if (tool.toolText) then GameTooltip:SetText(tool.toolText) end
		end
	}
})