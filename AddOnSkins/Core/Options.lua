local AS, ASL = unpack(AddOnSkins)
local sort, pairs, gsub, strfind, strlower, strtrim = sort, pairs, gsub, strfind, strlower, strtrim
local ACR, ACD = LibStub('AceConfigRegistry-3.0'), LibStub('AceConfigDialog-3.0')

local DEVELOPER_STRING = ''
local LINE_BREAK = '\n'

local DEVELOPERS = {
	'AcidWeb',
	'Affli',
	'Arstraea',
	'Blazeflack',
	'Cadayron',
	'Camealion',
	'Catok',
	'CJO',
	'Darth Predator',
	'Dec',
	'Drii',
	'Edoc',
	'efaref',
	'Elv',
	'Jasje',
	'Kemat1an',
	'Kkthnx',
	'Konungr',
	'Lockslap',
	'Ludius',
	'luminnas',
	'lolarennt',
	'MaXiMUS',
	'Merith',
	'MrRuben5',
	'Outofammo',
	'Pat',
	'Pezzer13',
	'Rakkhin',
	'Repooc',
	'Roktaal',
	'Shestak',
	'Shadowcall',
	'Sinaris',
	'Simpy',
	'Tercioo',
	'Tukz',
	'Warmexx',
	'Vito Sansevero',
	'Brian Thurlow',
	'Paul',
	'Jens Jacobsen',
	'Merathilis',
	'Torch',
	'Jason Longwell',
}

sort(DEVELOPERS, function(a, b) return strlower(a) < strlower(b) end)
for _, devName in pairs(DEVELOPERS) do
	DEVELOPER_STRING = DEVELOPER_STRING..devName..'    '
end

local Defaults, DebugString = nil, ''
function AS:SetupProfile()
	if not Defaults then
		Defaults = {
			profile = {
			-- Embeds
				['EmbedOoC'] = false,
				['EmbedOoCDelay'] = 10,
				['EmbedCoolLine'] = false,
				['EmbedSexyCooldown'] = false,
				['EmbedSystem'] = false,
				['EmbedSystemDual'] = false,
				['EmbedMain'] = 'Skada',
				['EmbedLeft'] = 'Skada',
				['EmbedRight'] = 'Skada',
				['EmbedRightChat'] = true,
				['EmbedLeftWidth'] = 200,
				['EmbedBelowTop'] = false,
				['TransparentEmbed'] = false,
				['EmbedIsHidden'] = false,
				['EmbedFrameStrata'] = '3-MEDIUM',
				['EmbedFrameLevel'] = 10,
			-- Misc
				['RecountBackdrop'] = true,
				['SkadaBackdrop'] = true,
				['OmenBackdrop'] = true,
				['DetailsBackdrop'] = true,
				['MiscFixes'] = true,
				['DBMSkinHalf'] = false,
				['DBMFont'] = 'EUI',
				['DBMFontSize'] = 12,
				['DBMFontFlag'] = 'OUTLINE',
				['DBMRadarTrans'] = false,
				['WeakAuraAuraBar'] = false,
				['WeakAuraIconCooldown'] = false,
				['SkinTemplate'] = 'Transparent',
				['HideChatFrame'] = 'NONE',
				['SkinDebug'] = false,
				['LoginMsg'] = true,
				['EmbedSystemMessage'] = true,
				['ElvUISkinModule'] = false,
				['ThinBorder'] = false,
			},
		}

		for skin in pairs(AS.register) do
			if Defaults.profile[skin] == nil then
				if AS:CheckAddOn('ElvUI') and strfind(skin, 'Blizzard_') then
					Defaults.profile[skin] = false
				else
					Defaults.profile[skin] = true
				end
			end
		end
	end

	self.data = LibStub('AceDB-3.0'):New('AddOnSkinsDB', Defaults)

	self.data.RegisterCallback(self, 'OnProfileChanged', 'SetupProfile')
	self.data.RegisterCallback(self, 'OnProfileCopied', 'SetupProfile')
	self.db = self.data.profile
