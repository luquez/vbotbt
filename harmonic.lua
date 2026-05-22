setDefaultTab("Harmonic")

lblInfo= UI.Label("Harmonic")
lblInfo:setColor("red")

UI.Separator()

-- classe_void.lua
local version = "1.0"
print("[Luquebot] Classe: Harmonic carregada v" .. version)

UI.Separator()

macro(200, "Combo - Harmonic", function()
  if g_game.isAttacking() then
  say("Accelerando")       -- Level 1600
  say("Resonance")         -- Level 800
  say("Divine Ballad")     -- Level 300
  say("Crescendo")         -- Level 120
  say("Magic String")      -- Level 65
  say("Reverberate")       -- Level 25
  say("Music Strike")      -- Level 8

  end
end)

UI.Separator()

-- Buff 1: Void
--macro(7000, "Voidwalking", function()
--  if not isInPz() then
--    say("Voidwalk") -- magia do buff
--  end
--end)  -- 🔹 fecha macro Buff Void

UI.Separator()

-- Buff 1: Void
macro(8000, "Buff Bardo", function()
  if not isInPz() then
    say("Echo Song") -- magia do buff
  end
end)  -- 🔹 fecha macro Buff Void

UI.Separator()

local spell = "Mana Waste"
local manaMin = 20       -- mínimo de mana% para castar
local interval = 3000    -- 3 segundos

macro(interval, "Mana Training", function()
--    if isInPz() then return end           -- bloqueia dentro de PZ
    if manapercent() < manaMin then return end
    say(spell)
end)

UI.Separator()

lblInfo = UI.Label("")
lblInfo = UI.Label("Heal")
lblInfo:setColor("blue")

UI.Separator()


local healingSpell = "Intense Wound Cleansing"
local healthPercent = 97
macro(200, "Intense Wound Cleansing", function()
  if isInPz() then return end   
  if hppercent() <= healthPercent then
    say(healingSpell)
  end
end)

UI.Separator()


local healingSpell = "Limb Restoration"
local healthPercent = 97
macro(200, "Limb Restoration", function()
  if isInPz() then return end   
  if hppercent() <= healthPercent then
    say(healingSpell)
  end
end)

UI.Separator()


lblInfo = UI.Label("")
lblInfo = UI.Label("Potion")
lblInfo:setColor("blue")
addSeparator()
Panels.HealthItem()
UI.Separator()

local potId = 7643  -- ID da potion
local interval = 500  -- 0.5s

macro(interval, "Pot Craft SPAM", function()
    usewith(potId, player)
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

macro(200, "Auto Haste", function()
  if isInPz() then return end          -- não usa em PZ
  if hasHaste() then return end        -- já tem haste ativo
  if getSpellCoolDown("utani hur") then return end  -- ainda em cooldown
  if mana() < 40 then return end       -- sem mana suficiente

  say("Haste")                     -- lança a spell
end)

UI.Separator()
-- upda / down
lblInfo= UI.Label("Para up / Down")
lblInfo= UI.Label("Space")
lblInfo:setColor("green")
UI.Separator()
onKeyPress(function(keys)
  if keys == "Space" then
    say('levitate "up') 
    say('levitate "down') 
  end
end)
UI.Separator()
