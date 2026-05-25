setDefaultTab("LK")

lblInfo= UI.Label("Lich King")
lblInfo:setColor("red")

UI.Separator()

-- classe_warrior.lua
local version = "1.0"
print("[Luquebot] Classe: DK carregada v" .. version)

-- Combo DK Sequence

macro(200, "Combo Custom", function()
  if g_game.isAttacking() then
    say("Reaping Spiral")    -- Level 1600
    say("Spiral Grasp")      -- Level 800
    say("Bone Shield")       -- Level 300
    say("Death Blade")       -- Level 120
    say("Thorned Shadows")   -- Level 65
    say("Cursed Flames")     -- Level 25
  end
end)

UI.Separator()

-- Buff 1: War
macro(16000, "Buff DK", function()
  if not isInPz() then
    say("Overflow") -- magia do buff
  end
end)  -- 🔹 

UI.Separator()

lblInfo = UI.Label("")
lblInfo = UI.Label("Potion")
lblInfo:setColor("blue")
addSeparator()
Panels.HealthItem()
UI.Separator()

local potId = 7643  -- ID da potion
local interval = 500  -- 0.5s

lblInfo:setColor("green")
addSeparator()
Panels.Health()
addSeparator()

lblInfo:setColor("green")
addSeparator()
Panels.Health()
addSeparator()

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


-- upda / down
onKeyPress(function(keys)
  if keys == "Space" then
    say('levitate "up') 
    say('levitate "down') 
  end
end)
UI.Sepa
