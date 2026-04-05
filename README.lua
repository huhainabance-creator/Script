local vim = game:GetService("VirtualInputManager")
local lp = game.Players.LocalPlayer

-- Твоє магічне число, яке спрацювало
local OFFSET_Y = 59 

-- Створення статус-бару
local coreGui = game:GetService("CoreGui")
if coreGui:FindFirstChild("FinalSuccessGui") then coreGui.FinalSuccessGui:Destroy() end

local sg = Instance.new("ScreenGui", coreGui)
sg.Name = "FinalSuccessGui"
local log = Instance.new("TextLabel", sg)
log.Size = UDim2.new(0.6, 0, 0.07, 0)
log.Position = UDim2.new(0.2, 0, 0.05, 0)
log.BackgroundColor3 = Color3.new(0, 0, 0)
log.TextColor3 = Color3.new(0, 1, 0) -- Зелений (колір успіху)
log.TextScaled = true
log.BorderSizePixel = 2
log.Text = "СИСТЕМА ГОТОВА"

local function smartClick(x, y)
    local realY = y + OFFSET_Y
    vim:SendMouseButtonEvent(x, realY, 0, true, game, 1)
    task.wait(0.1)
    vim:SendMouseButtonEvent(x, realY, 0, false, game, 1)
end

local function useLucky()
    log.Text = "🔍 Шукаю Lucky Arrow..."
    -- Спробуємо знайти стрілу протягом 5 секунд
    for i = 1, 10 do
        local arrow = lp.Backpack:FindFirstChild("Lucky Arrow") or lp.Character:FindFirstChild("Lucky Arrow")
        if arrow then
            log.Text = "✨ ЗНАЙШОВ! ВИКОРИСТОВУЮ..."
            lp.Character.Humanoid:EquipTool(arrow)
            task.wait(0.7)
            arrow:Activate()
            log.Text = "🔥 ЛАКІ СТРІЛА АКТИВОВАНА!"
            return true
        end
        task.wait(0.5)
    end
    log.Text = "❌ Стрілу не знайдено (перевір інвентар)"
    return false
end

task.spawn(function()
    -- 1. Запуск чит-меню
    log.Text = "Вантажу Bitch Boy V3.2..."
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zakater5/LuaRepo/main/YBA/v3.lua"))()
    end)
    
    task.wait(15) -- Чекаємо прогрузки меню

    -- 2. Вкладка Item
    log.Text = "Відкриваю вкладку 'Item'..."
    smartClick(257, 125) 
    task.wait(2)

    -- 3. Auto Farm
    log.Text = "Вмикаю 'Item Auto Farm'..."
    smartClick(392, 80)
    task.wait(2)

    -- 4. Використання Лакі Стріли
    useLucky()

    log.Text = "🚀 ВСЕ ГОТОВО! Фарм та стріла активні."
    task.wait(10)
    sg:Destroy()
end)
