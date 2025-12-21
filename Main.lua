-- =============================================
-- 🌐 LuqueBot Main - Modular + Version Check (Stable)
-- =============================================

local localVersion = "1.0"
local remoteVersion

print("[LuqueBot] 🔍 Verificando versão... (local " .. localVersion .. ")")

-- =============================================
-- 🔎 URLs
-- =============================================
local URL_VERSION = "https://raw.githubusercontent.com/luquez/vbotbt/refs/heads/main/version.txt"
local URL_MAIN    = "https://raw.githubusercontent.com/luquez/vbotbt/refs/heads/main/Main.lua"

local URL_CORE = "https://raw.githubusercontent.com/luquez/vbotbt/refs/heads/main/Luquebot.lua"
local URL_VOID = "https://raw.githubusercontent.com/luquez/vbotbt/refs/heads/main/void.lua"
local URL_GUNS = "https://raw.githubusercontent.com/luquez/vbotbt/refs/heads/main/guns.lua"
local URL_WAR  = "https://raw.githubusercontent.com/luquez/vbotbt/refs/heads/main/war.lua"
local URL_ARCHER  = "https://raw.githubusercontent.com/luquez/vbotbt/refs/heads/main/archer.lua"
local URL_ALARMS = "https://raw.githubusercontent.com/luquez/vbotbt/refs/heads/main/alarmsn.lua"

-- =============================================
-- 🧠 Execução Remota
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

        local ok, res = pcall(loadstring(code))
        if ok then
            print("[LuqueBot]  " .. name .. " executado!")
            if label then
                label:setText(" " .. name .. " carregado!")
                label:setColor("green")
            end
        else
            print("[LuqueBot] ❌ Erro executando " .. name .. ": " .. tostring(res))
        end
    end)
end

-- =============================================
-- 🧩 Version Check
-- =============================================
HTTP.get(URL_VERSION .. "?nocache=" .. os.time(), function(data, err)
    if err then
        print("[LuqueBot] ⚠️ Erro ao verificar versão: " .. err)
        return
    end

    remoteVersion = data:match("%S+")
    if not remoteVersion then
        print("[LuqueBot] ⚠️ Versão remota inválida.")
        return
    end

    if remoteVersion ~= localVersion then
        print("[LuqueBot] 🔄 Nova versão detectada (" .. remoteVersion .. ")")

        HTTP.get(URL_MAIN .. "?nocache=" .. os.time(), function(code)
            local ok, res = pcall(loadstring(code))
            if ok then print("[LuqueBot] ✅ Main atualizado!") end
        end)

        return
    end

    print("[LuqueBot] ✅ Main.lua atualizado (v" .. localVersion .. ")")

    -- =============================================
    -- 🧠 INTERFACE + BOTÕES + AUTOLOAD POR CHAR
    -- =============================================
    schedule(1000, function()

        setDefaultTab("Main")

        --------------------------------------------
        -- LABEL DE VERSÃO
        --------------------------------------------
        local versionLabel = UI.Label("LuqueBot v" .. localVersion)
        versionLabel:setColor("orange")

        --------------------------------------------
        -- LISTA DE MÓDULOS
        --------------------------------------------
        local modules = {
            { name = "Core-Utilidades", url = URL_CORE, color = "green" },
            { name = "Void",            url = URL_VOID, color = "green" },
            { name = "Guns",            url = URL_GUNS, color = "green" },
            { name = "War",             url = URL_WAR,  color = "green" },
            { name = "Archer",          url = URL_ARCHER,  color = "green" },
            { name = "Alarms Custom", url = URL_ALARMS, color = "green" },
        }

        local classModules = { Void=true, Guns=true, War=true, Archer=true}

        storage.luqueClassByChar = storage.luqueClassByChar or {}

        --------------------------------------------
        -- CRIAÇÃO DOS BOTÕES
        --------------------------------------------
        for _, mod in ipairs(modules) do
            UI.Separator()
            local statusLabel = UI.Label("")

            local button = UI.Button(mod.name, function()
                statusLabel:setText("⏳ Carregando " .. mod.name .. "...")
                statusLabel:setColor("yellow")
                executeRemote(mod.name .. ".lua", mod.url, statusLabel)

                if classModules[mod.name] then
                    local nick = player:getName()
                    storage.luqueClassByChar[nick] = mod.name
                    print("[LuqueBot] 💾 Classe " .. mod.name .. " vinculada ao char " .. nick)
                end
            end)

            button:setColor(mod.color)
        end

        --------------------------------------------
        -- AUTOLOAD DA CLASSE POR CHAR
        --------------------------------------------
        local nick = player:getName()
        local saved = storage.luqueClassByChar[nick]

        if saved then
            print("[LuqueBot] 🔁 Autoload: carregando classe " .. saved .. "...")
            for _, mod in ipairs(modules) do
                if mod.name == saved then
                    executeRemote(mod.name .. ".lua", mod.url)
                end
            end
        else
            print("[LuqueBot] ℹ️ Nenhuma classe associada ao char.")
        end

        UI.Separator()
        UI.Label("Bot by LichKing"):setColor("yellow")
        UI.Label("Nova versao saindo amanha sera necessario atualizar a pasta."):setColor("yellow")
    end)
end)
