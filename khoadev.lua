-- ====================================================================
-- KHOA DEV HUB - EVADE SCRIPT TỐI ƯU HÓA HOÀN TOÀN
-- Tác giả: Khoa Dev
-- ====================================================================

local player = game.Players.LocalPlayer
local guiService = game:GetService("GuiService")
local starterGui = game:GetService("StarterGui")
local playerGui = player:WaitForChild("PlayerGui")
if playerGui:FindFirstChild("CustomTopGui") then
    return
end

pcall(function() starterGui:SetCore("TopbarEnabled", false) end)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CustomTopGui"
screenGui.IgnoreGuiInset = false
screenGui.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets
screenGui.DisplayOrder = 100
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Parent = screenGui
frame.BackgroundTransparency = 1
frame.BorderSizePixel = 0
frame.Position = UDim2.new(0, 0, 0, 0)
frame.Size = UDim2.new(1, 0, 1, -2)

local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Name = "Right"
scrollingFrame.Parent = frame
scrollingFrame.BackgroundTransparency = 1
scrollingFrame.BorderSizePixel = 0
scrollingFrame.Position = UDim2.new(0, 12, 0, 0)
scrollingFrame.Size = UDim2.new(1, -24, 1, 0)
scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.X
scrollingFrame.ScrollBarThickness = 0
scrollingFrame.ScrollingDirection = Enum.ScrollingDirection.X
scrollingFrame.ScrollingEnabled = false

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Parent = scrollingFrame
uiListLayout.Padding = UDim.new(0, 12)
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.FillDirection = Enum.FillDirection.Horizontal
uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom

task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/More-Loadstrings.lua'))()
    end)
end)

getgenv().WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
getgenv().WindUI:SetTheme("Plant")

local Confirmed = false

function gradient(text, startColor, endColor)
    local result = ""
    local length = #text
    local r1, g1, b1 = startColor.R * 255, startColor.G * 255, startColor.B * 255
    local r2, g2, b2 = endColor.R * 255, endColor.G * 255, endColor.B * 255
    
    for i = 1, length do
        local t = (i - 1) / math.max(length - 1, 1)
        local r = math.floor(r1 + (r2 - r1) * t)
        local g = math.floor(g1 + (g2 - g1) * t)
        local b = math.floor(b1 + (b2 - b1) * t)
        local char = text:sub(i, i)
        result = result .. string.format('<font color="rgb(%d, %d, %d)">%s</font>', r, g, b, char)
    end
    return result
end

getgenv().WindUI:Popup({
    Title = "Chào mừng bạn đến với Khoa Dev Hub!",
    Icon = "console",
    IconThemed = true,
    Content = "Chào mừng bạn đến với " .. gradient("Khoa Dev", Color3.fromHex("#00E676"), Color3.fromHex("#00B0FF")) .. " Evade Hub.",
    Buttons = {
        {
            Title = "Bắt Đầu",
            Icon = "arrow-right",
            Variant = "Primary",
            Callback = function()
                Confirmed = true
            end
        }
    }
})

repeat task.wait() until Confirmed

local function getSecurityPart()
    local part = workspace:FindFirstChild("SecurityPart")
    if not part then
        part = Instance.new("Part")
        part.Name = "SecurityPart"
        part.Size = Vector3.new(20, 2, 20)
        part.Position = Vector3.new(5000, 5000, 5000)
        part.Anchored = true
        part.CanCollide = true
        part.Transparency = 1
        part.CanTouch = false
        part.Parent = workspace
    end
    return part
end

getSecurityPart()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

getgenv().FeatureStates = {
    SelfReviveMethod = "Spawnpoint",
    AutoSelfRevive = false,
    TimerDisplay = false,
    EspPlayer = false,
    EspTicket = false,
    EspNextbot = false,
    TracerDowned = false,
    InfiniteSlide = false,
    AutoCarry = false,
    BhopEnabled = false,
    BhopMode = "Acceleration",
    BhopAccelValue = -0.1,
    SelectedEmote = nil,
    EmoteEnabled = false,
    LagSwitchEnabled = false,
    LagDuration = 0.5,
    InstantReviveEnabled = false,
    InstantReviveDelay = 0.15,
    CameraStretchEnabled = false,
    CameraStretchVertical = 0.80,
    CameraStretchHorizontal = 0.80,
    FrontJumpEnabled = false,
    FrontJumpSpeed = 50,
    FrontAutoJumpEnabled = true,
    AutoTicketFarm = false,
    AutoMoneyFarm = false,
    AutoTrimpEnabled = false,
    AntiAFK = true,
    FixColaAnimation = false,
    FixColaHookEnabled = false,
}

getgenv().featureToggles = getgenv().featureToggles or {}

local function createGradientButton(parent, name, initialState, yPosition, toggleCallback)
    if getgenv().featureToggles[name] and getgenv().featureToggles[name].Gui then
        pcall(function() getgenv().featureToggles[name].Gui:Destroy() end)
        getgenv().featureToggles[name] = nil
    end
    
    local sGui = Instance.new("ScreenGui")
    sGui.Name = name .. "ToggleGUI"
    sGui.ResetOnSpawn = false
    sGui.Parent = parent or PlayerGui
    
    local button = Instance.new("Frame")
    button.Name = "GradientBtn"
    button.BackgroundTransparency = 0.7
    button.Size = UDim2.new(0, 130, 0, 35)
    button.Position = UDim2.new(0.02, 0, yPosition or 0.1, 0)
    button.Active = true
    button.Selectable = true
    pcall(function() button.Draggable = true end)
    button.Parent = sGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = button
    
    local grad = Instance.new("UIGradient")
    grad.Rotation = 45
    grad.Parent = button
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Parent = button
    
    local label = Instance.new("TextLabel")
    label.Text = name
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextSize = 13
    label.Font = Enum.Font.GothamMedium
    label.Parent = button
    
    local clicker = Instance.new("TextButton")
    clicker.Size = UDim2.new(1, 0, 1, 0)
    clicker.BackgroundTransparency = 1
    clicker.Text = ""
    clicker.ZIndex = 5
    clicker.Active = true
    clicker.Selectable = true
    clicker.Parent = button
    
    local function updateButton(state)
        if state then
            grad.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 200, 100)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 120, 60))
            }
            stroke.Color = Color3.fromRGB(0, 180, 80)
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            grad.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 200, 200)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 150, 150))
            }
            stroke.Color = Color3.fromRGB(100, 100, 100)
            label.TextColor3 = Color3.fromRGB(240, 240, 240)
        end
    end
    
    updateButton(initialState)
    
    clicker.MouseButton1Click:Connect(function()
        local newState = not initialState
        initialState = newState
        updateButton(newState)
        if toggleCallback then
            toggleCallback(newState)
        end
    end)
    
    getgenv().featureToggles[name] = {
        Gui = sGui,
        Button = button,
        UpdateState = function(newState)
            initialState = newState
            updateButton(newState)
        end
    }
    
    return getgenv().featureToggles[name]
end

local function createFeatureToggle(name, initialState, yPosition, toggleCallback)
    return createGradientButton(PlayerGui, name, initialState, yPosition, toggleCallback)
end

-- ====================================================================
-- HÀM TRUY CẬP GAME ĐA NĂNG (HỖ TRỢ MỌI PHIÊN BẢN EVADE)
-- ====================================================================
local function getInteractRemote()
    if ReplicatedStorage:FindFirstChild("Events") then
        if ReplicatedStorage.Events:FindFirstChild("Interact") then
            return ReplicatedStorage.Events.Interact
        elseif ReplicatedStorage.Events:FindFirstChild("Character") and ReplicatedStorage.Events.Character:FindFirstChild("Interact") then
            return ReplicatedStorage.Events.Character.Interact
        end
    end
    return nil
end

local function setPlayerMode(state)
    pcall(function()
        if ReplicatedStorage:FindFirstChild("Events") then
            if ReplicatedStorage.Events:FindFirstChild("SetPlayerMode") then
                ReplicatedStorage.Events.SetPlayerMode:FireServer(state)
                ReplicatedStorage.Events.SetPlayerMode:FireServer()
            elseif ReplicatedStorage.Events:FindFirstChild("Player") and ReplicatedStorage.Events.Player:FindFirstChild("ChangePlayerMode") then
                ReplicatedStorage.Events.Player.ChangePlayerMode:FireServer(state)
            end
        end
    end)
end

local function getToolActionRemote()
    if ReplicatedStorage:FindFirstChild("Events") then
        if ReplicatedStorage.Events:FindFirstChild("ToolAction") then
            return ReplicatedStorage.Events.ToolAction
        elseif ReplicatedStorage.Events:FindFirstChild("Character") and ReplicatedStorage.Events.Character:FindFirstChild("ToolAction") then
            return ReplicatedStorage.Events.Character.ToolAction
        end
    end
    return nil
end

local function playEmote(emoteName)
    if not emoteName then return end
    pcall(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Animate") and char.Animate:FindFirstChild("PlayEmote") then
            char.Animate.PlayEmote:Invoke(emoteName)
        end
    end)
    pcall(function()
        if ReplicatedStorage:FindFirstChild("Events") then
            if ReplicatedStorage.Events:FindFirstChild("Character") and ReplicatedStorage.Events.Character:FindFirstChild("Emote") then
                ReplicatedStorage.Events.Character.Emote:FireServer(emoteName)
            elseif ReplicatedStorage.Events:FindFirstChild("Emote") then
                ReplicatedStorage.Events.Emote:FireServer(emoteName)
            elseif ReplicatedStorage.Events:FindFirstChild("CharacterTask") then
                ReplicatedStorage.Events.CharacterTask:FireServer("Emote", emoteName)
            elseif ReplicatedStorage.Events:FindFirstChild("Action") then
                ReplicatedStorage.Events.Action:FireServer("Emote", emoteName)
            end
        end
    end)
end

local function getPlayerModel()
    local gameFolder = workspace:FindFirstChild("Game")
    if gameFolder and gameFolder:FindFirstChild("Players") then
        local pMod = gameFolder.Players:FindFirstChild(LocalPlayer.Name)
        if pMod then return pMod end
    end
    return LocalPlayer.Character
end

