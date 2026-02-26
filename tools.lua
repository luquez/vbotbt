setDefaultTab("Tools")

lblInfo= UI.Label("Tools")
lblInfo:setColor("red")

macro(500, "Anti Follow", function()
  if g_game.isAttacking() then
    g_game.setChaseMode(0)
  end
end)


--lblInfo= UI.Label("______________")
--lblInfo:setColor("green")


lblInfo= UI.Label("AUTO FOLLOW")
lblInfo:setColor("green")


followName = "autofollow"
if not storage[followName] then storage[followName] = { player = 'name'} end
local toFollowPos = {}

followTE = UI.TextEdit(storage[followName].player or "name", function(widget, newText)
    storage[followName].player = newText
end)

local followMacro = macro(20, "Follow", function()
    local target = getCreatureByName(storage[followName].player)
    if target then
        local tpos = target:getPosition()
        toFollowPos[tpos.z] = tpos
    end
    if player:isWalking() then
        return
    end
    local p = toFollowPos[posz()]
    if not p then
        return
    end
    if autoWalk(p, 20, { ignoreNonPathable = true, precision = 1 }) then
        delay(100)
    end
end)

UI.Separator()

onPlayerPositionChange(function(newPos, oldPos)
  if (g_game.isFollowing()) then
    tfollow = g_game.getFollowingCreature()

    if tfollow then
      if tfollow:getName() ~= storage[followName].player then
        followTE:setText(tfollow:getName())
        storage[followName].player = tfollow:getName()
      end
    end
  end
end)

onCreaturePositionChange(function(creature, newPos, oldPos)
    if creature:getName() == storage[followName].player and newPos then
        toFollowPos[newPos.z] = newPos
    end
end)

staminaOn = macro(1000, "Auto Stamina", function()
    local Stamina = player:getStamina()
    local item = 31105 -- mudar ID da stamina
    if (Stamina < 2399) then
        use(item)
    end
end)


Exp15 = macro(10000, "Exp Scroll 15%", function()
    local item = 6119 -- COLOCA AQUI O ID DO ITEM
    use(item)
end)

Exp40 = macro(10000, "Exp Scroll 40%", function()
    local item = 11510 -- COLOCA AQUI O ID DO ITEM
    use(item)
end)

EliteScroll = macro(10000, "Scroll de Elite", function()
    local item = 32624 -- COLOCA AQUI O ID DO ITEM
    use(item)
end)


MineScroll = macro(10000, "Scroll Mine", function()
    local item = 32622 -- COLOCA AQUI O ID DO ITEM
    use(item)
end)

FishingScroll = macro(10000, "Scroll Fishing", function()
    local item = 32625 -- COLOCA AQUI O ID DO ITEM
    use(item)
end)

