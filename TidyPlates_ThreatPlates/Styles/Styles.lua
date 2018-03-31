local ADDON_NAME, NAMESPACE = ...
local ThreatPlates = NAMESPACE.ThreatPlates

---------------------------------------------------------------------------------------------------
-- Imported functions and constants
---------------------------------------------------------------------------------------------------
local UnitThreatSituation = UnitThreatSituation
local InCombatLockdown = InCombatLockdown
local UnitPlayerControlled = UnitPlayerControlled
local UnitIsOtherPlayersPet = UnitIsOtherPlayersPet
local UnitIsBattlePet = UnitIsBattlePet
local IsInInstance = IsInInstance

local TidyPlatesThreat = TidyPlatesThreat
local TOTEMS = ThreatPlates.TOTEMS
local GetUnitVisibility = ThreatPlates.GetUnitVisibility
local FixUpdateUnitCondition = ThreatPlates.FixUpdateUnitCondition

---------------------------------------------------------------------------------------------------
-- Helper functions for styles and functions
---------------------------------------------------------------------------------------------------

-- Mapping necessary - to removed it, config settings must be changed/migrated
-- Visibility    Scale / Alpha               Threat System
-------------------------------------------------------------------------
-- FriendlyPlayer   = FriendlyPlayer
-- FriendlyNPC      = FriendlyNPC
-- FriendlyTotem    = Totem
-- FriendlyGuardian = Guardian
-- FriendlyPet      = Pet
-- EnemyPlayer      = EnemyPlayer
-- EnemyNPC         = EnemyNPC / Boss / Elite   = Normal / Boss / Elite
-- EnemyTotem       = Totem
-- EnemyGuardian    = Guardian
-- EnemyPet         = Pet
-- EnemyMinus       = Minus                     = Minus
-- NeutralNPC       = Neutral                   = Neutral
-- NeutralGuardian  = Guardian
-- NeutralMinus     = Minus                     = Minus
--                    Tapped                    = Tapped

-- only called for: unit.type == "NPC"
local function GetSimpleUnitType(unit)
  local unit_type = unit.TP_DetailedUnitType
  if unit_type == "EnemyNPC" then
    return "Normal"
  else
    return unit_type
  end
end

local function OnThreatTable(unit)
  -- "is unit inactive" from TidyPlates - fast, but doesn't meant that player is on threat table
  -- return  (unit.health < unit.healthmax) or (unit.isInCombat or unit.threatValue > 0) or (unit.isCasting == true) then

  -- nil means player is not on unit's threat table - more acurate, but slower reaction time than the above solution
  return UnitThreatSituation("player", unit.unitid)
end

local function ShowThreatFeedback(unit)
  local db = TidyPlatesThreat.db.profile.threat

  local show = false

  if not db.toggle.InstancesOnly or IsInInstance() then
    local T = GetSimpleUnitType(unit)
    if db.toggle[T] then
      if db.nonCombat then
        if OnThreatTable(unit) then
          show = true
        end
      else
        show = true
      end
    end
  end

  return show
end

local REACTION_MAPPING = {
  FRIENDLY = "Friendly",
  HOSTILE = "Enemy",
  NEUTRAL = "Neutral",
}

local function GetUnitType(unit)
  local faction = REACTION_MAPPING[unit.reaction]
  local unit_class

  local unit_id, unit_mini, unit_type = unit.unitid, unit.isMini, unit.type
  local totem_id = TOTEMS[unit.name]

  -- not all combinations are possible in the game: Friendly Minus, Neutral Player/Totem/Pet
  if unit_type == "PLAYER" then
    unit_class = "Player"
    unit.TP_DetailedUnitType = faction .. unit_class
  elseif totem_id then
    unit_class = "Totem"
    unit.TP_DetailedUnitType = unit_class
  elseif UnitIsOtherPlayersPet(unit_id) then -- player pets are also considered guardians, so this check has priority
    unit_class = "Pet"
    unit.TP_DetailedUnitType = unit_class
  elseif UnitPlayerControlled(unit_id) then
    unit_class = "Guardian"
    unit.TP_DetailedUnitType = unit_class
  elseif unit_mini then
    unit_class = "Minus"
    unit.TP_DetailedUnitType = unit_class
  else
    unit_class = "NPC"
    if faction == "Neutral" then
      unit.TP_DetailedUnitType = "Neutral"
    else
      unit.TP_DetailedUnitType = faction .. unit_class
    end
  end

  return faction, unit_class
end

