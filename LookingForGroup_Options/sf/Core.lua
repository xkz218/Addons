local LibStub = LibStub
local AceAddon = LibStub("AceAddon-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local LookingForGroup = AceAddon:GetAddon("LookingForGroup")
local LookingForGroup_Options = AceAddon:GetAddon("LookingForGroup_Options")
local L = LibStub("AceLocale-3.0"):GetLocale("LookingForGroup")
local wipe = wipe
local pairs = pairs

local order = 0
local function get_order()
	local temp = order
	order = order +1
	return temp
end

local select_tb = {}

LookingForGroup_Options:push("filter",{
	name = SPAM_FILTER,
	type = "group",
	args =
	{
		mlength = 
		{
			name = L["Maximum length"],
			type = "input",
			order = get_order(),
			set = function(_,val)
				if val == "" then
					LookingForGroup.db.profile.spam_filter_maxlength = -1
				else
					LookingForGroup.db.profile.spam_filter_maxlength = tonumber(val)
				end
			end,
			get = function()
				local ml = LookingForGroup.db.profile.spam_filter_maxlength
				if 0 <= ml then
					return tostring(LookingForGroup.db.profile.spam_filter_maxlength)
				end
			end,
			pattern = "^[0-9]*$",
			width = "full",
		},
		add =
		{
			name = ADD,
			type = "input",
			order = get_order(),
			set = function(_,val)
				local tb = LookingForGroup.db.profile.spam_filter_keywords
				local lower = string.lower
				local gsub = string.gsub
				tb[#tb+1] = lower(gsub(val," ",""))
				table.sort(tb)
			end,
			get = function()end,
			width = "full"
		},
		rmv =
		{
			name = REMOVE,
			type = "execute",
			order = get_order(),
			func = function()
				local profile = LookingForGroup.db.profile
				local spkt = profile.spam_filter_keywords
				local cp = {}
				local i
				local n = #spkt
				for i = 1,n do
					if select_tb[i]~=true then
						cp[#cp+1] = spkt[i]
					end
				end
				wipe(select_tb)
				profile.spam_filter_keywords = cp
			end
		},
		cancel =
		{
			name = RESET,
			type = "execute",
			order = get_order(),
			func = function() wipe(select_tb) end
		},
		filters_s =
		{
			name = FILTERS,
			type = "multiselect",
			order = get_order(),
			values = function() return LookingForGroup.db.profile.spam_filter_keywords end,
			set = function(_,key,val)
				if val then
					select_tb[key] = true
				else
					select_tb[key] = nil
				end
			end,
			get = function(_,key)
				return select_tb[key]
			end,
			width = "full",
		},
		filters =
		{
			name = FILTERS,
			type = "input",
			multiline = true,
			width = "full",
			set = function(_,val)
				local gmatch = string.gmatch
				local insert = table.insert
				local lower = string.lower
				local gsub = string.gsub
				local t = LookingForGroup.db.profile.spam_filter_keywords
				wipe(t)
				for str in gmatch(val, "([^\n]+)") do
					insert(t,lower(gsub(str," ","")))
				end
				table.sort(t)
			end,
			get = function()
				return table.concat(LookingForGroup.db.profile.spam_filter_keywords,'\n')
			end,
		},
		language =
		{
			name = LANGUAGE,
			type = "group",
			args =
			{
				enable =
				{
					name = ENABLE,
					type = "toggle",
					order = get_order(),
					set = function(_,val)
						if val then
							LookingForGroup.db.profile.spam_filter_language = true
						else
							LookingForGroup.db.profile.spam_filter_language = nil
						end
					end,
					get = function()
						return LookingForGroup.db.profile.spam_filter_language
					end,
					width = "full"
				},
				english =
				{
					name = LFG_LIST_LANGUAGE_ENUS,
					type = "toggle",
					set = function(_,val)
						if LookingForGroup.db.profile.spam_filter_language then
							if val then
								LookingForGroup.db.profile.spam_filter_language_english = true
							else
								LookingForGroup.db.profile.spam_filter_language_english = nil
							end
						end
					end,
					get = function()
						return LookingForGroup.db.profile.spam_filter_language_english
					end,
				},
				chinese =
				{
					name = LFG_LIST_LANGUAGE_ZHCN,
					type = "toggle",
					set = function(_,val)
						if LookingForGroup.db.profile.spam_filter_language then
							if val then
								LookingForGroup.db.profile.spam_filter_language_chinese = true
							else
								LookingForGroup.db.profile.spam_filter_language_chinese = nil
							end
						end
					end,
					get = function()
						return LookingForGroup.db.profile.spam_filter_language_chinese
					end
				},
				korean =
				{
					name = LFG_LIST_LANGUAGE_KOKR,
					type = "toggle",
					set = function(_,val)
						if LookingForGroup.db.profile.spam_filter_language then
							if val then
								LookingForGroup.db.profile.spam_filter_language_korean = true
							else
								LookingForGroup.db.profile.spam_filter_language_korean = nil
							end
						end
					end,
					get = function()
						return LookingForGroup.db.profile.spam_filter_language_korean
					end
				},
				russian =
				{
					name = LFG_LIST_LANGUAGE_RURU,
					type = "toggle",
					set = function(_,val)
						if LookingForGroup.db.profile.spam_filter_language then
							if val then
								LookingForGroup.db.profile.spam_filter_language_russian = true
							else
								LookingForGroup.db.profile.spam_filter_language_russian = nil
							end
						end
					end,
					get = function()
						return LookingForGroup.db.profile.spam_filter_language_russian
					end
				},
				german =
				{
					name = LFG_LIST_LANGUAGE_DEDE,
					type = "toggle",
					set = function(_,val)
						if LookingForGroup.db.profile.spam_filter_language then
							if val then
								LookingForGroup.db.profile.spam_filter_language_german = true
							else
								LookingForGroup.db.profile.spam_filter_language_german = nil
							end
						end
					end,
					get = function()
						return LookingForGroup.db.profile.spam_filter_language_german
					end
				},
				france =
				{
					name = LFG_LIST_LANGUAGE_FRFR,
					type = "toggle",
					set = function(_,val)
						if LookingForGroup.db.profile.spam_filter_language then
							if val then
								LookingForGroup.db.profile.spam_filter_language_france = true
							else
								LookingForGroup.db.profile.spam_filter_language_france = nil
							end
						end
					end,
					get = function()
						return LookingForGroup.db.profile.spam_filter_language_france
					end
				},
				spanish =
				{
					name = LFG_LIST_LANGUAGE_ESES,
					type = "toggle",
					set = function(_,val)
						if LookingForGroup.db.profile.spam_filter_language then
							if val then
								LookingForGroup.db.profile.spam_filter_language_spanish = true
							else
								LookingForGroup.db.profile.spam_filter_language_spanish = nil
							end
						end
					end,
					get = function()
						return LookingForGroup.db.profile.spam_filter_language_spanish
					end
				},
				portuguese =
				{
					name = LFG_LIST_LANGUAGE_PTBR,
					type = "toggle",
					set = function(_,val)
						if LookingForGroup.db.profile.spam_filter_language then
							if val then
								LookingForGroup.db.profile.spam_filter_language_portuguese = true
							else
								LookingForGroup.db.profile.spam_filter_language_portuguese = nil
							end
						end
					end,
					get = function()
						return LookingForGroup.db.profile.spam_filter_language_portuguese
					end
				}
			}
		},
		channel =
		{
			name = CHANNEL,
			type = "group",
			args =
			{
				guild =
				{
					name = GUILD,
					type = "toggle",
					set = function(_,val)
						if val then
							LookingForGroup.db.profile.spam_filter_channel_guild = true
						else
							LookingForGroup.db.profile.spam_filter_channel_guild = nil
						end
						local sf = LibStub("AceAddon-3.0"):GetAddon("LookingForGroup_SF")
						sf:OnEnable()
					end,
					get = function()
						return LookingForGroup.db.profile.spam_filter_channel_guild
					end
				},
				instance =
				{
					name = INSTANCE,
					type = "toggle",
					set = function(_,val)
						if val then
							LookingForGroup.db.profile.spam_filter_channel_instance = true
						else
							LookingForGroup.db.profile.spam_filter_channel_instance = nil
						end
						local sf = LibStub("AceAddon-3.0"):GetAddon("LookingForGroup_SF")
						sf:OnEnable()
					end,
					get = function()
						return LookingForGroup.db.profile.spam_filter_channel_instance
					end
				},
			}
		},
		advanced =
		{
			name = ADVANCED_LABEL,
			type = "group",
			order = -1,
			args =
			{
				dk = 
				{
					name = GetClassInfoByID(6),
					type = "toggle",
					set = function(_,val)
						if val then
							LookingForGroup_Options.db.profile.spam_filter_dk = nil
						else
							LookingForGroup_Options.db.profile.spam_filter_dk = true
						end
					end,
					get = function()
						return not LookingForGroup_Options.db.profile.spam_filter_dk
					end
				},
				solo = 
				{
					name = SOLO,
					type = "toggle",
					set = function(_,val)
						if val then
							LookingForGroup_Options.db.profile.spam_filter_solo = true
						else
							LookingForGroup_Options.db.profile.spam_filter_solo = nil
						end
					end,
					get = function()
						return LookingForGroup_Options.db.profile.spam_filter_solo
					end
				},
				language =
				{
					name = LANGUAGE,
					desc = format(L.find_f_advanced_language,SPAM_FILTER,LANGUAGE),
					type = "toggle",
					get = function(info)
						return LookingForGroup_Options.db.profile.find_a_group_language
					end,
					set = function(info,val)
						if val then
							LookingForGroup_Options.db.profile.find_a_group_language = true
						else
							LookingForGroup_Options.db.profile.find_a_group_language = nil
						end
					end
				},
				auto_report =
				{
					name = L.auto_report,
					desc = L.auto_report_desc,
					type = "toggle",
					get = function(info)
						return not LookingForGroup_Options.db.profile.spam_filter_auto_report
					end,
					set = function(info,val)
						if val then
							LookingForGroup_Options.db.profile.spam_filter_auto_report = nil
						else
							LookingForGroup_Options.db.profile.spam_filter_auto_report = true
						end
					end
				},
				rpt =
				{
					name = L.Repeat,
					type = "toggle",
					get = function(info)
						return not LookingForGroup_Options.db.profile.spam_filter_repeat
					end,
					set = function(info,val)
						if val then
							LookingForGroup_Options.db.profile.spam_filter_repeat = nil
						else
							LookingForGroup_Options.db.profile.spam_filter_repeat = true
						end
					end
				},
				reset =
				{
					name = RESET,
					type = "execute",
					order = -1,
					func = function()
						local profile = LookingForGroup_Options.db.profile
						profile.spam_filter_dk = nil
						profile.spam_filter_solo = nil
						profile.find_a_group_language = nil
						profile.spam_filter_auto_report = nil
						profile.spam_filter_repeat = nil
					end,
					width = "full"
				}
			}
		}
	}
})
