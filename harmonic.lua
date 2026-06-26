setDefaultTab("Harmonic")

lblInfo = UI.Label("Harmonic")
lblInfo:setColor("red")

UI.Separator()

local version = "1.0"
print("[Luquebot] Classe: Harmonic carregada v" .. version)

UI.Separator()

macro(200, "Combo - Harmonic", function()
  if g_game.isAttacking() then
    say("Accelerando")       -- Level 1600
    say("Triad")
    say("Double Chord")
    say("Resonance")         -- Level 800
    say("Divine Ballad")     -- Level 300
    say("Crescendo")         -- Level 120
    say("Magic String")      -- Level 65
    say("Reverberate")       -- Level 25
    say("Music Strike")      -- Level 8
  end
end)

UI.Separator()

macro(200, "Combo - ++", function()
  if g_game.isAttacking() then
    say("Triad")
    say("Accelerando")       -- Level 1600
    say("Double Chord")
    say("Resonance")         -- Level 800
    say("Divine Ballad")     -- Level 300
    say("Crescendo")         -- Level 120
    say("Magic String")      -- Level 65
  end
end)

UI.Separator()

macro(200, "Bardo Buffs", function()
  if not isInPz() then
    bardTryCastList({
      "Accelerando",   -- Level 1600
      "Triad",
      "Double Chord",
      "Resonance",     -- Level 800
      "Divine Ballad", -- Level 300
      "Crescendo"      -- Level 120
    })
  end
end)

UI.Separator()

macro(8000, "Buff Bardo", function()
  if not isInPz() then
    say("Echo Song")
  end
end)

UI.Separator()


macro(8000, "Buff Bardo - CDR", function()
  if not isInPz() then
    say("Echo Song")
  end
end)

UI.Separator()
macro(3000, "Sleep", function()
  if not isInPz() then
    say("Lullaby")
  end
end)

UI.Separator()

local spell = "Mana Waste"
local manaMin = 20
local interval = 3000

macro(interval, "Mana Training", function()
  if manapercent() < manaMin then return end
  say(spell)
end)

UI.Separator()

lblInfo = UI.Label("Heal")
lblInfo:setColor("blue")

UI.Separator()

local healingSpell1 = "Intense Wound Cleansing"
local healthPercent1 = 97

macro(200, "Intense Wound Cleansing", function()
  if isInPz() then return end
  if hppercent() <= healthPercent1 then
    say(healingSpell1)
  end
end)

UI.Separator()

local healingSpell2 = "Limb Restoration"
local healthPercent2 = 97

macro(200, "Limb Restoration", function()
  if isInPz() then return end
  if hppercent() <= healthPercent2 then
    say(healingSpell2)
  end
end)

UI.Separator()

lblInfo = UI.Label("Potion HP")
lblInfo:setColor("blue")
addSeparator()
Panels.HealthItem()

UI.Separator()

lblInfo = UI.Label("MANA para noobs")
lblInfo:setColor("blue")
addSeparator()
addSeparator()
Panels.ManaItem()

UI.Separator()

local potId = 7643
local potInterval = 500

macro(potInterval, "Pot Craft SPAM", function()
  usewith(potId, player)
end)

UI.Separator()

local spell = "Crescendo"

macro(5000, "Crescendo - Buff", function()
    local target = g_game.getAttackingCreature()
    if not target then
        say(spell)
    end
end)

UI.Separator()

local spell = "Divine Ballad"

macro(5000, "Def - Buff", function()
    local target = g_game.getAttackingCreature()
    if not target then
        say(spell)
    end
end)

UI.Separator()

macro(10000, "FOOD", function()
  if player:getRegenerationTime() > 400 then return end

  for _, container in pairs(g_game.getContainers()) do
    for _, item in ipairs(container:getItems()) do
      if item:getId() == 8019 then
        return modules._G.g_blacktalon.use(item)
      end
    end
  end
end)

UI.Separator()

macro(10000, "FOOD - Passe", function()
  if player:getRegenerationTime() > 400 then return end

  for _, container in pairs(g_game.getContainers()) do
    for _, item in ipairs(container:getItems()) do
      if item:getId() == 30607 then
        return modules._G.g_blacktalon.use(item)
      end
    end
  end
end)

UI.Separator()

macro(200, "Auto Haste", function()
  if isInPz() then return end
  if hasHaste() then return end
  if getSpellCoolDown("utani hur") then return end
  if mana() < 40 then return end

  say("Haste")
end)

UI.Separator()

lblInfo = UI.Label("Para up / Down")
lblInfo:setColor("green")

lblInfo = UI.Label("Space")
lblInfo:setColor("green")

UI.Separator()

onKeyPress(function(keys)
  if keys == "Space" then
    say('levitate "up')
    say('levitate "down')
  end
end)

UI.Separator()

hotkey("F12", function()
  SelectWindow.select("normal")
  return true
end)
