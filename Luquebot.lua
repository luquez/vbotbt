-- misc.luaprofessions
-- Dois Node Collectors separados por categoria

setDefaultTab("Misc")


lblInfo= UI.Label("gathering")
lblInfo:setColor("blue")

-------------------------
-- NODE COLLECTOR 1 (minério)
-------------------------
local itemIds1 = {32100, 32101, 32080, 32102, 32093, 37958, 37962, 37964, 43516} -- lista de IDs aceitos
local radius1 = 6
local itemVisible1 = false
local forceTime1 = 0

local function isTargetId(id, list)
  for _, v in ipairs(list) do
    if v == id then
      return true
    end
  end
  return false
end

macro(500, "Mine", function()
  local foundItem = false

  for x = -radius1, radius1 do
    for y = -radius1, radius1 do
      local tile = g_map.getTile({x = posx() + x, y = posy() + y, z = posz()})
      if tile then
        for _, thing in ipairs(tile:getThings()) do
          if isTargetId(thing:getId(), itemIds1) then
            use(thing)
            foundItem = true
          end
        end
      end
    end
  end

  if foundItem and CaveBot.isOn() then
    CaveBot.setOn(false)
    itemVisible1 = true
    forceTime1 = now + 10000
    print("[Node Collector Multi-ID] Node detectado → CaveBot pausado")
  end

  if not foundItem and itemVisible1 then
    CaveBot.setOn(true)
    itemVisible1 = false
    print("[Node Collector Multi-ID] Node sumiu → CaveBot reativado")
  end

  if forceTime1 > 0 and now >= forceTime1 then
    CaveBot.setOn(true)
    itemVisible1 = false
    forceTime1 = 0
    print("[Node Collector Multi-ID] Timeout → CaveBot ON forçado")
  end
end)

UI.Separator()

-------------------------
-- NODE COLLECTOR 2 (plantas)
-------------------------

local itemIds1 = {3889,3894,3913,3754,3641,12419,36230,36230,43519} -- lista de IDs aceitos
local radius1 = 6
local itemVisible1 = false
local forceTime1 = 0

local function isTargetId(id, list)
  for _, v in ipairs(list) do
    if v == id then
      return true
    end
  end
  return false
end

macro(500, "Plantas", function()
  local foundItem = false

  for x = -radius1, radius1 do
    for y = -radius1, radius1 do
      local tile = g_map.getTile({x = posx() + x, y = posy() + y, z = posz()})
      if tile then
        for _, thing in ipairs(tile:getThings()) do
          if isTargetId(thing:getId(), itemIds1) then
            use(thing)
            foundItem = true
          end
        end
      end
    end
  end

  if foundItem and CaveBot.isOn() then
    CaveBot.setOn(false)
    itemVisible1 = true
    forceTime1 = now + 10000
    print("[Node Collector Multi-ID] Node detectado → CaveBot pausado")
  end

  if not foundItem and itemVisible1 then
    CaveBot.setOn(true)
    itemVisible1 = false
    print("[Node Collector Multi-ID] Node sumiu → CaveBot reativado")
  end

  if forceTime1 > 0 and now >= forceTime1 then
    CaveBot.setOn(true)
    itemVisible1 = false
    forceTime1 = 0
    print("[Node Collector Multi-ID] Timeout → CaveBot ON forçado")
  end
end)

UI.Separator()

-------------------------
-- NODE COLLECTOR 2 (Arvores)
-------------------------

local itemIds1 = {37945,32144,37947,37985,37948,37946} -- lista de IDs aceitos
local radius1 = 6
local itemVisible1 = false
local forceTime1 = 0

local function isTargetId(id, list)
  for _, v in ipairs(list) do
    if v == id then
      return true
    end
  end
  return false
end

macro(500, "Arvores", function()
  local foundItem = false

  for x = -radius1, radius1 do
    for y = -radius1, radius1 do
      local tile = g_map.getTile({x = posx() + x, y = posy() + y, z = posz()})
      if tile then
        for _, thing in ipairs(tile:getThings()) do
          if isTargetId(thing:getId(), itemIds1) then
            use(thing)
            foundItem = true
          end
        end
      end
    end
  end

  if foundItem and CaveBot.isOn() then
    CaveBot.setOn(false)
    itemVisible1 = true
    forceTime1 = now + 10000
    print("[Node Collector Multi-ID] Node detectado → CaveBot pausado")
  end

  if not foundItem and itemVisible1 then
    CaveBot.setOn(true)
    itemVisible1 = false
    print("[Node Collector Multi-ID] Node sumiu → CaveBot reativado")
  end

  if forceTime1 > 0 and now >= forceTime1 then
    CaveBot.setOn(true)
    itemVisible1 = false
    forceTime1 = 0
    print("[Node Collector Multi-ID] Timeout → CaveBot ON forçado")
  end
end)

UI.Separator()



-------------------------
-- NODE COLLECTOR 2 (PESCA)
-------------------------

local itemIds1 = {38106, 41190} -- lista de IDs aceitos
local radius1 = 8
local itemVisible1 = false
local forceTime1 = 0

local function isTargetId(id, list)
  for _, v in ipairs(list) do
    if v == id then
      return true
    end
  end
  return false
end

macro(500, "Pesca", function()
  local foundItem = false

  for x = -radius1, radius1 do
    for y = -radius1, radius1 do
      local tile = g_map.getTile({x = posx() + x, y = posy() + y, z = posz()})
      if tile then
        for _, thing in ipairs(tile:getThings()) do
          if isTargetId(thing:getId(), itemIds1) then
            use(thing)
            foundItem = true
          end
        end
      end
    end
  end

  if foundItem and CaveBot.isOn() then
    CaveBot.setOn(false)
    itemVisible1 = true
    forceTime1 = now + 10000
    print("[Node Collector Multi-ID] Node detectado → CaveBot pausado")
  end

  if not foundItem and itemVisible1 then
    CaveBot.setOn(true)
    itemVisible1 = false
    print("[Node Collector Multi-ID] Node sumiu → CaveBot reativado")
  end

  if forceTime1 > 0 and now >= forceTime1 then
    CaveBot.setOn(true)
    itemVisible1 = false
    forceTime1 = 0
    print("[Node Collector Multi-ID] Timeout → CaveBot ON forçado")
  end
end)

UI.Separator()

-- uti

lblInfo= UI.Label("Misc - Up/Down")
lblInfo:setColor("green")

onKeyPress(function(keys)
  if keys == "Space" then
    say('levitate "up') 
    say('levitate "down') 
  end
end)

UI.Separator()

-- uti

lblInfo= UI.Label("Tower")
lblInfo:setColor("green")

onKeyPress(function(keys)
  if keys == "3" then
    say('!nextwave') 
    say('!nextfloor') 
  end
end)

UI.Separator()


macro(500, "Tower", function()
    say("!nextwave")
    say("!nextfloor")
end)

UI.Separator()


lblInfo= UI.Label("Void")
lblInfo:setColor("red")


-- Buff 1: Void
macro(1000, "Buff Void", function()
  if not isInPz() then
    say("Voidwalk") -- magia do buff
  end
end)  -- 🔹 fecha macro Buff Void

UI.Separator()

local spell = "Rifts of Beyound"

macro(500, "Void - Spell Farm", function()
    local target = g_game.getAttackingCreature()
    if not target then
        say(spell)
    end
end)

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
    say("Nether Gaze")
  end
end)

