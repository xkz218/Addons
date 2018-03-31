-- $Id: Config.lua 9 2017-04-21 17:17:58Z arith $
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local pairs = _G.pairs
-- Libraries
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local LibStub = _G.LibStub;
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name);

local config = {}
private.config = config

config.options = {
	type = "group",
	name = L["PLUGIN_NAME"],
	desc = L["ADDON_DESC"],
	get = function(info) return private.db[info[#info]] end,
	set = function(info, v)
		private.db[info[#info]] = v
		addon:SendMessage("HandyNotes_NotifyUpdate", private.addon_name:gsub("HandyNotes_", ""))
	end,
	args = {
		icon = {
			type = "group",
			name = L["Icon settings"],
			inline = true,
			order = 1,
			args = {
				desc = {
					name = L["These settings control the look and feel of the icon."],
					type = "description",
					order = 0,
				},
				icon_scale = {
					type = "range",
					name = L["Icon Scale"],
					desc = L["The scale of the icons"],
					min = 0.25, max = 2, step = 0.01,
					order = 20,
				},
				icon_alpha = {
					type = "range",
					name = L["Icon Alpha"],
					desc = L["The alpha transparency of the icons"],
					min = 0, max = 1, step = 0.01,
					order = 30,
				},
			},
		},
		display = {
			type = "group",
			name = L["What to display"],
			inline = true,
			order = 2,
			args = {
				show_entrance = {
					type = "toggle",
					name = L["SHOWENTRANCE"],
					desc = L["SHOWENTRANCE_DESC"],
					order = 10,
				},
				show_ramp = {
					type = "toggle",
					name = L["SHOWRAMP"],
					desc = L["SHOWRAMP_DESC"],
					order = 11,
				},
				show_rare = {
					type = "toggle",
					name = L["SHOWRARE"],
					desc = L["SHOWRARE_DESC"],
					order = 12,
				},
				show_treasure = {
					type = "toggle",
					name = L["SHOWTREASURE"],
					desc = L["SHOWTREASURE_DESC"],
					order = 13,
				},
				show_others = {
					type = "toggle",
					name = L["SHOWOTHERS"],
					desc = L["SHOWOTHERS_DESC"],
					order = 14,
				},
				show_note = {
					type = "toggle",
					name = L["SHOWNOTE"],
					desc = L["SHOWNOTE_DESC"],
					order = 15,
				},
				query_server = {
					type = "toggle",
					name = L["QUERY"],
					desc = L["QUERY_DESC"],
					order = 20,
				},
				unhide = {
					type = "execute",
					name = L["Reset hidden nodes"],
					desc = L["Show all nodes that you manually hid by right-clicking on them and choosing \"hide\"."],
					func = function()
						for map,coords in pairs(private.hidden) do
							wipe(coords)
						end
						addon:Refresh()
					end,
					order = 50,
				},
			},
		},
	},
}

