-- =============================================
-- 🌐 LuqueBot Main - Modular + Version Check (Safe / URLs explícitas)
-- =============================================

if _G.__LUQUE_MAIN_LOADED then
    print("[LuqueBot] ⚙️ Main.lua já carregado, ignorando nova execução.")
    return
end
_G.__LUQUE_MAIN_LOADED = true

local localVersion = "2.14"
local remoteVersion

print("[LuqueBot] 🔍 Verificando versão... (local " .. localVersion .. ")")

-- =============================================
-- 🔎 URLs fixas (web-based)
-- =============================================
local URL_VERSION = "https://raw.githubusercontent.com/luquez/vbotbt/refs/heads/main/version.txt"
local URL_MAIN = "https://raw.githubusercontent.com/luquez/vbotbt/refs/heads/main/Main.lua"

local URL_CORE = "https://raw.githubusercontent.com/luquez/vbotbt/refs/heads/main/Luquebot.lua"
local URL_VOID = "https://raw.githubusercontent.com/luquez/vbotbt/refs/heads/main/void.lua"

-- =============================================
-- Função para baixar e executar scripts remotos
-- =============================================
local function executeRemote(name, url, label)
    print("[LuqueBot] 🔁 Baixando " .. name .. "...")
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
            if label then
                label:setText("✅ " .. name .. " carregado!")
                label:setColor("green")
            end
        else
            print("[LuqueBot] ❌ Erro ao executar " .. name .. ": " .. tostring(result))
        end
    end)
end

-- =============================================
-- Checagem de versão
-- =============================================
HTTP.get(URL_VERSION .. "?nocache=" .. os.time(), function(data, err)
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
        HTTP.get(URL_MAIN .. "?nocache=" .. os.time(), function(code, err2)
            if not err2 and code and code ~= "" then
                print("[LuqueBot] 🚀 Atualizando Main.lua remoto...")
                local ok, res = pcall(loadstring(code))
                if ok then
                    print("[LuqueBot] ✅ Main.lua atualizado e executado!")
                    return
                else
                    print("[LuqueBot] ❌ Erro ao executar Main.lua atualizado: " .. tostring(res))
                end
            else
                print("[LuqueBot] ⚠️ Falha ao baixar Main.lua atualizado: " .. tostring(err2))
            end
        end)
        return
    end

    print("[LuqueBot] ✅ Main.lua atualizado (v" .. localVersion .. ")")

    -- =============================================
    -- Interface e botões dos módulos
    -- =============================================
schedule(1000, function()
    setDefaultTab("Main")

    local label = UI.Label("LuqueBot v" .. (remoteVersion or localVersion))
    label:setColor("orange")

    macro(1000, function()
        if remoteVersion and remoteVersion ~= localVersion then
            label:setText("LuqueBot v" .. remoteVersion)
            label:setColor("green")
        end
    end)
end)


    local modules = {
        { name = "Core", url = URL_CORE, color = "green" },
        { name = "Void", url = URL_VOID, color = "purple" },

    }

    for _, mod in ipairs(modules) do
        local label = UI.Label("") -- espaço para status
        local button = UI.Button("" .. mod.name, function()
            label:setText("Carregando " .. mod.name .. "...")
            label:setColor("yellow")
            executeRemote(mod.name .. ".lua", mod.url, label)
        end)
        button:setColor(mod.color)
    end

    UI.Label("Bot by Luque – Autoupdate"):setColor("white")
end)
-- =============================================