local function ShowUnit(unit)
  local db = TidyPlatesThreat.db.profile

  -- If nameplate visibility is controlled by Wow itself (configured via CVars), this function is never used as
  -- nameplates aren't created in the first place (e.g. friendly NPCs, totems, guardians, pets, ...)
  local faction, unit_type = GetUnitType(unit)
  local full_unit_type = faction .. unit_type

  local show, headline_view = GetUnitVisibility(full_unit_type)

  local db_hv = db.HeadlineView
  if not db_hv.ON then
    headline_view = false
  elseif db_hv.ForceHealthbarOnTarget and unit.isTarget then
    headline_view = false
  elseif db_hv.ForceOutOfCombat and not InCombatLockdown() then
    headline_view = true
  end

  local unit_id = unit.unitid
  local e, b, t = (unit.isElite or unit.isRare), unit.isBoss, unit.isTapped
  local visibility = db.Visibility
  local hide_n, hide_e, hide_b, hide_t = visibility.HideNormal , visibility.HideElite, visibility.HideBoss, visibility.HideTapped

  if (e and hide_e) or (b and hide_b) or (t and hide_t) then
    show = false
  elseif hide_n and not (e or b) then
    show = false
  elseif unit_id and UnitIsBattlePet(unit_id) then
    -- TODO: add configuration option for enable/disable
    show = false
  end

  if full_unit_type == "EnemyNPC" then
    if b then
      unit.TP_DetailedUnitType = "Boss"
    elseif e then
      unit.TP_DetailedUnitType = "Elite"
    end
  end

  if t then
    unit.TP_DetailedUnitType = "Tapped"
    show = not hide_t
  end

  return show, unit_type, headline_view
end

-- Returns style based on threat (currently checks for in combat, should not do hat)
local function GetThreatStyle(unit)
  local db = TidyPlatesThreat.db.profile.threat
  local style = "normal"

  -- style tank/dps only used for NPCs/non-player units
  if (InCombatLockdown() and unit.type == "NPC" and unit.reaction ~= "FRIENDLY") and db.ON then
    if ShowThreatFeedback(unit) then
      if TidyPlatesThreat:GetSpecRole()	then
        style = "tank"
      else
        style = "dps"
      end
		end
  end

  return style
end

-- list traversal is inefficient - convert to hash table
local function GetUniqueNameplateSetting(unit)
  local db = TidyPlatesThreat.db.profile
  local unit_name = unit.name

  for k_c,k_v in pairs(db.uniqueSettings.list) do
    if k_v == unit_name then
      local unique_setting = db.uniqueSettings[k_c]
      if unique_setting.useStyle then
        return unique_setting
      else
        return nil
      end
    end
  end

  return nil
end

local function SetStyle(unit)
  -- sometimes unitid is nil, still don't know why, but it creates all kinds of LUA errors as other attributes are nil
  -- also, e.g., unit.type, unit.name, ...
  --ThreatPlates.DEBUG_PRINT_UNIT(unit)
  if not unit.unitid then return "empty" end

  FixUpdateUnitCondition(unit)

  local db = TidyPlatesThreat.db.profile
  local style = "empty"
  local unique_setting

  local show, unit_type, headline_view = ShowUnit(unit)

  if show then
    -- Check if custom nameplate should be used for the unit:
    unique_setting = GetUniqueNameplateSetting(unit)
    if unique_setting then
      if unique_setting.showNameplate then
        style = "unique"
      elseif unique_setting.ShowHeadlineView then
        style = (db.HeadlineView.ON and "NameOnly-Unique") or "unique"
      end
    elseif unit_type == "Totem" then
      local unit_name = unit.name
      local tS = db.totemSettings[TOTEMS[unit_name]]
      if tS[1] then
        -- show healthbar, show headline or show nothing
        -- if db.totemSetting.ShowHeadlineView then
        if db.totemSettings.hideHealthbar then
          style = "etotem"
        else
          style = "totem"
        end
      end
    else
      if headline_view then
        style = "NameOnly"
      elseif unit.reaction == "FRIENDLY" then
        style = "normal"
      else
        -- could call GetThreatStyle here, but that would at a tiny overhead
        style = "normal"
        local db_threat = db.threat
        -- style tank/dps only used for hostile (enemy, neutral) NPCs
        if InCombatLockdown() and unit.type == "NPC" and db_threat.ON then -- and unit.reaction ~= "FRIENDLY" because of previous if-part
          if ShowThreatFeedback(unit) then
            if TidyPlatesThreat:GetSpecRole() then
              style = "tank"
            else
              style = "dps"
            end
          end
        end
      end
    end
  end

  unit.TP_Style = style
  unit.TP_UniqueSetting = unique_setting
  return style, unique_setting
end

ThreatPlates.OnThreatTable = OnThreatTable
ThreatPlates.ShowThreatFeedback = ShowThreatFeedback
ThreatPlates.GetThreatStyle = GetThreatStyle
ThreatPlates.GetUniqueNameplateSetting = GetUniqueNameplateSetting
TidyPlatesThreat.SetStyle = SetStyle
