------------------------------------------------------------------------------
-- Traditional Chinese localization --by andy52005
------------------------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):NewLocale("Skada", "zhTW", false)
if not L then return end

L["%s dies"] = "%s已死亡"
L["%s on %s removed by %s"] = "%s在%s被%s移除了"
L["%s on %s removed by %s's %s"] = "%s在%s被%s的%s移除了"
L["A damage meter."] = "一個傷害統計。"
L["Absorb"] = "吸收"
L["Absorb details"] = "吸收細節"
L["Absorb spells"] = "吸收的法術"
L["Absorbed"] = "已吸收"
L["Absorbs"] = "吸收量"
L["Absorbs and healing"] = "吸收和治療"
L["Active time"] = "活躍時間"
L["Activity"] = "活躍度"
L["Adds a background frame under the bars. The height of the background frame determines how many bars are shown. This will override the max number of bars setting."] = "新增一個計量條的背景框架。背景框架的高度將決定顯示多少個計量條。這會忽略計量條最多數量的設定。"
L["Adds a set of standard themes to Skada. Custom themes can also be used."] = "新增一個Skada的基本主題設定。自訂主題也能使用。"
L["Aggressive combat detection"] = "雜兵戰鬥檢測"
L["All data has been reset."] = "所有資料已重置。"
L["All Skada functionality is now in 1 addon folder."] = "所有的Skada模組現在全在一個插件資料夾裡"
L["Alternate color"] = "間隔的顏色"
L["Always show self"] = "總是顯示自己"
L["Animate bar changes smoothly rather than immediately."] = "計量條動態平滑變化而非立即的。"
L["Announce CC breaking to party"] = "控場被破除時通知到隊伍頻道中"
L["Appearance"] = "外觀"
L["Append a count to set names with duplicate mob names."] = "追加一個統計以設置重複的怪物名稱。"
L["Apply"] = "套用"
L["Apply theme"] = "套用主題"
L["Ask"] = "詢問"
L["Attack"] = "近戰攻擊"
L["Automatically switch to set 'Current' and this mode after a wipe."] = "清除後，自動切換至'目前的'模組。"
L["Automatically switch to set 'Current' and this mode when entering combat."] = "當進入戰鬥時，自動切換'目前的'以及選擇的模組。"
L["Autostop"] = "自動停止"
L["Autostop description"] = "當有一半以上的團員已死時自動停止當前區段。"
L["Average"] = "平均"
L["Average hit:"] = "平均值:"
L["Background"] = "背景"
L["Background color"] = "背景的顏色"
L["Background texture"] = "背景的材質"
L["Bar color"] = "計量條的顏色"
L["Bar display"] = "顯示計量條"
L["Bar display is the normal bar window used by most damage meters. It can be extensively styled."] = "條列顯示是大多數傷害統計使用的一般條列視窗。它可以是廣泛的樣式。"
L["Bar font"] = "計量條的字型"
L["Bar font size"] = "計量條的字型大小"
L["Bar height"] = "計量條的高度"
L["Bar orientation"] = "計量條的方向"
L["Bar spacing"] = "計量條的間距"
L["Bar texture"] = "計量條的材質"
L["Bar width"] = "計量條的寬度"
L["Bars"] = "計量條"
L["Bars will grow up instead of down."] = "計量條將向上增長。"
L["Block"] = "格擋"
L["Blocked"] = "已格擋"
L["Border"] = "外框"
L["Border color"] = "外框顏色"
L["Border texture"] = "邊框的材質"
L["Border thickness"] = "邊框的厚度"
L["Boss fights will be kept with this on, and non-boss fights are discarded."] = "保留與首領之間的戰鬥紀錄，與非首領的戰鬥紀錄將會被消除。"
L["Broker display"] = "Broker顯示"
L["Buff spell list"] = "增益法術列表"
L["Buff uptimes"] = "增益持續時間"
L["Buffs"] = "增益"
L["Buttons"] = "按鈕"
L["CC"] = "控場"
L["CC breakers"] = "控場破除者"
L["CC breaks"] = "控場被破除"
L["Change"] = "變更"
L["Channel"] = "頻道"
L["Choose the alternate color of the bars."] = "選擇計量條間隔的顏色。"
L["Choose the background color of the bars."] = "選擇計量條的背景顏色。"
L["Choose the default color of the bars."] = "變更計量條預設的顏色。"
L["Choose the default color."] = "選擇預設顏色。"
L["Choose the system to be used for displaying data in this window."] = "在視窗中選擇顯示資料的使用方式。"
L["Choose the window to be deleted."] = "選擇的視窗已刪除。"
L["Choose which data feed to show in the DataBroker view. This requires an LDB display addon, such as Titan Panel."] = "選擇需要顯示在DataBroker上的資料來源。需要一個LDB的顯示插件，例如Titan Panel。"
L["Class color bars"] = "計量條的職業顏色"
L["Class color text"] = "文字的職業顏色"
L["Class icons"] = "職業圖示"
L["Click below and configure your '|cFFFF0000Disabled Modules|r'."] = "點擊下方按鈕並設定你的'|cFFFF0000停用模組|r'"
L["Click for"] = "點擊後為"
L["Clickthrough"] = "穿越點擊"
L["Columns"] = "計量條上"
L["Combat mode"] = "戰鬥模組"
L["Combined"] = "組合的"
L["Condensed"] = "簡易的"
L["Configure"] = "設定"
L["Configure description"] = "讓你配置此啟用的Skada視窗。"
L["Control-Click for"] = "Ctrl+點擊後為"
L["Controls if data is reset when you enter an instance."] = "當你進入副本時資料是否要重置。"
L["Controls if data is reset when you join a group."] = "當你加入團體時資料是否要重置。"
L["Controls if data is reset when you leave a group."] = "當你離開團體時控制資料是否要重置。"
L["Controls the way large numbers are displayed."] = "控制數字的顯示位數。"
L["Controls the way set names are displayed."] = "控制設定名稱顯示的方式。"
L["Create window"] = "建立視窗"
L["Critical"] = "致命一擊"
L["Crushing"] = "碾壓"
L["Current"] = "目前的"
L["Damage"] = "傷害"
L["Damage done"] = "總傷害"
L["Damage done per player"] = "每位玩家的總傷害"
L["Damage from"] = "傷害來自"
L["Damage on"] = "傷害於"
L["Damage spell details"] = "傷害法術細節"
L["Damage spell list"] = "傷害法術列表"
L["Damage taken"] = "承受傷害"
L["Damage taken by spell"] = "承受法術傷害"
L["Damage taken per player"] = "每位玩家的承受傷害"
L["Damage: Personal DPS"] = "傷害:個人的DPS"
L["Damage: Raid DPS"] = "傷害:團隊的DPS"
L["Damaged mobs"] = "受到傷害的怪物"
L["DamageTaken"] = "承受傷害"
L["Data Collection"] = "數據收集"
L["Data feed"] = "資料來源"
L["Data resets"] = "資料重置"
L["Data segments to keep"] = "保留分段資料"
L["Data text"] = "數據文字"
L["Data text acts as an LDB data feed. It can be integrated in any LDB display such as Titan Panel or ChocolateBar. It also has an optional internal frame."] = "數據文字行為類似LDB數據輸出。它可以整合在任何像是泰坦面板與巧克力棒的LDB顯示中。它也有一個可選的內部框架。"
L["Death log"] = "死亡紀錄表"
L["Deaths"] = "死亡紀錄"
L["Deaths:"] = "死亡人數:"
L["Debuff spell list"] = "減益法術的列表"
L["Debuff uptimes"] = "減益持續時間"
L["Debuffs"] = "減益"
L["Default"] = "預設值"
L["Deflect"] = "偏斜"
L["Delete"] = "刪除"
L["Delete segment"] = "刪除分段資料"
L["Delete theme"] = "刪除主題"
L["Delete window"] = "刪除視窗"
L["Deletes the chosen window."] = "刪除已選擇的視窗。"
L["Detailed"] = "詳細的"
L["Disable"] = "停用"
L["Disable while hidden"] = "停用時隱藏"
L["DISABLED"] = "停用"
L["Disabled Modules"] = "停用模組"
L["Disables mouse clicks on bars."] = "在計量條上停用滑鼠點擊。"
L["Dispels"] = "驅散"
L["Dispels:"] = "驅散:"
L["Display system"] = "顯示方式"
L["Distance between bars."] = "計量條之間的距離。"
L["Do not show DPS"] = "不顯示每秒傷害"
L["Do not show HPS"] = "不顯示每秒治療"
L["Do not show TPS"] = "不顯示每秒威脅值"
L["Do not warn while tanking"] = "坦怪時不警告"
L["Do you want to reset Skada?"] = "你要重置Skada嗎？"
L["Dodge"] = "閃躲"
L["DPS"] = "每秒傷害"
L["DTPS"] = "每秒承受的傷害"
L["Enable"] = "啟用"
L["ENABLED"] = "啟用"
L["Enables the title bar."] = "啟用標題條。"
L["Enemies"] = "敵方"
L["Enemy damage done"] = "敵方的傷害"
L["Enemy damage taken"] = "敵方的承受傷害"
L["Enemy healing done"] = "敵方的治療"
L["Enemy healing taken"] = "敵方承受的治療"
L["Energy gain sources"] = "能量獲得來源"
L["Energy gained"] = "獲得能量"
L["Enter the name for the new window."] = "為新視窗輸入名稱。"
L["Enter the name for the window."] = "輸入視窗名稱。"
L["Evade"] = "閃避"
L["Fails"] = "失誤"
L["Fails:"] = "失誤:"
L["Fixed bar width"] = "固定條列寬度"
L["Flash screen"] = "螢幕閃爍"
L["Focus gain sources"] = "集中值獲得來源"
L["Focus gained"] = "獲得集中值"
L["Font flags"] = "字型標籤"
L["General"] = "一般"
L["General options"] = "一般選項"
L["Glancing"] = "偏斜"
L["Guild"] = "公會"
L["Healed by"] = "被治療"
L["Healed players"] = "被治療的玩家"
L["Healing"] = "治療"
L["Healing spell details"] = "治療法術細節"
L["Healing spell list"] = "治療法術列表"
L["Healing taken"] = "承受的治療"
L["Health"] = "生命力"
L["Height"] = "高度"
L["Hide in combat"] = "戰鬥中隱藏"
L["Hide in PvP"] = "在PvP中隱藏"
L["Hide when solo"] = "單練時隱藏"
L["Hide window"] = "隱藏視窗"
L["Hides DPS from the Damage mode."] = "在傷害模組中不顯示每秒傷害。"
L["Hides HPS from the Healing modes."] = "在治療模組中不顯示每秒治療。"
L["Hides Skada's window when in Battlegrounds/Arenas."] = "當處於戰場/競技場時隱藏Skada的視窗。"
L["Hides Skada's window when in combat."] = "當處於戰鬥狀態時隱藏Skada的視窗。"
L["Hides Skada's window when not in a party or raid."] = "當不在隊伍或團隊時隱藏Skada的視窗。"
L["Hint: Left-Click to set active mode."] = "提示：左鍵點擊來設定啟動模式。"
L["Hint: Left-Click to toggle Skada window."] = "提示:左鍵點擊切換Skada視窗。"
L["Hit"] = "命中"
L["Holy power gain sources"] = "神聖能量獲得來源"
L["Holy power gained"] = "獲得神聖能量"
L["How often windows are updated. Shorter for faster updates. Increases CPU usage."] = "視窗更新有多頻繁。較短時間更新快速，但增加CPU的負擔。"
L["HPS"] = "每秒治療"
L["HPS:"] = "每秒治療:"
L["If checked, bar width is fixed. Otherwise, bar width depends on the text width."] = "勾選後，條列寬度將會固定。否則條列寬度取決於文字寬度。"
L["Ignore Main Tanks"] = "忽略主坦克"
L["Immune"] = "免疫"
L["Include set"] = "包含設定"
L["Include set name in title bar"] = "在標題欄包含設定名稱"
L["Informative tooltips"] = "提示訊息的資訊"
L["Inline bar display"] = "內置條顯示"
L["Inline display is a horizontal window style."] = "內置顯示是一個水平視窗樣式。"
L["Instance"] = "副本"
L["Interrupts"] = "中斷"
L["Keep segment"] = "保留分段資料"
L["Keeps the player shown last even if there is not enough space."] = "保持玩家顯示在最後即使沒有足夠的空間。"
L["Last fight"] = "最後的戰鬥"
L["Left to right"] = "由左到右"
L["Lines"] = "行數"
L["List of damaged players"] = "玩家造成傷害的列表"
L["List of damaging spells"] = "傷害法術的列表"
L["Lock window"] = "鎖定視窗"
L["Locks the bar window in place."] = "鎖定計量條視窗位置。"
L["Mana gain spell list"] = "獲得法力的法術列表"
L["Mana gained"] = "獲得法力"
L["Margin"] = "邊距"
L["Max bars"] = "最多計量條數量"
L["Maximum"] = "最大"
L["Maximum hit:"] = "最大值:"
L["Memory usage is high. You may want to reset Skada, and enable one of the automatic reset options."] = "記憶體使用過高，你或許想要重置Skada，並且啟用一個自動重設的選項。"
L["Merge pets"] = "合併寵物"
L["Merges pets with their owners. Changing this only affects new data."] = "合併寵物與主人的資料，此只影響改變後的資料。"
L["Minimum"] = "最小"
L["Minimum hit:"] = "最小值:"
L["Missed"] = "未擊中"
L["Mode"] = "模組"
L["Mode description"] = "跳至特定模組。"
L["Mode switching"] = "轉換模組"
L["Monochrome"] = "單色"
L["Name"] = "名稱"
L["Name of recipient"] = "接收者的名稱"
L["Name of your new theme."] = "你新主題的名稱。"
L["No"] = "否"
L["No mode or segment selected for report."] = "沒有選擇可報告的模組或分段資料。"
L["No mode selected for report."] = "沒有選擇可報告的模組。"
L["None"] = "無"
L["Number format"] = "數字位數"
L["Number set duplicates"] = "重複數字設置"
L["Officer"] = "幹部"
L["Only keep boss fighs"] = "只保留首領戰"
L["opens the configuration window"] = "開啟設定視窗"
L["Options"] = "選項"
L["Other"] = "其他"
L["Outline"] = "輪廓"
L["Outlined monochrome"] = "單色字體"
L["Overheal"] = "過量治療"
L["Overhealing"] = "過量治療"
L["Parry"] = "招架"
L["Party"] = "隊伍"
L["Percent"] = "百分比"
L["Play sound"] = "播放音效"
L["Position of the tooltips."] = "提示訊息的位置。"
L["Power"] = "獲得能量"
L["Power gains"] = "獲得能量"
L["Profiles"] = "設定檔"
L["Rage gain sources"] = "怒氣獲得來源"
L["Rage gained"] = "獲得怒氣"
L["Raid"] = "團隊"
L["RDPS"] = "團隊DPS"
L["RealID"] = "真實ID"
L["Reflect"] = "反射"
L["Rename window"] = "重新命名視窗"
L["Report"] = "報告"
L["Report description"] = "打開一個對話框，讓你以各種方式報告數據給他人。"
L["reports the active mode"] = "報告目前的模組"
L["Reset"] = "重置"
L["Reset description"] = "除標記為保留外重置全部戰鬥數據。"
L["Reset on entering instance"] = "進入副本時重置"
L["Reset on joining a group"] = "加入團體時重置"
L["Reset on leaving a group"] = "離開團體時重置"
L["resets all data"] = "重置所有資料"
L["Resist"] = "抵抗"
L["Resisted"] = "已抵抗"
L["Return after combat"] = "戰鬥後返回"
L["Return to the previous set and mode after combat ends."] = "戰鬥結束後返回原先的設定和模組。"
L["Reverse bar growth"] = "計量條反向增長"
L["Right to left"] = "由右到左"
L["Right-click to configure"] = "右鍵點擊進行設定"
L["Right-click to open menu"] = "右鍵點擊開啟選單"
L["Right-click to set active set."] = "右鍵點擊設定啟動設置。"
L["Role icons"] = "角色類型圖標"
L["Runic power gain sources"] = "符能獲得來源"
L["Runic power gained"] = "獲得符能"
L["'s "] = "的"
L["'s Absorbs"] = "的吸收"
L["'s Buffs"] = "的增益"
L["'s Damage"] = "的傷害"
L["'s Damage taken"] = "的承受傷害"
L["'s Death"] = "的死亡紀錄"
L["'s Debuffs"] = "的減益"
L["'s Fails"] = "的失誤"
L["'s Healing"] = "的治療"
L["Save"] = "儲存"
L["Save theme"] = "儲存主題"
L["Say"] = "說"
L["Scale"] = "比例"
L["Segment"] = "分段"
L["Segment description"] = "跳至特定區段。"
L["Segment time"] = "分段時間"
L["Self"] = "自己"
L["Send report"] = "發送報告"
L["Set format"] = "設定格式"
L["Sets the font flags."] = "設定字型的標籤。"
L["Sets the scale of the window."] = "設定視窗比例。"
L["Shake screen"] = "螢幕震動"
L["Shift + Left-Click to open menu."] = "Shift+左鍵點擊開啟選單。"
L["Shift + Left-Click to reset."] = "Shift+左鍵點擊進行重置。"
L["Shift-Click for"] = "Shift+點擊後為"
L["Show menu button"] = "顯示選單按鈕"
L["Show minimap button"] = "顯示小地圖按鈕"
L["Show rank numbers"] = "顯示排名"
L["Show raw threat"] = "顯示原始威脅值"
L["Show spark effect"] = "顯示觸發效果"
L["Show tooltips"] = "顯示提示訊息"
L["Show totals"] = "顯示總計"
L["Shows a button for opening the menu in the window title bar."] = "在視窗標題條上顯示一個按鈕以便開啟選單。"
L["Shows a extra row with a summary in certain modes."] = "在某些模式顯示額外一行的總計。"
L["Shows numbers for relative ranks for modes where it is applicable."] = "在模組適當位置顯示相對排名。"
L["Shows raw threat percentage relative to tank instead of modified for range."] = "顯示與坦克之間的原始威脅值百分比。"
L["Shows subview summaries in the tooltips."] = "在提示訊息中顯示即時資訊。"
L["Shows threat on focus target, or focus target's target, when available."] = "當有設定時可顯示專注目標或專注目標的目標的威脅值。"
L["Shows tooltips with extra information in some modes."] = "在一些模組中顯示提示訊息以及額外的訊息。"
L["Skada has changed!"] = "Skada 已經改版!"
L["Skada Menu"] = "Skada 選單"
L["Skada summary"] = "Skada一覽"
L["Skada usually uses a very conservative (simple) combat detection scheme that works best in raids. With this option Skada attempts to emulate other damage meters. Useful for running dungeons. Meaningless on boss encounters."] = "Skada在團隊副本中經常性的使用一種非常傳統(簡易)的戰鬥檢測機制。勾選此選項Skada將嘗試模仿其他的傷害統計插件，使其有效運用在雜兵戰。但與首領戰則是無效的。"
L["Skada will |cFFFF0000NOT|r function properly until you delete the following AddOns:"] = "Skada |cFFFF0000不會|r正確的運作直到你刪除以下插件:"
L["Skada will not collect any data when automatically hidden."] = "當自動隱藏時，Skada將不會紀錄任何資料。"
L["Skada: %s for %s:"] = "Skada:%s來自%s:"
L["Skada: Fights"] = "Skada:戰鬥"
L["Skada: Modes"] = "Skada:模組"
L["Smart"] = "智能"
L["Smooth bars"] = "平滑計量條"
L["Snap to best fit"] = "適合比例"
L["Snaps the window size to best fit when resizing."] = "視窗比例自動調整到適合比例。"
L["Sort modes by usage"] = "根據使用率對模組排序"
L["Spell details"] = "法術細節"
L["Spell list"] = "法術列表"
L["Spell school colors"] = "法術派別顏色"
L["Start new segment"] = "開始新的分段"
L["Stop"] = "停止"
L["Stop description"] = "停止或恢復當前區段。用於滅團後停止收集數據。也可在設置中設為自動停止。"
L["Strata"] = "層級"
L["Subview rows"] = "資訊行數"
L["Switch to mode"] = "模組切換到"
L["Switch to segment"] = "轉換到分段資料"
L["targets"] = "目標"
L["Text color"] = "文字顏色"
L["The background color of the title."] = "標題的背景顏色。"
L["The color of the background."] = "背景的顏色。"
L["The color used for the border."] = "使用在外框的顏色。"
L["The direction the bars are drawn in."] = "計量條的增長方向。"
L["The font size of all bars."] = "所有計量條的字型大小。"
L["The font used by all bars."] = "所有計量條使用這個字型。"
L["The height of the bars."] = "計量條的高度。"
L["The height of the title frame."] = "標題框架的高度"
L["The height of the window. If this is 0 the height is dynamically changed according to how many bars exist."] = "視窗的高度。若設定為0則依照計量條的多寡自動調整。"
L["The margin between the outer edge and the background texture."] = "外框和背景材質之間的邊距。"
L["The maximum number of bars shown."] = "顯示最多數量的計量條。"
L["The mode list will be sorted to reflect usage instead of alphabetically."] = "模組列表將依照使用率排序而非字母順序"
L["The number of fight segments to keep. Persistent segments are not included in this."] = "保留多少戰鬥資料分段的數量，不包含連續的片段。"
L["The number of rows from each subview to show when using informative tooltips."] = "當使用提示訊息的資訊時需要多少行數來顯示資訊。"
L["The size of the texture pattern."] = "材質圖案的大小"
L["The sound that will be played when your threat percentage reaches a certain point."] = "當你的威脅值達到一定的百分比時播放音效。"
L["The text color of the title."] = "標題的文字顏色。"
L["The texture used as the background of the title."] = "使用於標題的背景材質。"
L["The texture used as the background."] = "使用於背景的材質。"
L["The texture used by all bars."] = "所有計量條使用這個材質。"
L["The texture used for the border of the title."] = "使用於標題的邊框材質。"
L["The texture used for the borders."] = "使用於邊框的材質。"
L["The thickness of the borders."] = "邊框的厚度。"
L["The width of the bars."] = "計量條的寬度。"
L["Theme"] = "主題"
L["Theme applied!"] = "主題已套用！"
L["Themes"] = "主題"
L["There is nothing to report."] = "沒有資料可以報告。"
L["Thick outline"] = "粗體"
L["This change requires a UI reload. Are you sure?"] = "這些改變需要重載UI，你確認嗎？"
L["This determines what other frames will be in front of the frame."] = "這決定了那些其他的框架會在此框架之前。"
L["This will cause the screen to flash as a threat warning."] = "威脅值警告時讓螢幕閃爍。"
L["This will cause the screen to shake as a threat warning."] = "威脅值警告時讓螢幕震動。"
L["This will play a sound as a threat warning."] = "威脅值警告時會撥放音效。"
L["Threat"] = "威脅值"
L["Threat sound"] = "威脅值的音效"
L["Threat threshold"] = "威脅值的條件"
L["Threat warning"] = "威脅值的警告"
L["Threat: Personal Threat"] = "威脅值:個人的威脅值"
L["Tick the modules you want to disable."] = "勾選您想要停用的模組。"
L["Tile"] = "標題"
L["Tile size"] = "標題大小"
L["Tile the background texture."] = "標題的背景材質。"
L["Title bar"] = "標題條"
L["Title color"] = "標題顏色"
L["Title height"] = "標題高度"
L["Toggle window"] = "切換視窗"
L["Toggles showing the minimap button."] = "切換顯示小地圖按鈕。"
L["Tooltip position"] = "提示訊息的位置"
L["Tooltips"] = "提示訊息"
L["Top left"] = "左上"
L["Top right"] = "右上"
L["Total"] = "總體的"
L["Total healing"] = "總體治療"
L["TotalHealing"] = "總體治療"
L["TPS"] = "每秒威脅值"
L["Tweaks"] = "調整"
L["Update frequency"] = "更新頻率"
L["Use class icons where applicable."] = "使用職業圖示(如果適用)."
L["Use focus target"] = "使用專注目標"
L["Use role icons where applicable."] = "使用適用的角色類型圖標。"
L["Use spell school colors where applicable."] = "適合的法術使用派別顏色。"
L["Various tweaks to get around deficiences and problems in the game's combat logs. Carries a small performance penalty."] = "不同的調整，以解決在遊戲中的戰鬥日誌不足和問題。附帶一個小小的性能損失。"
L["When possible, bar text will be colored according to player class."] = "依照玩家職業來調整計量條文字的顏色。"
L["When possible, bars will be colored according to player class."] = "依照玩家職業來調整計量條的顏色。"
L["When your threat reaches this level, relative to tank, warnings are shown."] = "當你的威脅值與坦克相同時顯示警告。"
L["Whisper"] = "悄悄話"
L["Whisper Target"] = "悄悄話目標"
L["Width"] = "寬度"
L["Window"] = "視窗"
L["Window height"] = "視窗的高度"
L["Windows"] = "視窗"
L["Wipe mode"] = "清除模組"
L["Yes"] = "是"

L["Friendly Fire"] = "隊友誤傷"
L["List of damaging spells"] = "傷害技能列表"
L["List of players damaged"] = "傷害玩家列表"
L["spells"] = "技能"
L["targets"] = "目標"

L["Healing: Personal HPS"] = "治療:個人HPS"
L["Healing: Raid HPS"] = "治療:團隊HPS"
L["RHPS"] = true

