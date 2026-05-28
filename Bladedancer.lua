setDefaultTab("Dancer")

lblInfo= UI.Label("War - Fael Noob")
lblInfo:setColor("red")

UI.Separator()

-- classe_warrior.lua
local version = "1.0"
print("[Luquebot] Classe: War carregada v" .. version)

-- Combo War Sequence
macro(200, "Combo BladeDancer", function()
  if g_game.isAttacking() then
  say("Blazing Axe")      -- Level 2500
  say("Spectral Throw")   -- Level 1600
  say("Twin Ricochet")    -- Level 800
  say("Hundred Blades")   -- Level 300
  say("Leap Slam")        -- Level 180
  say("Cyclone")          -- Level 120
  say("Groundshaker")     -- Level 65
  say("Fast Sweep")       -- Level 25
  say("Whirlwind Throw")  -- Level 8
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

-- Buff 1: War
macro(16000, "Buff War", function()
  if not isInPz() then
    say("Defender Spirit") -- magia do buff
  end
end)  -- 🔹 

UI.Separator()

UI.Separator()

-- Buff 2: War
macro(1000, "Exeta", function()
  if not isInPz() then
    say("Challenge") -- magia do buff
  end
end)  -- 🔹 

UI.Separator()

lblInfo = UI.Label("")
lblInfo = UI.Label("Heal")
lblInfo:setColor("blue")

UI.Separator()


local healingSpell = "Intense Wound Cleansing"
local healthPercent = 100
macro(200, "Intense Wound Cleansing", function()
  if isInPz() then return end   
  if hppercent() <= healthPercent then
    say(healingSpell)
  end
end)

UI.Separator()


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
