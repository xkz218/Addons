-- $Id: DB.lua 19 2017-04-24 11:07:33Z arith $
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local pairs = _G.pairs;
-- Libraries
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name);

local function GetLocaleLibBabble(typ)
	local rettab = {}
	local tab = LibStub(typ):GetBaseLookupTable()
	local loctab = LibStub(typ):GetUnstrictLookupTable()
	for k,v in pairs(loctab) do
		rettab[k] = v;
	end
	for k,v in pairs(tab) do
		if not rettab[k] then
			rettab[k] = v;
		end
	end
	return rettab;
end
local BZ = GetLocaleLibBabble("LibBabble-SubZone-3.0");
local function mapFile(mapID)
	return HandyNotes:GetMapIDtoMapFile(mapID)
end

local DB = {}

private.DB = DB

DB.points = {
	--[[ structure:
	[mapFile] = { -- "_terrain1" etc will be stripped from attempts to fetch this
		[coord] = {
			label = [string], 		-- label: text that'll be the label, optional
			npc = [id], 				-- related npc id, used to display names in tooltip
			type = [string], 			-- the pre-define icon type which can be found in Constant.lua
			class = [CLASS NAME],		-- specified the class name so that this node will only be available for this class
			note=[string],			-- additional notes for this node
		},
	},
	--]]
	[mapFile(1021)] = {
		-- /////////////////////////////////
		-- entrance
		-- /////////////////////////////////
		[39236010] = {
			label = format(L["Entrance of %s"], BZ["Stonefin Shoals"]),
			entrance = true,
		},
		[45456709] = {
			label = format(L["Entrance of %s"], BZ["The Pit of Agony"]),
			entrance = true,
		},
		[55206304] = {
			label = format(L["Entrance of %s"], BZ["Maw of Corruption"]),
			entrance = true,
		},
		[76513982] = {
			label = format(L["Entrance of %s"], BZ["The Lost Temple"]),
			entrance = true,
		},
		[66633456] = {
			label = format(L["Entrance of %s"], BZ["Felsworn Vault"]),
			entrance = true,
		},
		[39713002] = {
			label = format(L["Entrance of %s"], BZ["Blood Nest"]),
			entrance = true,
		},
		[51421720] = {
			label = L["Entrance"],
			entrance = true,
		},
		[56162724] = {
			label = format(L["Entrance of %s"], BZ["Felbreach Hollow"]),
			entrance = true,
		},
		[58555401] = {
			label = format(L["Entrance of %s"], BZ["Feldust Cavern"]),
			entrance = true,
		},
		
		-- /////////////////////////////////
		-- ramp
		-- /////////////////////////////////
		[67843399] = {
			label = format(L["Ramp to %s"], BZ["Screaming Cliffs"]),
			ramp = true,
		},
		[60503315] = {
			label = format(L["Ramp to %s"], BZ["Screaming Cliffs"]),
			ramp = true,
		},
		[71503528] = {
			label = format(L["Ramp to %s"], BZ["Moonlight Ascent"]),
			ramp = true,
		},
		[46833318] = {
			label = format(L["Ramp to %s"], BZ["Broken Valley"]),
			ramp = true,
		},
		-- /////////////////////////////////
		-- rare mobs
		-- /////////////////////////////////
		[42404282] = {
			npc = 117094,
			rare = true,
			label = L["Malorus the Soulkeeper"],
		},
		[64443020] = {
			npc = 116166,
			rare = true,
			label = L["Eye of Gurgh"],
			note = format(L["Inside %s"], BZ["Felsworn Vault"]),
		},
		[57085649] = {
			npc = 117096,
			rare = true,
			label = L["Potionmaster Gloop"],
		},
		[60474504] = {
			npc = 118720,
			rare = true,
			label = L["Imp Mother Flaz"],
		},
		[60965330] = {
			npc = 116953,
			rare = true,
			label = L["Corrupted Bonebreaker"],
		},
		[78322747] = {
			npc = 121134,
			rare = true,
			label = L["Duke Sithizi"],
		},
		[78334004] = {
			npc = 121046,
			rare = true,
			label = L["Brother Badatin"],
		},
		[40348045] = {
			npc = 118993,
			rare = true,
			label = L["Dreadeye"],
		},
		[40385977] = {
			npc = 120998,
			rare = true,
			label = L["Flllurlokkr"],
		},
		[31315933] = {
			npc = 121112,
			rare = true,
			label = L["Somber Dawn"],
		},
		[39553265] = {
			npc = 121029,
			rare = true,
			label = L["Brood Mother Nix"],
			note = format(L["Inside %s"], BZ["Blood Nest"]),
		},
		[41601723] = {
			npc = 121107,
			rare = true,
			label = L["Lady Eldrathe"],
		},
		[49553794] = {
			npc = 117136,
			rare = true,
			label = L["Doombringer Zar'thoz"],
		},
		[89043227] = {
			npc = 117103,
			rare = true,
			label = L["Felcaller Zelthae"],
		},
		[51814293] = {
			npc = 117086,
			rare = true,
			label = L["Emberfire"],
		},
		[49114800] = {
			npc = 117090,
			rare = true,
			label = L["Xorogun the Flamecarver"],
		},
		[39194241] = {
			npc = 117091,
			rare = true,
			label = L["Felmaw Emberfiend"],
		},
		[44645317] = {
			npc = 119629,
			rare = true,
			label = L["Lord Hel'Nurath"],
		},
		[58294288] = {
			npc = 117093,
			rare = true,
			label = L["Felbringer Xar'thok"],
		},
		[77842292] = {
			npc = 121037,
			rare = true,
			label = L["Grossir"],
		},
		[61913840] = {
			npc = 117089,
			rare = true,
			label = L["Inquisitor Chillbane"],
		},
		[57793148] = {
			npc = 117095,
			rare = true,
			label = L["Dreadblade Annihilator"],
		},
		[59692724] = {
			npc = 117141,
			rare = true,
			label = L["Malgrazoth"],
			note = format(L["Inside %s"], BZ["Felbreach Hollow"]),
		},
		[54027882] = {
			npc = 121016,
			rare = true,
			label = L["Aqueux"],
		},
		-- /////////////////////////////////
		-- Others
		-- /////////////////////////////////
		[47836734] = {
			label = L["Peculiar Rope"],
			note = format(L["Entrance to %s"], BZ["Secret Treasure Lair"]),
			others = true,
			icon = private.constants.icon_texture["yellowButton"],
			scale = 0.6,
			hide_indoor = true,
		},
		[44566304] = {
			label = L["Legionfall Construction Table"],
			npc = 122082,
			others = true,
			icon = private.constants.icon_texture["yellowButton"],
			scale = 0.6,
			hide_indoor = true,
		},
		[46326193] = {
			label = _G["72_BROKENSHORE_BUILDING_MAGETOWER"],
			others = true,
			icon = private.constants.icon_texture["yellowButton"],
			scale = 0.6,
			hide_indoor = true,
		},
		[43746426] = {
			label = _G["72_BROKENSHORE_BUILDING_COMMANDCENTER"],
			others = true,
			icon = private.constants.icon_texture["yellowButton"],
			scale = 0.6,
			hide_indoor = true,
		},
		[41526357] = {
			label = _G["72_BROKENSHORE_BUILDING_NETHERDISRUPTOR"],
			others = true,
			icon = private.constants.icon_texture["yellowButton"],
			scale = 0.6,
			hide_indoor = true,
		},
		[37177141] = {
			npc = 102695,
			label = L["Drak'thul"],
			others = true,
			icon = private.constants.icon_texture["yellowButton"],
			scale = 0.6,
		},
	},
}

