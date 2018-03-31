﻿local _, ns = ...
local t = ns.ThreatPlates

---------------------------------------------------------------------------------------------------
-- Imported functions and constants
---------------------------------------------------------------------------------------------------
local LibStub = LibStub

local UnitIsUnit = UnitIsUnit
local UnitReaction = UnitReaction

local RGB = t.RGB
local RGB_P = t.RGB_P
local L = t.L
local class = t.Class()

t.Theme = {}

---------------------------------------------------------------------------------------------------
-- Global configs and funtions
---------------------------------------------------------------------------------------------------
local TidyPlatesThreat = TidyPlatesThreat

-- check if the correct TidyPlates version is installed
--function CheckTidyPlatesVersion()
  -- local GlobDB = TidyPlatesThreat.db.global
  -- if not GlobDB.versioncheck then
  -- 	local version_no = 0
  -- 	local version = string.gsub(TIDYPLATES_INSTALLED_VERSION, "Beta", "")
  -- 	for w in string.gmatch(version, "[0-9]+") do
  -- 		version_no = version_no * 1000 + (tonumber(w) or 0)
  -- 	end
  --
  -- 	if version_no < TIDYPLATES_MIN_VERSION_NO then
  -- 		t.Print("\n---------------------------------------\nThe current version of ThreatPlates requires at least TidyPlates "] .. TIDYPLATES_MIN_VERSION .. L[". You have installed an older or incompatible version of TidyPlates: "] .. TIDYPLATES_INSTALLED_VERSION .. L[". Please update TidyPlates, otherwise ThreatPlates will not work properly.")
  -- 	end
  -- 	GlobDB.versioncheck = true
  -- end
--end

t.Print = function(val,override)
  local db = TidyPlatesThreat.db.profile
  if override or db.verbose then
    print(t.Meta("titleshort")..": "..val)
  end
end

function TidyPlatesThreat:SpecName()
  local _,name,_,_,_,role = GetSpecializationInfo(GetSpecialization(false,false,1),nil,false)
  if name then
    return name
  else
    return L["Undetermined"]
  end
end

local tankRole = L["|cff00ff00tanking|r"]
local dpsRole = L["|cffff0000dpsing / healing|r"]

function TidyPlatesThreat:RoleText()
  if TidyPlatesThreat:GetSpecRole() then
    return tankRole
  else
    return dpsRole
  end
end

---------------------------------------------------------------------------------------------------
-- Functions called by TidyPlates
---------------------------------------------------------------------------------------------------

local function ActivateTheme(theme_table, theme_name)
--  -- Recreate all TidyPlates styles for ThreatPlates("normal", "dps", "tank", ...) - required, if theme style settings were changed
--  t.SetThemes(self)

  -- 	Set aura widget style for Aura 1.0
  local db = TidyPlatesThreat.db.profile
  if db.debuffWidget.style == "square" then
    TidyPlatesWidgets.UseSquareDebuffIcon()
  elseif db.debuffWidget.style == "wide" then
    TidyPlatesWidgets.UseWideDebuffIcon()
  end
  TidyPlatesWidgets.SetAuraFilter(ThreatPlatesWidgets.AuraFilter)

  -- TODO: check with what this  was replaces
  --TidyPlatesUtility:EnableGroupWatcher()
  -- TPHUub: if LocalVars.AdvancedEnableUnitCache then TidyPlatesUtility:EnableUnitCache() else TidyPlatesUtility:DisableUnitCache() end
  -- TPHUub: TidyPlatesUtility:EnableHealerTrack()
  -- if TidyPlatesThreat.db.profile.healerTracker.ON then
  -- 	if not healerTrackerEnabled then
  -- 		TidyPlatesUtility.EnableHealerTrack()
  -- 	end
  -- else
  -- 	if healerTrackerEnabled then
  -- 		TidyPlatesUtility.DisableHealerTrack()
  -- 	end
  -- end
  -- TidyPlatesWidgets:EnableTankWatch()
  -- initialize widgets and other Threat Plates stuff
  local ThreatPlatesWidgets = ThreatPlatesWidgets
  ThreatPlatesWidgets.PrepareFilter()
  ThreatPlatesWidgets.ConfigAuraWidgetFilter()
  ThreatPlatesWidgets.ConfigAuraWidget()
  t.SyncWithGameSettings()
end

