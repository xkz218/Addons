-- $Id: Constants.lua 19 2017-04-24 11:07:33Z arith $
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
-- Libraries
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...
private.addon_name = "HandyNotes_BrokenShore"

local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)

local constants = {}
private.constants = constants

constants.defaults = {
	profile = {
		icon_scale = 1.5,
		icon_alpha = 1.0,
		query_server = true,
		show_entrance = true,
		show_ramp = true,
		show_rare = true,
		show_others = true, 
		show_note = true,
		show_treasure = true,
		ignore_InOutDoor = false,
	},
	char = {
		hidden = {
			['*'] = {},
		},
	},
}

constants.icon_texture = {
	flight = "Interface\\MINIMAP\\TRACKING\\FlightMaster",
	yellowButton = "Interface\\AddOns\\HandyNotes_BrokenShore\\Images\\YellowButton",
	mission = "Interface\\AddOns\\HandyNotes_BrokenShore\\Images\\Mission",
	portal = "Interface\\AddOns\\HandyNotes_BrokenShore\\Images\\Portal",
	treasure = "Interface\\AddOns\\HandyNotes_BrokenShore\\Images\\treasure",
	entrance = "Interface\\MINIMAP\\Suramar_Door_Icon",
	ramp = "Interface\\MINIMAP\\MiniMap-VignetteArrow",
	rare = "Interface\\AddOns\\HandyNotes_BrokenShore\\Images\\Skull",
}

-- Define the default icon here
constants.defaultIcon = constants.icon_texture["entrance"]

constants.events = {
	"ZONE_CHANGED",
	"ZONE_CHANGED_INDOORS",
	-- Fires when stepping off of a world map object. 
	-- Appears to fire whenever the player has moved off of a structure 
	-- such as a bridge or building and onto terrain or another object.
	"NEW_WMO_CHUNK",
};
