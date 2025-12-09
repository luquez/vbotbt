-- =============================================
-- 🌐 LuqueBot Main - Modular + Version Check (Stable)
-- =============================================

local localVersion = "1.0"
local remoteVersion

print("[LuqueBot] 🔍 Verificando versão... (local " .. localVersion .. ")")

-- =============================================
-- 🔎 URLs fixas (web-based)
-- =============================================
local URL_VERSION = "https://raw.githubusercontent.com/luquez/vbotbt/refs/heads/main/version.txt"
local URL_MAIN    = "https://raw.githubusercontent.com/luquez/vbotbt/refs/heads/main/Main.lua"

local URL_CORE = "https://raw.githubusercontent.com/luquez/vbotbt/refs/heads/main/Luquebot.lua"
local URL_VOID = "https://raw.githubusercontent.com/luquez/vbotbt/refs/heads/main/void.lua"
local URL_GUNS = "https://raw.githubusercontent.com/luquez/vbotbt/refs/heads/main/guns.lua"
local URL_WAR  = "https://raw.githubusercontent.com/luquez/vbotbt/refs/heads/main/war.lua"

-- =============================================
-- 🧠 Função para baixar e executar módulos remotos
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
-- 🧩 Checagem de versão remota (com controle)
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
                else
                    print("[LuqueBot] ❌ Erro ao executar Main.lua atualizado: " .. tostring(res))
                end
            else
                print("[LuqueBot] ⚠️ Falha ao baixar Main.lua atualizado: " .. tostring(err2))
            end
        end)

        return  -- 🧠 Sai aqui pra evitar loop
    end

    print("[LuqueBot] ✅ Main.lua atualizado (v" .. localVersion .. ")")

    -- =============================================
    -- 🧠 Interface, botões e autoload por char
    -- =============================================
    schedule(1000, function()
        setDefaultTab("Main")

        -- Label de versão
        local versionLabel = UI.Label("LuqueBot v" .. (remoteVersion or localVersion))
        versionLabel:setColor("orange")

        macro(1000, function()
            if remoteVersion and remoteVersion ~= localVersion then
                versionLabel:setText("LuqueBot v" .. remoteVersion)
                versionLabel:setColor("green")
            end
        end)

        -- Módulos disponíveis
        local modules = {
            { name = "Core-Utilidades", url = URL_CORE, color = "green" },
            { name = "Void",            url = URL_VOID, color = "green" },
            { name = "Guns",            url = URL_GUNS, color = "green" },
            { name = "War",             url = URL_WAR,  color = "green" },
        }

        -- Quais módulos são "classe" (autoload por char)
        local classModules = {
            ["Void"] = true,
            ["Guns"] = true,
            ["War"]  = true,
        }

        -- Tabela de mapeamento char -> classe
        storage.luqueClassByChar = storage.luqueClassByChar or {}

        -- Botões dos módulos
        for _, mod in ipairs(modules) do
            UI.Separator()
            local statusLabel = UI.Label("")

            local button = UI.Button(mod.name, function()
                statusLabel:setText("⏳ Carregando " .. mod.name .. "...")
                statusLabel:setColor("yellow")
                executeRemote(mod.name .. ".lua", mod.url, statusLabel)

                -- se for módulo de classe, grava a classe para este char
                if classModules[mod.name] and player and player.getName then
                    local charName = player:getName()
                    if charName and charName ~= "" then
                        storage.luqueClassByChar[charName] = mod.name
                        print("[LuqueBot] 💾 Classe " .. mod.name .. " associada ao char " .. charName)
                    end
                end
            end)

            button:setColor(mod.color)
        end

        UI.Separator()
        UI.Label("Bot by Luque Autoupdate"):setColor("white")

        -- =============================================
        -- 🔁 Autoload da classe com base no char logado
        -- =============================================
        if player and player.getName then
            local charName = player:getName()
            if charName and charName ~= "" then
                local className = storage.luqueClassByChar[charName]
                if className then
                    print("[LuqueBot] 🔁 Auto-carregando classe " .. className .. " para " .. charName .. "...")

                    for _, mod in ipairs(modules) do
                        if mod.name == className then
                            executeRemote(mod.name .. ".lua", mod.url)
                            break
                        end
                    end
                else
                    print("[LuqueBot] ℹ️ Nenhuma classe associada para " .. charName .. ".")
                    print("[LuqueBot] ℹ️ Clique uma vez no botão da classe para memorizar.")
                end
            end
        end
    end)
end)

-- =============================================```
