setDefaultTab("Archer")

lblInfo= UI.Label("Archer")
lblInfo:setColor("red")

UI.Separator()

-- classe_archer.lua
local version = "1.0"
print("[Luquebot] Classe: archer carregada v" .. version)

-- Combo Archer Sequence
macro(200, "Archer Combo", function()
  if not g_game.isAttacking() then return end

  -- Skills do maior level para o menor
  say("Arrow Rain")
  say("Brute Bane Arrow")
  say("Arrow Fury")
  say("Arrow Volley")
  say("Magic Arrows")
  say("Explosive Arrow")
  say("Triple Arrow")
--  say("Arrow")
end)




UI.Separator()

-- Buff 1: Guns
--macro(7000, "Voidwalking", function()
--  if not isInPz() then
--    say("Voidwalk") -- magia do buff
--  end
-- end)  -- 🔹 fecha macro Buff Void

UI.Separator()

-- Buff 1: War
macro(16000, "Buff Archer", function()
  if not isInPz() then
    say("Sharpshooter") -- magia do buff
  end
end)  -- 🔹 

UI.Separator()

lblInfo = UI.Label("")
lblInfo = UI.Label("Heal")
lblInfo:setColor("blue")

UI.Separator()


local healingSpell = "Rangers Blessing"
local healthPercent = 97
macro(200, "Ranger Blessing", function()
  if isInPz() then return end   
  if hppercent() <= healthPercent then
    say(healingSpell)
  end
end)

UI.Separator()


UI.Separator()


local healingSpell = "Ranger Restoration"
local healthPercent = 97
macro(200, "Ranger Restoration", function()
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

local potLow = 7643       -- ultimate mana
local potMid = 24937      -- dracula

macro(200, "Dual POT", function()
  if isInPz() then return end            -- evita uso em PZ

  local hp = hppercent()
  local me = g_game.getLocalPlayer()

  if hp <= 70 then
    usewith(potLow, me)                 -- usa potion de emergência
  elseif hp <= 95 then
    usewith(potMid, me)                 -- usa potion comum
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
