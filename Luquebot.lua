-- misc.luaprofessions
-- Dois Node Collectors separados por categoria

setDefaultTab("Luque")

lblInfo= UI.Label("gathering")
lblInfo:setColor("red")

UI.Separator()
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

local itemIds1 = {3889,3894,3913,3754,3641,12419,36230,36230,43519,37975,41144} -- lista de IDs aceitos
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

local itemIds1 = {37945,32144,37947,37985,37948,37946,37978,41143} -- lista de IDs aceitos
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

--- Utilidades

lblInfo= UI.Label("Utilidades")
lblInfo:setColor("red")

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

-- Tower

lblInfo= UI.Label("Tower")
lblInfo:setColor("green")

onKeyPress(function(keys)
  if keys == "3" then
    say('!nextwave') 
    say('!nextfloor') 
  end
end)
UI.Separator()
macro(500, "Auto Tower", function()
    say("!nextwave")
    say("!nextfloor")
end)
UI.Separator()

local itemId = 41656
local radius = 7 -- distância do personagem (1 sqm em volta)

macro(500, "Auto Chest - Rift", function()
  for x = -radius, radius do
    for y = -radius, radius do
      local tile = g_map.getTile({x = posx() + x, y = posy() + y, z = posz()})
      if tile then
        for _, thing in ipairs(tile:getThings()) do
          if thing:getId() == itemId then
            use(thing)
            return
          end
        end
      end
    end
  end
end)

UI.Separator()

---

local effectsIds = {193, 2}
local walkingToEffect = false

local ir = macro(100, "Pegar Orb", function() end)

onAddThing(function(tile, thing)
    if ir.isOff() then return end
    if not thing:isEffect() then return end

    local id = thing:getId()
    if not table.find(effectsIds, id) then return end
    if walkingToEffect then return end

    walkingToEffect = true
    CaveBot.setOn(false)
    delay(100)

    local pos = thing:getPosition()
    autoWalk(pos, { precision = 0 })

    -- Reforça o autoWalk após 600ms se ainda não estiver em cima
    schedule(600, function()
        if posx() ~= pos.x or posy() ~= pos.y or posz() ~= pos.z then
            autoWalk(pos, { precision = 0 })
        end
    end)

    schedule(3000, function()
        CaveBot.setOn(true)
        walkingToEffect = false
    end)
end)

UI.Separator()