local function getAllTargets()
    local targets = {}
    local seen = {}

    local gameFolder = workspace:FindFirstChild("Game")
    if gameFolder and gameFolder:FindFirstChild("Players") then
        for _, ch in ipairs(gameFolder.Players:GetChildren()) do
            if ch:IsA("Model") and ch.Name ~= LocalPlayer.Name and ch:GetAttribute("Team") ~= "Nextbot" then
                local hrp = ch:FindFirstChild("HumanoidRootPart") or ch:FindFirstChild("Torso") or ch:FindFirstChild("UpperTorso") or ch:FindFirstChildWhichIsA("BasePart")
                if hrp then
                    seen[ch.Name] = true
                    local pl = Players:FindFirstChild(ch.Name)
                    table.insert(targets, {
                        Name = ch.Name,
                        DisplayName = (pl and pl.DisplayName) or ch.Name,
                        Character = ch,
                        RootPart = hrp,
                        Player = pl
                    })
                end
            end
        end
    end

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and not seen[p.Name] and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart") or p.Character:FindFirstChild("Torso") or p.Character:FindFirstChild("UpperTorso") or p.Character:FindFirstChildWhichIsA("BasePart")
            if hrp then
                seen[p.Name] = true
                table.insert(targets, {
                    Name = p.Name,
                    DisplayName = p.DisplayName or p.Name,
                    Character = p.Character,
                    RootPart = hrp,
                    Player = p
                })
            end
        end
    end

    return targets
end

local function isTargetDowned(target)
    local char = target.Character
    local p = target.Player

    if char then
        if char:GetAttribute("Downed") == true then return true end
        local st = char:GetAttribute("State")
        if typeof(st) == "string" and st:lower():find("down") then return true end
        if char:FindFirstChild("Downed") then return true end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum and (hum.Health <= 0 or hum.PlatformStand) then return true end
    end

    if p then
        if p:GetAttribute("Downed") == true then return true end
        local pst = p:GetAttribute("State")
        if typeof(pst) == "string" and pst:lower():find("down") then return true end
    end

    local gameFolder = workspace:FindFirstChild("Game")
    if gameFolder and gameFolder:FindFirstChild("Players") then
        local gp = gameFolder.Players:FindFirstChild(target.Name)
        if gp then
            if gp:GetAttribute("Downed") == true then return true end
            local st = gp:GetAttribute("State")
            if typeof(st) == "string" and st:lower():find("down") then return true end
        end
    end

    return false
end

local function isLocalPlayerDowned()
    local char = LocalPlayer.Character
    if char then
        if char:GetAttribute("Downed") == true then return true end
        local st = char:GetAttribute("State")
        if typeof(st) == "string" and st:lower():find("down") then return true end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum and (hum.Health <= 0 or hum.PlatformStand) then return true end
    end

    local gameFolder = workspace:FindFirstChild("Game")
    if gameFolder and gameFolder:FindFirstChild("Players") then
        local gp = gameFolder.Players:FindFirstChild(LocalPlayer.Name)
        if gp then
            if gp:GetAttribute("Downed") == true then return true end
            local st = gp:GetAttribute("State")
            if typeof(st) == "string" and st:lower():find("down") then return true end
        end
    end

    local pg = LocalPlayer:FindFirstChild("PlayerGui")
    if pg and pg:FindFirstChild("Game") and pg.Game:FindFirstChild("Respawn") then
        local downedFrame = pg.Game.Respawn:FindFirstChild("Downed")
        if downedFrame and downedFrame.Visible then return true end
        local deathFrame = pg.Game.Respawn:FindFirstChild("Death")
        if deathFrame and deathFrame.Visible then return true end
    end

    return false
end

local knownNextbots = {
    ["Bunny Bobo"] = true, ["Bunny Jard"] = true, ["Bunny Galf"] = true, ["Fazbore"] = true,
    ["Kitten Bobo"] = true, ["Kitten Jard"] = true, ["Oswald"] = true, ["Pootis"] = true,
    ["Spider"] = true, ["steam happi"] = true, ["Pac Man"] = true, ["Rolling Giant"] = true,
    ["Noob Driver"] = true, ["Angry Bobo"] = true, ["Angry Munci"] = true, ["Cat Jard"] = true,
    ["Wolf Rebel"] = true, ["Super Munci"] = true, ["Hard Difficulty"] = true, ["Custom"] = true,
    ["Rebel"] = true, ["Angry BoboR6"] = true, ["Mimic"] = true, ["BoboR6"] = true,
    ["Noob Fighter"] = true, ["Slasher"] = true, ["TestNPC"] = true, ["Decoy"] = true,
    ["1000 Yard Stare"] = true, ["Meem"] = true, ["Spy"] = true, ["Soldier"] = true,
    ["Sniper"] = true, ["Scout"] = true, ["huh"] = true, ["Wake Up"] = true, ["male_07"] = true,
    ["Skinwalker"] = true, ["Sisyphus"] = true, ["Shhh"] = true, ["Screaming Stark"] = true,
    ["Roo Bear"] = true, ["Bite Of 87"] = true, ["Moyai"] = true, ["Metal Pipe"] = true,
    ["Literally Me"] = true, ["Killer Fish"] = true, ["Glen"] = true, ["Finguh"] = true,
    ["Elite"] = true, ["Gubby"] = true, ["Damnation"] = true, ["3DRampage"] = true,
    ["Baldi"] = true, ["Defect"] = true, ["TheEyeless"] = true, ["TripleT"] = true,
    ["Trollge"] = true, ["Imposter"] = true
}

local function getAllNextbotTargets()
    local bots = {}
    local seen = {}

    local function checkAndAdd(model)
        if not model:IsA("Model") or seen[model] then return end
        if model.Name == LocalPlayer.Name then return end
        if Players:FindFirstChild(model.Name) and model:GetAttribute("Team") ~= "Nextbot" then return end

        local isBot = model:GetAttribute("Team") == "Nextbot" or model:GetAttribute("AI") == true or knownNextbots[model.Name]
        if isBot then
            local root = model:FindFirstChild("Root") or model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Head") or model:FindFirstChild("Torso") or model:FindFirstChildWhichIsA("BasePart")
            if root then
                seen[model] = true
                table.insert(bots, {
                    Name = model.Name,
                    Model = model,
                    RootPart = root
                })
            end
        end
    end

    local gameFolder = workspace:FindFirstChild("Game")
    if gameFolder then
        if gameFolder:FindFirstChild("Players") then
            for _, ch in ipairs(gameFolder.Players:GetChildren()) do checkAndAdd(ch) end
        end
        if gameFolder:FindFirstChild("NPCs") then
            for _, ch in ipairs(gameFolder.NPCs:GetChildren()) do checkAndAdd(ch) end
        end
        if gameFolder:FindFirstChild("Entities") then
            for _, ch in ipairs(gameFolder.Entities:GetChildren()) do checkAndAdd(ch) end
        end
    end

    if workspace:FindFirstChild("NPCs") then
        for _, ch in ipairs(workspace.NPCs:GetChildren()) do checkAndAdd(ch) end
    end
    for _, ch in ipairs(workspace:GetChildren()) do
        if ch:IsA("Model") and (knownNextbots[ch.Name] or ch:GetAttribute("Team") == "Nextbot") then
            checkAndAdd(ch)
        end
    end

    return bots
end

