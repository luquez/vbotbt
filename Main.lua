-- =============================================
-- LuqueBot Loader - Dual File Memory Mode
-- =============================================

-- =============================================
-- 🌐 LuqueBot Main - Modular + Version Check
-- =============================================

local localVersion = "2.15"
local remoteVersion
print("[LuqueBot] 🔍 Verificando versão... (local " .. localVersion .. ")")

HTTP.get("https://raw.githubusercontent.com/luquez/vbotbt/refs/heads/main/version.txt?nocache=" .. os.time(), function(data, err)
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
        HTTP.get("https://raw.githubusercontent.com/luquez/vbotbt/refs/heads/main/Main.lua?nocache=" .. os.time(), function(code)
            if code and code ~= "" then
                print("[LuqueBot] 🚀 Atualizando Main.lua remoto...")
                loadstring(code)()
            else
                print("[LuqueBot] ❌ Falha ao baixar Main.lua atualizado.")
            end
        end)
        return
    end

    print("[LuqueBot] ✅ Main.lua já está atualizado (v" .. localVersion .. ")")

    -- Se chegou aqui, continua e cria os botões normalmente
    setDefaultTab("Main")

    UI.Label("LuqueBot v" .. localVersion):setColor("aqua")

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

    local modules = {
        { name = "Core", url = "https://raw.githubusercontent.com/luquez/vbotbt/refs/heads/main/Luquebot.lua", color = "green" },
        { name = "Void", url = "https://raw.githubusercontent.com/luquez/vbotbt/refs/heads/main/Void.lua", color = "purple" },
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
