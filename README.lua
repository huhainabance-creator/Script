local lp = game.Players.LocalPlayer

local vim = game:GetService("VirtualInputManager")



-- ТВОЇ НАЛАШТУВАННЯ

local PLAY_X, PLAY_Y = 132, 265 -- Твої нові координати Play

local MENU_OFFSET_Y = 59        -- Твій перевірений офсет для Bitch Boy



local coreGui = game:GetService("CoreGui")

if coreGui:FindFirstChild("YBA_DeepClick_Fix") then coreGui.YBA_DeepClick_Fix:Destroy() end



local sg = Instance.new("ScreenGui", coreGui)

sg.Name = "YBA_DeepClick_Fix"

local log = Instance.new("TextLabel", sg)

log.Size = UDim2.new(0.6, 0, 0.08, 0)

log.Position = UDim2.new(0.2, 0, 0.05, 0)

log.BackgroundColor3 = Color3.new(0, 0, 0)

log.TextColor3 = Color3.new(0, 1, 1)

log.TextScaled = true

log.Text = "СИСТЕМА ГОТОВА"



-- НОВА ФУНКЦІЯ: ГЛИБОКЕ НАТИСКАННЯ

local function deepClick(x, y, offset)

    local finalY = offset and (y + MENU_OFFSET_Y) or y

    

    -- 1. Наводимо і затискаємо

    vim:SendMouseButtonEvent(x, finalY, 0, true, game, 1)

    task.wait(0.4) -- ТРИМАЄМО палець на кнопці майже пів секунди

    

    -- 2. Відпускаємо

    vim:SendMouseButtonEvent(x, finalY, 0, false, game, 1)

    

    -- 3. Додатково шлемо Тап для надійності

    pcall(function()

        vim:SendTouchTapEvent(x, finalY)

    end)

    task.wait(0.5)

end



task.spawn(function()

    -- 1. Таймер 15 секунд

    for i = 15, 1, -1 do

        log.Text = "⏳ ПРИГОТУЙСЯ... ЗАПУСК ЧЕРЕЗ: " .. i

        task.wait(1)

    end



    -- 2. Натискання кнопки PLAY

    log.Text = "🚀 ТИСНУ PLAY (ГЛИБОКИЙ КЛІК)..."

    for i = 1, 5 do

        -- Спроба ремутом

        pcall(function()

            lp.Character.RemoteEvent:FireServer("PressedPlay")

        end)

        

        deepClick(PLAY_X, PLAY_Y, false)

        task.wait(2)

    end



    log.Text = "✅ ВХІД... ЧЕКАЮ СПАВНУ..."

    task.wait(10)



    -- 3. Завантаження Bitch Boy

    log.Text = "📦 ЗАПУСК BITCH BOY..."

    pcall(function()

        loadstring(game:HttpGet("https://raw.githubusercontent.com/zakater5/LuaRepo/main/YBA/v3.lua"))()

    end)

    task.wait(15)



    -- 4. Активація Item (твої 257, 125)

    log.Text = "📂 ВІДКРИВАЮ ITEM..."

    deepClick(257, 125, true)

    task.wait(2.5)



    -- 5. Активація Auto Farm (твої 392, 80)

    log.Text = "⚙️ ВМИКАЮ AUTO FARM..."

    deepClick(392, 80, true)

    task.wait(2)



    -- 6. Lucky Arrow

    log.Text = "🔎 ШУКАЮ ЛАКІ СТРІЛУ..."

    local found = false

    for i = 1, 15 do

        local arrow = lp.Backpack:FindFirstChild("Lucky Arrow") or lp.Character:FindFirstChild("Lucky Arrow")

        if arrow then

            lp.Character.Humanoid:EquipTool(arrow)

            task.wait(0.8)

            arrow:Activate()

            found = true

            break

        end

        task.wait(1)

    end



    log.Text = found and "🔥 ВСЕ АКТИВОВАНО!" or "⚠️ СТРІЛУ НЕ ЗНАЙДЕНО"

    task.wait(5)

    sg:Destroy()

end)