local function getAllTicketTargets()
    local list = {}
    local seen = {}

    local function checkAndAdd(obj)
        if (obj:IsA("Model") or obj:IsA("BasePart")) and not seen[obj] then
            local part = obj:IsA("BasePart") and obj or (obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart"))
            if part then
                seen[obj] = true
                table.insert(list, {
                    Name = obj.Name,
                    Instance = obj,
                    RootPart = part
                })
            end
        end
    end

    local gameFolder = workspace:FindFirstChild("Game")
    if gameFolder and gameFolder:FindFirstChild("Effects") then
        local eff = gameFolder.Effects
        if eff:FindFirstChild("Tickets") then
            for _, t in ipairs(eff.Tickets:GetChildren()) do checkAndAdd(t) end
        end
        if eff:FindFirstChild("Collectibles") then
            for _, t in ipairs(eff.Collectibles:GetChildren()) do checkAndAdd(t) end
        end
    end
    if gameFolder and gameFolder:FindFirstChild("Tickets") then
        for _, t in ipairs(gameFolder.Tickets:GetChildren()) do checkAndAdd(t) end
    end
    if workspace:FindFirstChild("Tickets") then
        for _, t in ipairs(workspace.Tickets:GetChildren()) do checkAndAdd(t) end
    end
    if workspace:FindFirstChild("Collectibles") then
        for _, t in ipairs(workspace.Collectibles:GetChildren()) do checkAndAdd(t) end
    end

    return list
end

local function clickGuiButton(btn)
    if not btn or not (btn:IsA("GuiButton") or btn:IsA("TextButton") or btn:IsA("ImageButton")) then return end
    
    if firesignal then
        pcall(function() firesignal(btn.MouseButton1Click) end)
        pcall(function() firesignal(btn.MouseButton1Down) end)
        pcall(function() firesignal(btn.MouseButton1Up) end)
        pcall(function() firesignal(btn.Activated) end)
    end

    pcall(function()
        local vim = game:GetService("VirtualInputManager")
        local pos = btn.AbsolutePosition + (btn.AbsoluteSize / 2)
        if pos.X > 0 and pos.Y > 0 then
            vim:SendMouseButtonEvent(pos.X, pos.Y, 0, true, game, 1)
            task.wait(0.02)
            vim:SendMouseButtonEvent(pos.X, pos.Y, 0, false, game, 1)
        end
    end)

    pcall(function()
        local gs = game:GetService("GuiService")
        local vim = game:GetService("VirtualInputManager")
        local old = gs.SelectedObject
        gs.SelectedObject = btn
        vim:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
        task.wait(0.02)
        vim:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
        gs.SelectedObject = old
    end)
end

local function triggerRespawnButton()
    pcall(function()
        local pg = LocalPlayer:FindFirstChild("PlayerGui")
        if pg then
            local gameGui = pg:FindFirstChild("Game")
            if gameGui and gameGui:FindFirstChild("Respawn") then
                for _, desc in ipairs(gameGui.Respawn:GetDescendants()) do
                    if desc:IsA("GuiButton") then
                        clickGuiButton(desc)
                    end
                end
            end
            for _, desc in ipairs(pg:GetDescendants()) do
                if desc:IsA("GuiButton") and (desc.Name:lower():find("respawn") or desc.Name:lower():find("death")) then
                    clickGuiButton(desc)
                end
            end
        end
    end)
    setPlayerMode(true)
    pcall(function()
        if ReplicatedStorage:FindFirstChild("Events") then
            if ReplicatedStorage.Events:FindFirstChild("SetPlayerMode") then
                for i = 1, 3 do
                    ReplicatedStorage.Events.SetPlayerMode:FireServer(true)
                    ReplicatedStorage.Events.SetPlayerMode:FireServer(false)
                    ReplicatedStorage.Events.SetPlayerMode:FireServer()
                    ReplicatedStorage.Events.SetPlayerMode:FireServer(1)
                end
            end
            if ReplicatedStorage.Events:FindFirstChild("GameUISetType") then
                ReplicatedStorage.Events.GameUISetType:FireServer("Respawn")
            end
        end
    end)
end

-- ====================================================================
-- GIAO DIỆN CHÍNH (KHOA DEV HUB)
-- ====================================================================
local Window = getgenv().WindUI:CreateWindow({
    Title = "🌟 Khoa Dev Hub 22222🌟",
    Icon = "gamepad",
    Author = "Khoa Dev",
    IconThemed = true,
    Size = UDim2.fromOffset(620, 420),
    Folder = "KhoaDevHub",
    Transparent = false,
})

local InfoTab = Window:Tab({Title = "🎄 Thông Tin 22", Icon = "message-circle"})
local PlayerTab = Window:Tab({Title = "👤 Người Chơi", Icon = "user"})
local AutoTab = Window:Tab({Title = "⚡ Tự Động", Icon = "zap"})
local FPSTab = Window:Tab({Title = "🖥️ Tối Ưu FPS", Icon = "monitor"})
local EspTab = Window:Tab({Title = "👁️ ESP & Định Vị", Icon = "eye"})
local VisualTab = Window:Tab({Title = "✨ Hình Ảnh & Hiệu Ứng", Icon = "smile"})
local SettingsTab = Window:Tab({Title = "⚙️ Cài Đặt", Icon = "settings"})

-- ====================================================================
-- TAB 1: THÔNG TIN (INFO)
-- ====================================================================
getgenv().DiscordInfo = getgenv().DiscordInfo or {
    ServerLink = "https://discord.gg/GE4T8wCSV",
    ServerID = 920587201,
}

InfoTab:Section({ Title = "Kênh Máy Chủ Hỗ Trợ", TextSize = 20 })
InfoTab:Divider()

InfoTab:Paragraph({
    Title = "Khoa Dev Community",
    Desc = "Script được phát triển và tối ưu lại toàn diện bởi Khoa Dev.\nTham gia máy chủ để nhận thông báo và hỗ trợ!",
    Buttons = {
        {
            Title = "Sao Chép Link Discord",
            Icon = "link",
            Callback = function()
                setclipboard(getgenv().DiscordInfo.ServerLink)
                WindUI:Notify({
                    Title = "Thông Báo",
                    Content = "Đã sao chép link Discord vào khay nhớ tạm!",
                    Duration = 3
                })
            end
        },
        {
            Title = "Vào Máy Chủ",
            Icon = "external-link",
            Callback = function()
                pcall(function() 
                    game:GetService("TeleportService"):Teleport(getgenv().DiscordInfo.ServerID, LocalPlayer) 
                end)
            end
        }
    }
})

InfoTab:Section({ Title = "Giới Thiệu", TextSize = 20 })
InfoTab:Divider()

InfoTab:Paragraph({
    Title = "Thông Tin Phiên Bản",
    Desc = "Tác giả: Khoa Dev\nThư viện UI: WindUI\nTrạng thái: Đã sửa toàn bộ lỗi tương thích với bản cập nhật mới nhất của Evade!",
    Buttons = {}
})

-- ====================================================================
-- TAB 2: NGƯỜI CHƠI (PLAYER)
-- ====================================================================
getgenv().frontJumpVelocity = nil

local function startFrontJump()
    if getgenv().frontJumpVelocity then 
        getgenv().frontJumpVelocity:Destroy() 
        getgenv().frontJumpVelocity = nil 
    end
    
    local char = LocalPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not humanoid or not root then return end

    getgenv().frontJumpVelocity = Instance.new("BodyVelocity")
    getgenv().frontJumpVelocity.MaxForce = Vector3.new(400000, 0, 400000)
    getgenv().frontJumpVelocity.P = 1250
    getgenv().frontJumpVelocity.Velocity = Vector3.new(0, 0, 0)
    getgenv().frontJumpVelocity.Parent = root

    task.spawn(function()
        while getgenv().FeatureStates.FrontJumpEnabled and getgenv().frontJumpVelocity and getgenv().frontJumpVelocity.Parent do
            local cam = workspace.CurrentCamera
            if cam and root then
                local forward = cam.CFrame.LookVector
                local direction = Vector3.new(forward.X, 0, forward.Z)
                if direction.Magnitude > 0 then direction = direction.Unit end
                
                getgenv().frontJumpVelocity.Velocity = direction * getgenv().FeatureStates.FrontJumpSpeed
                
                if getgenv().FeatureStates.FrontAutoJumpEnabled and humanoid and humanoid:GetState() ~= Enum.HumanoidStateType.Jumping then
                    local ray = Ray.new(root.Position, Vector3.new(0, -4, 0))
                    local hit = workspace:FindPartOnRayWithIgnoreList(ray, {char})
                    if hit then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
                end
            end
            task.wait(0.016)
        end
        if getgenv().frontJumpVelocity then 
            getgenv().frontJumpVelocity:Destroy() 
            getgenv().frontJumpVelocity = nil 
        end
    end)
end

local function handleFrontJumpToggle(newState)
    getgenv().FeatureStates.FrontJumpEnabled = newState
    if newState then
        startFrontJump()
    else
        if getgenv().frontJumpVelocity then
            getgenv().frontJumpVelocity:Destroy()
            getgenv().frontJumpVelocity = nil
        end
    end
end

PlayerTab:Toggle({
    Title = "Nhảy Về Phía Trước (Front Jump)",
    Value = false,
    Callback = function(state)
        handleFrontJumpToggle(state)
        if state and not getgenv().featureToggles["Front Jump"] then
            getgenv().featureToggles["Front Jump"] = createFeatureToggle("Front Jump", state, 0.1, function(newState)
                handleFrontJumpToggle(newState)
            end)
        end
        if getgenv().featureToggles["Front Jump"] then
            getgenv().featureToggles["Front Jump"].Gui.Enabled = state
            if getgenv().featureToggles["Front Jump"].UpdateState then
                getgenv().featureToggles["Front Jump"].UpdateState(state)
            end
        end
    end
})

PlayerTab:Input({
    Title = "Tốc Độ Nhảy (Front Jump Speed)",
    Icon = "zap",
    Placeholder = "Mặc định: 50",
    Value = "50",
    Callback = function(input)
        local val = tonumber(input)
        if val and val > 0 and val <= 500 then
            getgenv().FeatureStates.FrontJumpSpeed = val
        end
    end
})

PlayerTab:Toggle({
    Title = "Tự Động Nhảy Với Front Jump",
    Value = true,
    Callback = function(state)
        getgenv().FeatureStates.FrontAutoJumpEnabled = state
    end
})

PlayerTab:Divider()

local function getMovementTables()
    local matched = {}
    pcall(function()
        local moveStatsMod = ReplicatedStorage:FindFirstChild("Objects") 
            and ReplicatedStorage.Objects:FindFirstChild("Game")
            and ReplicatedStorage.Objects.Game:FindFirstChild("Character")
            and ReplicatedStorage.Objects.Game.Character:FindFirstChild("Client")
            and ReplicatedStorage.Objects.Game.Character.Client:FindFirstChild("Movement")
            and ReplicatedStorage.Objects.Game.Character.Client.Movement:FindFirstChild("MoveStats")
        if moveStatsMod then
            local res = require(moveStatsMod)
            if typeof(res) == "table" then
                table.insert(matched, res)
            end
        end
    end)
    
    if getgc then
        for _, obj in pairs(getgc(true)) do
            if typeof(obj) == "table" then
                local hasSpeed = rawget(obj, "Speed") ~= nil
                local hasFriction = rawget(obj, "Friction") ~= nil
                local hasJumpCap = rawget(obj, "JumpCap") ~= nil or rawget(obj, "JumpHeight") ~= nil
                if hasSpeed and (hasFriction or hasJumpCap) then
                    local alreadyIn = false
                    for _, m in ipairs(matched) do
                        if m == obj then alreadyIn = true break end
                    end
                    if not alreadyIn then
                        table.insert(matched, obj)
                    end
                end
            end
        end
    end
    return matched
end

PlayerTab:Input({
    Title = "Cài Đặt Tốc Độ Chạy (Speed)",
    Icon = "speedometer",
    Placeholder = "Mặc định: 1500",
    Value = "1500",
    Callback = function(input)
        local val = tonumber(input)
        if not val or val < 100 then return end
        for _, tableObj in ipairs(getMovementTables()) do
            pcall(function() tableObj.Speed = val end)
        end
    end
})

PlayerTab:Input({
    Title = "Giới Hạn Nhảy (Jump Cap)",
    Icon = "chevrons-up",
    Placeholder = "Mặc định: 1",
    Value = "1",
    Callback = function(input)
        local val = tonumber(input)
        if not val or val < 0.1 then return end
        for _, tableObj in ipairs(getMovementTables()) do
            pcall(function() tableObj.JumpCap = val end)
        end
    end
})

PlayerTab:Input({
    Title = "Gia Tốc Lượn (Strafe Acceleration)",
    Icon = "wind",
    Placeholder = "Mặc định: 187",
    Value = "187",
    Callback = function(input)
        local val = tonumber(input)
        if not val or val < 1 then return end
        for _, tableObj in ipairs(getMovementTables()) do
            pcall(function() tableObj.AirStrafeAcceleration = val end)
        end
    end
})

PlayerTab:Divider()

getgenv().slideFrictionValue = -8

local function setSlideFriction(value)
    for _, tbl in ipairs(getMovementTables()) do
        pcall(function() tbl.Friction = value end)
    end
end

local function infiniteSlideHeartbeatFunc()
    if not getgenv().FeatureStates.InfiniteSlide then return end
    local char = LocalPlayer.Character
    if not char then return end
    local state = char:GetAttribute("State")
    if state == "Slide" or state == "EmotingSlide" then
        setSlideFriction(getgenv().slideFrictionValue)
    else
        setSlideFriction(5)
    end
end

local function setInfiniteSlide(enabled)
    getgenv().FeatureStates.InfiniteSlide = enabled
    if enabled then
        if getgenv().infiniteSlideHeartbeat then getgenv().infiniteSlideHeartbeat:Disconnect() end
        getgenv().infiniteSlideHeartbeat = RunService.Heartbeat:Connect(infiniteSlideHeartbeatFunc)
    else
        if getgenv().infiniteSlideHeartbeat then
            getgenv().infiniteSlideHeartbeat:Disconnect()
            getgenv().infiniteSlideHeartbeat = nil
        end
        setSlideFriction(5)
    end
end

PlayerTab:Toggle({
    Title = "Trượt Vô Hạn (Infinite Slide)",
    Value = false,
    Callback = function(state)
        setInfiniteSlide(state)
        if state and not getgenv().featureToggles["Inf Slide"] then
            getgenv().featureToggles["Inf Slide"] = createFeatureToggle("Inf Slide", state, 0.25, function(newState)
                setInfiniteSlide(newState)
            end)
        end
        if getgenv().featureToggles["Inf Slide"] then
            getgenv().featureToggles["Inf Slide"].Gui.Enabled = state
            if getgenv().featureToggles["Inf Slide"].UpdateState then
                getgenv().featureToggles["Inf Slide"].UpdateState(state)
            end
        end
    end
})

PlayerTab:Input({
    Title = "Độ Ma Sát Trượt (Slide Friction)",
    Desc = "Chỉ nhập số âm để trượt nhanh hơn",
    Placeholder = "-8",
    NumbersOnly = true,
    Value = "-8",
    Callback = function(value)
        local num = tonumber(value)
        if num and num < 0 then
            getgenv().slideFrictionValue = num
            if getgenv().FeatureStates.InfiniteSlide then
                setSlideFriction(getgenv().slideFrictionValue)
            end
        end
    end
})

PlayerTab:Divider()

-- AutoTrimp
getgenv().AutoTrimpEnabled = false
getgenv().AutoTrimpSpeed = 50
getgenv().maxExtraSpeed = 100
getgenv().lastTick = tick()
getgenv().airAccumulator = 0
getgenv().currentSpeed = getgenv().AutoTrimpSpeed
getgenv().AutoTrimpConnections = {}

local function handleAutoTrimp()
    local deltaTime = tick() - getgenv().lastTick
    getgenv().lastTick = tick()

    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not root or not humanoid then return end
    
    local isAir = humanoid.FloorMaterial == Enum.Material.Air
    
    if getgenv().AutoTrimpEnabled then
        if isAir then
            getgenv().airAccumulator = getgenv().airAccumulator + deltaTime
            while getgenv().airAccumulator >= 0.04 do
                getgenv().airAccumulator = getgenv().airAccumulator - 0.04
                getgenv().currentSpeed = math.min(getgenv().AutoTrimpSpeed + getgenv().maxExtraSpeed, getgenv().currentSpeed + 2.5)
            end
        else
            getgenv().airAccumulator = 0
            getgenv().currentSpeed = math.max(getgenv().AutoTrimpSpeed, getgenv().currentSpeed - 4 * deltaTime)
        end
        
        if getgenv().activeBV then 
            getgenv().activeBV:Destroy() 
            getgenv().activeBV = nil
        end
        
        local lookDir = Camera.CFrame.LookVector
        lookDir = Vector3.new(lookDir.X, 0, lookDir.Z)
        if lookDir.Magnitude > 0 then lookDir = lookDir.Unit end
        
        local bv = Instance.new("BodyVelocity")
        bv.Velocity = lookDir * getgenv().currentSpeed
        bv.MaxForce = Vector3.new(4e5, 0, 4e5)
        bv.P = 1250
        bv.Parent = root
        Debris:AddItem(bv, 0.1)
        getgenv().activeBV = bv
    else
        if getgenv().activeBV then 
            getgenv().activeBV:Destroy() 
            getgenv().activeBV = nil
        end
        getgenv().currentSpeed = getgenv().AutoTrimpSpeed
    end
end

PlayerTab:Toggle({
    Title = "Tự Động Trimp (AutoTrimp)",
    Value = false,
    Callback = function(state)
        getgenv().AutoTrimpEnabled = state
        if state then
            getgenv().AutoTrimpConnections["RenderStepped"] = RunService.RenderStepped:Connect(handleAutoTrimp)
            if not getgenv().featureToggles["AutoTrimp"] then
                getgenv().featureToggles["AutoTrimp"] = createFeatureToggle("AutoTrimp", state, 0.15, function(newState)
                    getgenv().AutoTrimpEnabled = newState
                end)
            end
        else
            for _, c in pairs(getgenv().AutoTrimpConnections) do c:Disconnect() end
            getgenv().AutoTrimpConnections = {}
            if getgenv().activeBV then getgenv().activeBV:Destroy() getgenv().activeBV = nil end
        end
        if getgenv().featureToggles["AutoTrimp"] then
            getgenv().featureToggles["AutoTrimp"].Gui.Enabled = state
        end
    end
})

PlayerTab:Input({
    Title = "Tốc Độ AutoTrimp",
    Placeholder = "Mặc định: 50",
    Value = "50",
    Callback = function(value)
        local num = tonumber(value)
        if num and num > 0 then
            getgenv().AutoTrimpSpeed = num
            getgenv().currentSpeed = num
        end
    end
})

PlayerTab:Divider()

-- Bhop
getgenv().bhopHoldActive = false
local LastJump = 0

local function updateBhop()
    local isBhopActive = getgenv().FeatureStates.BhopEnabled or getgenv().bhopHoldActive
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local root = char and char:FindFirstChild("HumanoidRootPart")

    if isBhopActive and hum and root then
        local now = tick()
        if hum.FloorMaterial ~= Enum.Material.Air and (now - LastJump) > 0.05 then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
            if getgenv().FeatureStates.BhopMode == "Acceleration" then
                pcall(function() setSlideFriction(getgenv().FeatureStates.BhopAccelValue or -0.1) end)
            end
            LastJump = now
        end
    end
end

UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.Space then
        getgenv().bhopHoldActive = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space then
        getgenv().bhopHoldActive = false
    end
end)

