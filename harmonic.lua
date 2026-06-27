setDefaultTab("Harmonic")

lblInfo = UI.Label("Harmonic")
lblInfo:setColor("red")

UI.Separator()

local version = "1.0"
print("[Luquebot] Classe: Harmonic carregada v" .. version)


UI.Separator()

HarmonicBardCooldownEnds = HarmonicBardCooldownEnds or {}
HarmonicBardLastCast = HarmonicBardLastCast or 0
HarmonicBardStackState = HarmonicBardStackState or {
  ["Divine Ballad"] = {stacks = 0, last = 0},
  ["Crescendo"] = {stacks = 0, last = 0}
}
HarmonicBardStackOrder = {"Divine Ballad", "Crescendo"}

function HarmonicBardSpellData(spell)
  if not modules.gamelib or not modules.gamelib.SpellInfo then return nil end

  local spells = modules.gamelib.SpellInfo["Default"]
  if not spells then return nil end

  local wanted = spell:lower()
  for name, data in pairs(spells) do
    local words = data.words and tostring(data.words):lower() or ""
    if name:lower() == wanted or words == wanted then
      return data
    end
  end

  return nil
end

function HarmonicBardCooldownLeft(spell)
  local data = HarmonicBardSpellData(spell)
  if not data or not data.id then return 0 end

  if not modules.game_cooldown.isCooldownIconActive(data.id) then
    return 0
  end

  return math.max(0, (HarmonicBardCooldownEnds[data.id] or 0) - now)
end

function HarmonicBardCanCast(spell)
  local data = HarmonicBardSpellData(spell)

  if data then
    if level() < data.level or mana() < data.mana then return false end
    if modules.game_cooldown.isCooldownIconActive(data.id) then return false end

    for groupId, _ in pairs(data.group or {}) do
      if modules.game_cooldown.isGroupCooldownIconActive(groupId) then
        return false
      end
    end

    return true
  end

  if getSpellCoolDown and getSpellCoolDown(spell) then return false end
  return true
end

function HarmonicBardCast(spell)
  say(spell)
  HarmonicBardLastCast = now

  local stack = HarmonicBardStackState[spell]
  if stack then
    stack.last = now
    if stack.stacks < 5 then
      stack.stacks = stack.stacks + 1
    end
  end

  return true
end

function HarmonicBardTryCast(spell)
  if HarmonicBardCanCast(spell) then
    return HarmonicBardCast(spell)
  end

  return false
end

function HarmonicBardTryCastList(spells)
  for _, spell in ipairs(spells) do
    if HarmonicBardTryCast(spell) then return true end
  end

  return false
end

if onSpellCooldown then
  onSpellCooldown(function(iconId, duration)
    HarmonicBardCooldownEnds[iconId] = now + duration
  end)
end

macro(50, "Bardo Buffs", function()
  if isInPz() then return end
  if now - HarmonicBardLastCast < 100 then return end

  if HarmonicBardTryCast("Accelerando") then return end

  local accelerandoLeft = HarmonicBardCooldownLeft("Accelerando")
  if accelerandoLeft > 0 and accelerandoLeft <= 2300 then return end

  if HarmonicBardTryCast("Triad") then return end
  if HarmonicBardTryCast("Double Chord") then return end
  if HarmonicBardTryCast("Resonance") then return end

  for _, spell in ipairs(HarmonicBardStackOrder) do
    local state = HarmonicBardStackState[spell]
    if state.stacks < 5 or now - state.last >= 30000 then
      if HarmonicBardTryCast(spell) then return end
    end
  end
end)

UI.Separator()

macro(200, "Combo - Harmonic", function()
  if g_game.isAttacking() then
    HarmonicBardTryCastList({
      "Accelerando",
      "Triad",
      "Double Chord",
      "Resonance",
      "Divine Ballad",
      "Crescendo",
      "Magic String",
      "Reverberate",
      "Music Strike"
    })
  end
end)

UI.Separator()

macro(200, "Combo - ++", function()
  if g_game.isAttacking() then
    HarmonicBardTryCastList({
      "Accelerando",
      "Triad",
      "Double Chord",
      "Resonance",
      "Divine Ballad",
      "Crescendo",
      "Magic String"
    })
  end
end)

UI.Separator()

macro(8000, "Buff Bardo", function()
  if not isInPz() then
    say("Echo Song")
  end
end)

UI.Separator()


macro(8000, "Buff Bardo - CDR", function()
  if not isInPz() then
    say("Echo Song")
  end
end)

UI.Separator()
macro(3000, "Sleep", function()
  if not isInPz() then
    say("Lullaby")
  end
end)

UI.Separator()

local spell = "Mana Waste"
local manaMin = 20
local interval = 3000

macro(interval, "Mana Training", function()
  if manapercent() < manaMin then return end
  say(spell)
end)

UI.Separator()

lblInfo = UI.Label("Heal")
lblInfo:setColor("blue")

UI.Separator()

local healingSpell1 = "Intense Wound Cleansing"
local healthPercent1 = 97

macro(200, "Intense Wound Cleansing", function()
  if isInPz() then return end
  if hppercent() <= healthPercent1 then
    say(healingSpell1)
  end
end)

UI.Separator()

local healingSpell2 = "Limb Restoration"
local healthPercent2 = 97

macro(200, "Limb Restoration", function()
  if isInPz() then return end
  if hppercent() <= healthPercent2 then
    say(healingSpell2)
  end
end)

UI.Separator()

lblInfo = UI.Label("Potion HP")
lblInfo:setColor("blue")
addSeparator()
Panels.HealthItem()

UI.Separator()

lblInfo = UI.Label("MANA para noobs")
lblInfo:setColor("blue")
addSeparator()
addSeparator()
Panels.ManaItem()

UI.Separator()

local potId = 7643
local potInterval = 500

macro(potInterval, "Pot Craft SPAM", function()
  usewith(potId, player)
end)

UI.Separator()

local spell = "Crescendo"

macro(5000, "Crescendo - Buff", function()
    local target = g_game.getAttackingCreature()
    if not target then
        say(spell)
    end
end)

UI.Separator()

local spell = "Divine Ballad"

macro(5000, "Def - Buff", function()
    local target = g_game.getAttackingCreature()
    if not target then
        say(spell)
    end
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

UI.Separator()

macro(10000, "FOOD - Passe", function()
  if player:getRegenerationTime() > 400 then return end

  for _, container in pairs(g_game.getContainers()) do
    for _, item in ipairs(container:getItems()) do
      if item:getId() == 30607 then
        return modules._G.g_blacktalon.use(item)
      end
    end
  end
end)

UI.Separator()

macro(200, "Auto Haste", function()
  if isInPz() then return end
  if hasHaste() then return end
  if getSpellCoolDown("utani hur") then return end
  if mana() < 40 then return end

  say("Haste")
end)

UI.Separator()

lblInfo = UI.Label("Para up / Down")
lblInfo:setColor("green")

lblInfo = UI.Label("Space")
lblInfo:setColor("green")

UI.Separator()

onKeyPress(function(keys)
  if keys == "Space" then
    say('levitate "up')
    say('levitate "down')
  end
end)

UI.Separator()

hotkey("F12", function()
  SelectWindow.select("normal")
  return true
end)
