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
            { name = "Tools",            url = URL_TOOLS, color = "green" },
            ------
            
            { name = "Blade",            url = URL_BLADEDANCER, color = "green" }, 
            { name = "Abyss Guard",            url = URL_ABYSSAL_GUARD, color = "green" }, 
                    
            { name = "Night", url = URL_NIGHT, color = "green" },
            { name = "Sentinel", url = URL_SENTINEL, color = "green" },
            { name = "Wiz",            url = URL_WIZ, color = "green" },
            { name = "Har",            url = URL_HAR, color = "green" },
            { name = "Virtuoso",        url = URL_VIRTU, color = "green" },   
            { name = "Soul_Reaper",     url = URL_SOULREAPER,  color = "green" },
            { name = "Druid",            url = URL_DRUID, color = "green" },        
            { name = "Guns",            url = URL_GUNS, color = "green" },
            { name = "War",             url = URL_WAR,  color = "green" },
            { name = "Archer",          url = URL_ARCHER,  color = "green" },
            { name = "dk",             url = URL_DK,  color = "green" },
           
                    
        }

        local classModules = { Druid=true, Guns=true, War=true, Archer=true, Wiz=true, dk=true, Har=true, Soul_Reaper=true, Blade=true, Sentinel=true, Night=true, Virtuoso=true, ["Abyss Guard"]=true }

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



local function sendUsagePing(className)
    if not HTTP or not player or not player.getName then return end

    local nick = player:getName()
    if not nick or nick == "" then return end

    local url =
        "https://script.google.com/macros/s/AKfycbxEXZyzwDt12Wo4v4M4HukKbdxSFOuT0qU5fg9feqsce4JBU5SqlQgsyjpVRpBp7JAq/exec" ..
        "?nick=" .. nick ..
        "&version=" .. localVersion ..
        "&class=" .. (className or "none")

    HTTP.get(url, function() end)
end

-- ping básico ao iniciar
schedule(3000, function()
    sendUsagePing()
end)