if getgenv().bhopConnection then getgenv().bhopConnection:Disconnect() end
getgenv().bhopConnection = RunService.Heartbeat:Connect(updateBhop)

PlayerTab:Toggle({
    Title = "Tự Động Nhảy (Bhop)",
    Value = false,
    Callback = function(state)
        getgenv().FeatureStates.BhopEnabled = state
        if state and not getgenv().featureToggles["Bhop"] then
            getgenv().featureToggles["Bhop"] = createFeatureToggle("Bhop", state, 0.3, function(newState)
                getgenv().FeatureStates.BhopEnabled = newState
            end)
        end
        if getgenv().featureToggles["Bhop"] then
            getgenv().featureToggles["Bhop"].Gui.Enabled = state
        end
    end
})

PlayerTab:Dropdown({
    Title = "Chế Độ Bhop",
    Values = {"Gia Tốc (Acceleration)", "Không Gia Tốc (Normal)"},
    Multi = false,
    Default = 1,
    Callback = function(value)
        getgenv().FeatureStates.BhopMode = (value:find("Gia Tốc") and "Acceleration" or "Normal")
    end
})

PlayerTab:Input({
    Title = "Hệ Số Gia Tốc Bhop (Số Âm)",
    Placeholder = "-0.1",
    Numeric = true,
    Callback = function(value)
        local num = tonumber(value)
        if num and num < 0 then
            getgenv().FeatureStates.BhopAccelValue = num
        end
    end
})

PlayerTab:Divider()

local emoteList = {
    "Default", "Baby Shark", "Billy Bounce", "California Gurls", "Catdance", "Club",
    "Coffin Dance", "Conga", "Distraction", "Floss", "Fresh", "Gangnam Style",
    "Griddy", "Groove", "Hype", "Kazotsky Kick", "Macarena", "Orange Justice",
    "Reanimated", "Rickroll", "Robot", "Russian Kick", "Salsa", "Smooth Criminal",
    "Spooky", "Take The L", "Thriller", "Torture Dance", "Vogue", "Waddle", "Zesty"
}

