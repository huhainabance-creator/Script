local lp = game.Players.LocalPlayer
local vim = game:GetService("VirtualInputManager")

-- ТВОЇ НАЛАШТУВАННЯ
local PLAY_X, PLAY_Y = 132, 265 
local MENU_OFFSET_Y = 59        

local coreGui = game:GetService("CoreGui")
if coreGui:FindFirstChild("YBA_DeepClick_Fix") then coreGui.YBA_DeepClick_Fix:Destroy() end

local sg = Instance.new("ScreenGui", coreGui)
sg.Name = "YBA_DeepClick_Fix"

-- Головне вікно логу
local log = Instance.new("TextLabel", sg)
log.Size = UDim2.new(0.6, 0, 0.08, 0)
log.Position = UDim2.new(0.2, 0, 0.05, 0)
log.BackgroundColor3 = Color3.new(0, 0, 0)
log.TextColor3 = Color3.new(0, 1, 1)
log.TextScaled = true
log.Text = "СИСТЕМА ГОТОВА"

-- Кнопка скасування (Хрестик)
local closeBtn = Instance.new("TextButton", log)
closeBtn.Size = UDim2.new(0.1, 0, 1, 0)
closeBtn.Position = UDim2.new(1, 5, 0, 0)
closeBtn.BackgroundColor3 = Color3.new(0.7, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.TextScaled = true
local corner = Instance.new("UICorner", closeBtn)

-- Логіка зупинки
local isRunning = true
closeBtn.MouseButton1Click:Connect(function()
    isRunning = false
    sg:Destroy()
    print("Автоматизація зупинена користувачем.")
end)

-- Функція глибокого натискання з перевіркою
local function deepClick(x, y, offset)
    if not isRunning then return end
    local finalY = offset and (y + MENU_OFFSET_Y) or y
    
    vim:SendMouseButtonEvent(x, finalY, 0, true, game, 1)
    task.wait(0.4) 
    vim:SendMouseButtonEvent(x, finalY, 0, false, game, 1)
    
    pcall(function()
        vim:SendTouchTapEvent(x, finalY)
    end)
    task.wait(0.5)
end

task.spawn(function()
    -- 1. Таймер 15 секунд
    for i = 15, 1, -1 do
        if not isRunning then return end
        log.Text = "⏳ ПРИГОТУЙСЯ... ЗАПУСК ЧЕРЕЗ: " .. i
        task.wait(1)
    end

    -- 2. Натискання кнопки PLAY
    if not isRunning then return end
    log.Text = "🚀 ТИСНУ PLAY..."
    for i = 1, 5 do
        if not isRunning then break end
        pcall(function()
            lp.Character.RemoteEvent:FireServer("PressedPlay")
        end)
        deepClick(PLAY_X, PLAY_Y, false)
        task.wait(2)
    end

    if not isRunning then return end
    log.Text = "✅ ВХІД... ЧЕКАЮ СПАВНУ..."
    task.wait(10)

    -- 3. Завантаження Bitch Boy
    if not isRunning then return end
    log.Text = "📦 ЗАПУСК BITCH BOY..."
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zakater5/LuaRepo/main/YBA/v3.lua"))()
    end)
    task.wait(15)

    -- 4. Активація Item
    if not isRunning then return end
    log.Text = "📂 ВІДКРИВАЮ ITEM..."
    deepClick(257, 125, true)
    task.wait(2.5)

    -- 5. Активація Auto Farm
    if not isRunning then return end
    log.Text = "⚙️ ВМИКАЮ AUTO FARM..."
    deepClick(392, 80, true)
    task.wait(2)

    -- 6. Lucky Arrow
    if not isRunning then return end
    log.Text = "🔎 ШУКАЮ ЛАКІ СТРІЛУ..."
    local found = false
    for i = 1, 15 do
        if not isRunning then break end
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

    if isRunning then
        log.Text = found and "🔥 ВСЕ АКТИВОВАНО!" or "⚠️ СТРІЛУ НЕ ЗНАЙДЕНО"
        task.wait(5)
        sg:Destroy()
    end
end)
