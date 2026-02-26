setDefaultTab("DK")

lblInfo= UI.Label("Lich King")
lblInfo:setColor("red")

UI.Separator()

-- classe_warrior.lua
local version = "1.0"
print("[Luquebot] Classe: DK carregada v" .. version)

-- Combo DK Sequence

macro(200, "Combo Custom", function()
  if g_game.isAttacking() then
    say("Cursed Flames")
    say("Thorned Shadows")
    say("Death Blade")
    say("Bone Shield")
    say("Evil Spirits")
    say("Hands from the Abyss")
    say("Bloody Night")
  end
end)

UI.Separator()

UI.Separator()

comboss = macro(200, "LELEU", function()
  if g_game.isAttacking() then
    say(storage.ComboText)
    say(storage.Combo1Text)
    say(storage.Combo2Text)
    say(storage.Combo3Text)
    say(storage.Combo4Text)
    say(storage.Combo5Text)
    say(storage.Combo6Text)
  end
end)

addTextEdit("ComboText", storage.ComboText or "magia 1", function(widget, text) 
  storage.ComboText = text
end)

addTextEdit("Combo1Text", storage.Combo1Text or "magia 2", function(widget, text)
  storage.Combo1Text = text
end)

addTextEdit("Combo2Text", storage.Combo2Text or "magia 3", function(widget, text)
  storage.Combo2Text = text
end)

addTextEdit("Combo3Text", storage.Combo3Text or "magia 4", function(widget, text)
  storage.Combo3Text = text
end)

addTextEdit("Combo4Text", storage.Combo4Text or "magia 5", function(widget, text)
  storage.Combo4Text = text
end)

addTextEdit("Combo5Text", storage.Combo5Text or "magia 6", function(widget, text)
  storage.Combo5Text = text
end)

addTextEdit("Combo6Text", storage.Combo6Text or "magia 7", function(widget, text)
  storage.Combo6Text = text
end)

addIcon("Combo", {item=2660, text="Combo"}, comboss)

-- Macro separada para Sharpshooter a cada 22 segundos

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