-- The theme loader will now call 'theme.OnActivateTheme' (a theme function) when the active theme
-- is changed.  it passes two value to the function: the active theme table, and the active theme
-- name.
-- Changelog entry seems to be wrong, there is never passed a 2nd parameter to this function
local function OnActivateTheme(theme_table, theme_name)
  -- Sends a reset notification to all available themes, ie. themeTable == nil
  if not theme_table then
    ThreatPlatesWidgets.DeleteWidgets()
  else
    if not TidyPlatesThreat.db.global.CheckNewLookAndFeel then
      StaticPopup_Show("SwitchToNewLookAndFeel")
    end

    ActivateTheme()

    -- disable all non-ThreatPlates widgets - normally, TidyPlates should do that, but it doesn't

  end
end

------------------
-- ADDON LOADED --
------------------

local function ApplyHubFunctions(theme)
  theme.SetStyle = TidyPlatesThreat.SetStyle
  theme.SetScale = TidyPlatesThreat.SetScale
  theme.SetAlpha = TidyPlatesThreat.SetAlpha
  theme.SetCustomText = TidyPlatesThreat.SetCustomText
  theme.SetNameColor = TidyPlatesThreat.SetNameColor
  theme.SetThreatColor = TidyPlatesThreat.SetThreatColor
  theme.SetCastbarColor = TidyPlatesThreat.SetCastbarColor
  theme.SetHealthbarColor = TidyPlatesThreat.SetHealthbarColor

  local ThreatPlatesWidgets = ThreatPlatesWidgets
  -- TidyPlatesGlobal_OnInitialize() is called when a nameplate is created or re-shown
  theme.OnInitialize = ThreatPlatesWidgets.OnInitialize -- Need to provide widget positions
  -- TidyPlatesGlobal_OnUpdate() is called when other data about the unit changes, or is requested by an external controller.
  theme.OnUpdate = ThreatPlatesWidgets.OnUpdate
  -- TidyPlatesGlobal_OnContextUpdate() is called when a unit is targeted or moused-over.  (Any time the unitid or GUID changes)
  theme.OnContextUpdate = ThreatPlatesWidgets.OnContextUpdate

  theme.OnActivateTheme = OnActivateTheme -- called by Tidy Plates Core, Theme Loader
  --theme.OnChangeProfile = TidyPlatesThreat.OnChangeProfile -- used by TidyPlates when a specialication change occurs or the profile is changed
  --theme.ApplyProfileSettings = TidyPlatesThreat.ApplyProfileSettings
  --theme.ShowConfigPanel = ShowConfigPanel -- I don't think that this function is used any longer by TidyPlates

  return theme
end

---------------------------------------------------------------------------------------------------

StaticPopupDialogs["SetToThreatPlates"] = {
  preferredIndex = STATICPOPUP_NUMDIALOGS,
  text = t.Meta("title")..L[":\n---------------------------------------\nWould you like to \nset your theme to |cff89F559Threat Plates|r?\n\nClicking '|cff00ff00Yes|r' will set you to Threat Plates. \nClicking '|cffff0000No|r' will open the Tidy Plates options."],
  button1 = L["Yes"],
  button2 = L["Cancel"],
  button3 = L["No"],
  timeout = 0,
  whileDead = 1,
  hideOnEscape = 1,
  OnAccept = function()
    TidyPlates:SetTheme(t.THEME_NAME)
    TidyPlatesThreat:StartUp()
    -- Reset Widgets
    TidyPlates:ResetWidgets()
    TidyPlates:ForceUpdate()
  end,
  OnAlt = function()
    -- call OpenToCategory twice to work around an update bug with WoW's internal addons category list introduced with 5.3.0
    InterfaceOptionsFrame_OpenToCategory("Tidy Plates")
    InterfaceOptionsFrame_OpenToCategory("Tidy Plates")
  end,
  OnCancel = function()
    t.Print(L["-->>|cffff0000Activate Threat Plates from the Tidy Plates options!|r<<--"])
  end,
}