pcall(function()
    local emotesFolder = (ReplicatedStorage:FindFirstChild("Items") and ReplicatedStorage.Items:FindFirstChild("Emotes"))
        or (ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Items") and ReplicatedStorage.Assets.Items:FindFirstChild("Emotes"))
    if emotesFolder then
        for _, emote in ipairs(emotesFolder:GetChildren()) do
            local found = false
            for _, em in ipairs(emoteList) do if em == emote.Name then found = true break end end
            if not found then table.insert(emoteList, emote.Name) end
        end
    end
end)
table.sort(emoteList)

PlayerTab:Dropdown({
    Title = "Chọn Hoạt Ảnh (Emote)",
    Values = emoteList,
    Multi = false,
    Callback = function(option)
        getgenv().FeatureStates.SelectedEmote = option
    end
})

PlayerTab:Toggle({
    Title = "Kích Hoạt Hoạt Ảnh (Giữ Nút Crouch)",
    Default = false,
    Callback = function(state)
        getgenv().FeatureStates.EmoteEnabled = state
    end
})

local function findCrouchButton()
    for _, desc in ipairs(PlayerGui:GetDescendants()) do
        if desc:IsA("GuiButton") and (desc.Name:lower():find("crouch") or desc.Name:lower():find("slide")) then
            return desc
        end
    end
    return nil
end

task.spawn(function()
    while true do
        local btn = findCrouchButton()
        if btn then
            local holding = false
            local eTask = nil
            local cDown = btn.MouseButton1Down:Connect(function()
                holding = true
                eTask = task.delay(0.4, function()
                    if holding and getgenv().FeatureStates.EmoteEnabled and getgenv().FeatureStates.SelectedEmote then
                        playEmote(getgenv().FeatureStates.SelectedEmote)
                    end
                end)
            end)
            local cUp = btn.MouseButton1Up:Connect(function()
                holding = false
                if eTask then task.cancel(eTask) eTask = nil end
            end)
            repeat task.wait(1) until not btn.Parent
            pcall(function() cDown:Disconnect() end)
            pcall(function() cUp:Disconnect() end)
        end
        task.wait(1)
    end
end)

local function triggerLagSwitch()
    task.spawn(function()
        local start = tick()
        while tick() - start < getgenv().FeatureStates.LagDuration do
            for i = 1, 10000 do math.random(1, 1000000) end
        end
    end)
end

PlayerTab:Toggle({
    Title = "Công Tắc Lag (Lag Switch)",
    Icon = "zap",
    Default = false,
    Callback = function(state)
        getgenv().FeatureStates.LagSwitchEnabled = state
        if state then triggerLagSwitch() end
    end
})

PlayerTab:Input({
    Title = "Thời Gian Lag (Giây)",
    Default = tostring(getgenv().FeatureStates.LagDuration),
    Placeholder = "0.5",
    NumbersOnly = true,
    Callback = function(text)
        local n = tonumber(text)
        if n and n > 0 and n <= 10 then
            getgenv().FeatureStates.LagDuration = n
        end
    end
})

-- ====================================================================
-- TAB 3: TỰ ĐỘNG (AUTO)
-- ====================================================================
local function tryCarry(target)
    if not target then return end
    local username = (target.Player and target.Player.Name) or (target.Character and target.Character.Name) or target.Name
    local charModel = target.Character
    local remote = getInteractRemote()

    if remote then
        pcall(function() remote:FireServer("Carry", nil, username) end)
        pcall(function() remote:FireServer("Carry", true, username) end)
        pcall(function() remote:FireServer("Carry", false, username) end)
        pcall(function() remote:FireServer("Carry", username) end)
        if charModel then
            pcall(function() remote:FireServer("Carry", nil, charModel) end)
            pcall(function() remote:FireServer("Carry", true, charModel) end)
            pcall(function() remote:FireServer("Carry", charModel) end)
            pcall(function() remote:FireServer(charModel) end)
        end
        if target.Player then
            pcall(function() remote:FireServer("Carry", nil, target.Player) end)
            pcall(function() remote:FireServer("Carry", target.Player) end)
        end
    end

    if charModel then
        for _, p in ipairs(charModel:GetDescendants()) do
            if p:IsA("ProximityPrompt") then
                pcall(function()
                    if fireproximityprompt then
                        fireproximityprompt(p, 0)
                        fireproximityprompt(p)
                    end
                    p:InputHoldBegin()
                    task.delay(0.04, function() pcall(function() p:InputHoldEnd() end) end)
                end)
            end
        end
    end

    pcall(function()
        if ReplicatedStorage:FindFirstChild("Services") and ReplicatedStorage.Services:FindFirstChild("Asset") and ReplicatedStorage.Services.Asset:FindFirstChild("InteractionService") and ReplicatedStorage.Services.Asset.InteractionService:FindFirstChild("Event") then
            ReplicatedStorage.Services.Asset.InteractionService.Event:Fire("Carry", charModel or username)
        end
        if ReplicatedStorage:FindFirstChild("Services") and ReplicatedStorage.Services:FindFirstChild("Client") and ReplicatedStorage.Services.Client:FindFirstChild("KeybindService") and ReplicatedStorage.Services.Client.KeybindService:FindFirstChild("SendKeybindEvent") then
            ReplicatedStorage.Services.Client.KeybindService.SendKeybindEvent:Fire("Interact", true)
        end
    end)
end

local autoCarryRunning = false
local function startAutoCarry()
    if autoCarryRunning then return end
    autoCarryRunning = true
    task.spawn(function()
        while getgenv().FeatureStates.AutoCarry do
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, target in ipairs(getAllTargets()) do
                    if isTargetDowned(target) and target.RootPart then
                        local dist = (hrp.Position - target.RootPart.Position).Magnitude
                        if dist <= 28 then
                            tryCarry(target)
                        end
                    end
                end
            end
            task.wait(0.1)
        end
        autoCarryRunning = false
    end)
end

AutoTab:Toggle({
    Title = "Tự Động Vác Người (Auto Carry)",
    Value = false,
    Callback = function(state)
        getgenv().FeatureStates.AutoCarry = state
        if state then
            startAutoCarry()
        end
    end
})

AutoTab:Divider()

local function tryRevive(target)
    if not target then return end
    local username = (target.Player and target.Player.Name) or (target.Character and target.Character.Name) or target.Name
    local charModel = target.Character
    local remote = getInteractRemote()

    if remote then
        pcall(function() remote:FireServer("Revive", true, username) end)
        pcall(function() remote:FireServer("Revive", false, username) end)
        pcall(function() remote:FireServer("Revive", username) end)
        if charModel then
            pcall(function() remote:FireServer("Revive", true, charModel) end)
            pcall(function() remote:FireServer("Revive", false, charModel) end)
            pcall(function() remote:FireServer("Revive", charModel) end)
            pcall(function() remote:FireServer(charModel) end)
        end
        if target.Player then
            pcall(function() remote:FireServer("Revive", true, target.Player) end)
            pcall(function() remote:FireServer("Revive", target.Player) end)
        end
        pcall(function() remote:FireServer(username) end)
    end

    if charModel then
        for _, p in ipairs(charModel:GetDescendants()) do
            if p:IsA("ProximityPrompt") then
                pcall(function()
                    if fireproximityprompt then
                        fireproximityprompt(p, 0)
                        fireproximityprompt(p)
                    end
                    p:InputHoldBegin()
                    task.delay(0.04, function() pcall(function() p:InputHoldEnd() end) end)
                end)
            end
        end
    end

    pcall(function()
        local vim = game:GetService("VirtualInputManager")
        vim:SendKeyEvent(true, Enum.KeyCode.E, false, game)
        task.delay(0.04, function()
            pcall(function() vim:SendKeyEvent(false, Enum.KeyCode.E, false, game) end)
        end)
    end)

    pcall(function()
        if ReplicatedStorage:FindFirstChild("Services") and ReplicatedStorage.Services:FindFirstChild("Asset") and ReplicatedStorage.Services.Asset:FindFirstChild("InteractionService") and ReplicatedStorage.Services.Asset.InteractionService:FindFirstChild("Event") then
            ReplicatedStorage.Services.Asset.InteractionService.Event:Fire("Revive", charModel or username)
        end
        if ReplicatedStorage:FindFirstChild("Services") and ReplicatedStorage.Services:FindFirstChild("Client") and ReplicatedStorage.Services.Client:FindFirstChild("KeybindService") and ReplicatedStorage.Services.Client.KeybindService:FindFirstChild("SendKeybindEvent") then
            ReplicatedStorage.Services.Client.KeybindService.SendKeybindEvent:Fire("Interact", true)
        end
    end)
end

local instantReviveRunning = false
local function startInstantRevive()
    if instantReviveRunning then return end
    instantReviveRunning = true
    task.spawn(function()
        while getgenv().InstantReviveEnabled do
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, target in ipairs(getAllTargets()) do
                    if isTargetDowned(target) and target.RootPart then
                        local dist = (hrp.Position - target.RootPart.Position).Magnitude
                        if dist <= 30 then
                            tryRevive(target)
                        end
                    end
                end
            end
            local delaySec = tonumber(getgenv().FeatureStates.InstantReviveDelay) or 0.15
            task.wait(math.clamp(delaySec, 0.05, 1))
        end
        instantReviveRunning = false
    end)
end

AutoTab:Toggle({
    Title = "Hồi Sinh Cấp Tốc Đồng Đội Gần (Instant Revive)",
    Value = false,
    Callback = function(state)
        getgenv().InstantReviveEnabled = state
        getgenv().FeatureStates.InstantReviveEnabled = state
        if state then
            startInstantRevive()
        end
    end
})

AutoTab:Slider({
    Title = "Độ Trễ Hồi Sinh (Giây)",
    Desc = "Thời gian nghỉ giữa các lần cứu",
    Value = { Min = 0.05, Max = 1, Default = 0.15 },
    Callback = function(value)
        getgenv().FeatureStates.InstantReviveDelay = value
    end
})

AutoTab:Divider()

local lastSavedPosition = nil
local isRevivingSelf = false

local function performSelfRevive()
    if isRevivingSelf then return end
    isRevivingSelf = true

    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hrp then
        lastSavedPosition = hrp.CFrame
    end

    local remote = getInteractRemote()
    if remote then
        pcall(function() remote:FireServer("Revive", true, LocalPlayer.Name) end)
        pcall(function() remote:FireServer("Revive", false, LocalPlayer.Name) end)
        pcall(function() remote:FireServer("Revive", LocalPlayer.Name) end)
        if char then
            pcall(function() remote:FireServer("Revive", true, char) end)
            pcall(function() remote:FireServer("Revive", char) end)
            pcall(function() remote:FireServer(char) end)
        end
    end

    if char then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("ProximityPrompt") then
                pcall(function()
                    if fireproximityprompt then
                        fireproximityprompt(p, 0)
                        fireproximityprompt(p)
                    end
                    p:InputHoldBegin()
                    task.delay(0.04, function() pcall(function() p:InputHoldEnd() end) end)
                end)
            end
        end
    end

    triggerRespawnButton()

    task.spawn(function()
        task.wait(0.3)
        if isLocalPlayerDowned() then
            pcall(function()
                if hum then
                    hum.Health = 0
                    hum:ChangeState(Enum.HumanoidStateType.Dead)
                end
                if char then char:BreakJoints() end
            end)
            for i = 1, 15 do
                triggerRespawnButton()
                task.wait(0.15)
                if not isLocalPlayerDowned() then break end
            end
        end

        if getgenv().FeatureStates.SelfReviveMethod == "Fake Revive" and lastSavedPosition then
            local attempts = 0
            while attempts < 40 do
                task.wait(0.1)
                attempts = attempts + 1
                local newChar = LocalPlayer.Character
                local newHRP = newChar and newChar:FindFirstChild("HumanoidRootPart")
                if newHRP and not isLocalPlayerDowned() then
                    newHRP.CFrame = lastSavedPosition + Vector3.new(0, 3, 0)
                    break
                end
            end
        end

        lastSavedPosition = nil
        isRevivingSelf = false
    end)
end

task.spawn(function()
    while true do
        if getgenv().FeatureStates.AutoSelfRevive and not isRevivingSelf then
            if isLocalPlayerDowned() then
                performSelfRevive()
            end
        end
        task.wait(0.3)
    end
end)

AutoTab:Toggle({
    Title = "Tự Động Hồi Sinh Bản Thân (Auto Self Revive)",
    Value = false,
    Callback = function(state)
        getgenv().FeatureStates.AutoSelfRevive = state
    end
})

AutoTab:Dropdown({
    Title = "Phương Thức Hồi Sinh",
    Values = {"Về Điểm Xuất Phát (Spawnpoint)", "Hồi Sinh Tại Chỗ (Fake Revive)"},
    Value = "Về Điểm Xuất Phát (Spawnpoint)",
    Callback = function(value)
        getgenv().FeatureStates.SelfReviveMethod = (value:find("Fake Revive") and "Fake Revive" or "Spawnpoint")
    end
})

AutoTab:Button({
    Title = "Hồi Sinh Bản Thân Ngay Lập Tức",
    Desc = "Bấm để hồi sinh ngay khi đang bị ngã hoặc chết",
    Icon = "heart",
    Callback = function()
        performSelfRevive()
    end
})

AutoTab:Divider()

local virtualUser = game:GetService("VirtualUser")

local function startAntiAFK()
    if getgenv().AntiAFK and getgenv().AntiAFK.Connection then
        getgenv().AntiAFK.Connection:Disconnect()
    end
    getgenv().AntiAFK = {
        Enabled = true,
        Connection = LocalPlayer.Idled:Connect(function()
            pcall(function()
                virtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                task.wait(1)
                virtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            end)
        end)
    }
end

AutoTab:Toggle({
    Title = "Chống Bị Kick Khi Treo Máy (Anti AFK)",
    Desc = "Không bị đẩy khỏi phòng khi không hoạt động quá 20 phút",
    Value = true,
    Callback = function(state)
        getgenv().FeatureStates.AntiAFK = state
        if state then startAntiAFK() else
            if getgenv().AntiAFK and getgenv().AntiAFK.Connection then
                getgenv().AntiAFK.Connection:Disconnect()
            end
        end
    end
})

if getgenv().FeatureStates.AntiAFK then startAntiAFK() end

AutoTab:Divider()

getgenv().AutoTicketFarmConnection = nil

local function startAutoTicketFarm()
    local secPart = getSecurityPart()
    if getgenv().AutoTicketFarmConnection then getgenv().AutoTicketFarmConnection:Disconnect() end

    getgenv().AutoTicketFarmConnection = RunService.Heartbeat:Connect(function()
        if not getgenv().FeatureStates.AutoTicketFarm then return end
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        if isLocalPlayerDowned() then
            performSelfRevive()
            hrp.CFrame = secPart.CFrame + Vector3.new(0, 3, 0)
            return
        end

        local tickets = getAllTicketTargets()
        if #tickets > 0 then
            hrp.CFrame = CFrame.new(tickets[1].RootPart.Position)
        else
            hrp.CFrame = secPart.CFrame + Vector3.new(0, 3, 0)
        end
    end)
end

AutoTab:Toggle({
    Title = "Tự Động Nhặt Vé Sự Kiện (Auto Ticket Farm)",
    Desc = "Dịch chuyển nhặt tất cả vé và về vùng an toàn",
    Value = false,
    Callback = function(state)
        getgenv().FeatureStates.AutoTicketFarm = state
        if state then
            startAutoTicketFarm()
        else
            if getgenv().AutoTicketFarmConnection then
                getgenv().AutoTicketFarmConnection:Disconnect()
                getgenv().AutoTicketFarmConnection = nil
            end
        end
    end
})

getgenv().AutoMoneyFarmConnection = nil

local function startAutoMoneyFarm()
    local secPart = getSecurityPart()
    if getgenv().AutoMoneyFarmConnection then getgenv().AutoMoneyFarmConnection:Disconnect() end

    getgenv().AutoMoneyFarmConnection = RunService.Heartbeat:Connect(function()
        if not getgenv().FeatureStates.AutoMoneyFarm then return end
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        if isLocalPlayerDowned() then
            performSelfRevive()
            task.wait(1)
            return
        end

        local downedTarget = nil
        for _, t in ipairs(getAllTargets()) do
            if isTargetDowned(t) and t.RootPart then
                downedTarget = t
                break
            end
        end

        if downedTarget then
            hrp.CFrame = downedTarget.RootPart.CFrame + Vector3.new(0, 3, 0)
            tryRevive(downedTarget)
            task.wait(0.2)
        else
            if (hrp.Position - secPart.Position).Magnitude > 20 then
                hrp.CFrame = secPart.CFrame + Vector3.new(0, 3, 0)
            end
        end
    end)
end

AutoTab:Toggle({
    Title = "Tự Động Cứu Người Kiếm Tiền (Auto Money Farm)",
    Desc = "Dịch chuyển cứu người chơi ngã để nhận thưởng rồi về vùng an toàn",
    Value = false,
    Callback = function(state)
        getgenv().FeatureStates.AutoMoneyFarm = state
        if state then
            startAutoMoneyFarm()
        else
            if getgenv().AutoMoneyFarmConnection then
                getgenv().AutoMoneyFarmConnection:Disconnect()
                getgenv().AutoMoneyFarmConnection = nil
            end
        end
    end
})

-- ====================================================================
-- TAB 4: TỐI ƯU FPS (FPS)
-- ====================================================================
FPSTab:Button({  
    Title = "Giảm Tầm Tải Bản Đồ (LowerChunks)",  
    Description = "Giảm bán kính streaming để tăng FPS",  
    Callback = function()  
        pcall(function()
            workspace.StreamingMinRadius = 200  
            workspace.StreamingTargetRadius = 500  
        end)
    end  
})  

FPSTab:Button({  
    Title = "Tắt Giới Hạn Khung Hình (DisableVSync)",  
    Callback = function() pcall(function() setfpscap(9999) end) end  
})  

FPSTab:Button({  
    Title = "Mở Khóa FPS Tối Đa (SetFpsCapMax)",  
    Callback = function() pcall(function() setfpscap(99999) end) end  
})  

FPSTab:Button({  
    Title = "Ẩn Bầu Trời (HideSkybox)",  
    Callback = function()  
        pcall(function()
            for _, v in pairs(game.Lighting:GetChildren()) do
                if v:IsA("Sky") then v:Destroy() end
            end
        end)
    end  
})  

FPSTab:Button({  
    Title = "Tắt Đổ Bóng (DisableShadows)",  
    Callback = function()  
        pcall(function()
            game.Lighting.GlobalShadows = false
            for _, part in pairs(workspace:GetDescendants()) do  
                if part:IsA("BasePart") then part.CastShadow = false end  
            end  
        end)
    end  
})  

FPSTab:Button({  
    Title = "Chất Lượng Đồ Họa Cực Thấp (SetLowGraphics)",  
    Callback = function() pcall(function() settings().Rendering.QualityLevel = 1 end) end  
})  

FPSTab:Button({  
    Title = "Xóa Mọi Hiệu Ứng Hạt (DisableParticles)",  
    Callback = function()  
        for _, particle in pairs(workspace:GetDescendants()) do  
            if particle:IsA("ParticleEmitter") then particle:Destroy() end  
        end  
    end  
})  

FPSTab:Button({  
    Title = "Chỉnh Trời Tối (Night 00:00)",  
    Callback = function() pcall(function() game.Lighting.TimeOfDay = "00:00:00" end) end  
})  

FPSTab:Button({  
    Title = "Chỉnh Trời Sáng (Day 08:00)",  
    Callback = function() pcall(function() game.Lighting.TimeOfDay = "08:00:00" end) end  
})  

FPSTab:Button({  
    Title = "Xóa Sương Mù (AntiFog)",  
    Callback = function()  
        pcall(function()
            game.Lighting.FogStart = 1e5  
            game.Lighting.FogEnd = 1e6  
        end)
    end  
})  

FPSTab:Button({  
    Title = "Chế Độ Đơn Sắc Nhẹ (LowPolyMode)",  
    Callback = function()  
        for _, p in pairs(workspace:GetDescendants()) do  
            if p:IsA("MeshPart") or p:IsA("UnionOperation") then  
                pcall(function()
                    p.Material = Enum.Material.Plastic  
                    p.RenderFidelity = Enum.RenderFidelity.Performance  
                end)
            end  
        end  
    end  
})  

FPSTab:Toggle({
    Title = "Bật Siêu Sáng (Full Bright)",
    Desc = "Làm sáng toàn bộ bản đồ không sợ góc tối",
    Callback = function()
        pcall(function()
            local L = game:GetService("Lighting")
            L.Ambient = Color3.new(1,1,1)
            L.OutdoorAmbient = Color3.new(1,1,1)
            L.Brightness = 3
            L.ExposureCompensation = 1
            L.GlobalShadows = false
        end)
    end
})

FPSTab:Button({
    Title = "Dọn Dẹp Và Giảm Lag Tổng Lực (Fix Lag & Optimize)",
    Desc = "Dọn rác, làm mượt vật thể và tối ưu đường truyền",
    Icon = "zap",
    Callback = function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                pcall(function()
                    obj.Material = Enum.Material.SmoothPlastic
                    obj.Reflectance = 0
                    obj.CastShadow = false
                end)
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                pcall(function() obj.Enabled = false end)
            end
        end
        WindUI:Notify({
            Title = "Thành Công",
            Content = "Đã dọn dẹp và tối ưu hóa FPS toàn diện!",
            Duration = 3
        })
    end
})

FPSTab:Toggle({
    Title = "Tăng Tốc FPS Cực Hạn (FPS Boost)",
    Desc = "Tắt dựng hình 3D tạm thời để đạt tốc độ khung hình cao nhất",
    Default = false,
    Callback = function(state)
        pcall(function()
            RunService:Set3dRenderingEnabled(not state)
            UserSettings():GetService("UserGameSettings"):SetQualityLevel(state and 1 or 5)
        end)
    end
})

-- ====================================================================
-- TAB 5: ESP & ĐỊNH VỊ (ESP)
-- ====================================================================
getgenv().espObjects = getgenv().espObjects or {}

local function createESP(part, titleText, baseColor)
    if getgenv().espObjects[part] then return getgenv().espObjects[part] end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "KhoaDevESP"
    billboard.Adornee = part
    billboard.Size = UDim2.new(0, 200, 0, 45)
    billboard.StudsOffset = Vector3.new(0, 3.5, 0)
    billboard.AlwaysOnTop = true
    billboard.LightInfluence = 0
    billboard.MaxDistance = 5000
    billboard.Parent = PlayerGui
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextStrokeTransparency = 0
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.Text = titleText or ""
    label.TextColor3 = baseColor or Color3.fromRGB(255, 255, 255)
    label.Parent = billboard
    
    getgenv().espObjects[part] = {billboard = billboard, label = label}
    return getgenv().espObjects[part]
end

local function cleanupAllESP()
    for part, data in pairs(getgenv().espObjects) do
        if data and data.billboard then
            pcall(function() data.billboard:Destroy() end)
        end
    end
    getgenv().espObjects = {}
end

EspTab:Toggle({
    Title = "ESP Người Chơi (Esp Player)",
    Value = false,
    Callback = function(state)
        getgenv().FeatureStates.EspPlayer = state
        if not state then cleanupAllESP() end
    end
})

EspTab:Toggle({
    Title = "ESP Vé Sự Kiện (Esp Ticket)",
    Value = false,
    Callback = function(state)
        getgenv().FeatureStates.EspTicket = state
        if not state then cleanupAllESP() end
    end
})

EspTab:Toggle({
    Title = "ESP Quái (Esp Nextbot)",
    Value = false,
    Callback = function(state)
        getgenv().FeatureStates.EspNextbot = state
        if not state then cleanupAllESP() end
    end
})

getgenv().tracerLines = getgenv().tracerLines or {}
getgenv().tracerBeams = getgenv().tracerBeams or {}
getgenv().tracerHighlights = getgenv().tracerHighlights or {}

local function cleanupTracers()
    for _, l in pairs(getgenv().tracerLines) do
        pcall(function() l:Remove() end)
    end
    getgenv().tracerLines = {}

    for _, b in pairs(getgenv().tracerBeams) do
        pcall(function() b:Destroy() end)
    end
    getgenv().tracerBeams = {}

    for _, h in pairs(getgenv().tracerHighlights) do
        pcall(function() h:Destroy() end)
    end
    getgenv().tracerHighlights = {}
end

EspTab:Toggle({
    Title = "Đường Kẻ Đến Người Gục (Tracer Downed Players)",
    Value = false,
    Callback = function(state)
        getgenv().FeatureStates.TracerDowned = state
        if not state then cleanupTracers() end
    end
})

task.spawn(function()
    while true do
        local myChar = LocalPlayer.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")

        if getgenv().FeatureStates.EspPlayer and myRoot then
            for _, t in ipairs(getAllTargets()) do
                if t.RootPart then
                    local esp = getgenv().espObjects[t.RootPart] or createESP(t.RootPart, t.DisplayName or t.Name, Color3.fromRGB(100, 255, 100))
                    if esp and esp.label then
                        local dist = math.floor((myRoot.Position - t.RootPart.Position).Magnitude)
                        local downed = isTargetDowned(t)
                        if downed then
                            esp.label.Text = string.format("[ĐÃ GỤC] %s\n%d mét", t.DisplayName or t.Name, dist)
                            esp.label.TextColor3 = Color3.fromRGB(255, 50, 50)
                        else
                            esp.label.Text = string.format("%s\n%d mét", t.DisplayName or t.Name, dist)
                            esp.label.TextColor3 = Color3.fromRGB(100, 255, 100)
                        end
                    end
                end
            end
        end

        if getgenv().FeatureStates.EspNextbot and myRoot then
            for _, b in ipairs(getAllNextbotTargets()) do
                if b.RootPart then
                    local esp = getgenv().espObjects[b.RootPart] or createESP(b.RootPart, b.Name, Color3.fromRGB(255, 0, 255))
                    if esp and esp.label then
                        local dist = math.floor((myRoot.Position - b.RootPart.Position).Magnitude)
                        esp.label.Text = string.format("[NEXTBOT] %s\n%d mét", b.Name, dist)
                        esp.label.TextColor3 = (dist <= 60 and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 100, 255))
                    end
                end
            end
        end

        if getgenv().FeatureStates.EspTicket and myRoot then
            for _, tk in ipairs(getAllTicketTargets()) do
                if tk.RootPart then
                    local esp = getgenv().espObjects[tk.RootPart] or createESP(tk.RootPart, tk.Name, Color3.fromRGB(255, 255, 0))
                    if esp and esp.label then
                        local dist = math.floor((myRoot.Position - tk.RootPart.Position).Magnitude)
                        esp.label.Text = string.format("[VÉ] %s\n%d mét", tk.Name, dist)
                        esp.label.TextColor3 = Color3.fromRGB(255, 255, 0)
                    end
                end
            end
        end

        task.wait(0.3)
    end
end)