end

function AS:GetOptions()
	local function GenerateOptionTable(skinName, order)
		local text = strtrim(skinName:gsub('^Blizzard_(.+)','%1'):gsub('(%l)(%u%l)','%1 %2'))
		local options = {
			type = 'toggle',
			name = text,
			order = order,
			desc = ASL.OptionsPanel.SkinDesc,
		}
		if AS:CheckAddOn('ElvUI') and strfind(skinName, 'Blizzard_') then
			options.set = function(info, value) AS:SetOption(info[#info], value) AS:SetElvUIBlizzardSkinOption(info[#info], not value) AS.NeedReload = true end
		end
		return options
	end

	local Options = {
		order = 101,
		type = 'group',
		name = "11."..AS.Title,
		childGroups = 'tab',
		args = {
			addons = {
				order = 0,
				type = 'group',
				name = ASL['AddOn Skins'],
				get = function(info) return AS:CheckOption(info[#info]) end,
				set = function(info, value) AS:SetOption(info[#info], value) AS.NeedReload = true end,
				args = {},
			},
			blizzard = {
				order = 1,
				type = 'group',
				name = ASL['Blizzard Skins'],
				get = function(info) return AS:CheckOption(info[#info]) end,
				set = function(info, value) AS:SetOption(info[#info], value) AS.NeedReload = true end,
				args = {},
			},
			bossmods = {
				type = 'group',
				name = ASL['BossMod Options'],
				order = 2,
				get = function(info) return AS:CheckOption(info[#info]) end,
				set = function(info, value) AS:SetOption(info[#info], value) end,
				args = {
					DBMFont = {
						type = 'select', dialogControl = 'LSM30_Font',
						order = 1,
						name = ASL['DBM|VEM Font'],
						values = AceGUIWidgetLSMlists.font,
					},
					DBMFontSize = {
						type = 'range',
						order = 2,
						name = ASL['DBM|VEM Font Size'],
						min = 8, max = 18, step = 1,
					},
					DBMFontFlag = {
						name = ASL['DBM|VEM Font Flag'],
						order = 3,
						type = 'select',
						values = {
							['NONE'] = 'None',
							['OUTLINE'] = 'OUTLINE',
							['THICKOUTLINE'] = 'THICKOUTLINE',
							['MONOCHROME'] = 'MONOCHROME',
							['MONOCHROMEOUTLINE'] = 'MONOCHROMEOUTLINE',
						},
					},
					DBMSkinHalf = {
						type = 'toggle',
						name = ASL['DBM|VEM Half-bar Skin'],
						order = 4,
						set = function(info, value)
							AS:SetOption(info[#info], value)
							if value then
								DBM.Bars:SetOption('BarYOffset', 18)
								DBM.Bars:SetOption('HugeBarYOffset', 18)
							else
								DBM.Bars:SetOption('BarYOffset', 2)
								DBM.Bars:SetOption('HugeBarYOffset', 2)
							end
						end,
					},
					DBMRadarTrans = {
						type = 'toggle',
						name = ASL['DBM Transparent Radar'],
						order = 5,
					},
				},
			},
			embed = {
				order = 3,
				type = 'group',
				name = ASL['Embed Settings'],
				get = function(info) return AS:CheckOption(info[#info]) end,
				set = function(info, value) AS:SetOption(info[#info], value) AS:Embed_Check() end,
				args = {
					desc = {
						type = 'description',
						name = ASL['Settings to control Embedded AddOns:\n\nAvailable Embeds: alDamageMeter | Details | Omen | Skada | Recount | TinyDPS'],
						order = 1
					},
					EmbedSystem = {
						type = 'toggle',
						name = ASL['Single Embed System'],
						order = 2,
						disabled = function() return AS:CheckOption('EmbedSystemDual') end,
					},
					EmbedMain = {
						type = 'select',
						name = ASL["Embed for Main Panel"],
						disabled = function() return not AS:CheckOption("EmbedSystem") end,
						order = 2,
						values = {
							['alDamageMeter'] = 'alDamageMeter',
							['Omen'] = 'Omen',
							['Skada'] = 'Skada',
							['Recount'] = 'Recount',
							['TinyDPS'] = 'TinyDPS',
							['Details'] = 'Details',
						},
					},
					EmbedSystemDual = {
						type = 'toggle',
						name = ASL['Dual Embed System'],
						order = 4,
						disabled = function() return AS:CheckOption('EmbedSystem') end,
					},
					EmbedLeft = {
						type = 'select',					
						name = ASL["Embed for Left Window"],
						disabled = function() return not AS:CheckOption("EmbedSystemDual") end,
						order = 5,
						values = {
							['alDamageMeter'] = 'alDamageMeter',
							['Omen'] = 'Omen',
							['Skada'] = 'Skada',
							['Recount'] = 'Recount',
							['TinyDPS'] = 'TinyDPS',
							['Details'] = 'Details',
						},
					},
					EmbedRight = {
						type = 'select',
						name = ASL["Embed for Right Window"],
						disabled = function() return not AS:CheckOption("EmbedSystemDual") end,
						order = 6,
						values = {
							['alDamageMeter'] = 'alDamageMeter',
							['Omen'] = 'Omen',
							['Skada'] = 'Skada',
							['Recount'] = 'Recount',
							['TinyDPS'] = 'TinyDPS',
							['Details'] = 'Details',
						},
					},
					EmbedLeftWidth = {
						type = 'range',
						order = 7,
						name = ASL['Embed Left Window Width'],
						min = 100,
						max = 300,
						step = 1,
						disabled = function() return not AS:CheckOption('EmbedSystemDual') end,
						width = 'full',
					},
					EmbedSystemMessage = {
						type = 'toggle',
						name = ASL['Embed System Message'],
						order = 9,
					},
					EmbedFrameStrata = {
						name = ASL['Embed Frame Strata'],
						order = 10,
						type = 'select',
						values = {
							['1-BACKGROUND'] = 'BACKGROUND',
							['2-LOW'] = 'LOW',
							['3-MEDIUM'] = 'MEDIUM',
							['4-HIGH'] = 'HIGH',
							['5-DIALOG'] = 'DIALOG',
							['6-FULLSCREEN'] = 'FULLSCREEN',
							['7-FULLSCREEN_DIALOG'] = 'FULLSCREEN_DIALOG',
							['8-TOOLTIP'] = 'TOOLTIP',
						},
						disabled = function() return not (AS:CheckOption('EmbedSystemDual') or AS:CheckOption('EmbedSystem')) end,
					},
					EmbedFrameLevel = {
						name = ASL['Embed Frame Level'],
						order = 11,
						type = 'range',
						min = 1,
						max = 255,
						step = 1,
						disabled = function() return not (AS:CheckOption('EmbedSystemDual') or AS:CheckOption('EmbedSystem')) end,
					},
					EmbedOoC = {
						type = 'toggle',
						name = ASL['Out of Combat (Hide)'],
						order = 12,
					},
					EmbedOoCDelay = {
						name = ASL['Embed OoC Delay'],
						order = 13,
						type = 'range',
						min = 1,
						max = 30,
						step = 1,
						disabled = function() return not ((AS:CheckOption('EmbedSystemDual') or AS:CheckOption('EmbedSystem')) and AS:CheckOption('EmbedOoC')) end,
					},
					HideChatFrame = {
						name = ASL['Hide Chat Frame'],
						order = 14,
						type = 'select',
						values = AS:GetChatWindowInfo(),
						disabled = function() return not (AS:CheckOption('EmbedSystemDual') or AS:CheckOption('EmbedSystem')) end,
					},
					EmbedRightChat = {
						type = 'toggle',
						name = ASL['Embed into Right Chat Panel'],
						order = 15,
					},
					TransparentEmbed = {
						type = 'toggle',
						name = ASL['Embed Transparancy'],
						order = 16,
					},
					EmbedBelowTop = {
						type = 'toggle',
						name = ASL['Embed Below Top Tab'],
						order = 17,
					},
					DetailsBackdrop = {
						type = 'toggle',
						name = ASL['Details Backdrop'],
						order = 18,
						disabled = function() return not (AS:CheckOption('Details', 'Details') and AS:CheckEmbed('Details')) end
					},
					RecountBackdrop = {
						type = 'toggle',
						name = ASL['Recount Backdrop'],
						order = 19,
						disabled = function() return not (AS:CheckOption('Recount', 'Recount') and AS:CheckEmbed('Recount')) end
					},
					SkadaBackdrop = {
						type = 'toggle',
						name = ASL['Skada Backdrop'],
						order = 20,
						disabled = function() return not (AS:CheckOption('Skada', 'Skada') and AS:CheckEmbed('Skada')) end
					},
					OmenBackdrop = {
						type = 'toggle',
						name = ASL['Omen Backdrop'],
						order = 21,
						disabled = function() return not (AS:CheckOption('Omen', 'Omen') and AS:CheckEmbed('Omen')) end
					},
					EmbedSexyCooldown = {
						type = 'toggle',
						name = ASL['Attach SexyCD to action bar'],
						order = 22,
						disabled = function() return not AS:CheckOption('SexyCooldown', 'SexyCooldown2') end,
					},
					EmbedCoolLine = {
						type = 'toggle',
						name = ASL['Attach CoolLine to action bar'],
						order = 23,
						disabled = function() return not AS:CheckOption('CoolLine', 'CoolLine') end,
					},
				},
			},
			misc = {
				type = 'group',
				name = MISCELLANEOUS,
				order = 4,
				get = function(info) return AS:CheckOption(info[#info]) end,
				set = function(info, value) AS:SetOption(info[#info], value) AS.NeedReload = true end,
				args = {
					SkinTemplate = {
						name = ASL['Skin Template'],
						order = 0,
						type = 'select',
						values = {
							['Transparent'] = 'Transparent',
							['Default'] = 'Default',
						}
					},
					WeakAuraAuraBar = {
						type = 'toggle',
						name = ASL['WeakAura AuraBar'],
						order = 2,
						disabled = function() return not AS:CheckOption('WeakAuras', 'WeakAuras') end,
					},
					Parchment = {
						type = 'toggle',
						name = ASL['Parchment'],
						order = 3,
					},
					SkinDebug = {
						type = 'toggle',
						name = ASL['Enable Skin Debugging'],
						order = 4,
					},
					LoginMsg = {
						type = 'toggle',
						name = ASL['Login Message'],
						order = 5,
					},
				},
			},
			faq = {
				type = 'group',
				name = ASL["FAQ's"],
				order = 5,
				args = {
					question1 = {
						type = 'description',
						name = '|cffc41f3b[Q] '..ASL['DBM/VEM Half-Bar Skin Spacing looks wrong. How can I fix it?'],
						order = 1,
						fontSize = 'medium',
					},
					answer1 = {
						type = 'description',
						name = '|cffabd473[A] '..ASL['To use the DBM/VEM Half-Bar skin. You must change the DBM/VEM Options. Offset Y needs to be at least 15.'],
						order = 2,
						fontSize = 'medium',
					},
				},
			},
			about = {
				type = 'group',
				name = ASL['About/Help'],
				order = -2,
				args = {
					AuthorHeader = {
						order = 0,
						type = 'header',
						name = 'Authors:',
					},
					Authors = {
						order = 1,
						type = 'description',
						name = AS.Authors,
						fontSize = 'large',
					},
					DevelopersHeader = {
						order = 2,
						type = 'header',
						name = 'Developers:',
					},
					Developers = {
						order = 3,
						type = 'description',
						name = DEVELOPER_STRING,
						fontSize = 'large',
					},
					desc = {
						order = 4,
						type = 'header',
						name = ASL['Links'],
					},
					tukuilink = {
						order = 5,
						type = 'input',
						width = 'full',
						name = ASL['Download Link'],
						get = function() return 'https://www.tukui.org/addons.php?id=3' end,
					},
					changeloglink = {
						order = 6,
						type = 'input',
						width = 'full',
						name = ASL['Changelog Link'],
						get = function() return 'https://www.tukui.org/forum/viewtopic.php?f=35&t=801' end,
					},
					gitlablink = {
						order = 7,
						type = 'input',
						width = 'full',
						name = ASL['GitLab Link / Report Errors'],
						get = function() return 'https://git.tukui.org/Azilroka/AddOnSkins' end,
					},
					skinlink = {
						order = 8,
						type = 'input',
						width = 'full',
						name = ASL['Available Skins / Skin Requests'],
						get = function() return 'https://www.tukui.org/forum/viewforum.php?f=35' end,
					},
				},
			},
		},
	}

	local order, blizzorder = 1, 1
	for skinName, _ in AS:OrderedPairs(AS.register) do
		if strfind(skinName, 'Blizzard_') then
		--	Options.args.blizzard.args[skinName] = GenerateOptionTable(skinName, blizzorder)
		--	blizzorder = blizzorder + 1
		else
			Options.args.addons.args[skinName] = GenerateOptionTable(skinName, order)
			order = order + 1
		end
	end

	if AS:CheckAddOn('ElvUI') then
		Options.args.blizzard.args.description ={
			type = 'header',
			name = ASL.OptionsPanel.ElvUIDesc,
			order = 0,
		}

		Options.args.misc.args.WeakAuraIconCooldown = {
			type = 'toggle',
			name = ASL['WeakAura Cooldowns'],
			order = 1,
			disabled = function() return not AS:CheckOption('WeakAuras', 'WeakAuras') end,
		}

		Options.args.misc.args.ElvUISkinModule = {
			type = 'toggle',
			name = 'Use ElvUI Skin Styling',
			order = 5,
		}

		hooksecurefunc(LibStub('AceConfigDialog-3.0-ElvUI'), 'CloseAll', function(self, appName)
			if AS.NeedReload then
				ElvUI[1]:StaticPopup_Show("PRIVATE_RL")
			end
		end)
	end

	if not AS:CheckAddOn('ElvUI') then
		Options.args.misc.args.ThinBorder = {
			name = 'Thin Border',
			order = 1,
			type = 'toggle',
		}
	end

	Options.args.profiles = LibStub('AceDBOptions-3.0'):GetOptionsTable(AS.data)
	Options.args.profiles.order = -2
	ACR:RegisterOptionsTable('AddOnSkinsProfiles', Options.args.profiles)

	if AS.EP then
		local Ace3OptionsPanel = IsAddOnLoaded('ElvUI') and ElvUI[1] or Enhanced_Config
		Ace3OptionsPanel.Options.args.addonskins = Options

		local Ace3OptionsPanel = IsAddOnLoaded("ElvUI") and ElvUI[1] or Enhanced_Config and Enhanced_Config[1]
		Ace3OptionsPanel.Options.args.addonskins = Options
		local E,L = unpack(ElvUI)
		E.Options.args.chat.args.EmbedRight = {
			order = 4,
			type = 'group',
			name = L['Embed Settings'],
			get = function(info) return AS:CheckOption(info[#info]) end,
			set = function(info, value) AS:SetOption(info[#info], value) AS:Embed_Check() end,
			args = E.Options.args.addonskins.args.embed.args,
		}
	end

	ACR:RegisterOptionsTable('AddOnSkins', Options)
	ACD:AddToBlizOptions('AddOnSkins', 'AddOnSkins', nil, 'addons')
	for k, v in AS:OrderedPairs(Options.args) do
		if k ~= 'addons' then
			ACD:AddToBlizOptions('AddOnSkins', v.name, 'AddOnSkins', k)
		end
	end
end