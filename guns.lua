setDefaultTab("Guns")

lblInfo= UI.Label("Guns")
lblInfo:setColor("red")

UI.Separator()

-- classe_guns.lua
local version = "1.0"
print("[Luquebot] Classe: Guns carregada v" .. version)

-- Combo Void Sequence
macro(200, "Combo Guns", function()
  if g_game.isAttacking() then
    say("Gun Kata")
    say("Bullseye")
    say("Heavy Artillery")
    say("Explosive Rounds")
    say("fragmented bullets")
  end
end)



UI.Separator()

-- Buff 1: Guns
--macro(7000, "Voidwalking", function()
--  if not isInPz() then
--    say("Voidwalk") -- magia do buff
--  end
-- end)  -- 🔹 fecha macro Buff Void

UI.Separator()

-- Buff 1: Guns
macro(8000, "Buff Guns", function()
  if not isInPz() then
    say("Bouncing Bullets") -- magia do buff
  end
end)  -- 🔹 

UI.Separator()

lblInfo = UI.Label("")
lblInfo = UI.Label("Heal")
lblInfo:setColor("blue")

UI.Separator()


local healingSpell = "Rangers Restoration"
local healthPercent = 97
macro(200, "Rangers Restoration", function()
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
addSeparator()
Panels.HealthItem()
UI.Separator()

local potLow = 7643       -- ultimate mana
local potMid = 24937      -- dracula

macro(200, "Dual POT", function()
  local health = healthpercent()
  if health <= 70 then
    usewith(potLow, player)
  elseif health <= 95 then
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
