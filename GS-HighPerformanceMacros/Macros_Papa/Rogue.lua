local _, Sequences = ...

------------------
----- Rogue
------------------

-- Rogue(specID = 260)

Sequences['papa_outlaw'] = {
-- This Sequence was exported from GSE 2.2.03.
  Author="Galvet@Draka",
  SpecID=260,
  Talents = "2211322",
  Help = [[alt for Roll at max combo points]],
  Default=1,
  MacroVersions = {
    [1] = {
      StepFunction = "Sequential",
      KeyPress={
        "/cast [combat] Curse of the Dreadblades",
        "/cast [combat] Adrenaline Rush",
        "/cast [combat] Marked for Death",
        "/cast [target=party1] Tricks of the Trade",
        "/cast [mod:alt] Roll the Bones",
        "/cast [mod:ctrl] Blade Flurry",
      },
      PreMacro={
        "/cast [nostealth,nocombat] Stealth",
        "/cast [stealth] Ambush",
      },
        "/castsequence Saber Slash, Saber Slash, Pistol Shot, Run Through",
      PostMacro={
      },
      KeyRelease={
        "/cast [nostealth,nocombat] Stealth",
      },
    },
  },
}

Sequences['Papa_ASS'] = {
-- This Sequence was exported from GSE 2.2.03.
  Author="Galvet@Draka",
  SpecID=259,
  Talents = "1111111",
  Help = [[Most control
Use talents: 1111111]],
  Default=1,
  MacroVersions = {
    [1] = {
     Combat=true,
      StepFunction = "Sequential",
      KeyPress={
        "/cast Vendetta",
        "/cast [mod:alt] Poisoned Knife",
      },
      PreMacro={
        "/cast [nostealth,nocombat] Stealth",
        "/cast [stealth] Shadowstep",
      },
        "/cast Garrote",
        "/castsequence  reset=combat  Mutilate, Rupture, Mutilate, Envenom",
        "/cast Kingsbane",
        "/cast Toxic Blade",
        "/castsequence  reset=combat  Mutilate, Envenom",
      PostMacro={
      },
      KeyRelease={
      },
    },
  },
}

Sequences['Papa_ASS_Aoe'] = {
-- This Sequence was exported from GSE 2.2.03.
  Author="Galvet@Draka",
  SpecID=259,
  Talents = "1111111",
  Help = [[tab target after Rupture 
Use talents: 1111111]],
  Default=1,
  MacroVersions = {
    [1] = {
     Combat=true,
      StepFunction = "Sequential",
      KeyPress={
        "/cast [mod:alt] Poisoned Knife",
      },
      PreMacro={
        "/cast [nostealth,nocombat] Stealth",
        "/cast [stealth] Shadowstep",
      },
        "/castsequence  reset=target/combat  Fan of Knives, Rupture, Fan of Knives, Envenom",
        "/cast Fan of Knives",
        "/cast Kingsbane",
        "/cast Toxic Blade",
        "/cast Garrote",
      PostMacro={
      },
      KeyRelease={
      },
    },
  },
}

Sequences['Papa_sub'] = {
-- This Sequence was exported from GSE 2.2.00.
  Author="Galvet@Draka",
  SpecID=261,
  Talents = "2331131",
  Help = [[WIP]],
  Default=1,
  MacroVersions = {
    [1] = {
      StepFunction = "Sequential",
      KeyPress={
        "/cast Symbols of Death",
        "/cast Shadow Blades",
      },
      PreMacro={
        "/cast [nostealth,nocombat] Stealth",
        "/cast Shadowstep",
        "/cast [stealth] Shadowstrike",
      },
        "/castsequence Shadow Dance, Shadowstrike, Shadowstrike",
        "/cast Goremaw's Bite",
        "/castsequence Backstab, Eviscerate, Backstab, Nightblade",
      PostMacro={
      },
      KeyRelease={
      },
    },
  },
}

