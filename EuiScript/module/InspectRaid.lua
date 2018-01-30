local E, L = unpack(ElvUI)
-------------------------------------
-- TinyInspect團隊装备等级 Author: M ## Version: 7.2.8
-------------------------------------
--InspectCore--
local LibEvent = LibStub:GetLibrary("LibEvent.7000")
local LibSchedule = LibStub:GetLibrary("LibSchedule.7000")
local LibItemInfo = LibStub:GetLibrary("LibItemInfo.7000")

local guids, inspecting = {}, false

local function GetGroupNumber(unit)
	if not unit then return; end

	local Name, Realm = UnitFullName(unit)
	if IsInRaid() then
		for i = 1, GetNumGroupMembers() do
			local sname, _, subgroup = GetRaidRosterInfo(i)
			if (sname == Name) or (Realm and (sname == Name..'-'..Realm)) then
				return format("%s-%s", subgroup, Name), subgroup
			end
		end
		return Name, 0
	else
		return Name, 0
	end
end

-- Global API
function GetInspectInfo(unit, timelimit)
    local guid = UnitGUID(unit)
    if (guid and guids[guid]) then
        if (not timelimit or timelimit == 0) then
            return guids[guid]
        end
        if (guids[guid].timer > time()-timelimit) then
            return guids[guid]
        end
    end
end

local inuse = { inuse = true }

-- Global API
function GetInspecting()
    if (InspectFrame and InspectFrame.unit) then
        local guid = UnitGUID(InspectFrame.unit)
        return guids[guid] or inuse
    end
    if (inspecting and inspecting.expired > time()) then
        return inspecting
    end
end

-- Global API @trigger UNIT_REINSPECT_READY
function ReInspect(unit)
    local guid = UnitGUID(unit)
    if (not guid) then return end
    local data = guids[guid]
    if (not data) then return end
    LibSchedule:AddTask({
        identity  = guid,
        timer     = 0.5,
        elasped   = 0.5,
        expired   = GetTime() + 3,
        data      = data,
        unit      = unit,
        onExecute = function(self)
            local count, ilevel, _, weaponLevel, isArtifact = LibItemInfo:GetUnitItemLevel(self.unit)
            if (ilevel <= 0) then return true end
            if (count == 0 and ilevel > 0) then
                self.data.timer = time()
                self.data.ilevel = ilevel
                self.data.weaponLevel = weaponLevel
                self.data.isArtifact = isArtifact
                LibEvent:trigger("UNIT_REINSPECT_READY", self.data)
                return true
            end
        end,
    })
end

-- Get Inspect Specialization
local function GetInspectSpec(unit)
    if (UnitLevel(unit) > 10) then
        local specID, specName
        if (unit == "player") then
            specID = GetSpecialization()
            specName = select(2, GetSpecializationInfo(specID))
        else
            specID = GetInspectSpecialization(unit)
            if (specID and specID > 0) then
                specName = select(2, GetSpecializationInfoByID(specID))
            end
        end
        return specName
    end
end

-- Clear
hooksecurefunc("ClearInspectPlayer", function()
    inspecting = false
end)

-- @trigger UNIT_INSPECT_STARTED
hooksecurefunc("NotifyInspect", function(unit)
    local guid = UnitGUID(unit)
    if (not guid) then return end
    local data = guids[guid]
    if (data) then
        data.unit = unit
        data.name = GetGroupNumber(unit)
		data.groupNumber = select(2, GetGroupNumber(unit))
    else
        data = {
            unit   = unit,
            guid   = guid,
            name   = GetGroupNumber(unit),
			groupNumber = select(2, GetGroupNumber(unit)),
            class  = select(2, UnitClass(unit)),
            level  = UnitLevel(unit),
            ilevel = -1,
            spec   = nil,
            hp     = UnitHealthMax(unit),
            timer  = time(),
        }
        guids[guid] = data
    end
    data.expired = time() + 4
    inspecting = data
    LibEvent:trigger("UNIT_INSPECT_STARTED", data)
end)

