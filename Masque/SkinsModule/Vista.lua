local MSQ = LibStub("Masque", true)
if not MSQ then return end

-- Vista
MSQ:AddSkin("Vista", {
	Author = "VitalityV",
	Version = "7.1.0",
	Shape = "Square",
	Masque_Version = 70200,
	Backdrop = {
		Width = 42,
		Height = 42,
		Color = {1, 1, 1, 1},
		Texture = [[Interface\AddOns\Masque\SkinsModule\Vista_Textures\Backdrop]],
	},
	Icon = {
		Width = 39,
		Height = 39,
	},
	Flash = {
		Width = 42,
		Height = 42,
		Color = {0.1, 0, 0, 1},
		Texture = [[Interface\AddOns\Masque\SkinsModule\Vista_Textures\Overlay_128]],
	},
	Cooldown = {
		Width = 36,
		Height = 36,
		Color = {0, 0, 0, 0.7},
	},
	AutoCast = {
		Width = 32,
		Height = 32,
		ModelScale = 1.0,
	},
	Normal = {
		Width = 42,
		Height = 42,
		Static = true,
		Color = {0.25, 0.25, 0.25, 1},
		Texture = [[Interface\AddOns\Masque\SkinsModule\Vista_Textures\Normal_Vista_128]],
	},
	Pushed = {
		Width = 42,
		Height = 42,
		Color = {0, 0, 0, 1},
		Texture = [[Interface\AddOns\Masque\SkinsModule\Vista_Textures\Overlay_128]],
	},
	Border = {
		Width = 42,
		Height = 42,
		BlendMode = "BLEND",
		Color = {0, 1, 0, 1},
		Texture = [[Interface\AddOns\Masque\SkinsModule\Vista_Textures\Border_128]],
	},
	Disabled = {
		Hide = true,
	},
	Checked = {
		Width = 42,
		Height = 42,
		BlendMode = "BLEND",
		Color = {0, 0.75, 1, 1},
		Texture = [[Interface\AddOns\Masque\SkinsModule\Vista_Textures\Border_128]],
	},
	AutoCastable = {
		Width = 64,
		Height = 64,
		OffsetX = 0.5,
		OffsetY = -0.5,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
	},
	Highlight = {
		Width = 42,
		Height = 42,
		BlendMode = "ADD",
		Color = {1, 1, 1, 0.15},
		Texture = [[Interface\AddOns\Masque\SkinsModule\Vista_Textures\Highlight_128]],
	},
	Gloss = {
		Width = 42,
		Height = 42,
		Texture = [[Interface\AddOns\Masque\SkinsModule\Vista_Textures\Gloss_128]],
	},
	HotKey = {
		Width = 42,
		Height = 10,
		OffsetX = -5,
		OffsetY = -4,
	},
	Count = {
		Width = 42,
		Height = 10,
		OffsetX = 0,
		OffsetY = 4,
	},
	Name = {
		Width = 42,
		Height = 10,
		OffsetY = -10,
	},
},true)