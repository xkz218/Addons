﻿local L = LibStub("AceLocale-3.0"):NewLocale("TidyPlatesThreat", "zhCN", false)
if not L then return end

L["    <no option>          Displays options dialog"] = "    <无设置>          显示设置对话框"
L["    help                 Prints this help message"] = "    帮助                 输出帮助信息"
L["    new-default-profile  Updates the default profile with new default settings"] = "    新的默认用户  使用新的默认设置作为默认用户"
L["    update-profiles      Migrates deprecated settings in your configuration"] = "    更新用户      迁移你配置中的废弃设置"
L["  options:"] = "设置："
L[" options by typing: /tptp"] = "选项通过输入：/tptp"
L[" role."] = "角色"
L[" to DPS."] = "输出"
L[" to tanking."] = "坦克"
L[ [=[

Feel free to email me at |cff00ff00threatplates@gmail.com|r

--

Blacksalsify

(Original author: Suicidal Katt - |cff00ff00Shamtasticle@gmail.com|r)]=] ] = [=[

随时可以给我发邮件|cff00ff00threatplates@gmail.com|r

--

Blacksalsify

(最开始的作者: Suicidal Katt - |cff00ff00Shamtasticle@gmail.com|r)]=]
L[ [=[
---------------------------------------
The current version of ThreatPlates requires at least TidyPlates ]=] ] = [=[
---------------------------------------
当前版本的ThreatPlates至少需要TidyPlates]=]
L[". Please update TidyPlates, otherwise ThreatPlates will not work properly."] = ".请升级TidyPlates，否则ThreatPlates将无法正常工作。"
L[". You have installed an older or incompatible version of TidyPlates: "] = ". 你已安装一个旧的或不兼容的TidyPlates版本: "
L[": Converting settings from aura widget to aura widget 2.0 ..."] = ": 光环部件的选项设置升级到光环部件2.0 ..."
L[ [=[:
----------
Would you like to
set your theme to |cff89F559Threat Plates|r?

Clicking '|cff00ff00Yes|r' will set you to Threat Plates & reload UI.
 Clicking '|cffff0000No|r' will open the Tidy Plates options.]=] ] = [=[:
----------
你希望
设置你的主题为|cff89F559Threat Plates|r吗?

点击 '|cff00ff00是|r' 将设置你的主题为Threat Plates并且重新载入插件。
点击 '|cffff0000否|r' 将打开Tidy Plates选项。]=]
L["|cff00ff00High threat|r"] = "|cff00ff00高仇恨|r"
L["|cff00ff00Low threat|r"] = "|cff00ff00低仇恨|r"
L["|cff00ff00Tank|r"] = "|cff00ff00坦克|r"
L["|cff00ff00tanking|r"] = "|cff00ff00坦克|r"
L["|cff89f559 role.|r"] = "|cff89f559 角色.|r"
L["|cff89f559Additional options can be found by typing |r'/tptp'|cff89F559.|r"] = "|cff89f559可以通过输入 |r'/tptp'|cff89f559来找到剩余选项。|r"
L["|cff89f559Threat Plates:|r Welcome back |cff"] = "|cff89f559Threat Plates:|r 欢迎回来 |cff"
L["|cff89F559Threat Plates|r: DPS switch detected, you are now in your |cffff0000dpsing / healing|r role."] = "|cff89F559Threat Plates|r:检测到DPS, 你现在是|cffff0000输出/治疗|r角色."
L["|cff89F559Threat Plates|r: Player spec change detected: |cff"] = "|cff89F559Threat Plates|r: 玩家天赋改变检测： |cff"
L["|cff89F559Threat Plates|r: Role toggle not supported because automatic role detection is enabled."] = "|cff89F559Threat Plates|r:角色切换不支持，因为你启用了角色自动检测。."
L["|cff89F559Threat Plates|r: Tank switch detected, you are now in your |cff00ff00tanking|r role."] = "|cff89F559Threat Plates|r:检测到坦克,你现在是|cff00ff00坦克|r角色."
L[ [=[|cff89f559Welcome to |rTidy Plates: |cff89f559Threat Plates!
This is your first time using Threat Plates and you are a(n):
|r|cff]=] ] = [=[|cff89f559欢迎使用|rTidy Plates: |cff89f559Threat Plates!
这是你第一次使用Threat Plates，你是一个:
|r|cff]=]
L["|cff89f559You are currently in your "] = "|cff89f559你目前在你的"
L["|cffff0000DPS/Healing|r"] = "|cffff0000输出/治疗|r"
L["|cffff0000dpsing / healing|r"] = "|cffff0000输出 / 治疗|r"
L["|cffff0000High threat|r"] = "|cffff0000高仇恨|r"
L["|cffff0000Low threat|r"] = "|cffff0000低仇恨|r"
L["|cffffff00Medium threat|r"] = "|cffffff00一般仇恨|r"
L["|cffffffffGeneral Settings|r"] = "|cffffffff主设置|r"
L["|cffffffffTotem Settings|r"] = "|cffffffff图腾设置|r"
L["-->>|cff00ff00Tank Plates Enabled|r<<--"] = "-->>|cff00ff00坦克姓名版开启|r<<--"
L["-->>|cffff0000Activate Threat Plates from the Tidy Plates options!|r<<--"] = "-->>|cffff0000从Tidy Plates选项中激活Threat Plates！|r<<--"
L["-->>|cffff0000DPS Plates Enabled|r<<--"] = "-->>|cff00ff00输出姓名版开启|r<<--"
L["-->>Nameplate Overlapping is now |cff00ff00ON!|r<<--"] = "-->>姓名板重叠现在 |cff00ff00开启！|r<<--"
L["-->>Nameplate Overlapping is now |cffff0000OFF!|r<<--"] = "-->>姓名板重叠现在 |cff00ff00关闭！|r<<--"
L["-->>Threat Plates verbose is now |cff00ff00ON!|r<<--"] = "-->>Threat Plates聊天框反馈信息现在 |cff00ff00开启！|r<<--"
L["-->>Threat Plates verbose is now |cffff0000OFF!|r<<-- shhh!!"] = "-->>Threat Plates聊天框反馈信息现在 |cffff0000关闭！|r<<--嘘！！"
L["A to Z"] = "A 到Z"
L["About"] = "关于"
L["Additional Adjustments"] = "额外调节"
L["Additional Toggles"] = "额外切换"
L["All Auras"] = "所有光环"
L["All Auras (Mine)"] = "所有光环(我的)"
L["Allow Marked HP Coloring"] = "允许被标记目标的血量配色"
L["Allow raid marked hp color settings instead of a custom hp setting if the nameplate has a raid mark."] = "如果姓名板有一个团队标记，那麽允许团队标记血量颜色设置代替自定义血量设置。"
L["Alpha"] = "透明度"
L["Alpha Settings"] = "透明度设置"
L["Amount Text"] = "数值文字"
L["Amount Text Formatting"] = "数值文字格式"
L["Anchor"] = "锚点"
L["Anchor Point"] = "瞄点"
L["Appearance"] = "外观"
L["Army of the Dead Ghoul"] = "亡者军团食尸鬼"
L["Art Options"] = "艺术设置"
L["Aura"] = "光环"
L["Aura 2.0"] = "光环 2.0"
L["Background Color"] = "背景颜色"
L["Background Color:"] = "背景颜色:"
L["Background Opacity"] = "背景可见性"
L["Background Texture"] = "背景纹理"
L["Bar Height"] = "条的高度"
L["Bar Layout"] = "条的布局"
L["Bar Limit"] = "条的界限"
L["Bar Mode"] = "条的风格"
L["Bar Textures"] = "条的纹理"
L["Bar Width"] = "条的宽度"
L["Black List"] = "黑名单"
L["Black List (Mine)"] = "黑名单(我的)"
L["Blizzard Settings"] = "Blizzard设置"
L["Blizzard Target Fading"] = "Blizzard非目标淡出"
L["Bone Spike"] = "骨针"
L["Bottom-to-top"] = "从下到上"
L["Canal Crab"] = "运河蟹"
L["Cancel"] = "取消"
L["Castbar"] = "施法条"
L["Changes the HP color depending on the amount of HP the nameplate shows."] = "随着姓名板显示的血量数值改变血量颜色。"
L["Changing these settings will alter the placement of the nameplates, however the mouseover area does not follow. |cffff0000Use with caution!|r"] = "改变这些选项将改变姓名板的位置，然而鼠标指向区域却不会随之改变。|cffff0000请谨慎使用！|r"
L["Class Coloring"] = "职业颜色"
L["Class Icons"] = "职业图标"
L["Clear"] = "清除"
L[ [=[Clear and easy to use nameplate theme for use with TidyPlates.

Current version: ]=] ] = [=[TidyPlates的清晰且易于使用的姓名板主题。

当前版本:]=]
L["Color"] = "颜色"
L["Color by Dispel Type"] = "显示类型颜色"
L["Color HP by amount"] = "随血量值变色"
L["Color HP by Threat"] = "仇恨血量颜色"
L["Coloring"] = "颜色"
L["Colors"] = "颜色"
L["Column Limit"] = "列限制"
L["Combo Points"] = "连击点"
L["Cooldown Spiral"] = "冷却漩涡"
L["Copied!"] = "已复制！"
L["Copy"] = "复制"
L["Creation"] = "创建"
L["Custom"] = "自定义"
L["Custom Alpha"] = "自定义透明度"
L["Custom HP Color"] = "自定义透明度"
L["Custom Nameplates"] = "自定义姓名版"
L["Custom Scale"] = "自定义缩放"
L["Custom Settings"] = "自定义设置"
L["Darnavan"] = "达尔纳文"
L["Default Buff Color"] = "默认增益颜色"
L["Default Debuff Color"] = "默认减益颜色"
L["Deficit Text"] = "损失血量文字"
L["Deformed Fanatic"] = "畸形的狂热者"
L["Determine your role (tank/dps/healing) automatically based on current spec."] = "根据当前天赋自动切换你的角色(坦克/输出/治疗)"
L["Disable Custom Alpha"] = "禁用自定义透明度"
L["Disable Custom Scale"] = "禁用自定义缩放"
L["Disables the custom alpha setting for this nameplate and instead uses your normal alpha settings."] = "对此姓名板禁用自定义透明度设置，使用正常透明度设置代替"
L["Disables the custom scale setting for this nameplate and instead uses your normal scale settings."] = "对此姓名板禁用自定义缩放设置，使用正常缩放设置代替"
L["Disables threat feedback from boss level mobs."] = "禁用首领级别怪物的仇恨反馈"
L["Disables threat feedback from elite mobs."] = "禁用精英怪物的仇恨反馈。"
L["Disables threat feedback from mobs you're currently not in combat with."] = "禁用当前不在与你战斗的怪物的仇恨反馈。"
L["Disables threat feedback from neutral mobs regardless of boss or elite levels."] = "禁用中立怪物的仇恨反馈，不管首领与精英级别的单位。"
L["Disables threat feedback from normal mobs."] = "禁用普通怪物的仇恨反馈。"
L["Disables threat feedback from tapped mobs regardless of boss or elite levels."] = "禁用标记怪物的仇恨反馈，不管首领与精英级别的单位。"
L["Disabling this will turn off any all icons without harming custom settings per nameplate."] = "禁用此选项将关闭所有图标，而不会对每个姓名板的自定义设置造成破坏。"
L["Display health amount text."] = "显示血量值文字。"
L["Display health percentage text."] = "显示血量百分比文字。"
L["Display health text on targets with full HP."] = "当目标满血时显示血量文字。"
L["Display Settings"] = "显示设置"
L["DPS/Healing"] = "输出/治疗"
L["Drudge Ghoul"] = "食尸鬼苦工"
L["Duration"] = "持续时间"
L["Ebon Gargoyle"] = "黑锋石像鬼"
L["Elite Border"] = "显示精英单位边框"
L["Elite Icon"] = "精英图标"
L["Elite Icon Style"] = "精英图标样式"
L["Empowered Adherent"] = "亢奋的追随者"
L["Enable"] = "开启"
L["Enable Adjustments"] = "启用调节"
L["Enable Alpha Threat"] = "启用仇恨透明度"
L["Enable Aura Widget 2.0"] = "启用光环部件2.0"
L["Enable Blizzard 'On-Target' Fading"] = "启用Blizzard非当前目标淡出"
L["Enable Class Icons Widget"] = "启用单位图标部件"
L["Enable Coloring"] = "启用配色"
L["Enable Custom Colors"] = "启用自定义颜色"
L["Enable Custom HP colors"] = "启用自定义血量颜色"
L["Enable Elite Icon"] = "启用精英图标"
L["Enable Enemy Class colors"] = "启用敌方单位职业颜色"
L["Enable Friendly Class Colors"] = "启用友方单位职业颜色"
L["Enable Friendly Icons"] = "启用友方单位图标"
L["Enable Headline View (Text-Only)"] = "启用标题预览(只限文字)"
L["Enable Health Text"] = "启用血量文字"
L["Enable Level Text"] = "启用等级文字"
L["Enable Name Text"] = "启用姓名文字"
L["Enable nameplates to change alpha depending on the levels you set below."] = "依据你在下面所设置的仇恨等级，启用姓名板透明度改变。"
L["Enable nameplates to change scale depending on the levels you set below."] = "依据你在下面所设置的仇恨等级，启用姓名板缩放改变。"
L["Enable Quest Widget"] = "启用任务部件"
L["Enable Raid Mark Icon"] = "启用团队标记"
L["Enable Raid Marked HP colors"] = "启用团队标记血量颜色"
L["Enable Scale Threat"] = "启用仇恨缩放"
L["Enable Shadow"] = "启用阴影"
L["Enable Skull Icon"] = "启用骷髅等级图标"
L["Enable Spell Icon"] = "启用法术图标"
L["Enable Spell Text"] = "启用法术文字"
L["Enable Stealth Widget (Feature not yet fully implemented!)"] = "启用隐身部件(该功能尚未完全实现!)"
L["Enable the showing of friendly player class color on hp bars."] = "启用血量条上友方玩家职业颜色的显示。"
L["Enable the showing of friendly player class icons."] = "启用友方玩家职业图标的显示。"
L["Enable the showing of hostile player class color on hp bars."] = "启用血条上方敌对玩家职业颜色的显示。"
L["Enable the showing of the custom nameplate icon for this nameplate."] = "对此姓名板启用自定义姓名板图标的显示。"
L["Enable Threat System"] = "启用仇恨系统"
L["Enables highlighting of nameplates of mobs involved with any of your current quests."] = "使任何涉及你当前的任务怪的姓名版高亮。"
L["Enables the showing of a texture on your target nameplate"] = "启用在你当前目标姓名板上一种材质的显示"
L["Enables the showing of indicator icons for friends, guildmates, and BNET Friends"] = "启用对好友，公会成员以及战网好友的指示图标显示。"
L["Enables the showing of text on nameplates."] = "在姓名板上启用文字显示"
L["Enables the showing of the elite icon on nameplates."] = "启用姓名板上精英图标的显示"
L["Enables the showing of the raid mark icon on nameplates."] = "启用姓名板上团队标记图标的显示"
L["Enables the showing of the skull icon on nameplates."] = "启用姓名板上骷髅等级图标的显示"
L["Enables the showing of the spell icon on nameplates."] = "启用姓名板上法术图标的显示"
L["Enabling this will allow you to set the alpha adjustment for non-target nameplates."] = "启用这个功能将允许你对非目标的姓名板进行透明度调节"
L["Enabling this will allow you to set the alpha adjustment for non-target names in headline view."] = "启用这个功能将允许你在治疗预览下对非目标的姓名板进行透明度调节"
L["Enemy"] = "敌对"
L["Enemy Color"] = "敌对颜色"
L["Fanged Pit Viper"] = "毒牙坑道蛇"
L["Filter by Dispel Type"] = "显示类型过滤器"
L["Filter by Spell"] = "技能过滤"
L["Filter by Unit Reaction"] = "单位反应过滤"
L["Filtered Auras"] = "过滤光环"
L["Filtering"] = "过滤"
L["Font"] = "字体"
L["Font Size"] = "字体大小"
L["Font Style"] = "字体样式"
L["Foreground Texture"] = "前景纹理"
L["Friendly"] = "友好单位"
L["Friendly Caching"] = "友方单位缓存"
L["Friendly Color"] = "友好单位颜色"
L["Gas Cloud"] = "毒气之云"
L["General Settings"] = "主设置"
L["Headline View"] = "治疗预览"
L["Health Bar Mode"] = "血条风格"
L["Health Coloring"] = "血量颜色"
L["Health Text"] = "血量文字"
L["Healthbar"] = "血条"
L["Hide Healthbars"] = "隐藏血条"
L["Hide in Combat"] = "战斗中隐藏"
L["Hide in Instance"] = "例外隐藏"
L["Hide on Attacked Units"] = "受单位攻击时隐藏"
L["Hiding"] = "隐藏"
L["High Threat"] = "高仇恨"
L["Horizontal Align"] = "水平定位"
L["Horizontal Alignment"] = "水平对齐"
L["Horizontal Spacing"] = "水平间距"
L["HP Coloring"] = "血量颜色"
L["Icon"] = "图标"
L["Icon Layout"] = "图标布局"
L["Icon Mode"] = "图标风格"
L["Icon Size"] = "图标大小"
L["Icon Style"] = "图标样式"
L["Ignore Marked Targets"] = "忽略被标记的目标"
L["Ignore Non-Combat Threat"] = "忽略非战斗目标仇恨"
L["Ignored Alpha"] = "忽略透明度"
L["Ignored Scaling"] = "忽略单位的缩放"
L["Immortal Guardian"] = "不朽守护者"
L["Interruptable Casts"] = "可打断的施法"
L["Kinetic Bomb"] = "动力炸弹"
L["Label Text Offset"] = "标签文字偏移"
L["Layout"] = "布局"
L["Left-to-right"] = "从左到右"
L["Level Text"] = "等级文字"
L["Lich King"] = "巫妖王"
L["Living Ember"] = "燃烧的余烬"
L["Living Inferno"] = "燃烧的炼狱火"
L["Low Threat"] = "低仇恨"
L["Marked Immortal Guardian"] = "被标记的不朽守护者"
L["Marked Targets"] = "被标记的目标"
L["Max HP Text"] = "最大血量文字"
L["Medium Threat"] = "一般仇恨"
--Translation missing
L["Migrating deprecated settings in configuration ..."] = "Migrating deprecated settings in configuration ..."
L["Mode"] = "风格"
L["Mouseover"] = "鼠标指向"
L["Muddy Crawfish"] = "沾泥龙虾"
L["Name Text"] = "姓名文字"
L["Nameplate Settings"] = "姓名板选项"
L["Neutral Color"] = "中立单位颜色"
L["No"] = "不"
L["No Outline, Monochrome"] = "无轮廓，单色"
L["No target found."] = "未发现目标。"
L["None"] = "无"
L["Non-Target Alpha"] = "非当前目标透明度"
L["Normal Border"] = "普通单位边框"
L["Nothing to paste!"] = "无可粘贴内容！"
L["Offset"] = "偏移"
L["Offset X"] = "X轴偏移"
L["Offset Y"] = "Y轴偏移"
L["Only on Attacked Units"] = "只限被攻击的单位"
L["Onyxian Whelp"] = "奥妮克希亚雏龙"
L["Open Blizzard Settings"] = "打开Blizzard设置"
L["Open Config"] = "打开设置"
L["Options"] = "设置"
L["Outline"] = "轮廓"
L["Outline, Monochrome"] = "轮廓，单色"
L["Paste"] = "粘贴"
L["Pasted!"] = "已粘贴！"
L["Percent Text"] = "百分比文字"
L["Placement"] = "位置"
L["Presences"] = "灵气"
L["Preview"] = "预览"
L["Profile "] = "用户"
L["Quest"] = "任务"
L["Raging Spirit"] = "暴怒的灵魂"
L["Raid Mark HP Color"] = "团队标记血量颜色"
L["Raid Marks"] = "团队标记"
L["Reanimated Adherent"] = "被复活的追随者"
L["Reanimated Fanatic"] = "被复活的狂热者"
L["Restore Defaults"] = "还原为默认值"
L["Reverse Order"] = "倒序"
L["Reverse the sort order (e.g., \"A to Z\" becomes \"Z to A\")."] = "颠倒排列顺序(例如，\"A 到 Z\" 变成 \"Z 到 A\")。"
L["Right-to-left"] = "从右到左"
L["Row Limit"] = "排限制"
L["Same as Foreground"] = "和前景相同"
L["Scale"] = "缩放"
L["Scale Settings"] = "缩放设置"
L["Seals"] = "光环"
L["Set alpha settings for different threat reaction types."] = "对不同的仇恨反应类型设置透明度。"
L["Set Icon"] = "设置图标"
L["Set Name"] = "设置名字"
L["Set scale settings for different threat reaction types."] = "对不同的仇恨反应类型设置缩放。"
L["Set the outlining style of the text."] = "设置姓名文字的轮廓样式。"
L["Set the roles your specs represent."] = "设置你的角色天赋代表"
L["Set threat textures and their coloring options here."] = "在这里设置仇恨的材质与它们的颜色选项"
L["Sets your spec "] = "设置你的天赋"
L["Shadow Fiend"] = "暗影魔"
L["Shadowy Apparition"] = "暗影幻灵"
L["Shambling Horror"] = "蹒跚的血僵尸"
L["Shapeshifts"] = "形态"
L["Shielded Coloring"] = "护盾颜色"
L["Show a glow based on threat level around the nameplate's healthbar (in combat)."] = "在姓名版的血条上显示基于仇恨等级的辉光(战斗中)。"
L["Show an indicator icon at the nameplate for quest mobs."] = "显示任务怪的姓名版指示图标。"
L["Show auras as bars (with optional icons)."] = "显示条上光环(可选图标)。"
--Translation missing
L["Show auras as icons in a grid configuration."] = "Show auras as icons in a grid configuration."
--Translation missing
L["Show auras in order created with oldest aura first."] = "Show auras in order created with oldest aura first."
L["Show Border"] = "显示边框"
L["Show Boss"] = "显示Boss"
L["Show Boss Threat"] = "显示Boss仇恨"
L["Show Elite"] = "显示精英"
L["Show Elite Border"] = "显示精英边框"
L["Show Elite Threat"] = "显示精英仇恨"
L["Show Enemies"] = "显示敌对单位"
L["Show Enemy"] = "显示敌对"
L["Show Enemy Guardians"] = "显示敌对守护者"
L["Show Enemy Pets"] = "显示敌对宠物"
L["Show Enemy Totems"] = "显示敌对图腾"
L["Show Friendly"] = "显示友好"
L["Show Friendly Guardians"] = "显示友好守护者"
L["Show Friendly NPCs"] = "显示友好NPC"
L["Show Friendly Pets"] = "显示友好宠物"
L["Show Friendly Totems"] = "显示友好图腾"
L["Show Friends"] = "显示友好单位"
L["Show Icon to the Left"] = "显示图标在左侧"
L["Show Nameplate"] = "显示姓名版"
L["Show Neutral"] = "显示中立单位"
L["Show Neutral Threat"] = "显示中立单位仇恨"
L["Show Normal"] = "显示普通单位"
L["Show Normal Threat"] = "显示普通单位仇恨"
--Translation missing
L["Show stack count as overlay on aura icon."] = "Show stack count as overlay on aura icon."
L["Show Tapped"] = "显示标记"
L["Show Tapped Threat"] = "显示标记单位仇恨"
L["Show Threat Glow"] = "显示仇恨色彩"
L["Show threat glow only on units in combat with the player."] = "仅在战斗中显示单位的仇恨高亮"
L["Shows a stealth icon above the nameplate of units that can detect you while stealthed."] = "显示一个隐身图标在单位姓名版之上可以检测你隐形效果。"
L["Size"] = "大小"
L["Sizing"] = "大小"
L["Skull Icon"] = "骷髅等级图标"
L["Social"] = "缩放"
L["Sort by overall duration in ascending order."] = "根据持续时间进行升序排序。"
L["Sort by time left in ascending order."] = "根据剩余时间进行升序排序。"
L["Sort in ascending alphabetical order."] = "根据字母排列进行升序排序。"
L["Sort Order"] = "排列顺序"
L["Spec Roles"] = "角色天赋"
L["Spell Icon"] = "法术图标"
L["Spell Text"] = "法术文字"
L["Spirit Wolf"] = "幽灵狼"
L["Square"] = "方格"
L["Stack Count"] = "堆栈计数"
L["Stances"] = "姿态"
L["Stealth"] = "隐身"
L["Style"] = "样式"
L["Tank"] = "坦克"
L["Tanked Targets"] = "坦克组件"
L["Tapped Color"] = "标记颜色"
L["Target Highlight"] = "目标高亮"
L["Target Only"] = "只有目标"
L["Text at Full HP"] = "满血血量文字"
L["Text Boundaries"] = "文字边框"
L["Text Bounds and Sizing"] = "文字边框和大小"
L["Text Height"] = "文字高亮"
L["Text Width"] = "文字的宽度"
L["Texture"] = "材质"
L["Textures"] = "材质"
L["These options are for the textures shown on nameplates at various threat levels."] = "这些选项用来对不同的仇恨等级设置材质。"
L[ [=[These settings will define the space that text can be placed on the nameplate.
Having too large a font and not enough height will cause the text to be not visible.]=] ] = [=[这些设置将定义文字放置在姓名板上的空间。
过大的字体与高度不足将导致导致文字不可见。]=]
L["Thick Outline"] = "粗轮廓"
L["Thick Outline, Monochrome"] = "粗轮廓，单色"
L["This allows HP color to be the same as the threat colors you set below."] = "这将允许血量颜色与你在下面所设置的仇恨颜色相同。"
L["This allows you to save friendly player class information between play sessions or nameplates going off the screen.|cffff0000(Uses more memory)"] = "这个选项允许你在游戏会话或者离开屏幕的姓名板中保存友方玩家职业信息。|cffff0000（更多的内存使用）"
L["This lets you select the layout style of the aura widget."] = "这可以让你选择光环部件的布局风格。"
L["This lets you select the layout style of the aura widget. (requires /reload)"] = "这可以让你选择光环部件的布局风格。(需要 /reload)"
L["This widget will display a small bar that will display your current threat relative to other players on your target nameplate or recently mousedover namplates."] = "这个组件将在你目标姓名板或者最近鼠标指向过的姓名板上显示一个小条，这个小条将显示相对于其他玩家你的当前仇恨。"
L["This widget will display a small shield or dagger that will indicate if the nameplate is currently being tanked.|cffff00ffRequires tanking role.|r"] = "这个组件将显示一个用来指示单位当前是否被坦住的盾或匕首。|cffff00ff需要坦克角色。|r"
L["This widget will display auras that match your filtering on your target nameplate and others you recently moused over."] = "这个组件将在你的目标姓名板与你最近鼠标指向过的其他单位姓名板上显示符合你过滤条件的减益状态(Auras)。"
L["This widget will display auras that match your filtering on your target nameplate and others you recently moused over. The old aura widget (Aura) must be disabled first."] = "该部件使你当前目标和你最近鼠标滑过的姓名版显示光环。旧版光环部件必须先禁用。"
L["This widget will display class icons on nameplate with the settings you set below."] = "这个组件将依据你在下面的设置在姓名板上显示职业图标。"
L["This widget will display combo points on your target nameplate."] = "这个组件将在你的姓名板上显示连击点。"
L["This will allow you to add additional scaling changes to specific mob types."] = "这将允许你对特殊的怪物类型增加额外的缩放改变。"
L["This will allow you to disabled threat alpha changes on marked targets."] = "这将允许你在被标记的目标上禁用仇恨透明度改变。"
L["This will allow you to disabled threat art on marked targets."] = "这将允许你在被标记的目标上禁用仇恨艺术材质。"
L["This will allow you to disabled threat scale changes on marked targets."] = "这将允许你在被标记的目标上禁用仇恨缩放改变。"
L["This will color the aura based on its type (poison, disease, magic, curse) - for Icon Mode the icon border is colored, for Bar Mode the bar itself."] = "这将根据其类型（中毒，疾病，魔法，诅咒）对图标风格进行边框上色，而对条的风格是在它本身。"
L["This will enable headline view (Text-Only) for nameplates. TidyPlatesHub must be enabled for this to work. Use the TidyPlatesHub options for configuration."] = "这将启用姓名版的标题预览(仅文字)。TidyPlatesHub必须启用才能工作。使用TidyPlatesHub配置选项。"
L["This will format text to a simpler format using M or K for millions and thousands. Disabling this will show exact HP amounts."] = "这个设置将使用M与K来表示百万或一千以简化文字格式。禁用此选项将显示准确的血量值。"
L["This will format text to show both the maximum hp and current hp."] = "这个选项将设置文字格式以同时显示最大血量与当前血量。"
L["This will format text to show hp as a value the target is missing."] = "这个选项将设置文字格式来显示目标损失的血量值。"
L["This will toggle the aura widget to only show for your current target."] = "这样做就只显示你对当前目标施加的减益效果。"
L["This will toggle the aura widget to show the cooldown spiral on auras."] = "这将使得光环部件触发显示冷却旋转。"
L["This will toggle the aura widget to show the cooldown spiral on auras. (requires /reload)"] = "这将使得光环部件触发显示冷却旋转。(需要 /reload)"
L["Threat Colors"] = "仇恨颜色"
L["Threat Line"] = "仇恨线"
L["Threat System"] = "仇恨系统"
L["Time Left"] = "剩余时间"
L["Time Text Offset"] = "时间文字偏移"
L["Toggles"] = "切换"
L["Toggling"] = "切换"
L["Top-to-bottom"] = "从上到下"
L["Totem Alpha"] = "图腾透明度"
L["Totem Nameplates"] = "图腾姓名板"
L["Totem Scale"] = "图腾缩放"
L["Treant"] = "树人"
L["Truncate Text"] = "简化文字"
L["Type direct icon texture path using '\\' to separate directory folders, or use a spellid."] = "直接输入图标材质的路径，使用'\\'来分开目录文件夹，或使用法术ID。"
L["Typeface"] = "字体"
L["Undetermined"] = "未确定"
L["Uninterruptable Casts"] = "不可打断的施法"
L["Unknown option: "] = "未知设置： "
L["Updating default profile with new settings ..."] = "在新设置上更新默认用户..."
L["Usage: /tptp [options]"] = "输入: /tptp [options]"
L["Use a custom color for the healtbar's background."] = "在血条背景上使用自定义颜色。"
L["Use a custom color for the health bar of quest mobs."] = "任务怪的血量使用自定义颜色"
L["Use coloring based an threat level (configured in Threat System) in combat (custom color is only used out of combat)."] = "在战斗中使用基于仇恨等级的着色(设置在仇恨系统)  (自定义颜色仅被用在战斗之外)。"
L["Use Custom Settings"] = "使用自定义设置"
L["Use Target's Name"] = "使用目标名字"
L["Use the healthbar's foreground color also for the background."] = "将血条前景颜色作为背景。"
L["Use Threat Colors"] = "使用仇恨颜色"
L["Val'kyr Shadowguard"] = "瓦格里暗影戒卫者"
L["Venomous Snake"] = "剧毒蛇"
L["Vertical Align"] = "垂直定位"
L["Vertical Alignment"] = "垂直对齐"
L["Vertical Spacing"] = "垂直间距"
L["Viper"] = "毒蛇"
L["Visibility"] = "可见性"
L["Volatile Ooze"] = "不稳定的软泥怪"
L["Water Elemental"] = "水元素"
L["Web Wrap"] = "缠网"
L["White List"] = "白名单"
L["White List (Mine)"] = "白名单(我的)"
L["Wide"] = "宽大"
L["Widgets"] = "组件"
L["X"] = "X轴"
L["Y"] = "Y轴"
L["Yes"] = "是"
L["You can access the "] = "你可以进入"
