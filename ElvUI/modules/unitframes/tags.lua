﻿local E, L, V, P, G = unpack(select(2, ...)); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local _, ns = ...
local ElvUF = ns.oUF
assert(ElvUF, "ElvUI was unable to locate oUF.")

--Cache global variables
--Lua functions
local _G = _G
local unpack, pairs = unpack, pairs
local twipe = table.wipe
local ceil, sqrt, floor = math.ceil, math.sqrt, math.floor
local format = string.format
--WoW API / Variables
local C_PetJournal_GetPetTeamAverageLevel = C_PetJournal.GetPetTeamAverageLevel
local GetGuildInfo = GetGuildInfo
local GetNumGroupMembers = GetNumGroupMembers
local GetPVPTimer = GetPVPTimer
local GetQuestGreenRange = GetQuestGreenRange
local GetRelativeDifficultyColor = GetRelativeDifficultyColor
local GetShapeshiftFormID = GetShapeshiftFormID
local GetSpecialization = GetSpecialization
local GetThreatStatusColor = GetThreatStatusColor
local GetTime = GetTime
local IsInGroup = IsInGroup
local IsInRaid = IsInRaid
local QuestDifficultyColors = QuestDifficultyColors
local UnitAlternatePowerTextureInfo = UnitAlternatePowerTextureInfo
local UnitBattlePetLevel = UnitBattlePetLevel
local UnitClass = UnitClass
local UnitClassification = UnitClassification
local UnitDetailedThreatSituation = UnitDetailedThreatSituation
local UnitExists = UnitExists
local UnitGetIncomingHeals = UnitGetIncomingHeals
local UnitGetTotalAbsorbs = UnitGetTotalAbsorbs
local UnitGUID = UnitGUID
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitIsAFK = UnitIsAFK
local UnitIsBattlePetCompanion = UnitIsBattlePetCompanion
local UnitIsConnected = UnitIsConnected
local UnitIsDead = UnitIsDead
local UnitIsDeadOrGhost = UnitIsDeadOrGhost
local UnitIsDND = UnitIsDND
local UnitIsGhost = UnitIsGhost
local UnitIsPlayer = UnitIsPlayer
local UnitIsPVP = UnitIsPVP
local UnitIsPVPFreeForAll = UnitIsPVPFreeForAll
local UnitIsUnit = UnitIsUnit
local UnitIsWildBattlePet = UnitIsWildBattlePet
local UnitLevel = UnitLevel
local UnitPower = UnitPower
local UnitPowerMax = UnitPowerMax
local UnitPowerType = UnitPowerType
local UnitReaction = UnitReaction
local UnitStagger = UnitStagger
local GetUnitSpeed = GetUnitSpeed
local ALTERNATE_POWER_INDEX = ALTERNATE_POWER_INDEX
local DEAD = DEAD
local DEFAULT_AFK_MESSAGE = DEFAULT_AFK_MESSAGE
local MOONKIN_FORM = MOONKIN_FORM
local PVP = PVP
local SHADOW_ORBS_SHOW_LEVEL = SHADOW_ORBS_SHOW_LEVEL
local SPEC_MONK_BREWMASTER = SPEC_MONK_BREWMASTER
local SPEC_PALADIN_RETRIBUTION = SPEC_PALADIN_RETRIBUTION
local SPEC_PRIEST_SHADOW = SPEC_PRIEST_SHADOW
local SPEC_WARLOCK_AFFLICTION = SPEC_WARLOCK_AFFLICTION
local SPEC_WARLOCK_DEMONOLOGY = SPEC_WARLOCK_DEMONOLOGY
local SPEC_WARLOCK_DESTRUCTION = SPEC_WARLOCK_DESTRUCTION

local SPELL_POWER_MANA = Enum.PowerType.Mana
local SPELL_POWER_RAGE = Enum.PowerType.Rage
local SPELL_POWER_FOCUS = Enum.PowerType.Focus
local SPELL_POWER_ENERGY = Enum.PowerType.Energy
local SPELL_POWER_RUNES = Enum.PowerType.Runes
local SPELL_POWER_RUNIC_POWER = Enum.PowerType.RunicPower
local SPELL_POWER_SOUL_SHARDS = Enum.PowerType.SoulShards
local SPELL_POWER_LUNAR_POWER = Enum.PowerType.LunarPower
local SPELL_POWER_HOLY_POWER = Enum.PowerType.HolyPower
local SPELL_POWER_LIGHT_FORCE = Enum.PowerType.Chi
local SPELL_POWER_INSANITY = Enum.PowerType.Insanity
local SPELL_POWER_BURNING_EMBERS = Enum.PowerType.Obsolete
local SPELL_POWER_DEMONIC_FURY = Enum.PowerType.Fury
local SPELL_POWER_ARCANE_CHARGES = Enum.PowerType.ArcaneCharges
local SPELL_POWER_MAELSTROM = Enum.PowerType.Maelstrom
local SPELL_POWER_FURY = Enum.PowerType.Fury
local SPELL_POWER_PAIN = Enum.PowerType.Pain
local SPELL_POWER_CHI = Enum.PowerType.Chi


local UNITNAME_SUMMON_TITLE17 = UNITNAME_SUMMON_TITLE17
local UNKNOWN = UNKNOWN

--Global variables that we don't cache, list them here for mikk's FindGlobals script
-- GLOBALS: Hex, PowerBarColor

------------------------------------------------------------------------
--	Tags
------------------------------------------------------------------------

local function UnitName(unit)
	local name, realm = _G.UnitName(unit);
	if name == UNKNOWN and E.myclass == "MONK" and UnitIsUnit(unit, "pet") then
		name = UNITNAME_SUMMON_TITLE17:format(_G.UnitName("player"))
	else
		return name, realm
	end
end

local NECROTIC_ROT = GetSpellInfo(209858)
local BURST = GetSpellInfo(240443)

ElvUF.Tags.Events["affix:necrotic-rot"] = "UNIT_AURA PLAYER_ENTERING_WORLD"
ElvUF.Tags.Methods["affix:necrotic-rot"] = function(unit)
	local name, _, _, count, _, _, _, _, _, _, spellId, _ = UnitDebuff(unit, NECROTIC_ROT)
	if spellId ~= 209858 then
		return ""
	else
		return count
	end
end

ElvUF.Tags.Events["affix:necrotic-rot-percent"] = "UNIT_AURA PLAYER_ENTERING_WORLD"
ElvUF.Tags.Methods["affix:necrotic-rot-percent"] = function(unit)
	local name, _, _, count, _, _, _, _, _, _, spellId, _ = UnitDebuff(unit, NECROTIC_ROT)
	if spellId ~= 209858 then
		return ""
	else
		return (count*3).. "%"
	end
end

ElvUF.Tags.Events["affix:bursting"] = "UNIT_AURA PLAYER_ENTERING_WORLD"
ElvUF.Tags.Methods["affix:bursting"] = function(unit)
	local name, _, _, count, _, _, _, _, _, _, spellId, _ = UnitDebuff(unit, BURST)
	if spellId ~= 240443 then
		return ""
	else
		return count
	end