-- @trigger UNIT_INSPECT_READY
LibEvent:attachEvent("INSPECT_READY", function(this, guid)
    if (not guids[guid]) then return end
    LibSchedule:AddTask({
        identity  = guid,
        timer     = 0.5,
        elasped   = 0.8,
        expired   = GetTime() + 4,
        data      = guids[guid],
        onTimeout = function(self) inspecting = false end,
        onExecute = function(self)
            local count, ilevel, _, weaponLevel, isArtifact = LibItemInfo:GetUnitItemLevel(self.data.unit)
            if (ilevel <= 0) then return true end
            if (count == 0 and ilevel > 0) then
                if (UnitIsVisible(self.data.unit) or self.data.ilevel == ilevel) then
                    self.data.timer = time()
                    self.data.name = GetGroupNumber(self.data.unit)
					self.data.groupNumber = select(2, GetGroupNumber(unit))
                    self.data.class = select(2, UnitClass(self.data.unit))
                    self.data.ilevel = ilevel
                    self.data.spec = GetInspectSpec(self.data.unit)
                    self.data.hp = UnitHealthMax(self.data.unit)
                    self.data.weaponLevel = weaponLevel
                    self.data.isArtifact = isArtifact
                    LibEvent:trigger("UNIT_INSPECT_READY", self.data)
                    inspecting = false
                    return true
                else
                    self.data.ilevel = ilevel
                end
            end
        end,
    })
end)

-------------------------------------------InspectCore-------------------------------------------------
local members, numMembers = {}, 0

--是否觀察完畢
local function InspectDone()
    for guid, v in pairs(members) do
        if (not v.done) then
            return false
        end
    end
    return true
end

--人員信息 @trigger RAID_MEMBER_CHANGED
local function GetMembers(num)
    local unit, guid
    local temp = {}
	local tag = ''
	if IsInRaid() then tag = "raid" else tag = "party" end
	
    for i = 1, num do
        unit = tag..i
        guid = UnitGUID(unit)
        if (guid) then temp[guid] = unit end
    end
    for guid, v in pairs(members) do
        if (not temp[guid]) then
            members[guid] = nil
        end
    end
    for guid, unit in pairs(temp) do
        if (members[guid]) then
            members[guid].unit = unit
            members[guid].name = GetGroupNumber(unit)
			members[guid].groupNumber = select(2, GetGroupNumber(unit))
            members[guid].class = select(2, UnitClass(unit))
            members[guid].role  = UnitGroupRolesAssigned(unit)
            members[guid].done  = GetInspectInfo(unit, 0, true)
        else
            members[guid] = {
                done   = false,
                guid   = guid,
                unit   = unit,
                name   = GetGroupNumber(unit),
				groupNumber = select(2, GetGroupNumber(unit)),
                class  = select(2, UnitClass(unit)),
                role   = UnitGroupRolesAssigned(unit),
                ilevel = -1,
            }
        end
    end
    LibEvent:trigger("RAID_MEMBER_CHANGED", members)
end

--觀察 @trigger RAID_INSPECT_STARTED
local function SendInspect(unit)
    if (GetInspecting()) then return end
	local tag = IsInGroup()
	
	if (tag) then --by eui
		if (unit and UnitIsVisible(unit) and CanInspect(unit)) then
			ClearInspectPlayer()
			NotifyInspect(unit)
			LibEvent:trigger("RAID_INSPECT_STARTED", members[UnitGUID(unit)])
			return
		end
	end
    for guid, v in pairs(members) do
        if ((not v.done or v.ilevel <= 0) and UnitIsVisible(v.unit) and CanInspect(v.unit)) then
            ClearInspectPlayer()
            NotifyInspect(v.unit)
            if tag then
				LibEvent:trigger("RAID_INSPECT_STARTED", v)
			else
				LibEvent:trigger("PARTY_INSPECT_STARTED", v)
            end
            return v
        end
    end
