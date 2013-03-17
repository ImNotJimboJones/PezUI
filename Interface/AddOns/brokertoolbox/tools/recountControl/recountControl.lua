local tool, k, v
tool = BrokerToolBox:NewTool("recountControl",{
	--author="Sanori",
	version="1.0 (14. Feb. 2012)",
	defaultON=false,
	requires="Recount",								--Required Addon
	broker = {											--Broker
		type = "launcher",
		text = "Recount",
		icon = "Interface\\AddOns\\BrokerToolBox\\tools\\recountControl\\icon.tga",
		OnClick = function(self, button)
			if button == "LeftButton" then
				if Recount.MainWindow:IsShown() then
		 			Recount.MainWindow:Hide()
				else
					Recount.MainWindow:Show()
					Recount:RefreshMainWindow()
				end
			end
			if button == "RightButton" then
				GameTooltip:Hide()
				tool:OpenMenu(self)
			end
		end,
		OnTooltipShow = function(self)
			GameTooltip:AddLine(tool:L("name"))
			GameTooltip:AddLine(tool:L("leftclick"))
			GameTooltip:AddLine(tool:L("rightclick"))	
		end,
	},
	--Update Recount
	UpdateDetailData = function()
		if Recount.DetailWindow:IsVisible() and Recount.MainWindow.Selected then
			local _, Data=Recount.MainWindow:GetData(dbCombatants[Recount.MainWindow.Selected])
			local mode=Recount.DetailMode

			if type(Data)=="table" then
				if type(Data[mode][2])~="function" then
					Recount:SetupDetailTitles(Recount.MainWindow.Selected,Data[mode][2],Data[mode][3])
					Recount:FillUpperDetailTable(Data[mode][1])
				else
					Data[mode][2](Recount,Recount.MainWindow.Selected,Data[mode][1])
				end
			end
		end
	end,
	--Menu
	OpenMenu = function(self, owner)
		local RecountL = LibStub("AceLocale-3.0"):GetLocale( "Recount" )
		tool.menu:Open(owner, 'children', function(level, value)
			if not level then return end
			--Main Menu
			if (level==1) then
				tool.menu:AddArrow(tool:L("datasource"),"datasource")
				tool.menu:AddLine()
				tool.menu:AddArrow(RecountL["Data"],"data","Interface\\Buttons\\UI-GuildButton-PublicNote-Up.blp")
				tool.menu:AddFunc(RecountL["Report"],function() Recount:ShowReport("Main",Recount.ReportData) end,"Interface\\Buttons\\UI-GuildButton-MOTD-Up.blp",true)
				tool.menu:AddFunc(RecountL["Reset"],function() Recount:ShowReset() end,"Interface\\AddOns\\Recount\\textures\\icon-reset.tga",true)
				tool.menu:AddLine()
				tool.menu:AddTitle(tool:L("graphs"))
				tool.menu:AddArrow(RecountL["Raid"],"raid")
				tool.menu:AddArrow(RecountL["Network"],"network")
				tool.menu:AddLine()
				tool.menu:AddFunc(RecountL["Config"],function() Recount:ShowConfig() end,"Interface\\AddOns\\Recount\\textures\\icon-config.tga")
			--Sub Menu
			elseif (level==2) then
				-- Select Data Source(dmg, heal, ...)
				if (value=="datasource") then
					for k,v in pairs(Recount.MainWindowData) do
						if Recount.db.profile.MainWindowMode==k then
							tool.menu:AddFunc(v[1],function() Recount:SetMainWindowMode(k) end,nil,false,nil,'checked',true)
						else
							tool.menu:AddFunc(v[1],function() Recount:SetMainWindowMode(k) end,nil,false,nil,'checked',false)
					end
				end
				--Select Data
				elseif (value=="data") then
					--All Data
					local checked
					if (Recount.db.profile.CurDataSet=="OverallData") then checked=true end
					tool.menu:AddFunc(RecountL["Overall Data"],function()
							Recount.db.profile.CurDataSet="OverallData"
							tool:UpdateDetailData()
							Recount.MainWindow.DispTableSorted={}
							Recount.MainWindow.DispTableLookup={}
							Recount.FightName="Overall Data"
							Recount:RefreshMainWindow()
							if RecountDeathTrack then RecountDeathTrack:SetFight(Recount.db.profile.CurDataSet) end
						end,nil,false,nil,'checked',checked)
					--Current Fight
					checked=nil
					if (Recount.db.profile.CurDataSet == "CurrentFightData" or Recount.db.profile.CurDataSet == "LastFightData") then checked=true end
					tool.menu:AddFunc(RecountL["Current Fight"],function()
							if Recount.InCombat then Recount.db.profile.CurDataSet="CurrentFightData" else Recount.db.profile.CurDataSet="LastFightData" end
							tool:UpdateDetailData()
							Recount.MainWindow.DispTableSorted={}
							Recount.MainWindow.DispTableLookup={}
							Recount.FightName="Current Fight"
							Recount:RefreshMainWindow()
							if RecountDeathTrack then RecountDeathTrack:SetFight(Recount.db.profile.CurDataSet) end
						end,nil,false,nil,'checked',checked)
					--Single Fight
					for k, v in pairs(Recount.db2.FoughtWho) do
						checked=nil
						if Recount.db.profile.CurDataSet == "Fight"..k then checked = 1 end
						tool.menu:AddFunc(RecountL["Fight"].." "..k.." - "..v,function()
								Recount.db.profile.CurDataSet="Fight"..k
								tool:UpdateDetailData()
								Recount.MainWindow.DispTableSorted={}
								Recount.MainWindow.DispTableLookup={}
								Recount.FightName=v;Recount:RefreshMainWindow()
								if RecountDeathTrack then RecountDeathTrack:SetFight(Recount.db.profile.CurDataSet) end
							end,nil,false,nil,'checked',checked)
					end
				elseif (value=="raid") then
					tool.menu:AddFunc(RecountL["DPS"],function() Recount:CreateRealtimeWindow("!RAID","DAMAGE","Raid DPS") end)
					tool.menu:AddFunc(RecountL["DTPS"],function() Recount:CreateRealtimeWindow("!RAID","DAMAGETAKEN","Raid DTPS") end)
					tool.menu:AddFunc(RecountL["HPS"],function() Recount:CreateRealtimeWindow("!RAID","HEALING","Raid HPS") end)
					tool.menu:AddFunc(RecountL["HTPS"],function() Recount:CreateRealtimeWindow("!RAID","HEALINGTAKEN","Raid HTPS") end)	
				elseif (value=="network") then
					tool.menu:AddFunc(RecountL["FPS"],function() Recount:CreateRealtimeWindow("FPS","FPS","") end)
					tool.menu:AddFunc(RecountL["Lag"],function() Recount:CreateRealtimeWindow("Latency","LAG","") end)
					tool.menu:AddFunc(RecountL["Up Traffic"],function() Recount:CreateRealtimeWindow("Upstream Traffic","UP_TRAFFIC","") end)
					tool.menu:AddFunc(RecountL["Down Traffic"],function() Recount:CreateRealtimeWindow("Downstream Traffic","DOWN_TRAFFIC","") end)
					tool.menu:AddFunc(RecountL["Bandwidth"],function() Recount:CreateRealtimeWindow("Bandwidth Available","AVAILABLE_BANDWIDTH","") end)			
				end	
			end
		end)
	end
})