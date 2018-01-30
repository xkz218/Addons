local myname, ns = ...

ns.defaults = {
    profile = {
        show_junk = true,
        show_npcs = true,
        found = false,
        repeatable = true,
        icon_scale = 1.0,
        icon_alpha = 1.0,
        icon_item = false,
        tooltip_item = true,
        tooltip_questid = false,
    },
    char = {
        hidden = {
            ['*'] = {},
        },
    },
}

local L = {}
if GetLocale() == 'zhCN' then
	L["Icon settings"] = "图标设置"
	L["These settings control the look and feel of the icon."] = "这些设置控制图标的外观和行为"
	L["Icon Scale"] = "图标比例"
	L["The scale of the icons"] = "图标的缩放比例"
	L["Icon Alpha"] = "图标透明度"
	L["The alpha transparency of the icons"] = "图标的透明度"
	L["What to display"] = "哪些显示"
	L["Use item icons"] = "使用物品图标"
	L["Show the icons for items, if known; otherwise, the achievement icon will be used"] = "如果物品是已知的，将显示物品图标；否则为显示成就图标."
	L["Use item tooltips"] = "使用物品提示"
	L["Show the full tooltips for items"] = "使用详细的物品提示信息"
	L["Show found"] = "显示已发现的"
	L["Show waypoints for items you've already found?"] = "显示你已发现的物品路径点"
	L["Show NPCs"] = "显示 NPCs"
	L["Show rare NPCs to be killed, generally for items or achievements"] = "显示已击杀过的NPC, 一般是为了成就或物品"
	L["Show repeatable"] = "显示可重复的"
	L["Show items which are repeatable? This generally means ones which have a daily tracking quest attached"] = "显示可重复完成的物品,通常意味着有一个日常任务关联的"
	L["Show quest ids"] = "显示任务ID"
	L["Show the internal id of the quest associated with this node. Handy if you want to report a problem with it."] = "显示与此物品相关联的任务ID, 通常是用来报告BUG使用"
	L["Reset hidden nodes"] = "重置隐藏的节点"
	L["Show all nodes that you manually hid by right-clicking on them and choosing \"hide\"."] = "显示所有你手动隐藏的节点，按右键单击选择'隐藏'"
elseif GetLocale() == 'zhTW' then
	L["Icon settings"] = "圖示設置"
	L["These settings control the look and feel of the icon."] = "這些設置控制圖示的外觀和行為"
	L["Icon Scale"] = "圖示比例"
	L["The scale of the icons"] = "圖示的縮放比例"
	L["Icon Alpha"] = "圖示透明度"
	L["The alpha transparency of the icons"] = "圖示的透明度"
	L["What to display"] = "哪些顯示"
	L["Use item icons"] = "使用物品圖示"
	L["Show the icons for items, if known; otherwise, the achievement icon will be used"] = "如果物品是已知的，將顯示物品圖示；否則為顯示成就圖示."
	L["Use item tooltips"] = "使用物品提示"
	L["Show the full tooltips for items"] = "使用詳細的物品提示資訊"
	L["Show found"] = "顯示已發現的"
	L["Show waypoints for items you've already found?"] = "顯示你已發現的物品路徑點"
	L["Show NPCs"] = "顯示 NPCs"
	L["Show rare NPCs to be killed, generally for items or achievements"] = "顯示已擊殺過的NPC, 一般是為了成就或物品"
	L["Show repeatable"] = "顯示可重複的"
	L["Show items which are repeatable? This generally means ones which have a daily tracking quest attached"] = "顯示可重複完成的物品,通常意味著有一個日常任務關聯的"
	L["Show quest ids"] = "顯示任務ID"
	L["Show the internal id of the quest associated with this node. Handy if you want to report a problem with it."] = "顯示與此物品相關聯的任務ID, 通常是用來報告BUG使用"
	L["Reset hidden nodes"] = "重置隱藏的節點"
	L["Show all nodes that you manually hid by right-clicking on them and choosing \"hide\"."] = "顯示所有你手動隱藏的節點，按按右鍵選擇'隱藏'"