end

--@see InspectCore.lua @trigger RAID_INSPECT_READY
LibEvent:attachTrigger("UNIT_INSPECT_READY", function(self, data)
    local member = members[data.guid]
    if (member) then
        member.role = UnitGroupRolesAssigned(data.unit)
        member.ilevel = data.ilevel
        member.spec = data.spec
        member.name = data.name
		member.class = data.class
        member.done = true
        LibEvent:trigger("RAID_INSPECT_READY", member)
    end
end)

--人員增加時觸發 @trigger RAID_INSPECT_TIMEOUT @trigger RAID_INSPECT_DONE
LibEvent:attachEvent("PLAYER_ENTERING_WORLD, GROUP_ROSTER_UPDATE", function(self)
    local tag = IsInRaid()
	local numCurrent = GetNumGroupMembers()
	
	if (tag) then
		if (numCurrent ~= numMembers) then GetMembers(numCurrent) end
		if (numCurrent > numMembers) then
			LibSchedule:AddTask({
				identity  = "InspectRaid",
				elasped   = 3,
				expired   = GetTime() + 1800,
				onTimeout = function(self) LibEvent:trigger("RAID_INSPECT_TIMEOUT", members) end,
				onExecute = function(self)
					if (not IsInRaid()) then return true end
					if (InspectDone()) then
						LibEvent:trigger("RAID_INSPECT_DONE", members)
						return true
					end
					SendInspect()
				end,
			})
		end
		numMembers = numCurrent
	else
		if (numCurrent > numMembers) then
			GetMembers(numCurrent)
			members[UnitGUID("player")] = {
				name   = GetGroupNumber("player"),
				groupNumber = select(2, GetGroupNumber(unit)),
				class  = select(2, UnitClass("player")),
				ilevel = select(2, GetAverageItemLevel()),
				done   = true,
				unit   = "player",
				spec   = select(2, GetSpecializationInfo(GetSpecialization())),
			}
			LibSchedule:AddTask({
				override  = true,
				identity  = "InspectParty",
				timer     = 1,
				elasped   = 1,
				begined   = GetTime() + 2,
				expired   = GetTime() + 30,
				onTimeout = function(self)
					if (GetNumSubgroupMembers()==0) then return end
					LibEvent:trigger("PARTY_INSPECT_TIMEOUT", members)
				end,
				onExecute = function(self)
					if (IsInRaid()) then return true end
					if (InspectDone()) then
						LibEvent:trigger("PARTY_INSPECT_DONE", members)
						return true
					end
					SendInspect()
				end,
			})
		end
	end
end)

----------------
-- 界面處理
----------------

local memberslist = {}

local frame = CreateFrame("Frame", "EuiInspectRaidFrame", UIParent, "InsetFrameTemplate3")
frame.BorderBottomLeft:SetTexture("Interface\\Common\\Common-Input-Border")
frame.BorderBottomRight:SetTexture("Interface\\Common\\Common-Input-Border")
frame.BorderBottomLeft:SetTexCoord(0.0625, 0.9375, 0.25, 0.375)
frame.BorderBottomRight:SetTexCoord(0.0625, 0.9375, 0.25, 0.375)
frame.BorderBottomMiddle:SetTexCoord(0.0625, 0.9375, 0.3, 0.625)
frame:SetPoint("TOP", 0, -300)
frame:SetClampedToScreen(true)
frame:SetMovable(true)
frame.sortOn = false
frame.sortWay = "DESC"
frame:SetSize(140, 22)
frame:Hide()

