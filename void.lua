setDefaultTab("Void2")

lblInfo= UI.Label("Void")
lblInfo:setColor("red")

UI.Separator()

-- classe_void.lua
local version = "1.0"
print("[Luquebot] Classe: Void carregada v" .. version)

-- Combo Void Sequence
macro(200, "Combo Void", function()
  if g_game.isAttacking() then
    say("Void Rupture")
    say("Black Hole")
    say("Void Intruder")
    say("Abyssal Tear")
  end
end)

UI.Separator()

-- Buff 1: Void
macro(7000, "Voidwalking", function()
  if not isInPz() then
    say("Voidwalk") -- magia do buff
  end
end)  -- 🔹 fecha macro Buff Void

UI.Separator()

-- Buff 1: Void
macro(8000, "Buff Void", function()
  if not isInPz() then
    say("Void Steroids") -- magia do buff
  end
end)  -- 🔹 fecha macro Buff Void

UI.Separator()

local spell = "Nether Gaze"

macro(1000, "Void - Spell Farm", function()
    local target = g_game.getAttackingCreature()
    if not target then
        say(spell)
    end
end)

UI.Separator()

macro(1000, "Auto Summon", function()
  if isInPz() then return end

  local summonName = "Voidling"
  local maxSummons = 3
  local summonCount = 0

  for _, spec in ipairs(getSpectators()) do
    if not spec:isPlayer() and spec:getName() == summonName then
      summonCount = summonCount + 1
    end
  end

  if summonCount < maxSummons then
    say("Summon " .. summonName)
  end
end)


UI.Separator()

lblInfo = UI.Label("")
lblInfo = UI.Label("Heal")
lblInfo:setColor("blue")

UI.Separator()

local healingSpell = 'Magic Restoration'
local manaPercent = 97
macro(200, "Magic Restoration",  function()
  if (manapercent() <= manaPercent) then
    say(healingSpell) 
  end
end)

UI.Separator()

lblInfo = UI.Label("")
lblInfo = UI.Label("Potion")
lblInfo:setColor("blue")
addSeparator()
addSeparator()
Panels.ManaItem()
UI.Separator()

local potLow = 23373       -- ultimate mana
local potMid = 24937      -- dracula

macro(200, "Dual POT", function()
  local mana = manapercent()
  if mana <= 70 then
    usewith(potLow, player)
  elseif mana <= 95 then
    usewith(potMid, player)
  end
end)

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
