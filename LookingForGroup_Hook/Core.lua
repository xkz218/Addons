local LibStub = LibStub
local AceAddon = LibStub("AceAddon-3.0")
local LookingForGroup = AceAddon:GetAddon("LookingForGroup")
local LookingForGroup_Hook = AceAddon:NewAddon("LookingForGroup_Hook","AceHook-3.0")

--------------------------------------------------------------------------------------
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

function LookingForGroup_Hook:OnInitialize()
end

function LookingForGroup_Hook:OnEnable()
	local profile = LookingForGroup.db.profile
	if profile.enable_hook then
		local function nullfun()end
		self:RawHook("LFGListFrame_BeginFindQuestGroup",true)
		self:RawHook("QueueStatusDropDown_AddLFGListButtons",true)
		self:RawHook("QueueStatusDropDown_AddLFGListApplicationButtons",true)
		self:RawHook("QueueStatusEntry_SetUpLFGListApplication",true)
		self:RawHook("QueueStatusEntry_SetUpLFGListActiveEntry",true)
		if profile.hook_gmotd then
			self:RawHook("ChatFrame_DisplayGMOTD",nullfun,true)
		end
		self:RawHook("LFGListInviteDialog_Show",true)
		self:RawHook("LFGListUtil_OpenBestWindow",true)
		self:RawHookScript(LFGListApplicationDialog.SignUpButton,"OnClick","LFGListApplicationDialog_SignUpButton_OnClick")
		if profile.hook_quick_join then
			self:RawHook(QuickJoinFrame,"Show",nullfun,true)
		end
		self:RawHook(UIErrorsFrame,"AddMessage",true)
	else
		self:UnhookAll()
	end
end

function LookingForGroup_Hook:LFGListFrame_BeginFindQuestGroup(panel,questID)
	if LookingForGroup.db.profile.enable_wq then
		LookingForGroup.GetAddon("LookingForGroup_WQ"):QUEST_ACCEPTED(LookingForGroup,0,questID)
		return
	end
	local LookingForGroup_Options = LookingForGroup.GetAddon("LookingForGroup_Options")
	LookingForGroup_Options.db.profile.start_a_group_quest_id = questID
	LookingForGroup_Options.do_wq_search()
	AceConfigDialog:Open("LookingForGroup")
end

function LookingForGroup_Hook:QueueStatusDropDown_AddLFGListApplicationButtons(info, resultID)
	wipe(info)
	info.text = LookingForGroup.GetAddon("LookingForGroup_Core").GetSearchResultName(resultID)
	info.isTitle = 1
	info.notCheckable = 1
	UIDropDownMenu_AddButton(info)
	wipe(info)
	info.text = CANCEL_SIGN_UP
	info.func = function(_,id) C_LFGList.CancelApplication(id)  end
	info.arg1 = resultID
	info.leftPadding = 10
	info.disabled = IsInGroup() and not UnitIsGroupLeader("player")
	UIDropDownMenu_AddButton(info)
end

function LookingForGroup_Hook:LFGListUtil_OpenBestWindow()
	if AceConfigDialog.OpenFrames.LookingForGroup then
		AceConfigDialog:Close("LookingForGroup")
	else
		local option = LookingForGroup.GetAddon("LookingForGroup_Options")
		if option.option_table.args.requests == nil then
			option.set_requests()
		end
		AceConfigDialog:SelectGroup("LookingForGroup","requests")
		AceConfigDialog:Open("LookingForGroup")
	end
end

function LookingForGroup_Hook:QueueStatusDropDown_AddLFGListButtons(info)
	wipe(info)
	if UnitIsGroupLeader("player") then
		info.text = EDIT
	else
		info.text = VIEW
	end
	info.func = function()
		LookingForGroup.GetAddon("LookingForGroup_Options").UpdateEditing()
		PVEFrame:Hide()
		AceConfigDialog:SelectGroup("LookingForGroup","find","s")
		AceConfigDialog:Open("LookingForGroup")
	end
	UIDropDownMenu_AddButton(info)
	info.text = LFG_LIST_VIEW_GROUP
	info.func = LFGListUtil_OpenBestWindow
	UIDropDownMenu_AddButton(info)
	if UnitIsGroupLeader("player") then
		info.text = UNLIST_MY_GROUP
		info.func = C_LFGList.RemoveListing
		UIDropDownMenu_AddButton(info)
	end
end

function LookingForGroup_Hook:QueueStatusEntry_SetUpLFGListApplication(entry,resultID)
	local name , comment = LookingForGroup.GetAddon("LookingForGroup_Core").GetSearchResultName(resultID)
	QueueStatusEntry_SetMinimalDisplay(entry,name,QUEUE_STATUS_SIGNED_UP,comment)
end

function LookingForGroup_Hook:QueueStatusEntry_SetUpLFGListActiveEntry(entry)
	local name, info = LookingForGroup.GetAddon("LookingForGroup_Core").GetActiveEntryInfo()
	QueueStatusEntry_SetMinimalDisplay(entry,name,QUEUE_STATUS_LISTED,info)
end

function LookingForGroup_Hook:LFGListInviteDialog_Show(entry,resultID)
	local _, status, _, _, role = C_LFGList.GetApplicationInfo(resultID);

	local informational = (status ~= "invited");
	assert(not informational or status == "inviteaccepted");

	entry.resultID = resultID;
	
	local gpn,actn = LookingForGroup.GetAddon("LookingForGroup_Core").GetSearchResultInviteDialog(resultID)
	entry.GroupName:SetText(gpn);
	entry.ActivityName:SetText(actn);
	entry.Role:SetText(_G[role]);
	entry.RoleIcon:SetTexCoord(GetTexCoordsForRole(role));
	entry.Label:SetText(informational and LFG_LIST_JOINED_GROUP_NOTICE or LFG_LIST_INVITED_TO_GROUP);

	entry.informational = informational;
	entry.AcceptButton:SetShown(not informational);
	entry.DeclineButton:SetShown(not informational);
	entry.AcknowledgeButton:SetShown(informational);

	if ( not informational and GroupHasOfflineMember(LE_PARTY_CATEGORY_HOME) ) then
		entry:SetHeight(250);
		entry.OfflineNotice:Show();
		LFGListInviteDialog_UpdateOfflineNotice(entry);
	else
		entry:SetHeight(210);
		entry.OfflineNotice:Hide();
	end

	StaticPopupSpecial_Show(entry);
	if not LookingForGroup.db.profile.mute then
		PlaySound(SOUNDKIT.READY_CHECK);
	end
	FlashClientIcon();
end

function LookingForGroup_Hook:LFGListApplicationDialog_SignUpButton_OnClick(obj)
	local dialog = obj:GetParent();
	if not LookingForGroup.db.profile.mute then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
	end
	local desc = dialog.Description.EditBox:GetText()
	local results = dialog.resultID
	local results_type = type(results)
	if results_type == "number" then
		C_LFGList.ApplyToGroup(results,desc, select(2,GetLFGRoles()));
	elseif results_type == "function" then
		results(desc)
	end
	StaticPopupSpecial_Hide(dialog);
end

function LookingForGroup_Hook:AddMessage(frame,message,...)
	if message ~= ERR_REPORT_SUBMITTED_SUCCESSFULLY then
		self.hooks[frame].AddMessage(frame,message,...)
	end
end