end

ElvUF.Tags.Events["affix:bursting-percent"] = "UNIT_AURA PLAYER_ENTERING_WORLD"
ElvUF.Tags.Methods["affix:bursting-percent"] = function(unit)
	local name, _, _, count, _, _, _, _, _, _, spellId, _ = UnitDebuff(unit, BURST)
	if spellId ~= 240443 then
		return ""
	else
		return (count*2.5).. "%/s"
	end
end


local function NormalizeSpeed(speed)
	return speed * 100 / 7 + 0.5
end
local FORMAT_PERCENT_PLAYER = format("%s %%d%%%%", PLAYER) -- Percentage displaying format without target
local FORMAT_PERCENT_PLAYERTARGET = format("%s %%d%%%%, %s %%d%%%%", PLAYER, TARGET) -- Percentage displaying format with target

ElvUF.Tags.OnUpdateThrottle['PlayerTargetSpeed'] = 1
ElvUF.Tags.Methods['PlayerTargetSpeed'] = function(unit)
	local hasTarget = UnitExists("target") and not UnitIsUnit("player", "target") and not UnitIsUnit("vehicle", "target")
	local playerSpeed = GetUnitSpeed(unit)
	local targetSpeed = hasTarget and GetUnitSpeed("target") or nil
	if targetSpeed then
		return (format(FORMAT_PERCENT_PLAYERTARGET, NormalizeSpeed(playerSpeed), NormalizeSpeed(targetSpeed)));
	else
		return (format(FORMAT_PERCENT_PLAYER, NormalizeSpeed(playerSpeed)));
	end
end


ElvUF.Tags.Events['faction'] = 'UNIT_NAME_UPDATE'
ElvUF.Tags.Methods['faction'] = function(unit)
	local _, localizedFaction = UnitFactionGroup(unit)
	local _, playerFaction = UnitFactionGroup('player')
	if localizedFaction then
		return localizedFaction
	else
		return ''
	end
end

ElvUF.Tags.Events['cpoints'] = 'UNIT_COMBO_POINTS UNIT_AURA'
ElvUF.Tags.Methods['cpoints'] = function(unit)
	local cp
	if(UnitHasVehicleUI'player') then
		cp = UnitPower('vehicle', 4)
	else
		cp = UnitPower('player', 4)
	end
	if cp and cp > 0 then
		local color = Hex(unpack(E:GetColorTable(E.db.unitframe.colors.classResources.ROGUE[cp])))
		
		return color..cp..'|r';
	else
		return '';
	end
end

ElvUF.Tags.Events['anticipation'] = 'UNIT_AURA PLAYER_ENTERING_WORLD'
ElvUF.Tags.Methods['anticipation'] = function(unit)
	if select(2, UnitClass('player')) ~= "ROGUE" then return ''; end
		
	local ANTICIPATION = GetSpellInfo(115189)
	local name, _, _, count = UnitBuff(unit, ANTICIPATION)
	
	if count and count > 0 then
		local color = Hex(unpack(E:GetColorTable(E.db.unitframe.colors.classResources.ROGUE[count])))
		
		return color..count..'|r';
	else
		return '';
	end
end


ElvUF.Tags.Events['raidgroup'] = 'GROUP_ROSTER_UPDATE'
ElvUF.Tags.Methods['raidgroup'] = function(unit)
	local R = {'①','②','③','④','⑤','⑥','⑦','⑧'}
	if IsInRaid() then
		for i = 1, GetNumGroupMembers() do
			local name, _, subgroup = GetRaidRosterInfo(i)
			local Name, Realm = UnitFullName(unit)
			if (name == Name) or (Realm and (name == Name..'-'..Realm)) then
				return R[subgroup] or ''
			end
		end
	else
		return ''
	end
end

ElvUF.Tags.Events['altpower:percent'] = "UNIT_POWER UNIT_MAXPOWER"
ElvUF.Tags.Methods['altpower:percent'] = function(u)
	local cur = UnitPower(u, ALTERNATE_POWER_INDEX)
	if cur > 0 then
		local max = UnitPowerMax(u, ALTERNATE_POWER_INDEX)

		return E:GetFormattedText('PERCENT', cur, max)
	else
		return ''
	end
end

ElvUF.Tags.Events['altpower:current'] = "UNIT_POWER"
ElvUF.Tags.Methods['altpower:current'] = function(u)
	local cur = UnitPower(u, ALTERNATE_POWER_INDEX)
	if cur > 0 then
		return cur
	else
		return ''
	end
end

ElvUF.Tags.Events['altpower:current-percent'] = "UNIT_POWER UNIT_MAXPOWER"
ElvUF.Tags.Methods['altpower:current-percent'] = function(u)
	local cur = UnitPower(u, ALTERNATE_POWER_INDEX)
	if cur > 0 then
		local max = UnitPowerMax(u, ALTERNATE_POWER_INDEX)

		return E:GetFormattedText('CURRENT_PERCENT', cur, max)
	else
		return ''
	end
end

ElvUF.Tags.Events['altpower:deficit'] = "UNIT_POWER UNIT_MAXPOWER"
ElvUF.Tags.Methods['altpower:deficit'] = function(u)
	local cur = UnitPower(u, ALTERNATE_POWER_INDEX)
	if cur > 0 then
		local max = UnitPowerMax(u, ALTERNATE_POWER_INDEX)

		return E:GetFormattedText('DEFICIT', cur, max)
	else
		return ''
	end
end

ElvUF.Tags.Events['altpower:current-max'] = "UNIT_POWER UNIT_MAXPOWER"
ElvUF.Tags.Methods['altpower:current-max'] = function(u)
	local cur = UnitPower(u, ALTERNATE_POWER_INDEX)
	if cur > 0 then
		local max = UnitPowerMax(u, ALTERNATE_POWER_INDEX)

		return E:GetFormattedText('CURRENT_MAX', cur, max)
	else
		return ''
	end
end

ElvUF.Tags.Events['altpower:current-max-percent'] = "UNIT_POWER UNIT_MAXPOWER"
ElvUF.Tags.Methods['altpower:current-max-percent'] = function(u)
	local cur = UnitPower(u, ALTERNATE_POWER_INDEX)
	if cur > 0 then
		local max = UnitPowerMax(u, ALTERNATE_POWER_INDEX)

		E:GetFormattedText('CURRENT_MAX_PERCENT', cur, max)
	else
		return ''
	end
end

ElvUF.Tags.Events['altpowercolor'] = "UNIT_POWER UNIT_MAXPOWER"
ElvUF.Tags.Methods['altpowercolor'] = function(u)
	local cur = UnitPower(u, ALTERNATE_POWER_INDEX)
	if cur > 0 then
		local tPath, r, g, b = UnitAlternatePowerTextureInfo(u, 2)

		if not r then
			r, g, b = 1, 1, 1
		end

		return Hex(r,g,b)
	else
		return ''
	end
