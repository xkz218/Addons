local AS = unpack(AddOnSkins)

if not AS:CheckAddOn('Classic Quest Log') then return end

function AS:ClassicQuestLog()
	AS:SkinFrame(ClassicQuestLog)
	ClassicQuestLog:SetTemplate("Transparent")
	AS:SkinScrollBar(ClassicQuestLogScrollFrameScrollBar)
	AS:SkinScrollBar(ClassicQuestLogDetailScrollFrameScrollBar)
	ClassicQuestLogInset:StripTextures()
	ClassicQuestLogScrollFrame.expandAll:StripTextures()
	ClassicQuestLog.count:StripTextures()
	ClassicQuestLogScrollFrame:StripTextures()
	ClassicQuestLogDetailScrollFrame:StripTextures()
	ClassicQuestLogPortraitFrame:Kill()
	ClassicQuestLog.title:SetFormattedText(TEXT" Quest Log ")

for i = 1, ClassicQuestLog:GetNumChildren() do
	local object = select(i, ClassicQuestLog:GetChildren())
	if object:IsObjectType('Button') then
		if object:GetText() ~= nil then
			AS:SkinButton(object, true)
		else
			AS:SkinCloseButton(object, true)
		end
	end
end

	--Reposition Expand/Collapse Button
	ClassicQuestLogScrollFrame.expandAll:ClearAllPoints()
	ClassicQuestLogScrollFrame.expandAll:Point('BOTTOMLEFT', ClassicQuestLog, 'TOPLEFT', 10, -53)

	ClassicQuestLog.count:Size(100, 20)
	ClassicQuestLog.count:ClearAllPoints()
	ClassicQuestLog.count:Point('LEFT', ClassicQuestLogScrollFrame.expandAll, 'RIGHT', -4, -4)

	--Reposition Show Map Button
	ClassicQuestLog.mapButton:ClearAllPoints()
	ClassicQuestLog.mapButton:Point('BOTTOMRIGHT', ClassicQuestLog, 'TOPRIGHT', 0, -59)
	ClassicQuestLog.mapButton.Text:SetFormattedText(TEXT" Click ")

	--Resize Expand/Collapse Button
	ClassicQuestLogScrollFrame.expandAll:Size(120, 30)
	ClassicQuestLogScrollFrame.expandAll:SetFormattedText(TEXT" Expand/Collapse ")

	--Resize Show Map Button
	ClassicQuestLog.mapButton:Size(56, 40)
end

AS:RegisterSkin('Classic Quest Log', AS.ClassicQuestLog)