StaticPopupDialogs["SwitchToNewLookAndFeel"] = {
  preferredIndex = STATICPOPUP_NUMDIALOGS,
  text = t.Meta("title")..L[":\n---------------------------------------\n|cff89F559Threat Plates|r v8.4 introduces a new default look and feel (currently shown). Do you want to switch to this new look and feel?\n\nYou can revert your decision by changing the default look and feel again in the options dialog (under Nameplate Settings - Healthbar View - Default Settings).\n\nNote: Some of your custom settings may get overwritten if you switch back and forth."],
  button1 = L["Switch"],
  button2 = L["Don't Switch"],
  timeout = 0,
  whileDead = 1,
  hideOnEscape = 1,
  OnAccept = function(self, _, _)
    TidyPlatesThreat.db.global.DefaultsVersion = "SMOOTH"
    TidyPlatesThreat.db.global.CheckNewLookAndFeel = true
    t.SwitchToCurrentDefaultSettings()
    TidyPlatesThreat:ReloadTheme()
  end,
  OnCancel = function(self, data, action)
    if action == "clicked" then
      TidyPlatesThreat.db.global.DefaultsVersion = "CLASSIC"
      TidyPlatesThreat.db.global.CheckNewLookAndFeel = true
      t.SwitchToDefaultSettingsV1()
      TidyPlatesThreat:ReloadTheme()
    end
  end,
}

function TidyPlatesThreat:ReloadTheme()
  -- Recreate all TidyPlates styles for ThreatPlates("normal", "dps", "tank", ...) - required, if theme style settings were changed
  t.SetThemes(self)

  -- ForceUpdate() is called in SetTheme(), also calls theme.OnActivateTheme,
  local TidyPlates = TidyPlates
  if TidyPlates.GetThemeName() == t.THEME_NAME then
    TidyPlates:SetTheme(t.THEME_NAME)
  end
end

function TidyPlatesThreat:StartUp()
  local db = self.db.global

  if not self.db.char.welcome then
    self.db.char.welcome = true
    local Welcome = L["|cff89f559Welcome to |rTidy Plates: |cff89f559Threat Plates!\nThis is your first time using Threat Plates and you are a(n):\n|r|cff"]..t.HCC[class]..self:SpecName().." "..UnitClass("player").."|r|cff89F559.|r\n"

    -- initialize roles for all available specs (level > 10) or set to default (dps/healing)
    for index=1, GetNumSpecializations() do
      local id, spec_name, description, icon, background, role = GetSpecializationInfo(index)
      self:SetRole(t.SPEC_ROLES[t.Class()][index], index)
    end

    t.Print(Welcome..L["|cff89f559You are currently in your "]..self:RoleText()..L["|cff89f559 role.|r"])
    t.Print(L["|cff89f559Additional options can be found by typing |r'/tptp'|cff89F559.|r"])

    local current_theme = TidyPlates.GetThemeName()
    if current_theme == "" then
      current_theme, _ = next(TidyPlatesThemeList, nil)
    end

    if current_theme ~= t.THEME_NAME then
      StaticPopup_Show("SetToThreatPlates")
    else
      local new_version = tostring(t.Meta("version"))
      if db.version ~= new_version then
        db.version = new_version
      end
    end
  else
    local new_version = tostring(t.Meta("version"))
    if db.version ~= new_version then
      -- migrate and/or remove any old DB entries
      t.MigrateDatabase()
      db.version = new_version
    end

    if not db.CheckNewLookAndFeel and TidyPlates.GetThemeName() == t.THEME_NAME then
      StaticPopup_Show("SwitchToNewLookAndFeel")
    end
  end

  TidyPlatesThreat:ReloadTheme()
end

---------------------------------------------------------------------------------------------------
-- AceAddon functions: do init tasks here, like loading the Saved Variables, or setting up slash commands.
---------------------------------------------------------------------------------------------------

-- The OnInitialize() method of your addon object is called by AceAddon when the addon is first loaded
-- by the game client. It's a good time to do things like restore saved settings (see the info on
-- AceConfig for more notes about that).
function TidyPlatesThreat:OnInitialize()
  local defaults = t.DEFAULT_SETTINGS

  -- change back defaults old settings if wanted preserved it the user want's to switch back
  if ThreatPlatesDB and ThreatPlatesDB.global and ThreatPlatesDB.global.DefaultsVersion == "CLASSIC" then
    -- copy default settings, so that their original values are
    defaults = t.GetDefaultSettingsV1(defaults)
  end

  local db = LibStub('AceDB-3.0'):New('ThreatPlatesDB', defaults, 'Default')
  self.db = db

  local RegisterCallback = db.RegisterCallback
  RegisterCallback(self, 'OnProfileChanged', 'ProfChange')
  RegisterCallback(self, 'OnProfileCopied', 'ProfChange')
  RegisterCallback(self, 'OnProfileReset', 'ProfChange')

  -- Setup Interface panel options
  local app_name = t.ADDON_NAME
  local dialog_name = app_name .. " Dialog"
  LibStub("AceConfig-3.0"):RegisterOptionsTable(dialog_name, t.GetInterfaceOptionsTable())
  LibStub("AceConfigDialog-3.0"):AddToBlizOptions(dialog_name, t.ADDON_NAME)

  -- Setup options dialog
  LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable(app_name, t.GetOptionsTable())
  LibStub("AceConfigDialog-3.0"):SetDefaultSize(app_name, 1000, 640)

  -- Setup chat commands
  self:RegisterChatCommand("tptp", "ChatCommand");