frame.label = CreateFrame("Button", nil, frame)
frame.label:SetAlpha(0.9)
frame.label:SetPoint("TOPLEFT")
frame.label:SetPoint("BOTTOMRIGHT")
frame.label:RegisterForDrag("LeftButton")
frame.label:SetHitRectInsets(0, 0, 0, 0)
frame.label.text = frame.label:CreateFontString(nil, "BORDER", "GameFontNormal")
frame.label.text:SetFont(UNIT_NAME_FONT, 13, "NORMAL")
frame.label.text:SetPoint("TOP", 0, -5)
frame.label.text:SetText(RAID..'/'..PARTY..INFO)
frame.label:SetScript("OnDragStop", function(self) self:GetParent():StopMovingOrSizing() end)
frame.label:SetScript("OnDragStart", function(self) self:GetParent():StartMoving() end)
frame.label:SetScript("OnClick", function(self)
    local parent = self:GetParent()
    if (parent.panel:IsShown()) then
        parent.panel:Hide()
        parent:SetWidth(120)
        parent:SetAlpha(0.8)
        self:SetHitRectInsets(0, 0, 0, 0)
    else
        parent.panel:Show()
        parent:SetWidth(230)
        parent:SetAlpha(1.0)
        self:SetHitRectInsets(72, 32, 0, 0)
    end
end)
frame.label:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, 'ANCHOR_TOP', 0, 6)
	GameTooltip:AddLine(L["Click Show/Hide Member Info"])
	GameTooltip:Show()
end)
frame.label:SetScript("OnLeave", function(self)
	GameTooltip:Hide()
end)
frame.label.progress = CreateFrame("StatusBar", nil, frame.label)
frame.label.progress:SetStatusBarTexture("Interface\\Buttons\\WHITE8X8")
frame.label.progress:SetPoint("BOTTOMLEFT",3,0)
frame.label.progress:SetPoint("BOTTOMRIGHT",-1,0)
frame.label.progress:SetStatusBarColor(0.1, 0.9, 0.1)
frame.label.progress:SetMinMaxValues(0, 100)
frame.label.progress:SetValue(0)
frame.label.progress:SetHeight(2)
frame.label.progress:SetAlpha(0.8)

local buts = CreateFrame("Button", nil, frame.label)
buts:SetHighlightTexture("Interface\\Buttons\\UI-ListBox-Highlight", "ADD")
buts:SetSize(16,16)
buts:RegisterForClicks("AnyUp");
buts:SetPoint("RIGHT", frame.label, "RIGHT", -2, 0)
buts:SetNormalTexture("Interface\\FriendsFrame\\InformationIcon")
buts:SetPushedTexture("Interface\\FriendsFrame\\InformationIcon")
buts:SetHighlightTexture("Interface\\FriendsFrame\\InformationIcon-Highlight");
buts:SetScript("OnClick", function(self, button)
	if button == 'RightButton' then
		ToggleFrame(EuiInspectRaidFrame)
		return;
	end
	
	local chatType = E:CheckChat(true)
	SendChatMessage(format("EUI: %s / %s %s:", RAID, PARTY, INFO), chatType)
	local ilevel, num = 0, 0;
	for _, v in pairs(memberslist) do
		if v.name then
			SendChatMessage(format("%s: %.1f - %s;", v.name, v.ilevel, v.spec), chatType)
			ilevel = ilevel + v.ilevel
			num = num + 1
		end
	end
	if num > 0 then
		SendChatMessage(format("EUI: "..L["Members: %d, AverageLevel: %.1f"], num, ilevel / num), chatType)
	end
end)

buts:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, 'ANCHOR_TOP', 0, 6)
	GameTooltip:AddLine(L["Left Click: Send Member Info"])
	GameTooltip:AddLine(L["Right Click: Close Frame"])
	GameTooltip:Show()
end)
buts:SetScript("OnLeave", function(self)
	GameTooltip:Hide()
end)

