local LookingForGroup = LibStub("AceAddon-3.0"):GetAddon("LookingForGroup")
--------------------------------------------------------------------------------------

function LookingForGroup:OnEnable()
	if IsAddOnLoaded("MeetingStone") then
		DisableAddOn("MeetingStone")
		ReloadUI()
	end
	local profile = self.db.profile
	if profile.enable_wq then
		LoadAddOn("LookingForGroup_WQ")
	end
	if profile.enable_invasionpoint then
		LoadAddOn("LookingForGroup_InvasionPoint")
	end
	if profile.enable_elite then
		LoadAddOn("LookingForGroup_Elite")
	end
	if profile.enable_icon then
		LoadAddOn("LookingForGroup_Icon")
	end
	if profile.enable_hook then
		LoadAddOn("LookingForGroup_Hook")
	end
	if profile.enable_event then
		LoadAddOn("LookingForGroup_Event")
	end
	if profile.enable_sf then
		LoadAddOn("LookingForGroup_SF")
	end
	if profile.enable_av then
		LoadAddOn("LookingForGroup_AV")
	end
	if profile.hook_quick_join then
		QuickJoinToastButton:Hide()
	end
end

function LookingForGroup.Search(callback,category,terms,filters,preferredfilters,delay)
	C_LFGList.Search(category,terms,filters,preferredfilters,C_LFGList.GetLanguageSearchFilter())
	LookingForGroup:RegisterEvent("LFG_LIST_SEARCH_RESULTS_RECEIVED",function()
		LookingForGroup:UnregisterEvent("LFG_LIST_SEARCH_RESULTS_RECEIVED")
		if LookingForGroup.db.profile.mode_rf == nil and delay == nil then
			callback()
		else
			if delay then
				C_Timer.After(delay,callback)
			else
				C_Timer.After(0.3,callback)
			end
		end
	end)
end

function LookingForGroup.FilterRealm(name)
	local profile = LookingForGroup.db.profile
	local mode_rf = profile.mode_rf
	if mode_rf == nil then
		return true
	end
	local realm_filters = profile.realm_filters
	if mode_rf then
		if name then
			local realm = name:match("-(.*)$")
			if realm and realm_filters[realm] then
				return false
			end
		end
		return true
	end
	if name then
		local realm = name:match("-(.*)$")
		if not realm or realm_filters[realm] then
			return true
		end
	end
	return false
end