DB.treasures = {
	-- /////////////////////////////////
	-- Veiled Wyrmtongue Chest
	-- /////////////////////////////////
	[43364692] = {  }, 
	[48901870] = {  }, 
	[53401940] = {  }, 
	[31113202] = {  }, 
	[32903227] = {  }, 
	[30903320] = {  }, 
	[30904960] = {  }, 
	[33805400] = {  }, 
	[85802960] = {  }, 
	[82343119] = {  }, 
	[74702980] = {  }, 
	[70733176] = {  }, 
	[69423801] = {  }, 
	[67904210] = {  }, 
	[79003730] = {  }, 
	[76003600] = {  }, 
	[73703640] = {  }, 
	[72803830] = {  }, 
	[72004070] = {  }, 
	[71704150] = {  }, 
	[82534593] = {  }, 
	[85415396] = {  }, 
	[60901170] = {  }, 
	[64341805] = {  }, 
	[70041911] = {  }, 
	[68371961] = {  }, 
	[63002480] = {  }, 
	[60702830] = {  }, 
	[63903080] = {  }, 
	[61733145] = {  }, 
	[61923303] = {  }, 
	[58023097] = {  }, 
	[53542790] = {  }, 
	[52302990] = {  }, 
	[36602430] = {  }, 
	[44603350] = {  }, 
	[47603470] = {  }, 
	[62003910] = {  }, 
	[64704550] = {  }, 
	[57404360] = {  }, 
	[52104140] = {  }, 
	[53674568] = {  }, 
	[46104350] = {  }, 
	[45784677] = {  }, 
	[47494687] = {  }, 
	[46205060] = {  }, 
	[43505220] = {  }, 
	[61405000] = {  }, 
	[63205190] = {  }, 
	[62805260] = {  }, 
	[62505500] = {  }, 
	[56905680] = {  }, 
	[52465950] = {  }, 
	[50805970] = {  }, 
	[39005830] = {  }, 
	[37806130] = {  }, 
	[40126099] = {  note=format(L["Inside %s"], BZ["Stonefin Shoals"]) },
	[42796199] = {  note=format(L["Inside %s"], BZ["The Pit of Agony"]) }, 
	[45906380] = {  hide_indoor = true, }, 
	[47306700] = {  hide_indoor = true, }, 
	[56306510] = {  }, 
	[36807161] = {  }, 
	[51737059] = {  }, 
	[54607400] = {  }, 
	[51907700] = {  }, 
	[53008180] = {  },
	[70003756] = {  },
	[55245973] = {  },
	[77062089] = {  },
	[84962312] = {  },
	[48113412] = {  },
	[37934293] = {  },
	[29486004] = {  },
	[58897297] = {  },
	[67326740] = {  },
	[84556563] = {  },
	[30106690] = {  },
	[30705770] = {  },
	[41901580] = {  },
	[57051408] = {  },
	[68785685] = {  },
	[50008540] = {  },
	[40657288] = {  },
	[41996717] = {  note=format(L["Inside %s"], BZ["The Pit of Agony"]) }, 
	[49207390] = {  },
	[90555868] = {  },
	[89604390] = {  },
	[61504300] = {  },
	[49804650] = {  },
	[50504990] = {  },
	[42104280] = {  },
	[38703450] = {  },
	[41373654] = {  },
	[41903440] = {  },
	[43402660] = {  },
	[48303710] = {  },
	[28506050] = {  },
	[58155875] = {  note=format(L["Inside %s"], BZ["Maw of Corruption"]) }, 
}

for k, v in pairs(DB.treasures) do
	DB.points[mapFile(1021)][k] = v
	DB.points[mapFile(1021)][k]["treasure"] = true
end
