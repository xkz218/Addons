local LookingForGroup = LibStub("AceAddon-3.0"):GetAddon("LookingForGroup")

function LookingForGroup.get_lfg_score_tooltip_info(player)
	local lfgscores = LookingForGroup.lfgscores
	if lfgscores and #lfgscores ~= 0 then
		local tb = {}
		for i=1,#lfgscores do
			tb[#tb+1] = lfgscores[i](player)
		end
		if #tb ~= 0 then
			return table.concat(tb,"\n")
		end
	end
end
