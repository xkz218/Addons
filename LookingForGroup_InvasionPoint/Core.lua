local AceAddon = LibStub("AceAddon-3.0")
local LookingForGroup = AceAddon:GetAddon("LookingForGroup")
local LookingForGroup_Auto = AceAddon:GetAddon("LookingForGroup_Auto")
local LookingForGroup_InvasionPoint = AceAddon:NewAddon("LookingForGroup_InvasionPoint","AceEvent-3.0")

function LookingForGroup_InvasionPoint:OnInitialize()
end

function LookingForGroup_InvasionPoint:OnEnable()
	if LookingForGroup.db.profile.enable_invasionpoint then
		self:RegisterEvent("LOADING_SCREEN_DISABLED")
		self:RegisterEvent("SCENARIO_COMPLETED")
	else
		self:UnregisterAllEvents()
	end
end

function LookingForGroup_InvasionPoint.callback(secure)
	local mfn = GetMapInfo()
	local scen = C_Scenario.GetInfo()
	if mfn and mfn:find("InvasionPoint") and (secure or scen) then
		local name = GetMapNameByID(GetCurrentMapAreaID())
		local enfnm = scen and ("Invasion Point: "..mfn:gsub ("InvasionPoint", "")) or "Greater Invasion"
		local function create()
			C_LFGList.CreateListing(16,enfnm,LookingForGroup.db.profile.auto_ilvl or 0,0,"","LookingForGroup "..name,true,false)
		end
		LookingForGroup_Auto.accepted(create,function()
			LookingForGroup.Search(function()
				LookingForGroup_Auto.apply(create)
			end,6,{{matches = {enfnm}}},0,0)
		end,secure)
	else
		local active, activityID, iLevel, honorLevel, name = C_LFGList.GetActiveEntryInfo()
		if active then
			if strfind(name,"Invasion") then
				LookingForGroup_Auto.done()
			end
		end
	end
end

function LookingForGroup_InvasionPoint:LOADING_SCREEN_DISABLED()
	C_Timer.After(2,LookingForGroup_InvasionPoint.callback)
end

function LookingForGroup_InvasionPoint:SCENARIO_COMPLETED()
	local mfn = GetMapInfo()
	if mfn and mfn:find("InvasionPoint") then
		LookingForGroup_Auto.done()
	end
end