end

-- The OnEnable() and OnDisable() methods of your addon object are called by AceAddon when your addon is
-- enabled/disabled by the user. Unlike OnInitialize(), this may occur multiple times without the entire
-- UI being reloaded.
-- AceAddon function: Do more initialization here, that really enables the use of your addon.
-- Register Events, Hook functions, Create Frames, Get information from the game that wasn't available in OnInitialize
function TidyPlatesThreat:OnEnable()
  TidyPlatesThemeList[t.THEME_NAME] = t.Theme
  ApplyHubFunctions(t.Theme)
  -- ActivateTheme()

  self:StartUp()

  --"PLAYER_ALIVE",
  --"PLAYER_LEAVING_WORLD",
  --"PLAYER_REGEN_DISABLED",
  --"PLAYER_TALENT_UPDATE"
  local events = {
    "PLAYER_ENTERING_WORLD",
    "PLAYER_LOGIN",
    "PLAYER_LOGOUT",
    "PLAYER_REGEN_ENABLED",
    "UNIT_FACTION",
    "QUEST_WATCH_UPDATE",
    "NAME_PLATE_CREATED",
    "QUEST_ACCEPTED",
  }

  for i = 1, #events do
    self:RegisterEvent(events[i])
  end
end

--function WelcomeHome:OnDisable()
--  -- Called when the addon is disabled
--end

-----------------------------------------------------------------------------------
-- WoW EVENTS --
-----------------------------------------------------------------------------------

local set = false
function TidyPlatesThreat:SetCvars()
  if not set then
    SetCVar("ShowClassColorInNameplate", 1)
    local ProfDB = self.db.profile
    if GetCVar("nameplateShowEnemyTotems") == "1" then
      ProfDB.nameplate.toggle["Totem"] = true
    else
      ProfDB.nameplate.toggle["Totem"] = false
    end

    if GetCVar("ShowVKeyCastbar") == "1" then
      ProfDB.settings.castbar.show = true
    else
      ProfDB.settings.castbar.show = false
    end

    set = true
  end
end

function TidyPlatesThreat:SetGlows()
  local ProfDB = self.db.profile.threat
  -- Required for threat/aggro detection
  if ProfDB.ON and (GetCVar("threatWarning") ~= 3) then
    SetCVar("threatWarning", 3)
  elseif not ProfDB.ON and (GetCVar("threatWarning") ~= 0) then
    SetCVar("threatWarning", 0)
  end
end

--function TidyPlatesThreat:PLAYER_ALIVE()
--end

function TidyPlatesThreat:PLAYER_ENTERING_WORLD()
  local _,type = IsInInstance()
  local ProfDB = self.db.profile
  if type == "pvp" or type == "arena" then
    ProfDB.OldSetting = ProfDB.threat.ON
    ProfDB.threat.ON = false
  else
    ProfDB.threat.ON = ProfDB.OldSetting
  end

  -- overwrite things TidyPlatesHub does on PLAYER_ENTERING_WORLD
  ActivateTheme()
  --self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
end

--function TidyPlatesThreat:PLAYER_LEAVING_WORLD()
--end

function TidyPlatesThreat:PLAYER_LOGIN(...)
  self.db.profile.cache = {}
  if self.db.char.welcome and (TidyPlatesOptions.ActiveTheme == t.THEME_NAME) then
    t.Print(L["|cff89f559Threat Plates:|r Welcome back |cff"]..t.HCC[class]..UnitName("player").."|r!!")
  end
  -- if class == "WARRIOR" or class == "DRUID" or class == "DEATHKNIGHT" or class == "PALADIN" then
  -- 	self:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
  -- end
end

function TidyPlatesThreat:PLAYER_LOGOUT(...)
  self.db.profile.cache = {}