RunService.RenderStepped:Connect(function()
    if getgenv().FeatureStates.TracerDowned then
        local myChar = LocalPlayer.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then
            cleanupTracers()
            return
        end

        local myOriginAtt = myRoot:FindFirstChild("KhoaDevTracerOrigin")
        if not myOriginAtt then
            myOriginAtt = Instance.new("Attachment")
            myOriginAtt.Name = "KhoaDevTracerOrigin"
            myOriginAtt.Parent = myRoot
        end

        local activeDownedParts = {}

        for _, t in ipairs(getAllTargets()) do
            if isTargetDowned(t) and t.RootPart then
                activeDownedParts[t.RootPart] = true

                -- 1. Dual-engine 3D Beam Tracer (100% tương thích mọi executor)
                local targetAtt = t.RootPart:FindFirstChild("KhoaDevDownedAtt")
                if not targetAtt then
                    targetAtt = Instance.new("Attachment")
                    targetAtt.Name = "KhoaDevDownedAtt"
                    targetAtt.Parent = t.RootPart
                end

                local beam = getgenv().tracerBeams[t.RootPart]
                if not beam or not beam.Parent then
                    beam = Instance.new("Beam")
                    beam.Name = "KhoaDevTracerBeam"
                    beam.Color = ColorSequence.new(Color3.fromRGB(255, 35, 35))
                    beam.Width0 = 0.25
                    beam.Width1 = 0.25
                    beam.FaceCamera = true
                    beam.Segments = 1
                    beam.LightEmission = 1
                    beam.LightInfluence = 0
                    beam.Transparency = NumberSequence.new(0)
                    beam.Attachment0 = myOriginAtt
                    beam.Attachment1 = targetAtt
                    beam.Parent = myRoot
                    getgenv().tracerBeams[t.RootPart] = beam
                else
                    beam.Attachment0 = myOriginAtt
                    beam.Attachment1 = targetAtt
                    beam.Enabled = true
                end

                -- 3D Highlight trên người đồng đội gục
                if t.Character then
                    local hl = getgenv().tracerHighlights[t.Character]
                    if not hl or not hl.Parent then
                        hl = Instance.new("Highlight")
                        hl.Name = "KhoaDevDownedHL"
                        hl.FillColor = Color3.fromRGB(255, 35, 35)
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        hl.FillTransparency = 0.35
                        hl.OutlineTransparency = 0
                        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        hl.Adornee = t.Character
                        hl.Parent = t.Character
                        getgenv().tracerHighlights[t.Character] = hl
                    else
                        hl.Enabled = true
                    end
                end

                -- 2. 2D Drawing Tracer (Dành cho executor hỗ trợ Drawing API)
                if Camera and Drawing and Drawing.new then
                    local pos, onScreen = Camera:WorldToViewportPoint(t.RootPart.Position)
                    local line = getgenv().tracerLines[t.RootPart]
                    if onScreen then
                        if not line then
                            pcall(function()
                                line = Drawing.new("Line")
                                line.Color = Color3.fromRGB(255, 40, 40)
                                line.Thickness = 2
                                line.Transparency = 1
                                line.ZIndex = 999
                                getgenv().tracerLines[t.RootPart] = line
                            end)
                        end
                        if line then
                            line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                            line.To = Vector2.new(pos.X, pos.Y)
                            line.Visible = true
                        end
                    else
                        if line then line.Visible = false end
                    end
                end
            end
        end

        -- Dọn dẹp những người không còn gục
        for part, beam in pairs(getgenv().tracerBeams) do
            if not activeDownedParts[part] then
                pcall(function() beam:Destroy() end)
                getgenv().tracerBeams[part] = nil
            end
        end
        for part, line in pairs(getgenv().tracerLines) do
            if not activeDownedParts[part] then
                pcall(function() line:Remove() end)
                getgenv().tracerLines[part] = nil
            end
        end
    else
        if next(getgenv().tracerBeams) or next(getgenv().tracerLines) or next(getgenv().tracerHighlights) then
            cleanupTracers()
        end
    end
end)

