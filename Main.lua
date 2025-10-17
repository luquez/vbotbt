-- =============================================
-- 🌐 LuqueBot Main - Modular + Version Check (Safe)
-- =============================================

-- Proteção contra loops / múltiplas execuções
if _G.__LUQUE_MAIN_LOADED then
    print("[LuqueBot] ⚙️ Main.lua já carregado, ignorando nova execução.")
    return
end
_G.__LUQUE_MAIN_LOADED = true

-- Versão local (deve sempre bater com o version.txt no GitHub)
local localVersion = "2.13"
local remoteVersion

print("[LuqueBot] 🔍 Verificando versão... (local " .. localVersion .. ")")

-- URLs base
local BASE_URL = "https://raw.githubusercontent.com/luquez/vbotbt/refs/heads/main/"
local VERSION_URL = BASE_URL .. "version.txt"
local MAIN_URL = BASE_URL .. "main.lua"

-- =============================================
-- 🧩 Função para executar módulos remotos
-- =============================================

local function executeRemote(name, url)
    print("[LuqueBot] 🔁 Carregando " .. name .. "...")
    HTTP.get(url .. "?nocache=" .. os.time(), function(code, err)
        if err then
            print("[LuqueBot] ❌ Erro ao baixar " .. name .. ": " .. err)
            return
        end
        if not code or code == "" then
            print("[LuqueBot] ⚠️ " .. name .. " vazio ou inválido.")
            return
        end

        local success, result = pcall(loadstring(code))
        if success then
            print("[LuqueBot] 🚀 " .. name .. " executado com sucesso!")
        else
            print("[LuqueBot] ❌ Erro ao executar " .. name .. ": " .. tostring(result))
        end
    end)
end

-- =============================================
-- 🔎 Checagem de versão remota
-- =============================================

HTTP.get(VERSION_URL .. "?nocache=" .. os.time(), function(data, err)
    if err then
        print("[LuqueBot] ⚠️ Erro ao verificar versão: " .. err)
        return
    end

    remoteVersion = data:match("%S+")
    if not remoteVersion then
        print("[LuqueBot] ⚠️ Não foi possível ler a versão remota.")
        return
    end

    if remoteVersion ~= localVersion then
        print("[LuqueBot] 🔄 Nova versão detectada! (remota " .. remoteVersion .. ")")

        HTTP.get(MAIN_URL .. "?nocache=" .. os.time(), function(code, err2)
            if not err2 and code and code ~= "" then
                print("[LuqueBot] 🚀 Atualizando Main.lua remoto...")
                local ok, res = pcall(loadstring(code))
                if ok then
                    print("[LuqueBot] ✅ Main.lua atualizado e executado!")
                    return -- 🔴 evita loop infinito
                else
                    print("[LuqueBot] ❌ Erro ao executar Main.lua atualizado: " .. tostring(res))
                end
            else
                print("[LuqueBot] ⚠️ Falha ao baixar Main.lua atualizado: " .. tostring(err2))
            end
        end)

        return -- 🔴 garante que o código abaixo não execute até o update terminar
    end

    print("[LuqueBot] ✅ Main.lua já está atualizado (v" .. localVersion .. ")")

    -- =============================================
    -- 🧠 Interface e Botões
    -- =============================================

    setDefaultTab("Main")

    UI.Label("LuqueBot v" .. localVersion):setColor("aqua")

    local modules = {
        { name = "Core", url = BASE_URL .. "Luquebot.lua", color = "green" },
        { name = "Void", url = BASE_URL .. "void.lua", color = "purple" },
    }

    for _, mod in ipairs(modules) do
        local button = UI.Button("⚙️ " .. mod.name, function()
            executeRemote(mod.name .. ".lua", mod.url)
        end)
        button:setColor(mod.color)
    end

    UI.Label("Bot by Luque – Autoupdate"):setColor("white")
end)

-- =============================================


-- =============================================
-- UI Label: LuqueBot + Versão
-- =============================================

setDefaultTab("Main")

local label = UI.Label("LuqueBot v" .. (remoteVersion or localVersion))
label:setColor("orange")

macro(1000, function()
    if remoteVersion and remoteVersion ~= localVersion then
        label:setText("LuqueBot v" .. remoteVersion)
        label:setColor("green")
    end
end)

-- =============================================