--創建條目
local function GetButton(parent, index)
    if (not parent["button"..index]) then
        local button = CreateFrame("Button", nil, parent)
        button:SetHighlightTexture("Interface\\Buttons\\UI-ListBox-Highlight", "ADD")
        button:SetID(index)
        button:SetHeight(16)
        button:SetWidth(224)
        if (index == 1) then
            button:SetPoint("TOPLEFT", parent, "TOPLEFT", 3, -22)
        else
            button:SetPoint("TOP", parent["button"..(index-1)], "BOTTOM", 0, 0)
        end
        button.bg = button:CreateTexture(nil, "BORDER")
        button.bg:SetAtlas("UI-Character-Info-Line-Bounce")
        button.bg:SetPoint("TOPLEFT", 0, 2)
        button.bg:SetPoint("BOTTOMRIGHT", 0, -3)
        button.bg:SetAlpha(0.2)
        button.bg:SetShown(index%2==0)
        button.role = button:CreateTexture(nil, "ARTWORK")
        button.role:SetSize(12, 12)
        button.role:SetPoint("LEFT", 6, -1)
        button.role:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES")
        button.ilevel = button:CreateFontString(nil, "ARTWORK")
        button.ilevel:SetFont(UNIT_NAME_FONT, 13, "OUTLINE")
        button.ilevel:SetSize(50, 13)
        button.ilevel:SetJustifyH("CENTER")
        button.ilevel:SetPoint("LEFT", 18, 0)
        button.ilevel:SetTextColor(1, 0.82, 0)
        button.name = button:CreateFontString(nil, "ARTWORK")
        button.name:SetFont(UNIT_NAME_FONT, 13, "OUTLINE")
        button.name:SetPoint("LEFT", 70, 0)
        button.spec = button:CreateFontString(nil, "ARTWORK")
        button.spec:SetFont(GameFontNormal:GetFont(), 11, "THINOUTLINE")
        button.spec:SetPoint("RIGHT", button, "RIGHT", -8, 0)
        button.spec:SetJustifyH("RIGHT")
        button.spec:SetTextColor(0.8, 0.9, 0.9)
        button:SetScript("OnDoubleClick", function(self)
            local ilevel = self.ilevel:GetText()
            if (ilevel and tonumber(ilevel)) then
                ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
                ChatEdit_InsertLink(self.name:GetText()..": "..ilevel .. "-" .. self.spec:GetText()..";") --by eui
            end
        end)
        parent["button"..index] = button
    end
    return parent["button"..index]
end

--進度
local function UpdateProgress(num, total)
    local value = ceil(num*100/max(1,total))
    frame.label.progress:SetValue(value)
    frame.label.progress:SetStatusBarColor(0.5-value/200, value/100, 0)
end

--導表並顯示進度
local function MakeMembersList()
    local num, total = 0, 0
    for k, _ in pairs(memberslist) do
        memberslist[k] = nil
    end
    for _, v in pairs(members) do
        table.insert(memberslist, v)
        if (v.done) then num = num + 1 end
        total = total + 1
    end
    UpdateProgress(num, total)
end

--顯示
local function ShowMembersList()
    local i = 1
    local button, role, r, g, b
    for _, v in pairs(memberslist) do
        button = GetButton(frame.panel, i)
        button.guid = v.guid
        role = v.role or UnitGroupRolesAssigned(v.unit)
        r, g, b = GetClassColor(v.class)
        if (role == "TANK" or role == "HEALER" or role == "DAMAGER") then
            button.role:SetTexCoord(GetTexCoordsForRoleSmallCircle(role))
            button.role:Show()
        else
            button.role:Hide()
        end
        button.ilevel:SetText(v.ilevel > 0 and format("%.1f",v.ilevel) or " - ")
        button.name:SetText(v.name)
        button.name:SetTextColor(r, g, b)
        button.spec:SetText(v.spec and v.spec or "")
        button:Show()
        i = i + 1
    end
    if (i > 25) then
        frame.panel:SetHeight(424+(i-1-25) * 16)
    else
        frame.panel:SetHeight(max(106,424-15-(25-i)*16))
    end
    while (frame.panel["button"..i]) do
        frame.panel["button"..i]:Hide()
        i = i + 1
    end