-- ====================================================================
-- TAB 6: HÌNH ẢNH & HIỆU ỨNG (VISUAL)
-- ====================================================================
getgenv().GameTimerUI = {
    Enabled = false,
    ScreenGui = nil,
    StartTime = tick()
}

local function formatTime(seconds)
    local minutes = math.floor(seconds / 60)
    local secs = math.floor(seconds % 60)
    return string.format("%02d:%02d", minutes, secs)
end

local function createTimerUI()
    if getgenv().GameTimerUI.ScreenGui then
        pcall(function() getgenv().GameTimerUI.ScreenGui:Destroy() end)
    end
    
    local sGui = Instance.new("ScreenGui")
    sGui.Name = "KhoaDevTimerUI"
    sGui.Parent = PlayerGui
    sGui.Enabled = getgenv().GameTimerUI.Enabled
    
    local timeLabel = Instance.new("TextLabel")
    timeLabel.Name = "TimeLabel"
    timeLabel.Size = UDim2.new(0, 180, 0, 35)
    timeLabel.Position = UDim2.new(0.02, 0, 0.02, 0)
    timeLabel.BackgroundTransparency = 1
    timeLabel.Text = "Thời gian: 0"
    timeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    timeLabel.TextSize = 16
    timeLabel.Font = Enum.Font.GothamBold
    timeLabel.TextXAlignment = Enum.TextXAlignment.Left
    timeLabel.Parent = sGui

    local clientLabel = Instance.new("TextLabel")
    clientLabel.Name = "ClientLabel"
    clientLabel.Size = UDim2.new(0, 180, 0, 35)
    clientLabel.Position = UDim2.new(0.02, 0, 0.06, 0)
    clientLabel.BackgroundTransparency = 1
    clientLabel.Text = "Đã chơi: 00:00"
    clientLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
    clientLabel.TextSize = 16
    clientLabel.Font = Enum.Font.GothamBold
    clientLabel.TextXAlignment = Enum.TextXAlignment.Left
    clientLabel.Parent = sGui
    
    getgenv().GameTimerUI.ScreenGui = sGui
    getgenv().GameTimerUI.StartTime = tick()
