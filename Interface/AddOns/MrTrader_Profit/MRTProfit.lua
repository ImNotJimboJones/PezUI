-------------------------------------------------------------------------------
-- MrTrader 
--
-- Suite of tools for the avid crafter.
--
-- Send suggestions, comments, and bugs to user@zedonline.net
-------------------------------------------------------------------------------

MRTProfit = LibStub("AceAddon-3.0"):NewAddon("MrTrader_Profit");											

local L = LibStub("AceLocale-3.0"):GetLocale("MrTrader", true);


-----
-- SkillWindow_Sort Interface
--
-- Function: SkillWindow_Sort
-- Arguments: 
--		tradeskillInfo - An object that represents the tradeskill info.
-----
function MRTProfit:SkillWindow_Sort(skillA, skillB, ascending)
	local profitA = self:GetProfitEstimate(skillA);
	local profitB = self:GetProfitEstimate(skillB);
	
	return (profitA < profitB and ascending)
	    or (profitA > profitB and not ascending);
end

-----
-- SkillWindow_InfoLine Interface
--
-- Function: SkillWindow_InfoLine
-- Arguments: 
--		tradeskillInfo - An object that represents the tradeskill info.
-----
function MRTProfit:SkillWindow_InfoLine(tradeskillInfo)	
	if( tradeskillInfo.altVerb ~= nil ) then
	    return nil;
	end
	
	if( tradeskillInfo.itemLink == nil ) then
		return nil;
	end
	
	local salePrice = MRTProfit:GetBestSalePrice(tradeskillInfo);
	local materialsCost = MRTProfit:GetPurchasePrice(tradeskillInfo);
	local profit = salePrice - materialsCost;
	local result = "";
	
	-- No way to sell it (no vendor, no disenchant, no auction)... don't bother polluting the list with it.
	if( salePrice == 0 ) then
		return nil;
	end
	-- Only vendors, and isn't a profit... don't list it. We only care about the loss on tradable items, or the profit on vendorable items
	if( salePrice == tradeskillInfo.itemSellPrice and profit < 0 ) then
		return nil;
	end
	
	if( profit >= 0 ) then
		result = "|cff00aa00Profit:|r ";
	else
	    result = "|cffaa0000Loss:|r ";
		profit = -profit;
	end
	
	result = result .. self:GetCoinTextureString(profit);
	
	if(materialsCost >= 0 and self:GetShowMaterialsCost() and result ~= "") then
		result = result .. "  |cffaaaaaa(" .. self:GetCoinTextureString(materialsCost) .. "|cffaaaaaa)|r";
	end
	
	return result;
end

function MRTProfit:GetProfitEstimate(tradeskillInfo)
	if( tradeskillInfo.altVerb ~= nil ) then
	    return 0;
	end
	
	if( tradeskillInfo.itemLink == nil ) then
		return 0;
	end
	
	local salePrice = MRTProfit:GetBestSalePrice(tradeskillInfo);
	local materialsCost = MRTProfit:GetPurchasePrice(tradeskillInfo);
	local profit = salePrice - materialsCost;

	if( salePrice == 0 ) then	
		return 0;
	end
	
	return profit, salePrice;
end

-----
-- Functions
-----
function MRTProfit:OnInitialize()
    -- Add ourselves to MrTrader plugins
	self.id = "421b441d-5c28-407e-b304-4369590b9f14";
	self.name = L["Profit Estimate"];
	self.interfaces = { 
		TradeSkillWindowInfoLine = function(skill) return MRTProfit:SkillWindow_InfoLine(skill) end,
		--TradeSkillWindowSort = function(skillA, skillB, ascending) return MRTProfit:SkillWindow_Sort(skillA, skillB, ascending) end,
	};

	MRTAPI:RegisterPlugin(self);

    -- Load the DB
	self:LoadDatabase();
end