end

-- Disabled events PLAYER_REGEN_DISABLED, PLAYER_TALENT_UPDATE, UPDATE_SHAPESHIFT_FORM, ACTIVE_TALENT_GROUP_CHANGED
-- as they are not used currently

-- function TidyPlatesThreat:PLAYER_REGEN_DISABLED()
-- 	-- Disabled while 5.4.8 changes are being officilizedself
-- 	--self:SetGlows()
-- end

function TidyPlatesThreat:PLAYER_REGEN_ENABLED()
  self:SetGlows()
  self:SetCvars()
  -- Syncs addon settings with game settings in case changes weren't possible during startup, reload
  -- or profile reset because character was in combat.
  t.SyncWithGameSettings()
end

-- QuestWidget needs to update all nameplates when a quest was completed
function TidyPlatesThreat:UNIT_FACTION(event, unitid)
  TidyPlates:ForceUpdate()
end

-- nameplate color can change when factions change (e.g., with disguises)
-- Legion example: Suramar city and Masquerade
function TidyPlatesThreat:QUEST_WATCH_UPDATE(event, quest_index)
  if TidyPlatesThreat.db.profile.questWidget.ON then
    TidyPlates:ForceUpdate()
  end
end
function TidyPlatesThreat:QUEST_ACCEPTED(event, quest_index, _)
  if TidyPlatesThreat.db.profile.questWidget.ON then
    TidyPlates:ForceUpdate()
  end
end

-- function TidyPlatesThreat:PLAYER_TALENT_UPDATE()
-- 	--
-- end

-- function TidyPlatesThreat:UPDATE_SHAPESHIFT_FORM()
-- 	--self.ShapeshiftUpdate()
-- end

-- Fires when the player switches to another specialication or everytime the player changes a talent
-- Completely handled by TidyPlates
-- function TidyPlatesThreat:ACTIVE_TALENT_GROUP_CHANGED()
-- 	if (TidyPlatesOptions.ActiveTheme == t.THEME_NAME) and self.db.profile.verbose then
-- 		t.Print(L"|cff89F559Threat Plates|r: Player spec change detected: |cff"]..t.HCC[class]..self:SpecName()..L"|r, you are now in your "]..self:RoleText()..L[" role."])
-- 	end
-- end

-- Prevent Blizzard nameplates from re-appearing, but show personal ressources bar, if enabled
local function FrameOnShow(self)
  --if not self.carrier and InterfaceOptionsNamesPanelUnitNameplatesMakeLarger:GetValue() ~= "1" then

  -- if not self.carrier and not UnitIsUnit(self.unit, "player") then
  -- not self:GetParent().carrier and
  if not self.unit or not UnitIsUnit(self.unit, "player") then
    -- hide blizzard's nameplate
    if not TidyPlatesThreat.db.profile.ShowFriendlyBlizzardNameplates then
      self:Hide()
      return
    end

    local unit = self.unit
    local show = unit and UnitReaction(unit, "player") > 4
    if show then
      self:Show()
      return
    end
  end
end

local function FrameOnUpdate(self)
  local frame_level = self:GetFrameLevel() * 2
  self.carrier:SetFrameLevel(frame_level)
  self.extended:SetFrameLevel(frame_level)

  if not TidyPlatesThreat.db.profile.ShowFriendlyBlizzardNameplates then return end

  local unit = self.UnitFrame.unit
  local show = unit and UnitReaction(unit, "player") > 4
  if show then
    self:GetChildren():Show()
    self.carrier:Hide()
  end
end

local function FrameOnHide(self)
  if not TidyPlatesThreat.db.profile.ShowFriendlyBlizzardNameplates then return end

  local unit = self.unit
  local show = unit and UnitReaction(unit, "player") > 4

  if show then
    self:Show()
    self:GetParent().carrier:Hide()
  end
end

-- Preventing WoW from re-showing Blizzard nameplates in certain situations
-- e.g., press ESC, got to Interface, Names, press ESC and voila!
-- Thanks to Kesava (KuiNameplates) for this solution
function TidyPlatesThreat:NAME_PLATE_CREATED(event, plate)
  if plate.UnitFrame then
    plate.UnitFrame:HookScript('OnShow',FrameOnShow)
    plate.UnitFrame:HookScript('OnHide',FrameOnHide)
  end

  plate:HookScript('OnUpdate', FrameOnUpdate)
end
