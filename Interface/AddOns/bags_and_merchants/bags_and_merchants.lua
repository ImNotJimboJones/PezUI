local bam_frame = CreateFrame("Frame", "BagsAndMerchantsFrame")

local events_showbags = {
	["AUCTION_HOUSE_SHOW"] = true,
	["BANKFRAME_OPENED"] = true,
	["GUILDBANKFRAME_OPENED"] = true,
	["MAIL_SHOW"] = true,
	["MERCHANT_SHOW"] = true,
	["TRADE_SHOW"] = true,
}
local events_closebags = {
	["AUCTION_HOUSE_CLOSED"] = true,
	["BANKFRAME_CLOSED"] = true,
	["GUILDBANKFRAME_CLOSED"] = true,
	["MAIL_CLOSED"] = true,
	["MERCHANT_CLOSED"] = true,
	["TRADE_CLOSED"] = true,
}

local events_bank = {
	["BANKFRAME_OPENED"] = true,
	["BANKFRAME_CLOSED"] = true,
}

for event in pairs(events_showbags) do
	bam_frame:RegisterEvent(event)
end

for event in pairs(events_closebags) do
	bam_frame:RegisterEvent(event)
end

bam_frame:SetScript("OnEvent", function(self, event)
	if events_showbags[event] then
		OpenAllBags(bam_frame)
		if events_bank[event] then
			for i=NUM_BAG_FRAMES+1, NUM_CONTAINER_FRAMES, 1 do
				OpenBag(i)
			end
		end
	end
	if events_closebags[event] then
		ContainerFrame1.backpackWasOpen = nil
		CloseAllBags(bam_frame)
		if events_bank[event] then
			for i=NUM_BAG_FRAMES+1, NUM_CONTAINER_FRAMES, 1 do
				CloseBag(i)
			end
		end
	end
end)