-- Workaround for a Cataclysm bug
function MRTProfit:GetCoinTextureString(profit)
	local result = "";
	local gold, silver, copper;
	
	copper = floor(profit % 100);
	profit = floor(profit / 100);
	silver = profit % 100;
	profit = floor(profit / 100);
	gold = profit;
	
	if( gold > 0 ) then
		result = result .. gold .. "|TInterface\\MoneyFrame\\UI-GoldIcon:12:12:2:0|t";		
	end
	if( silver > 0 ) then
		if( result ~= "" ) then result = result .. " " end;
		result = result .. silver .. "|TInterface\\MoneyFrame\\UI-SilverIcon:12:12:2:0|t";
	end
	if( copper > 0 ) then
		if( result ~= "" ) then result = result .. " " end;
		result = result .. copper .. "|TInterface\\MoneyFrame\\UI-CopperIcon:12:12:2:0|t";
	end
	
	return result;
end

function MRTProfit:GetAuctionPrice(itemLink)
	if( AuctionLite ~= nil ) then
		return AuctionLite:GetAuctionValue(itemLink) or 0;
	end
	if( Atr_GetAuctionBuyout ~= nil ) then
		return Atr_GetAuctionBuyout(itemLink) or 0;
	end
	if( AucAdvanced ~= nil ) then
		return AucAdvanced.API.GetMarketValue(itemLink) or 0;
	end

	return 0;
end

function MRTProfit:GetDisenchantPrice(itemLink)	
	if( AuctionLite ~= nil ) then
		return AuctionLite:GetDisenchantValue(itemLink) or 0;
	end
	if( Atr_GetDisenchantValue ~= nil ) then
		return Atr_GetDisenchantValue(itemLink) or 0;
	end
		
	return 0;
end

function MRTProfit:GetBestSalePrice(tradeskillInfo)
	local availablePrices = {};
	local bestPrice = 0;
	local averageMade = tradeskillInfo.minMade + ((tradeskillInfo.maxMade - tradeskillInfo.minMade) / 2);
	
	if( tradeskillInfo.itemSellPrice ~= nil ) then
		tinsert(availablePrices, tradeskillInfo.itemSellPrice);
	end
	
	tinsert(availablePrices, MRTProfit:GetDisenchantPrice(tradeskillInfo.itemLink));
	tinsert(availablePrices, MRTProfit:GetAuctionPrice(tradeskillInfo.itemLink));
	
	local count = getn(availablePrices);
	for i=1, count do
		if( availablePrices[i] > bestPrice ) then
			bestPrice = availablePrices[i];
		end
	end
	
	return bestPrice * averageMade;
end

function MRTProfit:GetPurchasePrice(tradeskillInfo)
	local purchasePrice = 0;
	
	local count = getn(tradeskillInfo.reagents);
	for i=1,count do
		purchasePrice = purchasePrice + (MRTProfit:GetAuctionPrice(tradeskillInfo.reagents[i].itemLink) * tradeskillInfo.reagents[i].count);
	end
	
	return purchasePrice;
end


-----
-- Database Functions for Retrieving User Options
-----

-- Options
local Options = {
	type = "group",
	get = function(item) return MRTProfit.db.profile[item[#item]] end,
	set = function(item, value) MRTProfit.db.profile[item[#item]] = value end,
	args = {
		showMaterialsCost = {
			type = "toggle",
			name = L["Show Materials Cost"],
			desc = L["Will show the cost of materials along with the estimate."],
			width = "full",
			order = 1,
		},	
	},
};

-- Defaults
local Defaults = {
	profile = {
		showMaterialsCost = false,
	},
}

function MRTProfit:LoadDatabase()
	-- Load the variable
	self.db = LibStub("AceDB-3.0"):New("MrTrader_ProfitDB", Defaults, "Default");
	
	-- Setup Options
	local config = LibStub("AceConfig-3.0");
	local registry = LibStub("AceConfigRegistry-3.0");
	local dialog = LibStub("AceConfigDialog-3.0");
	local mrtOptions = registry:GetOptionsTable("MrTrader Options", "dialog", "MrTrader_Profit-1.0");
	if (not mrtOptions) then
		mrtOptions = {
			type = "group",
			args = {
			}
		}
		config:RegisterOptionsTable("MrTrader", mrtOptions);
		dialog:AddToBlizOptions("MrTrader Options", L["MrTrader"]);
	end
	
	registry:RegisterOptionsTable("MrTrader_Profit Options", Options);
	dialog:AddToBlizOptions("MrTrader_Profit Options", L["Profit Estimate"], L["MrTrader"]);
end

function MRTProfit:GetShowMaterialsCost()
	return self.db.profile.showMaterialsCost;
end