end

ElvUF.Tags.Events['afk'] = 'PLAYER_FLAGS_CHANGED'
ElvUF.Tags.Methods['afk'] = function(unit)
	local isAFK = UnitIsAFK(unit)
	if isAFK then
		return ('|cffFFFFFF[|r|cffFF0000%s|r|cFFFFFFFF]|r'):format(DEFAULT_AFK_MESSAGE)
	else
		return ''
	end
end

ElvUF.Tags.Events['healthcolor'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED'
ElvUF.Tags.Methods['healthcolor'] = function(unit)
	if UnitIsDeadOrGhost(unit) or not UnitIsConnected(unit) then
		return Hex(0.84, 0.75, 0.65)
	else
		local r, g, b = ElvUF.ColorGradient(UnitHealth(unit), UnitHealthMax(unit), 0.69, 0.31, 0.31, 0.65, 0.63, 0.35, 0.33, 0.59, 0.33)
		return Hex(r, g, b)
	end
end

ElvUF.Tags.Events['health:max'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED'
ElvUF.Tags.Methods['health:max'] = function(unit)
	return UnitHealthMax(unit) or ' '
end

ElvUF.Tags.Events['health:current'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED'
ElvUF.Tags.Methods['health:current'] = function(unit)
	local status = UnitIsDead(unit) and DEAD or UnitIsGhost(unit) and L["Ghost"] or not UnitIsConnected(unit) and L["Offline"]
	if (status) then
		return status
	else
		return E:GetFormattedText('CURRENT', UnitHealth(unit), UnitHealthMax(unit))
	end
end

ElvUF.Tags.Events['health:deficit'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED'
ElvUF.Tags.Methods['health:deficit'] = function(unit)
	local status = UnitIsDead(unit) and DEAD or UnitIsGhost(unit) and L["Ghost"] or not UnitIsConnected(unit) and L["Offline"]

	if (status) then
		return status
	else
		return E:GetFormattedText('DEFICIT', UnitHealth(unit), UnitHealthMax(unit))
	end
end

ElvUF.Tags.Events['health:current-percent'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED'
ElvUF.Tags.Methods['health:current-percent'] = function(unit)
	local status = UnitIsDead(unit) and DEAD or UnitIsGhost(unit) and L["Ghost"] or not UnitIsConnected(unit) and L["Offline"]

	if (status) then
		return status
	else
		return E:GetFormattedText('CURRENT_PERCENT', UnitHealth(unit), UnitHealthMax(unit))
	end
end

ElvUF.Tags.Events['health:current-max'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED'
ElvUF.Tags.Methods['health:current-max'] = function(unit)
	local status = UnitIsDead(unit) and DEAD or UnitIsGhost(unit) and L["Ghost"] or not UnitIsConnected(unit) and L["Offline"]

	if (status) then
		return status
	else
		return E:GetFormattedText('CURRENT_MAX', UnitHealth(unit), UnitHealthMax(unit))
	end
end

ElvUF.Tags.Events['health:current-max-percent'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED'
ElvUF.Tags.Methods['health:current-max-percent'] = function(unit)
	local status = UnitIsDead(unit) and DEAD or UnitIsGhost(unit) and L["Ghost"] or not UnitIsConnected(unit) and L["Offline"]

	if (status) then
		return status
	else
		return E:GetFormattedText('CURRENT_MAX_PERCENT', UnitHealth(unit), UnitHealthMax(unit))
	end
end

ElvUF.Tags.Events['status'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED'
ElvUF.Tags.Methods['status'] = function(unit)
	local status = UnitIsDead(unit) and DEAD or UnitIsGhost(unit) and L['Ghost'] or not UnitIsConnected(unit) and L['Offline']

	if (status) then
		return status
	else
		return ''
	end
end

ElvUF.Tags.Events['health:max'] = 'UNIT_MAXHEALTH'
ElvUF.Tags.Methods['health:max'] = function(unit)
	local max = UnitHealthMax(unit)

	return E:GetFormattedText('CURRENT', max, max)
end

ElvUF.Tags.Events['health:percent'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED'
ElvUF.Tags.Methods['health:percent'] = function(unit)
	local status = UnitIsDead(unit) and DEAD or UnitIsGhost(unit) and L["Ghost"] or not UnitIsConnected(unit) and L["Offline"]

	if (status) then
		return status
	else
		return E:GetFormattedText('PERCENT', UnitHealth(unit), UnitHealthMax(unit))
	end
end

ElvUF.Tags.Events['health:percent-with-absorbs'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_ABSORB_AMOUNT_CHANGED UNIT_CONNECTION PLAYER_FLAGS_CHANGED'
ElvUF.Tags.Methods['health:percent-with-absorbs'] = function(unit)
	local status = UnitIsDead(unit) and L["Dead"] or UnitIsGhost(unit) and L["Ghost"] or not UnitIsConnected(unit) and L["Offline"]

	if (status) then
		return status
	end
		
	local absorb = UnitGetTotalAbsorbs(unit) or 0
	if absorb == 0 then
		return E:GetFormattedText('PERCENT', UnitHealth(unit), UnitHealthMax(unit))
	end
	
	local healthTotalIncludingAbsorbs = UnitHealth(unit) + absorb
	return E:GetFormattedText('PERCENT', healthTotalIncludingAbsorbs, UnitHealthMax(unit))
end

ElvUF.Tags.Events['health:current-nostatus'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH'
ElvUF.Tags.Methods['health:current-nostatus'] = function(unit)
	return E:GetFormattedText('CURRENT', UnitHealth(unit), UnitHealthMax(unit))
end

ElvUF.Tags.Events['health:deficit-nostatus'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH'
ElvUF.Tags.Methods['health:deficit-nostatus'] = function(unit)
	return E:GetFormattedText('DEFICIT', UnitHealth(unit), UnitHealthMax(unit))
end

ElvUF.Tags.Events['health:current-percent-nostatus'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH'
ElvUF.Tags.Methods['health:current-percent-nostatus'] = function(unit)
	return E:GetFormattedText('CURRENT_PERCENT', UnitHealth(unit), UnitHealthMax(unit))
end

ElvUF.Tags.Events['health:current-max-nostatus'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH'
ElvUF.Tags.Methods['health:current-max-nostatus'] = function(unit)
	return E:GetFormattedText('CURRENT_MAX', UnitHealth(unit), UnitHealthMax(unit))
end

ElvUF.Tags.Events['health:current-max-percent-nostatus'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH'
ElvUF.Tags.Methods['health:current-max-percent-nostatus'] = function(unit)
	return E:GetFormattedText('CURRENT_MAX_PERCENT', UnitHealth(unit), UnitHealthMax(unit))
end

ElvUF.Tags.Events['health:percent-nostatus'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH'
ElvUF.Tags.Methods['health:percent-nostatus'] = function(unit)
	return E:GetFormattedText('PERCENT', UnitHealth(unit), UnitHealthMax(unit))
end

ElvUF.Tags.Events['health:deficit-percent:name'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_NAME_UPDATE'
ElvUF.Tags.Methods['health:deficit-percent:name'] = function(unit)
	local currentHealth = UnitHealth(unit)
	local deficit = UnitHealthMax(unit) - currentHealth

	if (deficit > 0 and currentHealth > 0) then
		return _TAGS["health:percent-nostatus"](unit)
	else
		return _TAGS["name"](unit)
	end
end

ElvUF.Tags.Events['health:deficit-percent:name-long'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_NAME_UPDATE'
ElvUF.Tags.Methods['health:deficit-percent:name-long'] = function(unit)
	local currentHealth = UnitHealth(unit)
	local deficit = UnitHealthMax(unit) - currentHealth

	if (deficit > 0 and currentHealth > 0) then
		return _TAGS["health:percent-nostatus"](unit)
	else
		return _TAGS["name:long"](unit)
	end
end

ElvUF.Tags.Events['health:deficit-percent:name-medium'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_NAME_UPDATE'
ElvUF.Tags.Methods['health:deficit-percent:name-medium'] = function(unit)
	local currentHealth = UnitHealth(unit)
	local deficit = UnitHealthMax(unit) - currentHealth

	if (deficit > 0 and currentHealth > 0) then
		return _TAGS["health:percent-nostatus"](unit)
	else
		return _TAGS["name:medium"](unit)
	end
end

ElvUF.Tags.Events['health:deficit-percent:name-short'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_NAME_UPDATE'
ElvUF.Tags.Methods['health:deficit-percent:name-short'] = function(unit)
	local currentHealth = UnitHealth(unit)
	local deficit = UnitHealthMax(unit) - currentHealth

	if (deficit > 0 and currentHealth > 0) then
		return _TAGS["health:percent-nostatus"](unit)
	else
		return _TAGS["name:short"](unit)
	end
end

ElvUF.Tags.Events['health:deficit-percent:name-veryshort'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_NAME_UPDATE'
ElvUF.Tags.Methods['health:deficit-percent:name-veryshort'] = function(unit)
	local currentHealth = UnitHealth(unit)
	local deficit = UnitHealthMax(unit) - currentHealth

	if (deficit > 0 and currentHealth > 0) then
		return _TAGS["health:percent-nostatus"](unit)
	else
		return _TAGS["name:veryshort"](unit)
	end
end

ElvUF.Tags.Events['power:current'] = 'UNIT_DISPLAYPOWER UNIT_POWER_FREQUENT UNIT_MAXPOWER'
ElvUF.Tags.Methods['power:current'] = function(unit)
	local pType = UnitPowerType(unit)
	local min = UnitPower(unit, pType)

	return min == 0 and ' ' or	E:GetFormattedText('CURRENT', min, UnitPowerMax(unit, pType))
end

ElvUF.Tags.Events['power:current-max'] = 'UNIT_DISPLAYPOWER UNIT_POWER_FREQUENT UNIT_MAXPOWER'
ElvUF.Tags.Methods['power:current-max'] = function(unit)
	local pType = UnitPowerType(unit)
	local min = UnitPower(unit, pType)

	return min == 0 and ' ' or	E:GetFormattedText('CURRENT_MAX', min, UnitPowerMax(unit, pType))
end

ElvUF.Tags.Events['power:current-percent'] = 'UNIT_DISPLAYPOWER UNIT_POWER_FREQUENT UNIT_MAXPOWER'
ElvUF.Tags.Methods['power:current-percent'] = function(unit)
	local pType = UnitPowerType(unit)
	local min = UnitPower(unit, pType)

	return min == 0 and ' ' or	E:GetFormattedText('CURRENT_PERCENT', min, UnitPowerMax(unit, pType))
end

ElvUF.Tags.Events['power:current-max-percent'] = 'UNIT_DISPLAYPOWER UNIT_POWER_FREQUENT UNIT_MAXPOWER'
ElvUF.Tags.Methods['power:current-max-percent'] = function(unit)
	local pType = UnitPowerType(unit)
	local min = UnitPower(unit, pType)

	return min == 0 and ' ' or	E:GetFormattedText('CURRENT_MAX_PERCENT', min, UnitPowerMax(unit, pType))
end

ElvUF.Tags.Events['power:percent'] = 'UNIT_DISPLAYPOWER UNIT_POWER_FREQUENT UNIT_MAXPOWER'
ElvUF.Tags.Methods['power:percent'] = function(unit)
	local pType = UnitPowerType(unit)
	local min = UnitPower(unit, pType)

	return min == 0 and ' ' or	E:GetFormattedText('PERCENT', min, UnitPowerMax(unit, pType))
end

ElvUF.Tags.Events['power:deficit'] = 'UNIT_DISPLAYPOWER UNIT_POWER_FREQUENT UNIT_MAXPOWER'
ElvUF.Tags.Methods['power:deficit'] = function(unit)
	local pType = UnitPowerType(unit)

	return E:GetFormattedText('DEFICIT', UnitPower(unit, pType), UnitPowerMax(unit, pType))
end

ElvUF.Tags.Events['power:max'] = 'UNIT_DISPLAYPOWER UNIT_MAXPOWER'
ElvUF.Tags.Methods['power:max'] = function(unit)
	local pType = UnitPowerType(unit)
	local max = UnitPowerMax(unit, pType)

	return E:GetFormattedText('CURRENT', max, max)
end

ElvUF.Tags.Methods['manacolor'] = function(unit)
	local altR, altG, altB = PowerBarColor["MANA"].r, PowerBarColor["MANA"].g, PowerBarColor["MANA"].b
	local color = ElvUF['colors'].power["MANA"]
	if color then
		return Hex(color[1], color[2], color[3])
	else
		return Hex(altR, altG, altB)
	end
end

ElvUF.Tags.Events['mana:current'] = 'UNIT_POWER_FREQUENT UNIT_MAXPOWER'
ElvUF.Tags.Methods['mana:current'] = function(unit)
	local min = UnitPower(unit, SPELL_POWER_MANA)

	return min == 0 and ' ' or	E:GetFormattedText('CURRENT', min, UnitPowerMax(unit, SPELL_POWER_MANA))
end

ElvUF.Tags.Events['mana:current-max'] = 'UNIT_POWER_FREQUENT UNIT_MAXPOWER'
ElvUF.Tags.Methods['mana:current-max'] = function(unit)
	local min = UnitPower(unit, SPELL_POWER_MANA)

	return min == 0 and ' ' or	E:GetFormattedText('CURRENT_MAX', min, UnitPowerMax(unit, SPELL_POWER_MANA))
end

ElvUF.Tags.Events['mana:current-percent'] = 'UNIT_POWER_FREQUENT UNIT_MAXPOWER'
ElvUF.Tags.Methods['mana:current-percent'] = function(unit)
	local min = UnitPower(unit, SPELL_POWER_MANA)

	return min == 0 and ' ' or	E:GetFormattedText('CURRENT_PERCENT', min, UnitPowerMax(unit, SPELL_POWER_MANA))
end

ElvUF.Tags.Events['mana:current-max-percent'] = 'UNIT_POWER_FREQUENT UNIT_MAXPOWER'
ElvUF.Tags.Methods['mana:current-max-percent'] = function(unit)
	local min = UnitPower(unit, SPELL_POWER_MANA)

	return min == 0 and ' ' or	E:GetFormattedText('CURRENT_MAX_PERCENT', min, UnitPowerMax(unit, SPELL_POWER_MANA))
end

ElvUF.Tags.Events['mana:percent'] = 'UNIT_POWER_FREQUENT UNIT_MAXPOWER'
ElvUF.Tags.Methods['mana:percent'] = function(unit)
	local min = UnitPower(unit, SPELL_POWER_MANA)

	return min == 0 and ' ' or	E:GetFormattedText('PERCENT', min, UnitPowerMax(unit, SPELL_POWER_MANA))
end

ElvUF.Tags.Events['mana:deficit'] = 'UNIT_POWER_FREQUENT UNIT_MAXPOWER'
ElvUF.Tags.Methods['mana:deficit'] = function(unit)
	return E:GetFormattedText('DEFICIT', UnitPower(unit), UnitPowerMax(unit, SPELL_POWER_MANA))
end

ElvUF.Tags.Events['mana:max'] = 'UNIT_MAXPOWER'
ElvUF.Tags.Methods['mana:max'] = function(unit)
	local max = UnitPowerMax(unit, SPELL_POWER_MANA)

	return E:GetFormattedText('CURRENT', max, max)
end

ElvUF.Tags.Events['difficultycolor'] = 'UNIT_LEVEL PLAYER_LEVEL_UP'
ElvUF.Tags.Methods['difficultycolor'] = function(unit)
	local r, g, b = 0.55, 0.57, 0.61
	if ( UnitIsWildBattlePet(unit) or UnitIsBattlePetCompanion(unit) ) then
		local level = UnitBattlePetLevel(unit)

		local teamLevel = C_PetJournal_GetPetTeamAverageLevel();
		if teamLevel < level or teamLevel > level then
			local c = GetRelativeDifficultyColor(teamLevel, level)
			r, g, b = c.r, c.g, c.b
		else
			local c = QuestDifficultyColors["difficult"]
			r, g, b = c.r, c.g, c.b
		end
	else
		local DiffColor = UnitLevel(unit) - UnitLevel('player')
		if (DiffColor >= 5) then
			r, g, b = 0.69, 0.31, 0.31
		elseif (DiffColor >= 3) then
			r, g, b = 0.71, 0.43, 0.27
		elseif (DiffColor >= -2) then
			r, g, b = 0.84, 0.75, 0.65
		elseif (-DiffColor <= GetQuestGreenRange()) then
			r, g, b = 0.33, 0.59, 0.33
		else
			r, g, b = 0.55, 0.57, 0.61
		end
	end

	return Hex(r, g, b)
end

ElvUF.Tags.Events['namecolor'] = 'UNIT_NAME_UPDATE'
ElvUF.Tags.Methods['namecolor'] = function(unit)
	local unitReaction = UnitReaction(unit, 'player')
	local _, unitClass = UnitClass(unit)
	if (UnitIsPlayer(unit)) then
		local class = ElvUF.colors.class[unitClass]
		if not class then return "" end
		return Hex(class[1], class[2], class[3])
	elseif (unitReaction) then
		local reaction = ElvUF['colors'].reaction[unitReaction]
		return Hex(reaction[1], reaction[2], reaction[3])
	else
		return '|cFFC2C2C2'
	end
end

ElvUF.Tags.Events['smartlevel'] = 'UNIT_LEVEL PLAYER_LEVEL_UP'
ElvUF.Tags.Methods['smartlevel'] = function(unit)
	local level = UnitLevel(unit)
	if ( UnitIsWildBattlePet(unit) or UnitIsBattlePetCompanion(unit) ) then
		return UnitBattlePetLevel(unit);
	elseif level == UnitLevel('player') then
		return ''
	elseif(level > 0) then
		return level
	else
		return '??'
	end
end

ElvUF.Tags.Events['name:veryshort'] = 'UNIT_NAME_UPDATE'
ElvUF.Tags.Methods['name:veryshort'] = function(unit)
	local name = UnitName(unit)
	return name ~= nil and E:ShortenString(name, 4) or ''
end

ElvUF.Tags.Events['name:short'] = 'UNIT_NAME_UPDATE'
ElvUF.Tags.Methods['name:short'] = function(unit)
	local name = UnitName(unit)
	return name ~= nil and E:ShortenString(name, 6) or ''
end

ElvUF.Tags.Events['name:medium'] = 'UNIT_NAME_UPDATE'
ElvUF.Tags.Methods['name:medium'] = function(unit)
	local name = UnitName(unit)
	return name ~= nil and E:ShortenString(name, 10) or ''
end

ElvUF.Tags.Events['name:long'] = 'UNIT_NAME_UPDATE'
ElvUF.Tags.Methods['name:long'] = function(unit)
	local name = UnitName(unit)
	return name ~= nil and E:ShortenString(name, 20) or ''
end

ElvUF.Tags.Events['name:veryshort:status'] = 'UNIT_NAME_UPDATE UNIT_CONNECTION PLAYER_FLAGS_CHANGED UNIT_HEALTH'
ElvUF.Tags.Methods['name:veryshort:status'] = function(unit)
	local status = UnitIsDead(unit) and DEAD or UnitIsGhost(unit) and L["Ghost"] or not UnitIsConnected(unit) and L["Offline"]
	local name = UnitName(unit)
	if (status) then
		return status
	else
		return name ~= nil and E:ShortenString(name, 5) or ''
	end
end

ElvUF.Tags.Events['name:short:status'] = 'UNIT_NAME_UPDATE UNIT_CONNECTION PLAYER_FLAGS_CHANGED UNIT_HEALTH'
ElvUF.Tags.Methods['name:short:status'] = function(unit)
	local status = UnitIsDead(unit) and DEAD or UnitIsGhost(unit) and L["Ghost"] or not UnitIsConnected(unit) and L["Offline"]
	local name = UnitName(unit)
	if (status) then
		return status
	else
		return name ~= nil and E:ShortenString(name, 10) or ''
	end
end

ElvUF.Tags.Events['name:medium:status'] = 'UNIT_NAME_UPDATE UNIT_CONNECTION PLAYER_FLAGS_CHANGED UNIT_HEALTH'
ElvUF.Tags.Methods['name:medium:status'] = function(unit)
	local status = UnitIsDead(unit) and DEAD or UnitIsGhost(unit) and L["Ghost"] or not UnitIsConnected(unit) and L["Offline"]
	local name = UnitName(unit)
	if (status) then
		return status
	else
		return name ~= nil and E:ShortenString(name, 15) or ''
	end
end

ElvUF.Tags.Events['name:long:status'] = 'UNIT_NAME_UPDATE UNIT_CONNECTION PLAYER_FLAGS_CHANGED UNIT_HEALTH'
ElvUF.Tags.Methods['name:long:status'] = function(unit)
	local status = UnitIsDead(unit) and DEAD or UnitIsGhost(unit) and L["Ghost"] or not UnitIsConnected(unit) and L["Offline"]
	local name = UnitName(unit)
	if (status) then
		return status
	else
		return name ~= nil and E:ShortenString(name, 20) or ''
	end
end

ElvUF.Tags.Events['realm'] = 'UNIT_NAME_UPDATE'
ElvUF.Tags.Methods['realm'] = function(unit)
	local _, realm = UnitName(unit)
	return realm or ""
end

ElvUF.Tags.Events['realm:dash'] = 'UNIT_NAME_UPDATE'
ElvUF.Tags.Methods['realm:dash'] = function(unit)
	local _, realm = UnitName(unit)
	local realmString
	if realm then
		realmString = format("-%s", realm)
	else
		realmString = ""
	end
	return realmString
end

ElvUF.Tags.Events['threat:percent'] = 'UNIT_THREAT_LIST_UPDATE GROUP_ROSTER_UPDATE'
ElvUF.Tags.Methods['threat:percent'] = function(unit)
	local _, _, percent = UnitDetailedThreatSituation('player', unit)
	if(percent and percent > 0) and (IsInGroup() or UnitExists('pet')) then
		return format('%.0f%%', percent)
	else
		return ''
	end
end

ElvUF.Tags.Events['threat:current'] = 'UNIT_THREAT_LIST_UPDATE GROUP_ROSTER_UPDATE'
ElvUF.Tags.Methods['threat:current'] = function(unit)
	local _, _, percent, _, threatvalue = UnitDetailedThreatSituation('player', unit)
	if(percent and percent > 0) and (IsInGroup() or UnitExists('pet')) then
		return E:ShortValue(threatvalue)
	else
		return ''
	end
end

ElvUF.Tags.Events['threatcolor'] = 'UNIT_THREAT_LIST_UPDATE GROUP_ROSTER_UPDATE'
ElvUF.Tags.Methods['threatcolor'] = function(unit)
	local _, status = UnitDetailedThreatSituation('player', unit)
	if (status) and (IsInGroup() or UnitExists('pet')) then
		return Hex(GetThreatStatusColor(status))
	else
		return ''
	end
end

local unitStatus = {}
ElvUF.Tags.OnUpdateThrottle['statustimer'] = 1
ElvUF.Tags.Methods['statustimer'] = function(unit)
	if not UnitIsPlayer(unit) then return; end
	local guid = UnitGUID(unit)
	if (UnitIsAFK(unit)) then
		if not unitStatus[guid] or unitStatus[guid] and unitStatus[guid][1] ~= 'AFK' then
			unitStatus[guid] = {'AFK', GetTime()}
		end
	elseif(UnitIsDND(unit)) then
		if not unitStatus[guid] or unitStatus[guid] and unitStatus[guid][1] ~= 'DND' then
			unitStatus[guid] = {'DND', GetTime()}
		end
	elseif(UnitIsDead(unit)) or (UnitIsGhost(unit))then
		if not unitStatus[guid] or unitStatus[guid] and unitStatus[guid][1] ~= 'Dead' then
			unitStatus[guid] = {'Dead', GetTime()}
		end
	elseif(not UnitIsConnected(unit)) then
		if not unitStatus[guid] or unitStatus[guid] and unitStatus[guid][1] ~= 'Offline' then
			unitStatus[guid] = {'Offline', GetTime()}
		end
	else
		unitStatus[guid] = nil
	end

	if unitStatus[guid] ~= nil then
		local status = unitStatus[guid][1]
		local timer = GetTime() - unitStatus[guid][2]
		local mins = floor(timer / 60)
		local secs = floor(timer - (mins * 60))
		return ("%s (%01.f:%02.f)"):format(status, mins, secs)
	else
		return ''
	end
end

ElvUF.Tags.OnUpdateThrottle['pvptimer'] = 1
ElvUF.Tags.Methods['pvptimer'] = function(unit)
	if (UnitIsPVPFreeForAll(unit) or UnitIsPVP(unit)) then
		local timer = GetPVPTimer()

		if timer ~= 301000 and timer ~= -1 then
			local mins = floor((timer / 1000) / 60)
			local secs = floor((timer / 1000) - (mins * 60))
			return ("%s (%01.f:%02.f)"):format(PVP, mins, secs)
		else
			return PVP
		end
	else
		return ""
	end
end

local Harmony = {
	[0] = {1, 1, 1},
	[1] = {.57, .63, .35, 1},
	[2] = {.47, .63, .35, 1},
	[3] = {.37, .63, .35, 1},
	[4] = {.27, .63, .33, 1},
	[5] = {.17, .63, .33, 1},
	[6] = {.17, .63, .33, 1},
}

local StaggerColors = ElvUF.colors.power["STAGGER"]
-- percentages at which the bar should change color
local STAGGER_YELLOW_TRANSITION = STAGGER_YELLOW_TRANSITION
local STAGGER_RED_TRANSITION = STAGGER_RED_TRANSITION
-- table indices of bar colors
local STAGGER_GREEN_INDEX = STAGGER_GREEN_INDEX or 1
local STAGGER_YELLOW_INDEX = STAGGER_YELLOW_INDEX or 2
local STAGGER_RED_INDEX = STAGGER_RED_INDEX or 3

local function GetClassPower(class)
	local min, max, r, g, b = 0, 0, 0, 0, 0
	
	local spec = GetSpecialization()
	if class == 'PALADIN' and spec == SPEC_PALADIN_RETRIBUTION then
		min = UnitPower('player', SPELL_POWER_HOLY_POWER);
		max = UnitPowerMax('player', SPELL_POWER_HOLY_POWER);
		r, g, b = 228/255, 225/255, 16/255
	elseif class == 'MONK' then
		if spec == SPEC_MONK_BREWMASTER then
			min = UnitStagger("player")
			max = UnitHealthMax("player")
			local staggerRatio = min / max
			if (staggerRatio >= STAGGER_RED_TRANSITION) then
				r, g, b = unpack(StaggerColors[STAGGER_RED_INDEX])
			elseif (staggerRatio >= STAGGER_YELLOW_TRANSITION) then
				r, g, b = unpack(StaggerColors[STAGGER_YELLOW_INDEX])
			else
				r, g, b = unpack(StaggerColors[STAGGER_GREEN_INDEX])
			end
		else
			min = UnitPower("player", SPELL_POWER_CHI)
			max = UnitPowerMax("player", SPELL_POWER_CHI)
			r, g, b = unpack(Harmony[min])
		end
	elseif class == 'WARLOCK' then
		min = UnitPower("player", SPELL_POWER_SOUL_SHARDS)
		max = UnitPowerMax("player", SPELL_POWER_SOUL_SHARDS)
		r, g, b = 148/255, 130/255, 201/255
	end

	return min, max, r, g, b
end

ElvUF.Tags.Events['classpowercolor'] = 'UNIT_POWER_FREQUENT PLAYER_TALENT_UPDATE UPDATE_SHAPESHIFT_FORM'
ElvUF.Tags.Methods['classpowercolor'] = function()
	local _, _, r, g, b = GetClassPower(E.myclass)
	return Hex(r, g, b)
end

ElvUF.Tags.Events['classpower:current'] = 'UNIT_POWER_FREQUENT PLAYER_TALENT_UPDATE UPDATE_SHAPESHIFT_FORM'
ElvUF.Tags.Methods['classpower:current'] = function()
	local min, max = GetClassPower(E.myclass)
	if min == 0 then
		return ' '
	else
		return E:GetFormattedText('CURRENT', min, max)
	end
end

ElvUF.Tags.Events['classpower:deficit'] = 'UNIT_POWER_FREQUENT PLAYER_TALENT_UPDATE UPDATE_SHAPESHIFT_FORM'
ElvUF.Tags.Methods['classpower:deficit'] = function()
	local min, max = GetClassPower(E.myclass)
	if min == 0 then
		return ' '
	else
		return E:GetFormattedText('DEFICIT', min, max)
	end
end

ElvUF.Tags.Events['classpower:current-percent'] = 'UNIT_POWER_FREQUENT PLAYER_TALENT_UPDATE UPDATE_SHAPESHIFT_FORM'
ElvUF.Tags.Methods['classpower:current-percent'] = function()
	local min, max, staggerPercent = GetClassPower(E.myclass)
	if min == 0 then
		return ' '
	else
		return E:GetFormattedText('CURRENT_PERCENT', min, max)
	end
end

ElvUF.Tags.Events['classpower:current-max'] = 'UNIT_POWER_FREQUENT PLAYER_TALENT_UPDATE UPDATE_SHAPESHIFT_FORM'
ElvUF.Tags.Methods['classpower:current-max'] = function()
	local min, max = GetClassPower(E.myclass)
	if min == 0 then
		return ' '
	else
		return E:GetFormattedText('CURRENT_MAX', min, max)
	end
end

ElvUF.Tags.Events['classpower:current-max-percent'] = 'UNIT_POWER_FREQUENT PLAYER_TALENT_UPDATE UPDATE_SHAPESHIFT_FORM'
ElvUF.Tags.Methods['classpower:current-max-percent'] = function()
	local min, max = GetClassPower(E.myclass)
	if min == 0 then
		return ' '
	else
		return E:GetFormattedText('CURRENT_MAX_PERCENT', min, max)
	end
end

ElvUF.Tags.Events['classpower:percent'] = 'UNIT_POWER_FREQUENT PLAYER_TALENT_UPDATE UPDATE_SHAPESHIFT_FORM'
ElvUF.Tags.Methods['classpower:percent'] = function()
	local min, max = GetClassPower(E.myclass)
	if min == 0 then
		return ' '
	else
		return E:GetFormattedText('PERCENT', min, max)
	end
end

ElvUF.Tags.Events['absorbs'] = 'UNIT_ABSORB_AMOUNT_CHANGED'
ElvUF.Tags.Methods['absorbs'] = function(unit)
	local absorb = UnitGetTotalAbsorbs(unit) or 0
	if absorb == 0 then
		return ' '
	else
		return E:ShortValue(absorb)
	end
end

ElvUF.Tags.Events['incomingheals:personal'] = 'UNIT_HEAL_PREDICTION'
ElvUF.Tags.Methods['incomingheals:personal'] = function(unit)
	local heal = UnitGetIncomingHeals(unit, 'player') or 0
	if heal == 0 then
		return ' '
	else
		return E:ShortValue(heal)
	end
end

ElvUF.Tags.Events['incomingheals:others'] = 'UNIT_HEAL_PREDICTION'
ElvUF.Tags.Methods['incomingheals:others'] = function(unit)
	local heal = UnitGetIncomingHeals(unit) or 0
	if heal == 0 then
		return ' '
	else
		return E:ShortValue(heal)
	end
end

ElvUF.Tags.Events['incomingheals'] = 'UNIT_HEAL_PREDICTION'
ElvUF.Tags.Methods['incomingheals'] = function(unit)
	local personal = UnitGetIncomingHeals(unit, 'player') or 0
	local others = UnitGetIncomingHeals(unit) or 0
	local heal = personal + others
	if heal == 0 then
		return ' '
	else
		return E:ShortValue(heal)
	end
end

local GroupUnits = {}
local f = CreateFrame("Frame")

f:RegisterEvent("GROUP_ROSTER_UPDATE")
f:SetScript("OnEvent", function()
	local groupType, groupSize
	twipe(GroupUnits)

	if IsInRaid() then
		groupType = "raid"
		groupSize = GetNumGroupMembers()
	elseif IsInGroup() then
		groupType = "party"
		groupSize = GetNumGroupMembers() - 1
		GroupUnits["player"] = true
	else
		groupType = "solo"
		groupSize = 1
	end

	for index = 1, groupSize do
		local unit = groupType..index
		if not UnitIsUnit(unit, "player") then
			GroupUnits[unit] = true
		end
	end
end)

ElvUF.Tags.OnUpdateThrottle['nearbyplayers:8'] = 0.25
ElvUF.Tags.Methods['nearbyplayers:8'] = function(unit)
	local unitsInRange, d = 0
	if UnitIsConnected(unit) then
		for groupUnit, _ in pairs(GroupUnits) do
			if not UnitIsUnit(unit, groupUnit) and UnitIsConnected(groupUnit) then
				d = E:GetDistance(unit, groupUnit)
				if d and d <= 8 then
					unitsInRange = unitsInRange + 1
				end
			end
		end
	end

	return unitsInRange
end

ElvUF.Tags.OnUpdateThrottle['nearbyplayers:10'] = 0.25
ElvUF.Tags.Methods['nearbyplayers:10'] = function(unit)
	local unitsInRange, d = 0
	if UnitIsConnected(unit) then
		for groupUnit, _ in pairs(GroupUnits) do
			if not UnitIsUnit(unit, groupUnit) and UnitIsConnected(groupUnit) then
				d = E:GetDistance(unit, groupUnit)
				if d and d <= 10 then
					unitsInRange = unitsInRange + 1
				end
			end
		end
	end

	return unitsInRange
end

ElvUF.Tags.OnUpdateThrottle['nearbyplayers:30'] = 0.25
ElvUF.Tags.Methods['nearbyplayers:30'] = function(unit)
	local unitsInRange, d = 0
	if UnitIsConnected(unit) then
		for groupUnit, _ in pairs(GroupUnits) do
			if not UnitIsUnit(unit, groupUnit) and UnitIsConnected(groupUnit) then
				d = E:GetDistance(unit, groupUnit)
				if d and d <= 30 then
					unitsInRange = unitsInRange + 1
				end
			end
		end
	end

	return unitsInRange
end

ElvUF.Tags.OnUpdateThrottle['distance'] = 0.1
ElvUF.Tags.Methods['distance'] = function(unit)
	local d
	if UnitIsConnected(unit) and not UnitIsUnit(unit, 'player') then
		d = E:GetDistance('player', unit)

		if d then
			d = format("%.1f", d)
		end
	end

	return d or ''
end

local baseSpeed = BASE_MOVEMENT_SPEED
local speedText = SPEED
ElvUF.Tags.OnUpdateThrottle['speed:percent'] = 0.1
ElvUF.Tags.Methods['speed:percent'] = function(unit)
	if unit == 'player' and UnitHasVehicleUI(unit) then
		unit = "vehicle"
	end
	local currentSpeedInYards = GetUnitSpeed(unit)
	local currentSpeedInPercent = (currentSpeedInYards / baseSpeed) * 100

	return format("%s: %d%%", speedText, currentSpeedInPercent)
end

ElvUF.Tags.OnUpdateThrottle['speed:percent-moving'] = 0.1
ElvUF.Tags.Methods['speed:percent-moving'] = function(unit)
	if unit == 'player' and UnitHasVehicleUI(unit) then
		unit = "vehicle"
	end
	local currentSpeedInYards = GetUnitSpeed(unit)
	local currentSpeedInPercent = currentSpeedInYards > 0 and ((currentSpeedInYards / baseSpeed) * 100)

	if currentSpeedInPercent then
		currentSpeedInPercent = format("%s: %d%%", speedText, currentSpeedInPercent)
	end

	return currentSpeedInPercent or ''
end

ElvUF.Tags.OnUpdateThrottle['speed:percent-raw'] = 0.1
ElvUF.Tags.Methods['speed:percent-raw'] = function(unit)
	if unit == 'player' and UnitHasVehicleUI(unit) then
		unit = "vehicle"
	end
	local currentSpeedInYards = GetUnitSpeed(unit)
	local currentSpeedInPercent = (currentSpeedInYards / baseSpeed) * 100

	return format("%d%%", currentSpeedInPercent)
end

ElvUF.Tags.OnUpdateThrottle['speed:percent-moving-raw'] = 0.1
ElvUF.Tags.Methods['speed:percent-moving-raw'] = function(unit)
	if unit == 'player' and UnitHasVehicleUI(unit) then
		unit = "vehicle"
	end
	local currentSpeedInYards = GetUnitSpeed(unit)
	local currentSpeedInPercent = currentSpeedInYards > 0 and ((currentSpeedInYards / baseSpeed) * 100)

	if currentSpeedInPercent then
		currentSpeedInPercent = format("%d%%", currentSpeedInPercent)
	end

	return currentSpeedInPercent or ''
end

ElvUF.Tags.OnUpdateThrottle['speed:yardspersec'] = 0.1
ElvUF.Tags.Methods['speed:yardspersec'] = function(unit)
	if unit == 'player' and UnitHasVehicleUI(unit) then
		unit = "vehicle"
	end
	local currentSpeedInYards = GetUnitSpeed(unit)

	return format("%s: %.1f", speedText, currentSpeedInYards)
end

ElvUF.Tags.OnUpdateThrottle['speed:yardspersec-moving'] = 0.1
ElvUF.Tags.Methods['speed:yardspersec-moving'] = function(unit)
	if unit == 'player' and UnitHasVehicleUI(unit) then
		unit = "vehicle"
	end
	local currentSpeedInYards = GetUnitSpeed(unit)

	return currentSpeedInYards > 0 and format("%s: %.1f", speedText, currentSpeedInYards) or ''
end

ElvUF.Tags.OnUpdateThrottle['speed:yardspersec-raw'] = 0.1
ElvUF.Tags.Methods['speed:yardspersec-raw'] = function(unit)
	if unit == 'player' and UnitHasVehicleUI(unit) then
		unit = "vehicle"
	end
	local currentSpeedInYards = GetUnitSpeed(unit)
	return format("%.1f", currentSpeedInYards)
end

ElvUF.Tags.OnUpdateThrottle['speed:yardspersec-moving-raw'] = 0.1
ElvUF.Tags.Methods['speed:yardspersec-moving-raw'] = function(unit)
	if unit == 'player' and UnitHasVehicleUI(unit) then
		unit = "vehicle"
	end
	local currentSpeedInYards = GetUnitSpeed(unit)

	return currentSpeedInYards > 0 and format("%.1f", currentSpeedInYards) or ''
end

ElvUF.Tags.Events['classificationcolor'] = 'UNIT_CLASSIFICATION_CHANGED'
ElvUF.Tags.Methods['classificationcolor'] = function(unit)
	local c = UnitClassification(unit)
	if(c == 'rare' or c == 'elite') then
		return Hex(1, 0.5, 0.25) --Orange
	elseif(c == 'rareelite' or c == 'worldboss') then
		return Hex(1, 0, 0) --Red
	end
end

ElvUF.Tags.Events['guild'] = 'PLAYER_GUILD_UPDATE'
ElvUF.Tags.Methods['guild'] = function(unit)
	local guildName = GetGuildInfo(unit)

	return guildName or ""
end

ElvUF.Tags.Events['guild:brackets'] = 'PLAYER_GUILD_UPDATE'
ElvUF.Tags.Methods['guild:brackets'] = function(unit)
	local guildName = GetGuildInfo(unit)

	return guildName and format("<%s>", guildName) or ""
end

ElvUF.Tags.Events['target:veryshort'] = 'UNIT_TARGET'
ElvUF.Tags.Methods['target:veryshort'] = function(unit)
	local targetName = UnitName(unit.."target")
	return targetName ~= nil and E:ShortenString(targetName, 5) or ''
end

ElvUF.Tags.Events['target:short'] = 'UNIT_TARGET'
ElvUF.Tags.Methods['target:short'] = function(unit)
	local targetName = UnitName(unit.."target")
	return targetName ~= nil and E:ShortenString(targetName, 10) or ''
end

ElvUF.Tags.Events['target:medium'] = 'UNIT_TARGET'
ElvUF.Tags.Methods['target:medium'] = function(unit)
	local targetName = UnitName(unit.."target")
	return targetName ~= nil and E:ShortenString(targetName, 15) or ''
end

ElvUF.Tags.Events['target:long'] = 'UNIT_TARGET'
ElvUF.Tags.Methods['target:long'] = function(unit)
	local targetName = UnitName(unit.."target")
	return targetName ~= nil and E:ShortenString(targetName, 20) or ''
end

ElvUF.Tags.Events['target'] = 'UNIT_TARGET'
ElvUF.Tags.Methods['target'] = function(unit)
	local targetName = UnitName(unit.."target")
	return targetName or ''
end