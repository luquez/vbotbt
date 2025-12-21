-- =============================================
-- 🔔 Alarms.lua (NO UI / SIMPLE VERSION)
-- =============================================

local panelName = "alarms"

-- =============================================
-- 🔧 CONFIGURAÇÃO (EDITA AQUI)
-- =============================================

local ENABLE_RARE        = true
local ENABLE_EPIC        = true
local ENABLE_LEGENDARY   = true
local ENABLE_CONTINENTAL = true
local ENABLE_RAID        = true

-- Sons (usa apenas sons que você SABE que existem)
local SOUND_RARE        = "/sounds/rare_spawned1.ogg"
local SOUND_EPIC        = "/sounds/epic_spawned1.ogg"
local SOUND_LEGENDARY   = "/sounds/legendary_spawned1.ogg"
local SOUND_CONTINENTAL = "/sounds/contiboss1.ogg"
local SOUND_RAID        = "/sounds/raid1.ogg"

-- Cooldown entre alarmes (ms)
local ALARM_COOLDOWN = 3000

-- =============================================
-- 🌍 CONTINENTAL BOSSES (CHAT)
-- =============================================

local CONTINENTAL_TRIGGERS = {
  "the sandking will",
  "gaz'haragoth will",
  "the brainstealer will",
  "turtleneck will",
  "akamaru will",
  "merlion will"
}

-- =============================================
-- ⏱️ CONTROLE DE COOLDOWN
-- =============================================

local lastAlarmTime = 0

-- =============================================
-- 🔊 FUNÇÃO ALARM (OBRIGATÓRIA)
-- =============================================

function alarm(sound, text)
  if now - lastAlarmTime < ALARM_COOLDOWN then return end
  lastAlarmTime = now

  -- fallback se som não existir
  if not g_resources.fileExists(sound) then
    sound = "/sounds/alarm.ogg"
  end

  -- altera título da janela
  g_window.setTitle(player:getName() .. " - " .. text)

  -- toca o som (API que funciona no teu fork)
  playSound(sound)
end

-- =============================================
-- 💬 LEITURA DO CHAT (CORE)
-- =============================================

onTextMessage(function(_, text)
  if not text then return end

  local msg = text:lower()

  -- RARE
  if ENABLE_RARE and msg:find("a rare") then
    return alarm(SOUND_RARE, "Rare Spawn!")
  end

  -- EPIC
  if ENABLE_EPIC and msg:find("an epic") then
    return alarm(SOUND_EPIC, "Epic Spawn!")
  end

  -- LEGENDARY
  if ENABLE_LEGENDARY and msg:find("legendary") then
    return alarm(SOUND_LEGENDARY, "Legendary Spawn!")
  end

  -- RAID
  if ENABLE_RAID and msg:find("%[raid%]") then
    return alarm(SOUND_RAID, "Raid Started!")
  end

  -- CONTINENTAL BOSSES
  if ENABLE_CONTINENTAL then
    for _, trigger in ipairs(CONTINENTAL_TRIGGERS) do
      if msg:find(trigger) then
        return alarm(SOUND_CONTINENTAL, "Continental Boss!") 
      end
    end
  end
end)

-- =============================================
-- 🔘 BOTÃO SIMPLES ON / OFF
-- =============================================

local ui = setupUI([[
Panel
  height: 19

  BotSwitch
    id: toggle
    width: 200
    text-align: center
    !text: tr('Alarms')
]])

ui:setId(panelName)

storage[panelName] = storage[panelName] or { enabled = true }

ui.toggle:setOn(storage[panelName].enabled)

ui.toggle.onClick = function(widget)
  storage[panelName].enabled = not storage[panelName].enabled
  widget:setOn(storage[panelName].enabled)

  -- hard disable geral
  ENABLE_RARE        = storage[panelName].enabled
  ENABLE_EPIC        = storage[panelName].enabled
  ENABLE_LEGENDARY   = storage[panelName].enabled
  ENABLE_CONTINENTAL = storage[panelName].enabled
  ENABLE_RAID        = storage[panelName].enabled
end

print("[Alarms] Loaded (NO UI, stable version)")