end

createTimerUI()

RunService.Heartbeat:Connect(function()
    if getgenv().GameTimerUI.ScreenGui and getgenv().GameTimerUI.ScreenGui.Enabled then
        local tLbl = getgenv().GameTimerUI.ScreenGui:FindFirstChild("TimeLabel")
        local cLbl = getgenv().GameTimerUI.ScreenGui:FindFirstChild("ClientLabel")
        if tLbl and cLbl then
            local tVal = nil
            local statsF = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Stats")
            if statsF then tVal = statsF:GetAttribute("Timer") end
            tLbl.Text = "Thời gian ván: " .. (tVal and tostring(math.floor(tVal)) or "0")
            cLbl.Text = "Thời gian chơi: " .. formatTime(tick() - getgenv().GameTimerUI.StartTime)
        end
    end
end)

VisualTab:Toggle({
    Title = "Hiển Thị Đồng Hồ Trận Đấu (Game Timer)",
    Value = false,
    Callback = function(state)
        getgenv().GameTimerUI.Enabled = state
        if getgenv().GameTimerUI.ScreenGui then
            getgenv().GameTimerUI.ScreenGui.Enabled = state
        end
    end
})

getgenv().CustomFOV = 70
getgenv().CustomFOVEnabled = false

pcall(function()
    RunService:BindToRenderStep("KhoaDevFOVOverride", Enum.RenderPriority.Camera.Value + 10, function()
        if getgenv().CustomFOVEnabled and getgenv().CustomFOV then
            local cam = workspace.CurrentCamera
            if cam and cam.FieldOfView ~= getgenv().CustomFOV then
                cam.FieldOfView = getgenv().CustomFOV
            end
        end
    end)
end)

VisualTab:Toggle({
    Title = "Bật Góc Nhìn Tùy Chỉnh (Custom FOV)",
    Desc = "Khóa góc nhìn camera không bị game tự động đặt lại",
    Value = false,
    Callback = function(state)
        getgenv().CustomFOVEnabled = state
        if not state then
            pcall(function()
                if workspace.CurrentCamera then
                    workspace.CurrentCamera.FieldOfView = 70
                end
            end)
        end
    end
})

VisualTab:Slider({
    Title = "Góc Nhìn Camera (Field of View)",
    Desc = "Mở rộng hoặc thu nhỏ tầm nhìn (30 - 140)",
    Value = { Min = 30, Max = 140, Default = 70 },
    Callback = function(value)
        local num = tonumber(value)
        if num then
            getgenv().CustomFOV = num
            if getgenv().CustomFOVEnabled and workspace.CurrentCamera then
                pcall(function() workspace.CurrentCamera.FieldOfView = num end)
            end
        end
    end
})

VisualTab:Divider()

VisualTab:Input({
    Title = "Phát Nhạc Theo ID Roblox",
    Desc = "Nhập ID âm thanh để phát nhạc",
    Placeholder = "Ví dụ: 1837532419",
    Callback = function(musicId)
        if musicId == "" or not tonumber(musicId) then return end
        for _, child in pairs(workspace:GetChildren()) do
            if child:IsA("Sound") and child.Name == "KhoaDevMusic" then
                child:Stop()
                child:Destroy()
            end
        end
        local sound = Instance.new("Sound")
        sound.Name = "KhoaDevMusic"
        sound.Parent = workspace
        sound.SoundId = "rbxassetid://" .. musicId
        sound.Volume = 2
        sound.Looped = true
        sound:Play()
    end
})

VisualTab:Button({
    Title = "Dừng Nhạc Đang Phát",
    Callback = function()
        for _, child in pairs(workspace:GetChildren()) do
            if child:IsA("Sound") and child.Name == "KhoaDevMusic" then
                child:Stop()
                child:Destroy()
            end
        end
    end
})

VisualTab:Toggle({
    Title = "Mở Khóa Khung Battlepass (Bypass)",
    Value = false,
    Callback = function(state)
        pcall(function()
            local menu = LocalPlayer.PlayerGui:FindFirstChild("Menu")
            if menu then
                local bp = menu:FindFirstChild("Views") and menu.Views:FindFirstChild("Battlepass")
                if bp then
                    for _, desc in ipairs(bp:GetDescendants()) do
                        if desc.Name == "Unlocked" and desc:IsA("GuiObject") then
                            desc.Visible = not state
                        end
                    end
                end
            end
        end)
    end
})

VisualTab:Divider()

VisualTab:Toggle({
    Title = "Kéo Giãn Màn Hình (Screen Stretch)",
    Value = false,
    Callback = function(state)
        getgenv().ScreenStretchEnabled = state
        if state then
            if not getgenv().ScreenStretchConn then
                getgenv().ScreenStretchConn = RunService.RenderStepped:Connect(function()
                    if Camera and getgenv().ScreenStretchEnabled then
                        Camera.CFrame = Camera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.65, 0, 0, 0, 1)
                    end
                end)
            end
        else
            if getgenv().ScreenStretchConn then
                getgenv().ScreenStretchConn:Disconnect()
                getgenv().ScreenStretchConn = nil
            end
        end
    end
})

VisualTab:Toggle({
    Title = "Sửa Lỗi Hoạt Ảnh Cola / Uống Nước",
    Value = false,
    Callback = function(state)
        if state then
            local toolRemote = getToolActionRemote()
            if toolRemote then
                pcall(function() toolRemote:FireServer(0, 19) end)
            end
        end
    end
})

VisualTab:Input({
    Title = "Đặt Chuỗi Thắng Giả (Fake Streak)",
    Placeholder = "Ví dụ: 100",
    Callback = function(value)
        local num = tonumber(value)
        if num then
            pcall(function()
                LocalPlayer:SetAttribute("Streak", num)
                WindUI:Notify({
                    Title = "Chuỗi Thắng",
                    Content = string.format("Đã đặt chuỗi thắng hiển thị thành %d!", num),
                    Duration = 3
                })
            end)
        end
    end
})

-- ====================================================================
-- TAB 7: CÀI ĐẶT (SETTINGS)
-- ====================================================================
SettingsTab:Section({Title = "Giao Diện & Hệ Thống"})

local themeValues = {}
for name, _ in pairs(getgenv().WindUI:GetThemes()) do
    table.insert(themeValues, name)
end

SettingsTab:Dropdown({
    Title = "Chọn Giao Diện (Theme)",
    Multi = false,
    AllowNone = false,
    Values = themeValues,
    Callback = function(theme)
        getgenv().WindUI:SetTheme(theme)
    end
})

SettingsTab:Toggle({
    Title = "Bật/Tắt Trong Suốt Menu",
    Callback = function(e)
        pcall(function() Window:ToggleTransparency(e) end)
    end,
    Value = getgenv().WindUI:GetTransparency()
})

pcall(function()
    local ConfigManager = Window.ConfigManager
    if ConfigManager then
        local myConfig = ConfigManager:CreateConfig("KhoaDevEvadeConfig")
        SettingsTab:Button({
            Title = "Lưu Cấu Hình (Save Config)",
            Callback = function()
                myConfig:Save()
                WindUI:Notify({Title = "Khoa Dev Hub", Content = "Đã lưu cài đặt thành công!", Duration = 3})
            end
        })
        SettingsTab:Button({
            Title = "Tải Cấu Hình (Load Config)",
            Callback = function()
                myConfig:Load()
                WindUI:Notify({Title = "Khoa Dev Hub", Content = "Đã tải cấu hình thành công!", Duration = 3})
            end
        })
    end
end)

Window:SelectTab(1)

WindUI:Notify({
    Title = "Khoa Dev Hub",
    Content = "Khởi tạo thành công! Chúc bạn chơi game vui vẻ!",
    Duration = 4,
    Icon = "heart",
})

-- ====================================================================
-- DỌN DẸP KHI THOÁT GAME HOẶC ĐỔI PHÒNG
-- ====================================================================
LocalPlayer.CharacterRemoving:Connect(function()
    if getgenv().frontJumpVelocity then
        getgenv().frontJumpVelocity:Destroy()
        getgenv().frontJumpVelocity = nil
    end
end)

game:GetService("Players").PlayerRemoving:Connect(function(leaving)
    if leaving == LocalPlayer then
        cleanupAllESP()
        cleanupTracers()
        pcall(function() RunService:UnbindFromRenderStep("KhoaDevFOVOverride") end)
        if getgenv().bhopConnection then getgenv().bhopConnection:Disconnect() end
        if getgenv().infiniteSlideHeartbeat then getgenv().infiniteSlideHeartbeat:Disconnect() end
        if getgenv().AutoCarryConnection then getgenv().AutoCarryConnection:Disconnect() end
        if getgenv().InstantReviveConnection then getgenv().InstantReviveConnection:Disconnect() end
        if getgenv().AutoTicketFarmConnection then getgenv().AutoTicketFarmConnection:Disconnect() end
        if getgenv().AutoMoneyFarmConnection then getgenv().AutoMoneyFarmConnection:Disconnect() end
        if getgenv().ScreenStretchConn then getgenv().ScreenStretchConn:Disconnect() end
        if getgenv().AntiAFK and getgenv().AntiAFK.Connection then getgenv().AntiAFK.Connection:Disconnect() end
    end
end)
