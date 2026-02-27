setDefaultTab("Druid")

lblInfo= UI.Label("Druid")
lblInfo:setColor("red")

UI.Separator()

-- classe_void.lua
local version = "1.0"
print("[Luquebot] Classe: Druid carregada v" .. version)

UI.Separator()

macro(200, "Combo - Druid", function()
  if g_game.isAttacking() then
    say("Shattering Ice")
    say("Ice Storm")
    say("Eternal Winter")
    say("Carniphila Attack")
    say("Strong Terra Strike")
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
macro(8000, "Buff Druid", function()
  if not isInPz() then
    say("Nature Regen") -- magia do buff
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

-- MAGIC RESTORATION (1200)
macro(1000, "Magic Restoration", function()
  if isInPz() then return end
  if manapercent() <= 97 then
    say("Magic Restoration")
  end
end)

UI.Separator()

-- MANA HEAL (150)

macro(1000, "Magic Infusion", function()
  if isInPz() then return end
  if manapercent() <= 97 then
    say("Magic Infusion")
  end
end)

UI.Separator()


UI.Separator()

lblInfo = UI.Label("")
lblInfo = UI.Label("Potiiion")
lblInfo:setColor("blue")
addSeparator()
addSeparator()
Panels.ManaItem()
UI.Separator()

local potId = 23373  -- ID da potion
local interval = 500  -- 0.5s

macro(interval, "Pot Craft SPAM", function()
    usewith(potId, player)
end)

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




UI.Separator()