else
	L["Icon settings"] = "Icon settings"
	L["These settings control the look and feel of the icon."] = "These settings control the look and feel of the icon."
	L["Icon Scale"] = "Icon Scale"
	L["The scale of the icons"] = "The scale of the icons"
	L["Icon Alpha"] = "Icon Alpha"
	L["The alpha transparency of the icons"] = "The alpha transparency of the icons"
	L["What to display"] = "What to display"
	L["Use item icons"] = "Use item icons"
	L["Show the icons for items, if known; otherwise, the achievement icon will be used"] = "Show the icons for items, if known; otherwise, the achievement icon will be used"
	L["Use item tooltips"] = "Use item tooltips"
	L["Show the full tooltips for items"] = "Show the full tooltips for items"
	L["Show found"] = "Show found"
	L["Show waypoints for items you've already found?"] = "Show waypoints for items you've already found?"
	L["Show NPCs"] = "Show NPCs"
	L["Show rare NPCs to be killed, generally for items or achievements"] = "Show rare NPCs to be killed, generally for items or achievements"
	L["Show repeatable"] = "Show repeatable"
	L["Show items which are repeatable? This generally means ones which have a daily tracking quest attached"] = "Show items which are repeatable? This generally means ones which have a daily tracking quest attached"
	L["Show quest ids"] = "Show quest ids"
	L["Show the internal id of the quest associated with this node. Handy if you want to report a problem with it."] = "Show the internal id of the quest associated with this node. Handy if you want to report a problem with it."
	L["Reset hidden nodes"] = "Reset hidden nodes"
	L["Show all nodes that you manually hid by right-clicking on them and choosing \"hide\"."] = "Show all nodes that you manually hid by right-clicking on them and choosing \"hide\"."
end

ns.options = {
    type = "group",
    name = myname:gsub("HandyNotes_", ""),
    get = function(info) return ns.db[info[#info]] end,
    set = function(info, v)
        ns.db[info[#info]] = v
        ns.HL:SendMessage("HandyNotes_NotifyUpdate", myname:gsub("HandyNotes_", ""))
    end,
    args = {
        icon = {
            type = "group",
            name = L["Icon settings"],
            inline = true,
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
            args = {
                icon_item = {
                    type = "toggle",
                    name = L["Use item icons"],
                    desc = L["Show the icons for items, if known; otherwise, the achievement icon will be used"],
                    order = 0,
                },
                tooltip_item = {
                    type = "toggle",
                    name = L["Use item tooltips"],
                    desc = L["Show the full tooltips for items"],
                    order = 10,
                },
                -- show_junk = {
                --     type = "toggle",
                --     name = "Junk",
                --     desc = "Show items which don't count for any achievement",
                -- },
                found = {
                    type = "toggle",
                    name = L["Show found"],
                    desc = L["Show waypoints for items you've already found?"],
                    order = 20,
                },
                show_npcs = {
                    type = "toggle",
                    name = L["Show NPCs"],
                    desc = L["Show rare NPCs to be killed, generally for items or achievements"],
                    order = 30,
                },
                repeatable = {
                    type = "toggle",
                    name = L["Show repeatable"],
                    desc = L["Show items which are repeatable? This generally means ones which have a daily tracking quest attached"],
                    order = 40,
                },
                tooltip_questid = {
                    type = "toggle",
                    name = L["Show quest ids"],
                    desc = L["Show the internal id of the quest associated with this node. Handy if you want to report a problem with it."],
                    order = 40,
                },
                unhide = {
                    type = "execute",
                    name = L["Reset hidden nodes"],
                    desc = L["Show all nodes that you manually hid by right-clicking on them and choosing \"hide\"."],
                    func = function()
                        for map,coords in pairs(ns.hidden) do
                            wipe(coords)
                        end
                        ns.HL:Refresh()
                    end,
                    order = 50,
                },
            },
        },
    },
}

local player_faction = UnitFactionGroup("player")
ns.should_show_point = function(coord, point, currentZone, currentLevel)
    if point.level and point.level ~= currentLevel then
        return false
    end
    if ns.hidden[currentZone] and ns.hidden[currentZone][coord] then
        return false
    end
    if point.junk and not ns.db.show_junk then
        return false
    end
    if point.faction and point.faction ~= player_faction then
        return false
    end
    if (not ns.db.found) then
        if point.quest then
            if type(point.quest) == 'table' then
                -- if it's a table, only count as complete if all quests are complete
                local complete = true
                for _, quest in ipairs(point.quest) do
                    if not IsQuestFlaggedCompleted(quest) then
                        complete = false
                        break
                    end
                end
                if complete then
                    return false
                end
            elseif IsQuestFlaggedCompleted(point.quest) then
                return false
            end
        end
        if point.follower and C_Garrison.IsFollowerCollected(point.follower) then
            return false
        end
        if point.toy and point.item and PlayerHasToy(point.item) then
            return false
        end
    end
    if (not ns.db.repeatable) and point.repeatable then
        return false
    end
    if point.npc and not point.follower and not ns.db.show_npcs then
        return false
    end
    if point.hide_before and not ns.db.upcoming and not IsQuestFlaggedCompleted(point.hide_before) then
        return false
    end
    return true
end