end

--排序並顯示
local function SortAndShowMembersList()
    if (not frame.panel:IsShown()) then return end
    if (frame.sortOn) then
        table.sort(memberslist, function(a, b)
            if (frame.sortWay == "ASC") then
				if a.groupNumber and (a.groupNumber > 0) then
					return a.groupNumber < b.groupNumber
				else
					return a.ilevel < b.ilevel
				end
            else
				if a.groupNumber and (a.groupNumber > 0) then
					return a.groupNumber > b.groupNumber
				else
					return a.ilevel > b.ilevel
				end
            end
        end)
    end
    ShowMembersList()
end

--團友列表
frame.panel = CreateFrame("Frame", nil, frame, "InsetFrameTemplate3")
frame.panel:SetScript("OnShow", function(self) SortAndShowMembersList() end)
frame.panel:SetPoint("TOPLEFT")
frame.panel:SetSize(230, 106)
frame.panel:Hide()

--排序按鈕
frame.panel.sortButton = CreateFrame("Button", nil, frame.panel)
frame.panel.sortButton:SetSize(16, 8)
frame.panel.sortButton:SetPoint("TOPLEFT", 38, -8)
frame.panel.sortButton:SetNormalTexture("Interface\\Buttons\\UI-MultiCheck-Up")
frame.panel.sortButton:SetScript("OnClick", function(self)
    local texture = self:GetNormalTexture()
    if (frame.sortWay == "DESC") then
        frame.sortWay = "ASC"
        texture:SetTexCoord(0, 0.8, 7/8, 0)
    else
        frame.sortWay = "DESC"
        texture:SetTexCoord(0, 0.8, 0, 7/8)
    end
    self.sortCount = (self.sortCount or 0) + 1
    if (self.sortCount%3 == 0) then
        frame.sortOn = false
        self:SetNormalTexture("Interface\\Buttons\\UI-MultiCheck-Up")
    else
        frame.sortOn = true
        self:SetNormalTexture("Interface\\Buttons\\UI-SortArrow")
    end
    SortAndShowMembersList()
end)

--重新掃描按鈕
frame.panel.rescanButton = CreateFrame("Button", nil, frame.panel)
frame.panel.rescanButton:SetSize(11, 11)
frame.panel.rescanButton:SetPoint("TOPLEFT", 10, -7)
frame.panel.rescanButton:SetNormalTexture("Interface\\Buttons\\UI-RefreshButton")
frame.panel.rescanButton:SetScript("OnClick", function(self)
    self:SetAlpha(0.3)
    LibSchedule:AddTask({
        identity  = "InspectReccanRaid",
        elasped   = 4,
        onTimeout = function() self:SetAlpha(1) end,
        onStart = function()
            if (not IsInRaid()) then
				if GetNumGroupMembers() == 0 then
					return GetMembers(0)
				end
            end
            for _, v in pairs(members) do
                v.done = false
            end
            LibEvent:event("GROUP_ROSTER_UPDATE")
        end,
    })
end)

--團友變更或觀察到數據時更新顯示
LibEvent:attachTrigger("PLAYER_ENTERING_WORLD, RAID_MEMBER_CHANGED, RAID_INSPECT_READY", function(self)
    MakeMembersList()
    SortAndShowMembersList()
end)

--高亮正在讀取的人員
LibEvent:attachTrigger("PARTY_INSPECT_DONE, RAID_INSPECT_STARTED", function(self, data)
    if (not frame.panel:IsShown()) then return end
    local i = 1
    local button
    while (frame.panel["button"..i]) do
        button = frame.panel["button"..i]
        if (button.guid == data.guid) then
            button.ilevel:SetText("|cff22ff22...|r")
            break
        end
        i = i + 1
    end
end)
