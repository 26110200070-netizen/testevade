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
    Title = "Welcome to my script!",
    Icon = "console",
    IconThemed = true,
    Content = "Welcome to " .. gradient("Weroshiny", Color3.fromHex("#4FC3F7"), Color3.fromHex("#0288D1")) .. ".",
    Buttons = {
        {
            Title = "Continue",
            Icon = "arrow-right",
            Variant = "Primary",
            Callback = function()
                Confirmed = true
            end
        }
    }
})

repeat task.wait() until Confirmed

if not workspace:FindFirstChild("SecurityPart") then
    local SecurityPart = Instance.new("Part")
    SecurityPart.Name = "SecurityPart"
    SecurityPart.Size = Vector3.new(10, 1, 10)
    SecurityPart.Position = Vector3.new(5000, 5000, 5000)
    SecurityPart.Anchored = true
    SecurityPart.CanCollide = true
    SecurityPart.Transparency = 1
    SecurityPart.CanTouch = false
    SecurityPart.Parent = workspace
end

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
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = name .. "ToggleGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = parent or PlayerGui
    
    local button = Instance.new("Frame")
    button.Name = "GradientBtn"
    button.BackgroundTransparency = 0.7
    button.Size = UDim2.new(0, 120, 0, 35)
    button.Position = UDim2.new(0.02, 0, yPosition or 0.1, 0)
    button.Active = true
    button.Selectable = true
    pcall(function() button.Draggable = true end)
    button.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = button
    
    local gradient = Instance.new("UIGradient")
    gradient.Rotation = 45
    gradient.Parent = button
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Parent = button
    
    local label = Instance.new("TextLabel")
    label.Text = name
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextSize = 14
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
            gradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 200, 100)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 120, 60))
            }
            stroke.Color = Color3.fromRGB(0, 180, 80)
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.Text = name
        else
            gradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 200, 200)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 150, 150))
            }
            stroke.Color = Color3.fromRGB(100, 100, 100)
            label.TextColor3 = Color3.fromRGB(240, 240, 240)
            label.Text = name
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
    
    clicker.MouseEnter:Connect(function()
        if initialState then
            stroke.Color = Color3.fromRGB(0, 220, 100)
        else
            stroke.Color = Color3.fromRGB(130, 130, 130)
        end
    end)
    
    clicker.MouseLeave:Connect(function()
        updateButton(initialState)
    end)
    
    getgenv().featureToggles[name] = {
        Gui = screenGui,
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

-- ==========================================
-- SAFE REMOTE HELPERS (EVADE NEW ARCHITECTURE)
-- ==========================================
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
    if gameFolder then
        local playersFolder = gameFolder:FindFirstChild("Players")
        if playersFolder and playersFolder:FindFirstChild(LocalPlayer.Name) then
            return playersFolder[LocalPlayer.Name]
        end
    end
    return LocalPlayer.Character
end

local function getPlayerObj2()
    return getPlayerModel()
end

local function getAllPlayerCharacters()
    local chars = {}
    local gameFolder = workspace:FindFirstChild("Game")
    if gameFolder and gameFolder:FindFirstChild("Players") then
        for _, ch in ipairs(gameFolder.Players:GetChildren()) do
            if ch:IsA("Model") and ch:GetAttribute("Team") ~= "Nextbot" then
                table.insert(chars, ch)
            end
        end
    end
    if #chars == 0 then
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character then
                table.insert(chars, p.Character)
            end
        end
    end
    return chars
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

local function getAllNextbots()
    local bots = {}
    local gameFolder = workspace:FindFirstChild("Game")
    if gameFolder and gameFolder:FindFirstChild("Players") then
        for _, ch in ipairs(gameFolder.Players:GetChildren()) do
            if ch:IsA("Model") and (ch:GetAttribute("Team") == "Nextbot" or knownNextbots[ch.Name]) then
                table.insert(bots, ch)
            end
        end
    end
    if gameFolder and gameFolder:FindFirstChild("NPCs") then
        for _, ch in ipairs(gameFolder.NPCs:GetChildren()) do
            if ch:IsA("Model") then
                table.insert(bots, ch)
            end
        end
    end
    if workspace:FindFirstChild("NPCs") then
        for _, ch in ipairs(workspace.NPCs:GetChildren()) do
            if ch:IsA("Model") then
                table.insert(bots, ch)
            end
        end
    end
    return bots
end

local function getAllTickets()
    local list = {}
    local gameFolder = workspace:FindFirstChild("Game")
    if gameFolder and gameFolder:FindFirstChild("Effects") then
        local eff = gameFolder.Effects
        if eff:FindFirstChild("Tickets") then
            for _, t in ipairs(eff.Tickets:GetChildren()) do table.insert(list, t) end
        end
        if eff:FindFirstChild("Collectibles") then
            for _, t in ipairs(eff.Collectibles:GetChildren()) do table.insert(list, t) end
        end
    end
    if gameFolder and gameFolder:FindFirstChild("Tickets") then
        for _, t in ipairs(gameFolder.Tickets:GetChildren()) do table.insert(list, t) end
    end
    if workspace:FindFirstChild("Tickets") then
        for _, t in ipairs(workspace.Tickets:GetChildren()) do table.insert(list, t) end
    end
    if workspace:FindFirstChild("Collectibles") then
        for _, t in ipairs(workspace.Collectibles:GetChildren()) do table.insert(list, t) end
    end
    return list
end

-- ==========================================
-- CREATE WINDOW & TABS
-- ==========================================
local Window = getgenv().WindUI:CreateWindow({
    Title = "🎄WeroShiny Hub🎄",
    Icon = "gamepad",
    Author = "Pnsdg, t.me/ItsYomka and Syfta",
    IconThemed = true,
    Size = UDim2.fromOffset(600, 400),
    Folder = "WeroShiny",
    Transparent = false,
})

local InfoTab = Window:Tab({Title = "🎄Info🎄", Icon = "message-circle"})
local PlayerTab = Window:Tab({Title = "Player", Icon = "book-open"})
local AutoTab = Window:Tab({Title = "Auto", Icon = "check"})
local FPSTab = Window:Tab({Title = "FPS", Icon = "monitor"})
local EspTab = Window:Tab({Title = "Esp", Icon = "star"})
local VisualTab = Window:Tab({Title = "Visual", Icon = "smile"})
local SettingsTab = Window:Tab({Title = "Settings", Icon = "user"})

-- ==========================================
-- INFO TAB
-- ==========================================
getgenv().DiscordInfo = getgenv().DiscordInfo or {
    ServerLink = "https://discord.gg/GE4T8wCSV",
    ServerID = 920587201,
    NotificationShown = false
}

InfoTab:Section({ Title = "Join My Discord Server", TextSize = 20 })
InfoTab:Divider()

InfoTab:Paragraph({
    Title = "WeroShiny Hub Discord",
    Desc = "Join our Discord server for updates, support, and community!",
    Image = "https://cdn.discordapp.com/attachments/1203333550010200175/1281053540044574741/download.png?ex=66fcb6c5&is=66fb6545&hm=12ec10e94d84ff8e06fd14e123796eb775ac48eb3daa2f6bd285626aabf8c0c0&",
    ImageSize = 48,
    Buttons = {
        {
            Title = "Click This",
            Icon = "link",
            Callback = function()
                setclipboard(getgenv().DiscordInfo.ServerLink)
                WindUI:Notify({
                    Title = "Discord",
                    Content = "Discord link copied to clipboard!",
                    Duration = 3
                })
                getgenv().DiscordInfo.NotificationShown = true
            end
        },
        {
            Title = "Join Server",
            Icon = "external-link",
            Callback = function()
                pcall(function() 
                    game:GetService("TeleportService"):Teleport(getgenv().DiscordInfo.ServerID, LocalPlayer) 
                end)
            end
        }
    }
})

InfoTab:Section({ Title = "About", TextSize = 20 })
InfoTab:Divider()

InfoTab:Paragraph({
    Title = "Credits",
    Desc = "Script created by SYFTA\nUI Library: WindUI\nSpecial thanks to all testers and supporters!",
    Image = "https://cdn.discordapp.com/attachments/1203333550010200175/1281053540044574741/download.png?ex=66fcb6c5&is=66fb6545&hm=12ec10e94d84ff8e06fd14e123796eb775ac48eb3daa2f6bd285626aabf8c0c0&",
    ImageSize = 48,
    Buttons = {}
})

-- ==========================================
-- PLAYER TAB
-- ==========================================
getgenv().frontJumpVelocity = nil

local function startFrontJump()
    if getgenv().frontJumpVelocity then 
        getgenv().frontJumpVelocity:Destroy() 
        getgenv().frontJumpVelocity = nil 
    end
    
    local char = LocalPlayer.Character
    if not char then return end
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

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
                if direction.Magnitude > 0 then 
                    direction = direction.Unit 
                end
                
                local targetVelocity = direction * getgenv().FeatureStates.FrontJumpSpeed
                getgenv().frontJumpVelocity.Velocity = targetVelocity
                
                if getgenv().FeatureStates.FrontAutoJumpEnabled and humanoid and humanoid:GetState() ~= Enum.HumanoidStateType.Jumping then
                    local rayOrigin = root.Position
                    local rayDir = Vector3.new(0, -4, 0)
                    local ray = Ray.new(rayOrigin, rayDir)
                    local hit, pos = workspace:FindPartOnRayWithIgnoreList(ray, {char})
                    
                    if hit then 
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping) 
                    end
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
    Title = "Front Jump",
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
    Title = "Front Jump Speed",
    Icon = "zap",
    Placeholder = "Default 50",
    Value = "50",
    Callback = function(input)
        local val = tonumber(input)
        if val and val > 0 and val <= 500 then
            getgenv().FeatureStates.FrontJumpSpeed = val
        end
    end
})

PlayerTab:Toggle({
    Title = "Auto Jump with Front Jump",
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
    Title = "Set Speed",
    Icon = "speedometer",
    Placeholder = "Default 1500",
    Value = "1500",
    Callback = function(input)
        local val = tonumber(input)
        if not val or val < 1450 or val > 100008888 then return end
        
        local targets = getMovementTables()
        for _, tableObj in ipairs(targets) do
            pcall(function()
                tableObj.Speed = val
            end)
        end
    end
})

PlayerTab:Input({
    Title = "Set Jump Cap",
    Icon = "chevrons-up",
    Placeholder = "Default 1",
    Value = "1",
    Callback = function(input)
        local val = tonumber(input)
        if not val or val < 0.1 or val > 5088888 then return end
        
        local targets = getMovementTables()
        for _, tableObj in ipairs(targets) do
            pcall(function()
                tableObj.JumpCap = val
            end)
        end
    end
})

PlayerTab:Input({
    Title = "Strafe Acceleration",
    Icon = "wind",
    Placeholder = "Set Strafe Acceleration",
    Value = "187",
    Callback = function(input)
        local val = tonumber(input)
        if not val or val < 1 or val > 1000888888 then return end
        
        local targets = getMovementTables()
        for _, tableObj in ipairs(targets) do
            pcall(function()
                tableObj.AirStrafeAcceleration = val
            end)
        end
    end
})

PlayerTab:Divider()

getgenv().slideFrictionValue = -8
getgenv().movementTables = {}
getgenv().infiniteSlideHeartbeat = nil
getgenv().infiniteSlideCharacterConn = nil

local function setSlideFriction(value)
    for _, tbl in ipairs(getMovementTables()) do
        pcall(function()
            tbl.Friction = value
        end)
    end
end

local function infiniteSlideHeartbeatFunc()
    if not getgenv().FeatureStates.InfiniteSlide then return end
    
    local playerModel = getPlayerModel()
    if not playerModel then return end
    
    local state = playerModel:GetAttribute("State")
    if state == "Slide" or state == "EmotingSlide" then
        setSlideFriction(getgenv().slideFrictionValue)
    else
        setSlideFriction(5)
    end
end

local function onCharacterAddedSlide()
    if not getgenv().FeatureStates.InfiniteSlide then return end
    for i = 1, 10 do
        task.wait(0.5)
        if getPlayerModel() then break end
    end
    task.wait(0.5)
end

local function setInfiniteSlide(enabled)
    getgenv().FeatureStates.InfiniteSlide = enabled
    
    if enabled then
        if not getgenv().infiniteSlideCharacterConn then
            getgenv().infiniteSlideCharacterConn = LocalPlayer.CharacterAdded:Connect(onCharacterAddedSlide)
        end
        
        if LocalPlayer.Character then
            task.spawn(onCharacterAddedSlide)
        end
        
        if getgenv().infiniteSlideHeartbeat then
            getgenv().infiniteSlideHeartbeat:Disconnect()
        end
        getgenv().infiniteSlideHeartbeat = RunService.Heartbeat:Connect(infiniteSlideHeartbeatFunc)
    else
        if getgenv().infiniteSlideHeartbeat then
            getgenv().infiniteSlideHeartbeat:Disconnect()
            getgenv().infiniteSlideHeartbeat = nil
        end
        
        if getgenv().infiniteSlideCharacterConn then
            getgenv().infiniteSlideCharacterConn:Disconnect()
            getgenv().infiniteSlideCharacterConn = nil
        end
        
        setSlideFriction(5)
    end
end

PlayerTab:Toggle({
    Title = "Infinite Slide",
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
    Title = "Slide Friction",
    Desc = "Negative Only And faster slide",
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

-- AutoTrimp Logic
getgenv().AutoTrimpEnabled = false
getgenv().AutoTrimpSpeed = 50
getgenv().maxExtraSpeed = 100
getgenv().minSpeedOffset = 0
getgenv().lastTick = tick()
getgenv().airAccumulator = 0
getgenv().airTotalTime = 0
getgenv().wasAir = false
getgenv().activeBV = nil
getgenv().currentSpeed = getgenv().AutoTrimpSpeed
getgenv().countingEnabled = false
getgenv().speedometer = nil
getgenv().AutoTrimpConnections = {}

local function truncate1Decimal(val)
    return math.floor(val * 10) / 10
end

local function getSpeedometer()
    local ok, spd = pcall(function()
        for _, descendant in ipairs(PlayerGui:GetDescendants()) do
            if descendant.Name == "Speedometer" then
                if descendant:IsA("TextLabel") then return descendant end
                local lbl = descendant:FindFirstChildWhichIsA("TextLabel", true)
                if lbl then return lbl end
            end
        end
        return LocalPlayer.PlayerGui.Shared.HUD.Overlay.Default.CharacterInfo.Item.Speedometer.Players
    end)
    if ok and spd then return spd end
    return nil
end

local function handleAutoTrimp()
    local deltaTime = tick() - getgenv().lastTick
    getgenv().lastTick = tick()

    local char = LocalPlayer.Character
    if not char then return end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    local humanoid = char:FindFirstChild("Humanoid")
    if not root or not humanoid then return end
    
    getgenv().speedometer = getSpeedometer()
    local isAir = humanoid.FloorMaterial == Enum.Material.Air
    
    if getgenv().wasAir and not isAir then
        getgenv().currentSpeed = math.max(getgenv().AutoTrimpSpeed - getgenv().minSpeedOffset, getgenv().currentSpeed - 10)
        if getgenv().speedometer then 
            pcall(function() getgenv().speedometer.Text = tostring(truncate1Decimal(getgenv().currentSpeed)) end)
        end
        getgenv().airTotalTime = 0
    end
    getgenv().wasAir = isAir
    
    if getgenv().AutoTrimpEnabled then
        if isAir then
            getgenv().airAccumulator = getgenv().airAccumulator + deltaTime
            getgenv().airTotalTime = getgenv().airTotalTime + deltaTime
            while getgenv().airAccumulator >= 0.04 do
                getgenv().airAccumulator = getgenv().airAccumulator - 0.04
                local increment = math.max(0.1, 2.5 * (0.04 / 1))
                getgenv().currentSpeed = math.min(getgenv().AutoTrimpSpeed + getgenv().maxExtraSpeed, getgenv().currentSpeed + increment)
            end
        else
            getgenv().airAccumulator = 0
            getgenv().currentSpeed = math.max(getgenv().AutoTrimpSpeed - getgenv().minSpeedOffset, getgenv().currentSpeed - 4 * deltaTime)
            getgenv().airTotalTime = 0
        end
        
        if getgenv().activeBV then 
            getgenv().activeBV:Destroy() 
            getgenv().activeBV = nil
        end
        
        local lookDir = Camera.CFrame.LookVector
        lookDir = Vector3.new(lookDir.X, 0, lookDir.Z)
        if lookDir.Magnitude ~= 0 then
            lookDir = lookDir.Unit
        end
        
        local bv = Instance.new("BodyVelocity")
        bv.Velocity = lookDir * getgenv().currentSpeed
        bv.MaxForce = Vector3.new(4e5, 0, 4e5)
        bv.P = 1250
        bv.Parent = root
        Debris:AddItem(bv, 0.1)
        getgenv().activeBV = bv
        
        getgenv().countingEnabled = true
        if getgenv().speedometer then 
            pcall(function() getgenv().speedometer.Text = tostring(truncate1Decimal(getgenv().currentSpeed)) end)
        end
    else
        if getgenv().activeBV then 
            getgenv().activeBV:Destroy() 
            getgenv().activeBV = nil
        end
        getgenv().currentSpeed = getgenv().AutoTrimpSpeed
        getgenv().countingEnabled = false
        getgenv().airAccumulator = 0
        getgenv().airTotalTime = 0
        getgenv().wasAir = false
    end
end

local function AutoTrimpCleanup()
    for _, conn in pairs(getgenv().AutoTrimpConnections) do
        if conn then
            conn:Disconnect()
        end
    end
    getgenv().AutoTrimpConnections = {}
    
    if getgenv().activeBV then
        getgenv().activeBV:Destroy()
        getgenv().activeBV = nil
    end
    
    getgenv().currentSpeed = getgenv().AutoTrimpSpeed
    getgenv().countingEnabled = false
    getgenv().airAccumulator = 0
    getgenv().airTotalTime = 0
    getgenv().wasAir = false
end

PlayerTab:Toggle({
    Title = "AutoTrimp",
    Value = false,
    Callback = function(state)
        getgenv().AutoTrimpEnabled = state
        
        if state then
            getgenv().AutoTrimpConnections["RenderStepped"] = RunService.RenderStepped:Connect(handleAutoTrimp)
            
            if not getgenv().featureToggles["AutoTrimp"] then
                getgenv().featureToggles["AutoTrimp"] = createFeatureToggle("AutoTrimp", state, 0.15, function(newState)
                    getgenv().AutoTrimpEnabled = newState
                    if newState then
                        getgenv().AutoTrimpConnections["RenderStepped"] = RunService.RenderStepped:Connect(handleAutoTrimp)
                    else
                        AutoTrimpCleanup()
                    end
                end)
            end
        else
            AutoTrimpCleanup()
        end
        
        if getgenv().featureToggles["AutoTrimp"] then
            getgenv().featureToggles["AutoTrimp"].Gui.Enabled = state
            if getgenv().featureToggles["AutoTrimp"].UpdateState then
                getgenv().featureToggles["AutoTrimp"].UpdateState(state)
            end
        end
    end
})

PlayerTab:Input({
    Title = "AutoTrimp Speed",
    Placeholder = "Default 50",
    Value = "50",
    Callback = function(value)
        local num = tonumber(value)
        if num and num > 0 then
            getgenv().AutoTrimpSpeed = num
            getgenv().currentSpeed = num
        end
    end
})

LocalPlayer.CharacterRemoving:Connect(function()
    if getgenv().activeBV then
        getgenv().activeBV:Destroy()
        getgenv().activeBV = nil
    end
end)

PlayerTab:Divider()

local autoJumpType = "Bounce"
getgenv().bhopHoldActive = false
local jumpCooldown = 0

local Character = nil
local Humanoid = nil
local HumanoidRootPart = nil
local LastJump = 0

local GROUND_CHECK_DISTANCE = 4
local MAX_SLOPE_ANGLE = 45

local function IsOnGround()
    if not Character or not HumanoidRootPart or not Humanoid then 
        return false 
    end

    local state = Humanoid:GetState()
    if state == Enum.HumanoidStateType.Jumping or 
       state == Enum.HumanoidStateType.Freefall or
       state == Enum.HumanoidStateType.Swimming then
        return false
    end

    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {Character}
    raycastParams.IgnoreWater = true

    local rayOrigin = HumanoidRootPart.Position
    local rayDirection = Vector3.new(0, -GROUND_CHECK_DISTANCE, 0)
    local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)

    if not raycastResult then 
        return false 
    end

    local surfaceNormal = raycastResult.Normal
    local angle = math.deg(math.acos(surfaceNormal:Dot(Vector3.new(0, 1, 0))))

    return angle <= MAX_SLOPE_ANGLE
end

local function updateBhop()
    local isBhopActive = getgenv().FeatureStates.BhopEnabled or getgenv().bhopHoldActive

    if isBhopActive and Humanoid then
        local now = tick()
        if IsOnGround() and (now - LastJump) > jumpCooldown then
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            if getgenv().FeatureStates.BhopMode == "Acceleration" then
                pcall(function()
                    setSlideFriction(getgenv().FeatureStates.BhopAccelValue or -0.1)
                end)
            end
            LastJump = now
        end
    end
end

LocalPlayer.CharacterAdded:Connect(function(character)
    Character = character
    Humanoid = character:WaitForChild("Humanoid")
    HumanoidRootPart = character:WaitForChild("HumanoidRootPart")
end)

if LocalPlayer.Character then
    Character = LocalPlayer.Character
    Humanoid = Character:WaitForChild("Humanoid")
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
end

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end
    if input.KeyCode == Enum.KeyCode.Space then
        getgenv().bhopHoldActive = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space then
        getgenv().bhopHoldActive = false
    end
end)

getgenv().bhopConnection = RunService.Heartbeat:Connect(updateBhop)

PlayerTab:Toggle({
    Title = "Bhop",
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
            if getgenv().featureToggles["Bhop"].UpdateState then
                getgenv().featureToggles["Bhop"].UpdateState(state)
            end
        end
    end
})

PlayerTab:Dropdown({
    Title = "Bhop Mode",
    Values = {"Acceleration", "No Acceleration"},
    Multi = false,
    Default = 1,
    Callback = function(value)
        getgenv().FeatureStates.BhopMode = value
    end
})

PlayerTab:Input({
    Title = "Bhop Acceleration (Negative Only)",
    Placeholder = "-0.5",
    Numeric = true,
    Callback = function(value)
        if value and tostring(value):sub(1, 1) == "-" then
            getgenv().FeatureStates.BhopAccelValue = tonumber(value)
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
            if emote:IsA("ModuleScript") or emote:IsA("LocalScript") or emote:IsA("Script") then
                local exists = false
                for _, em in ipairs(emoteList) do
                    if em == emote.Name then exists = true break end
                end
                if not exists then table.insert(emoteList, emote.Name) end
            end
        end
    end
end)

table.sort(emoteList)

PlayerTab:Dropdown({
    Title = "Select Emote",
    Values = emoteList,
    Multi = false,
    Callback = function(option)
        getgenv().FeatureStates.SelectedEmote = option
    end
})

PlayerTab:Toggle({
    Title = "Enable Emote (Hold Crouch Button)",
    Default = false,
    Callback = function(state)
        getgenv().FeatureStates.EmoteEnabled = state
    end
})

local function findCrouchButton()
    local gameGui = PlayerGui:FindFirstChild("Game")
    if gameGui then
        local hud = gameGui:FindFirstChild("HUD")
        if hud then
            local mobile = hud:FindFirstChild("Mobile")
            if mobile then
                for _, descendant in ipairs(mobile:GetDescendants()) do
                    if descendant:IsA("GuiButton") and (descendant.Name:lower():find("crouch") or descendant.Name:lower():find("slide")) then
                        return descendant
                    end
                end
            end
        end
    end
    for _, descendant in ipairs(PlayerGui:GetDescendants()) do
        if descendant:IsA("GuiButton") and (descendant.Name:lower():find("crouch") or descendant.Name:lower():find("slide")) then
            return descendant
        end
    end
    return nil
end

task.spawn(function()
    while true do
        local button = findCrouchButton()
        if button then
            local holding = false
            local emoteTask = nil
            
            local downConn = button.MouseButton1Down:Connect(function()
                holding = true
                emoteTask = task.delay(0.5, function()
                    if holding and getgenv().FeatureStates.EmoteEnabled and getgenv().FeatureStates.SelectedEmote then
                        playEmote(getgenv().FeatureStates.SelectedEmote)
                    end
                end)
            end)
            
            local upConn = button.MouseButton1Up:Connect(function()
                holding = false
                if emoteTask then
                    task.cancel(emoteTask)
                    emoteTask = nil
                end
            end)
            
            repeat task.wait(1) until not button.Parent
            pcall(function() downConn:Disconnect() end)
            pcall(function() upConn:Disconnect() end)
        end
        task.wait(1)
    end
end)

getgenv().EmoteSpeedSettings = getgenv().EmoteSpeedSettings or {
    SpeedValue = 1500,
    Mode = "not this",
    OriginalSpeeds = {},
    AppliedToUnwalkable = false,
    LastAppliedValue = 0
}

PlayerTab:Section({ Title = "Emote Speed (BETA)", TextSize = 20 })
PlayerTab:Divider()

local function applySpeedMultiplier(speedMultiplier)
    local targets = getMovementTables()
    for _, tableObj in ipairs(targets) do
        if tableObj and typeof(tableObj) == "table" then
            pcall(function()
                tableObj.WalkSpeedMultiplier = speedMultiplier
            end)
        end
    end
end

local playerObj = nil
local connection = nil

local function setupConnection(obj)
    if connection then 
        connection:Disconnect() 
        connection = nil
    end
    playerObj = obj
    if not obj then return end
    
    local function onStateChanged()
        local state = obj:GetAttribute("State")
        local targetSpeed = (state == "Emoting") and (getgenv().EmoteSpeedSettings.SpeedValue / 1000) or 1.5
        applySpeedMultiplier(targetSpeed)
    end
    
    onStateChanged()
    connection = obj:GetAttributeChangedSignal("State"):Connect(onStateChanged)
end

local function resetMultiplierSpeed()
    applySpeedMultiplier(1.5)
end

PlayerTab:Dropdown({
    Title = "Emote speed mode",
    Values = {"not this", "Legit", "Multiplier speed"},
    Value = getgenv().EmoteSpeedSettings.Mode,
    Callback = function(value)
        getgenv().EmoteSpeedSettings.Mode = value
        
        if value == "not this" then
            resetMultiplierSpeed()
            if connection then 
                connection:Disconnect() 
                connection = nil
            end
        elseif value == "Multiplier speed" then
            setupConnection(getPlayerObj2())
            
            task.spawn(function()
                while getgenv().EmoteSpeedSettings.Mode == "Multiplier speed" do
                    task.wait(2)
                    local current = getPlayerObj2()
                    if current ~= playerObj then
                        setupConnection(current)
                    elseif playerObj then
                        local state = playerObj:GetAttribute("State")
                        local targetSpeed = (state == "Emoting") and (getgenv().EmoteSpeedSettings.SpeedValue / 1000) or 1.5
                        applySpeedMultiplier(targetSpeed)
                    end
                end
            end)
        elseif value == "Legit" then
            resetMultiplierSpeed()
            if connection then 
                connection:Disconnect() 
                connection = nil
            end
            applySpeedMultiplier(getgenv().EmoteSpeedSettings.SpeedValue / 1000)
        end
    end
})

PlayerTab:Input({
    Title = "Emote Speed Value",
    Placeholder = tostring(getgenv().EmoteSpeedSettings.SpeedValue),
    NumbersOnly = true,
    Value = tostring(getgenv().EmoteSpeedSettings.SpeedValue),
    Callback = function(value)
        local num = tonumber(value)
        if num and num > 0 then
            getgenv().EmoteSpeedSettings.SpeedValue = num
            if getgenv().EmoteSpeedSettings.Mode == "Legit" then
                applySpeedMultiplier(num / 1000)
            elseif getgenv().EmoteSpeedSettings.Mode == "Multiplier speed" then
                if playerObj and playerObj:GetAttribute("State") == "Emoting" then
                    applySpeedMultiplier(num / 1000)
                end
            end
        end
    end
})

PlayerTab:Button({
    Title = "Apply Speed to Unwalkable Emotes",
    Callback = function()
        applySpeedMultiplier(getgenv().EmoteSpeedSettings.SpeedValue / 1000)
        getgenv().EmoteSpeedSettings.AppliedToUnwalkable = true
        WindUI:Notify({
            Title = "Emote Speed",
            Content = "Applied speed to unwalkable emotes",
            Duration = 3
        })
    end
})

PlayerTab:Button({
    Title = "Reset Emote Speed",
    Desc = "Having Trouble? Reset the speed or rejoin",
    Callback = function()
        resetMultiplierSpeed()
        getgenv().EmoteSpeedSettings.AppliedToUnwalkable = false
        getgenv().EmoteSpeedSettings.LastAppliedValue = 0
        WindUI:Notify({
            Title = "Emote Speed",
            Content = "All emote speeds reset to default values",
            Duration = 3
        })
    end
})

PlayerTab:Button({
    Title = "Save Current Settings",
    Callback = function()
        WindUI:Notify({
            Title = "Emote Speed",
            Content = "Settings saved! Speed: " .. getgenv().EmoteSpeedSettings.SpeedValue .. 
                     ", Mode: " .. getgenv().EmoteSpeedSettings.Mode,
            Duration = 3
        })
    end
})

PlayerTab:Divider()

local function triggerLagSwitch()
    task.spawn(function()
        local start = tick()
        while tick() - start < getgenv().FeatureStates.LagDuration do
            for i = 1, 10000 do
                math.random(1, 1000000)
            end
        end
    end)
end

PlayerTab:Toggle({
    Title = "Lag Switch",
    Icon = "zap",
    Default = false,
    Callback = function(state)
        getgenv().FeatureStates.LagSwitchEnabled = state
        if state and not getgenv().featureToggles["Lag Switch"] then
            getgenv().featureToggles["Lag Switch"] = createFeatureToggle("Lag Switch", state, 0.35, function(newState)
                getgenv().FeatureStates.LagSwitchEnabled = newState
                if newState then
                    triggerLagSwitch()
                end
            end)
        end
        if getgenv().featureToggles["Lag Switch"] then
            getgenv().featureToggles["Lag Switch"].Gui.Enabled = state
            if getgenv().featureToggles["Lag Switch"].UpdateState then
                getgenv().featureToggles["Lag Switch"].UpdateState(state)
            end
        end
        if state then
            triggerLagSwitch()
        end
    end
})

PlayerTab:Input({
    Title = "Lag Duration (seconds)",
    Default = tostring(getgenv().FeatureStates.LagDuration),
    Placeholder = "Enter seconds",
    NumbersOnly = true,
    Callback = function(text)
        local n = tonumber(text)
        if n and n > 0 and n <= 10 then
            getgenv().FeatureStates.LagDuration = n
        end
    end
})

-- ==========================================
-- AUTO TAB
-- ==========================================
getgenv().AutoCarryConnection = nil

local function startAutoCarry()
    if getgenv().AutoCarryConnection then return end
    
    getgenv().AutoCarryConnection = RunService.Heartbeat:Connect(function()
        if not getgenv().FeatureStates.AutoCarry then return end
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local remote = getInteractRemote()
        if hrp and remote then
            for _, other in ipairs(Players:GetPlayers()) do
                if other ~= LocalPlayer and other.Character and other.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (hrp.Position - other.Character.HumanoidRootPart.Position).Magnitude
                    if dist <= 20 then
                        pcall(function() remote:FireServer("Carry", other.Name) end)
                        pcall(function() remote:FireServer("Carry", true, other.Name) end)
                        task.wait(0.05)
                    end
                end
            end
        end
    end)
end

local function stopAutoCarry()
    if getgenv().AutoCarryConnection then
        getgenv().AutoCarryConnection:Disconnect()
        getgenv().AutoCarryConnection = nil
    end
end

AutoTab:Toggle({
    Title = "Auto Carry",
    Value = false,
    Callback = function(state)
        getgenv().FeatureStates.AutoCarry = state
        if state then
            startAutoCarry()
            if not getgenv().featureToggles["Auto Carry"] then
                getgenv().featureToggles["Auto Carry"] = createFeatureToggle("Auto Carry", state, 0.2, function(newState)
                    getgenv().FeatureStates.AutoCarry = newState
                    if newState then
                        startAutoCarry()
                    else
                        stopAutoCarry()
                    end
                end)
            end
        else
            stopAutoCarry()
        end
        
        if getgenv().featureToggles["Auto Carry"] then
            getgenv().featureToggles["Auto Carry"].Gui.Enabled = state
            if getgenv().featureToggles["Auto Carry"].UpdateState then
                getgenv().featureToggles["Auto Carry"].UpdateState(state)
            end
        end
    end
})

AutoTab:Divider()

getgenv().InstantReviveEnabled = false
getgenv().InstantReviveDelay = 0.15
getgenv().InstantReviveConnection = nil

local function isPlayerDowned(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return false end
    return targetPlayer.Character:GetAttribute("Downed") == true
end

local function startInstantRevive()
    if getgenv().InstantReviveConnection then return end
    
    getgenv().InstantReviveConnection = RunService.Heartbeat:Connect(function()
        if not getgenv().InstantReviveEnabled then return end
        
        local character = LocalPlayer.Character
        if not character then return end
        
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        local remote = getInteractRemote()
        if not remote then return end
        
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and isPlayerDowned(p) and p.Character then
                local targetHrp = p.Character:FindFirstChild("HumanoidRootPart")
                if targetHrp then
                    local distance = (hrp.Position - targetHrp.Position).Magnitude
                    if distance <= 20 then
                        pcall(function() remote:FireServer("Revive", true, p.Name) end)
                        pcall(function() remote:FireServer("Revive", p.Name) end)
                        task.wait(getgenv().InstantReviveDelay)
                    end
                end
            end
        end
    end)
end

local function stopInstantRevive()
    if getgenv().InstantReviveConnection then
        getgenv().InstantReviveConnection:Disconnect()
        getgenv().InstantReviveConnection = nil
    end
end

AutoTab:Toggle({
    Title = "Instant Revive While Emoting",
    Value = false,
    Callback = function(state)
        getgenv().FeatureStates.InstantReviveEnabled = state
        getgenv().InstantReviveEnabled = state
        if state then
            startInstantRevive()
        else
            stopInstantRevive()
        end
    end
})

AutoTab:Slider({
    Title = "Revive Delay",
    Desc = "Delay between revives",
    Value = { Min = 0, Max = 1, Default = 0.15 },
    Callback = function(value)
        getgenv().FeatureStates.InstantReviveDelay = value
        getgenv().InstantReviveDelay = value
    end
})

local lastSavedPosition = nil
local respawnConnection = nil
local AutoSelfReviveConnection = nil
local hasRevived = false

local function reviveAtSpawnpoint()
    if not hasRevived then
        hasRevived = true
        task.wait(1.5)
        setPlayerMode(true)
        task.delay(5, function()
            hasRevived = false
        end)
    end
end

local function reviveAtPosition(character, hrp)
    if hrp then
        lastSavedPosition = hrp.Position
    end
    task.wait(1.5)
    
    local startTime = tick()
    repeat
        setPlayerMode(true)
        task.wait(0.5)
    until not (character and character:GetAttribute("Downed")) or (tick() - startTime > 3)
    
    local newCharacter = LocalPlayer.Character
    local attempts = 0
    while (not newCharacter or not newCharacter:FindFirstChild("HumanoidRootPart")) and attempts < 20 do
        newCharacter = LocalPlayer.Character
        task.wait(0.1)
        attempts = attempts + 1
    end
    
    local newHRP = newCharacter and newCharacter:FindFirstChild("HumanoidRootPart")
    if lastSavedPosition and newHRP then
        newHRP.CFrame = CFrame.new(lastSavedPosition)
        task.wait(0.1)
        lastSavedPosition = nil
    end
end

AutoTab:Toggle({
    Title = "Auto Self Revive",
    Value = false,
    Callback = function(state)
        getgenv().FeatureStates.AutoSelfRevive = state
        
        if AutoSelfReviveConnection then
            AutoSelfReviveConnection:Disconnect()
            AutoSelfReviveConnection = nil
        end
        
        if respawnConnection then
            respawnConnection:Disconnect()
            respawnConnection = nil
        end
        
        if not state then
            hasRevived = false
            lastSavedPosition = nil
            return
        end
        
        local function setupReviveLogic(character)
            if not character then return end
            
            AutoSelfReviveConnection = character:GetAttributeChangedSignal("Downed"):Connect(function()
                if not getgenv().FeatureStates.AutoSelfRevive then return end
                
                local isDowned = character:GetAttribute("Downed")
                if isDowned then
                    local hrp = character:FindFirstChild("HumanoidRootPart")
                    if getgenv().FeatureStates.SelfReviveMethod == "Spawnpoint" then
                        reviveAtSpawnpoint()
                    elseif getgenv().FeatureStates.SelfReviveMethod == "Fake Revive" then
                        reviveAtPosition(character, hrp)
                    end
                end
            end)
        end
        
        local currentChar = LocalPlayer.Character
        if currentChar then
            setupReviveLogic(currentChar)
        end
        
        respawnConnection = LocalPlayer.CharacterAdded:Connect(function(newChar)
            task.wait(1)
            setupReviveLogic(newChar)
        end)
    end
})

AutoTab:Dropdown({
    Title = "Self Revive Method",
    Values = {"Spawnpoint", "Fake Revive"},
    Value = "Spawnpoint",
    Callback = function(value)
        getgenv().FeatureStates.SelfReviveMethod = value
    end
})

local function manualRevive()
    local character = LocalPlayer.Character
    if not character then return end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    local isDowned = character:GetAttribute("Downed")
    if not isDowned then return end
    
    if getgenv().FeatureStates.SelfReviveMethod == "Spawnpoint" then
        reviveAtSpawnpoint()
    elseif getgenv().FeatureStates.SelfReviveMethod == "Fake Revive" then
        reviveAtPosition(character, hrp)
    end
end

AutoTab:Button({
    Title = "Manual Revive",
    Desc = "Manually revive yourself",
    Icon = "heart",
    Callback = manualRevive
})

AutoTab:Divider()

getgenv().AntiAFK = {
    Enabled = false,
    Connection = nil
}

local virtualUser = game:GetService("VirtualUser")

local function startAntiAFK()
    if getgenv().AntiAFK.Connection then
        getgenv().AntiAFK.Connection:Disconnect()
        getgenv().AntiAFK.Connection = nil
    end
    
    getgenv().AntiAFK.Connection = LocalPlayer.Idled:Connect(function()
        pcall(function()
            virtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            virtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
    end)
    
    getgenv().AntiAFK.Enabled = true
end

local function stopAntiAFK()
    if getgenv().AntiAFK.Connection then
        getgenv().AntiAFK.Connection:Disconnect()
        getgenv().AntiAFK.Connection = nil
    end
    getgenv().AntiAFK.Enabled = false
end

AutoTab:Toggle({
    Title = "Anti AFK",
    Desc = "Prevents getting kicked for inactivity",
    Value = getgenv().AntiAFK.Enabled,
    Callback = function(state)
        if state then
            startAntiAFK()
        else
            stopAntiAFK()
        end
    end
})

LocalPlayer.CharacterAdded:Connect(function()
    if getgenv().AntiAFK.Enabled then
        task.wait(1)
        startAntiAFK()
    end
end)

getgenv().AutoTicketFarmConnection = nil

local function startAutoTicketFarm()
    local securityPart = workspace:FindFirstChild("SecurityPart")
    if not securityPart then
        securityPart = Instance.new("Part")
        securityPart.Name = "SecurityPart"
        securityPart.Size = Vector3.new(10, 1, 10)
        securityPart.Position = Vector3.new(5000, 5000, 5000)
        securityPart.Anchored = true
        securityPart.CanCollide = true
        securityPart.Transparency = 1
        securityPart.Parent = workspace
    end
    
    getgenv().AutoTicketFarmConnection = RunService.Heartbeat:Connect(function()
        if not getgenv().FeatureStates.AutoTicketFarm then
            if getgenv().AutoTicketFarmConnection then
                getgenv().AutoTicketFarmConnection:Disconnect()
                getgenv().AutoTicketFarmConnection = nil
            end
            return
        end
        
        local character = LocalPlayer.Character
        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
        
        if character and humanoidRootPart then
            if character:GetAttribute("Downed") then
                setPlayerMode(true)
                humanoidRootPart.CFrame = securityPart.CFrame + Vector3.new(0, 3, 0)
                return
            end
            
            local activeTickets = getAllTickets()
            if #activeTickets > 0 then
                local ticketPart = activeTickets[1]:FindFirstChild("HumanoidRootPart") or activeTickets[1]:FindFirstChildWhichIsA("BasePart")
                if ticketPart then
                    humanoidRootPart.CFrame = CFrame.new(ticketPart.Position)
                end
            else
                humanoidRootPart.CFrame = securityPart.CFrame + Vector3.new(0, 3, 0)
            end
        end
    end)
end

local function stopAutoTicketFarm()
    if getgenv().AutoTicketFarmConnection then
        getgenv().AutoTicketFarmConnection:Disconnect()
        getgenv().AutoTicketFarmConnection = nil
    end
    
    local character = LocalPlayer.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    local securityPart = workspace:FindFirstChild("SecurityPart")
    if humanoidRootPart and securityPart then
        humanoidRootPart.CFrame = securityPart.CFrame + Vector3.new(0, 3, 0)
    end
end

AutoTab:Toggle({
    Title = "Auto Ticket Farm",
    Desc = "Auto farm tickets",
    Value = false,
    Callback = function(state)
        getgenv().FeatureStates.AutoTicketFarm = state
        if state then
            startAutoTicketFarm()
        else
            stopAutoTicketFarm()
        end
    end
})

local function startAutoMoneyFarm()
    local securityPart = workspace:FindFirstChild("SecurityPart")
    if not securityPart then
        securityPart = Instance.new("Part")
        securityPart.Name = "SecurityPart"
        securityPart.Size = Vector3.new(10, 1, 10)
        securityPart.Position = Vector3.new(5000, 5000, 5000)
        securityPart.Anchored = true
        securityPart.CanCollide = true
        securityPart.Transparency = 1
        securityPart.Parent = workspace
    end
    
    if getgenv().AutoMoneyFarmConnection then
        getgenv().AutoMoneyFarmConnection:Disconnect()
        getgenv().AutoMoneyFarmConnection = nil
    end
    
    getgenv().AutoMoneyFarmConnection = RunService.Heartbeat:Connect(function()
        if not getgenv().FeatureStates.AutoMoneyFarm then return end
        
        local character = LocalPlayer.Character
        if not character then return end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        
        if character:GetAttribute("Downed") then
            setPlayerMode(true)
            task.wait(1.5)
            return
        end
        
        local downedPlayerFound = false
        local remote = getInteractRemote()
        
        for _, otherModel in ipairs(getAllPlayerCharacters()) do
            if otherModel.Name ~= LocalPlayer.Name and otherModel:GetAttribute("Downed") == true then
                local targetHRP = otherModel:FindFirstChild("HumanoidRootPart")
                if targetHRP then
                    local distance = (rootPart.Position - targetHRP.Position).Magnitude
                    if distance > 20 then
                        rootPart.CFrame = targetHRP.CFrame + Vector3.new(0, 3, 0)
                        task.wait(0.3)
                    end
                    
                    if remote then
                        pcall(function() remote:FireServer("Revive", true, otherModel.Name) end)
                        pcall(function() remote:FireServer("Revive", otherModel.Name) end)
                    end
                    
                    downedPlayerFound = true
                    break
                end
            end
        end
        
        if not downedPlayerFound then
            local currentPos = rootPart.Position
            local securityPos = securityPart.Position
            local distanceToSecurity = (currentPos - securityPos).Magnitude
            
            if distanceToSecurity > 10 then
                rootPart.CFrame = securityPart.CFrame + Vector3.new(0, 3, 0)
            end
        end
    end)
end

local function stopAutoMoneyFarm()
    if getgenv().AutoMoneyFarmConnection then
        getgenv().AutoMoneyFarmConnection:Disconnect()
        getgenv().AutoMoneyFarmConnection = nil
    end
    
    local character = LocalPlayer.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    local securityPart = workspace:FindFirstChild("SecurityPart")
    
    if rootPart and securityPart then
        rootPart.CFrame = securityPart.CFrame + Vector3.new(0, 3, 0)
    end
end

AutoTab:Toggle({
    Title = "Auto Money Farm",
    Desc = "Auto revive players for money",
    Value = false,
    Callback = function(state)
        getgenv().FeatureStates.AutoMoneyFarm = state
        
        if state and not getgenv().featureToggles["Auto Money Farm"] then
            getgenv().featureToggles["Auto Money Farm"] = createFeatureToggle("Auto Money Farm", state, 0.4, function(newState)
                getgenv().FeatureStates.AutoMoneyFarm = newState
                if newState then
                    startAutoMoneyFarm()
                else
                    stopAutoMoneyFarm()
                end
            end)
        end
        
        if getgenv().featureToggles["Auto Money Farm"] then
            getgenv().featureToggles["Auto Money Farm"].Gui.Enabled = state
            if getgenv().featureToggles["Auto Money Farm"].UpdateState then
                getgenv().featureToggles["Auto Money Farm"].UpdateState(state)
            end
        end
        
        if state then
            startAutoMoneyFarm()
        else
            stopAutoMoneyFarm()
        end
    end
})

-- ==========================================
-- FPS TAB
-- ==========================================
FPSTab:Divider()

FPSTab:Button({  
    Title = "LowerChunks",  
    Description = "Reduces the streaming radius for performance improvement",  
    Callback = function()  
        pcall(function()
            workspace.StreamingMinRadius = 200  
            workspace.StreamingTargetRadius = 500  
        end)
    end  
})  

FPSTab:Button({  
    Title = "DisableVSync",  
    Description = "Disables vertical sync to allow higher FPS",  
    Callback = function()  
        pcall(function() setfpscap(9999) end)
    end  
})  

FPSTab:Button({  
    Title = "SetFpsCapMax",  
    Description = "Sets the FPS cap to a very high value",  
    Callback = function()  
        pcall(function() setfpscap(99999) end)
    end  
})  

FPSTab:Button({  
    Title = "HideSkybox",  
    Description = "Removes the skybox for better performance",  
    Callback = function()  
        pcall(function()
            for _, v in pairs(game.Lighting:GetChildren()) do
                if v:IsA("Sky") then v:Destroy() end
            end
        end)
    end  
})  

FPSTab:Button({  
    Title = "DisableShadows",  
    Description = "Disables all shadows in the workspace",  
    Callback = function()  
        for _, part in pairs(workspace:GetDescendants()) do  
            if part:IsA("BasePart") then  
                part.CastShadow = false  
            end  
        end  
    end  
})  

FPSTab:Button({  
    Title = "SetLowGraphics",  
    Description = "Sets the rendering quality to low",  
    Callback = function()  
        pcall(function() settings().Rendering.QualityLevel = 1 end)
    end  
})  

FPSTab:Button({  
    Title = "DisableParticles",  
    Description = "Removes all particle effects from the game",  
    Callback = function()  
        for _, particle in pairs(workspace:GetDescendants()) do  
            if particle:IsA("ParticleEmitter") then  
                particle:Destroy()  
            end  
        end  
    end  
})  

FPSTab:Button({  
    Title = "Night",  
    Description = "Sets the time to night (00:00)",  
    Callback = function()  
        pcall(function() game.Lighting.TimeOfDay = "00:00:00" end)
    end  
})  

FPSTab:Button({  
    Title = "Day",  
    Description = "Sets the time to morning (08:00)",  
    Callback = function()  
        pcall(function() game.Lighting.TimeOfDay = "08:00:00" end)
    end  
})  

FPSTab:Button({  
    Title = "AntiFog",  
    Description = "Removes fog for better visibility",  
    Callback = function()  
        pcall(function()
            local L = game.Lighting  
            L.FogStart = 1e5  
            L.FogEnd = 1e6  
        end)
    end  
})  

FPSTab:Button({  
    Title = "LowPolyMode",  
    Description = "Converts meshes to low-poly for performance",  
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

FPSTab:Button({  
    Title = "DisableSimplifyLighting",  
    Description = "Disables lighting simplifications for custom settings",  
    Callback = function()  
        pcall(function()
            local L = game.Lighting  
            L.Technology = Enum.Technology.Compatibility  
            L.ShadowSoftness = 0  
            L.EnvironmentDiffuseScale = 0  
            L.EnvironmentSpecularScale = 0  
        end)
    end  
})  

FPSTab:Button({  
    Title = "HideUselessChunks",  
    Description = "Reduces streaming of unnecessary chunks",  
    Callback = function()  
        pcall(function()
            workspace.StreamingMinRadius = 0  
            workspace.StreamingTargetRadius = 500  
        end)
    end  
})  

FPSTab:Button({  
    Title = "ReduceAntiAliasing",  
    Description = "Reduces anti-aliasing for performance",  
    Callback = function()  
        pcall(function()
            settings().Rendering.QualityLevel = 1
        end)
    end  
})

FPSTab:Toggle({
    Title = "full bright",
    Desc = "not mine.",
    Callback = function()
        pcall(function()
            local Lighting = game:GetService("Lighting")
            Lighting.Ambient = Color3.new(1,1,1)
            Lighting.OutdoorAmbient = Color3.new(1,1,1)
            Lighting.Brightness = 3
            Lighting.ExposureCompensation = 1
            Lighting.GlobalShadows = false

            for _, v in pairs(Lighting:GetChildren()) do
                if v:IsA("ColorCorrectionEffect")
                or v:IsA("DepthOfFieldEffect")
                or v:IsA("BloomEffect")
                or v:IsA("SunRaysEffect")
                or v:IsA("Atmosphere")
                or v:IsA("Sky") then
                    v:Destroy()
                end
            end
        end)
    end
})

FPSTab:Button({
    Title = "Anti lag 1",
    Callback = function()
        pcall(function()
            local Lighting = game:GetService("Lighting")
            local Terrain = workspace:FindFirstChildOfClass("Terrain")

            Lighting.GlobalShadows = false
            Lighting.FogEnd = 1e10
            Lighting.Brightness = 1

            if Terrain then
                Terrain.WaterWaveSize = 0
                Terrain.WaterWaveSpeed = 0
                Terrain.WaterReflectance = 0
                Terrain.WaterTransparency = 1
            end

            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    obj.Material = Enum.Material.Plastic
                    obj.Reflectance = 0
                elseif obj:IsA("Decal") or obj:IsA("Texture") then
                    obj:Destroy()
                elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                    obj:Destroy()
                elseif obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
                    obj:Destroy()
                end
            end
        end)
    end
})

FPSTab:Button({
    Title = "Reduce Graphics 1",
    Desc = "All parts smooth, disable particles and trails",
    Icon = "image-off",
    Callback = function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.Material = Enum.Material.SmoothPlastic
                obj.Reflectance = 0
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                obj.Enabled = false
            end
        end
    end
})

FPSTab:Button({
    Title = "Optimize Graphics 2",
    Desc = "Smoother + Remove fog and effects",
    Callback = function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.Material = Enum.Material.SmoothPlastic
                obj.Reflectance = 0
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                obj.Enabled = false
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                obj:Destroy()
            end
        end

        local Lighting = game:GetService("Lighting")
        Lighting.FogEnd = 100000
        Lighting.FogStart = 0
        Lighting.GlobalShadows = false
        
        getgenv().WindUI:Notify({
            Title = "Graphics Optimized",
            Content = "V.2 optimization applied successfully",
            Duration = 3
        })
    end
})

local function optimizeGraphics()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            pcall(function()
                obj.Material = Enum.Material.SmoothPlastic
                obj.Reflectance = 0
                obj.CastShadow = false
            end)
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
            pcall(function() obj.Enabled = false end)
        elseif obj:IsA("Decal") then
            pcall(function() obj.Transparency = 1 end)
        elseif obj:IsA("MeshPart") then
            pcall(function() obj.RenderFidelity = Enum.RenderFidelity.Performance end)
        end
    end
    
    local lighting = game:GetService("Lighting")
    pcall(function()
        lighting.GlobalShadows = false
        lighting.FogEnd = 100000
        lighting.Brightness = 2
        lighting.Technology = Enum.Technology.Voxel
    end)
end

local function cleanWorkspace()
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Model") and obj.Name == "Debris" then
            obj:Destroy()
        elseif obj:IsA("BasePart") and obj.Transparency > 0.8 then
            obj:Destroy()
        end
    end
end

FPSTab:Button({
    Title = "Fix Lag & Optimize",
    Desc = "Reduces graphics, optimizes network, cleans workspace",
    Icon = "zap",
    Callback = function()
        optimizeGraphics()
        cleanWorkspace()
        getgenv().WindUI:Notify({
            Title = "✅ Lag Fix Applied",
            Content = "Game performance optimized",
            Duration = 3
        })
    end
})

FPSTab:Button({
    Title = "Auto-Optimize New Objects",
    Desc = "Automatically optimize new particles/debris",
    Default = false,
    Callback = function(state)
        if state then
            workspace.DescendantAdded:Connect(function(obj)
                if obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                    task.wait(0.1)
                    pcall(function() obj.Enabled = false end)
                end
            end)
        end
    end
})

FPSTab:Toggle({
    Title = "FPS Boost",
    Desc = "Reduce quality for maximum FPS",
    Default = false,
    Callback = function(state)
        local RunService = game:GetService("RunService")
        local UserGameSettings = UserSettings():GetService("UserGameSettings")
        
        if state then
            pcall(function()
                UserGameSettings:SetQualityLevel(1)
                RunService:Set3dRenderingEnabled(false)
            end)
        else
            pcall(function()
                RunService:Set3dRenderingEnabled(true)
                UserGameSettings:SetQualityLevel(5)
            end)
        end
    end
})

-- ==========================================
-- ESP TAB
-- ==========================================
getgenv().espObjects = getgenv().espObjects or {}
getgenv().espThreads = getgenv().espThreads or {}

local function createESP(part, name, baseColor)
    if getgenv().espObjects[part] then return getgenv().espObjects[part] end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = name .. "ESP"
    billboard.Adornee = part
    billboard.Size = UDim2.new(0, 180, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 3.5, 0)
    billboard.AlwaysOnTop = true
    billboard.LightInfluence = 0
    billboard.MaxDistance = 800
    billboard.Parent = PlayerGui
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextStrokeTransparency = 0.25
    label.TextSize = 14
    label.Font = Enum.Font.GothamSemibold
    label.Text = ""
    label.TextColor3 = baseColor or Color3.fromRGB(255, 255, 255)
    label.Parent = billboard
    
    getgenv().espObjects[part] = {billboard = billboard, label = label, type = name}
    return getgenv().espObjects[part]
end

local function removeESP(part)
    if getgenv().espObjects[part] then
        pcall(function() getgenv().espObjects[part].billboard:Destroy() end)
        getgenv().espObjects[part] = nil
    end
end

local function cleanupESP()
    for part, data in pairs(getgenv().espObjects) do
        if data and data.billboard then
            pcall(function() data.billboard:Destroy() end)
        end
    end
    getgenv().espObjects = {}
    
    for name, thread in pairs(getgenv().espThreads) do
        if thread then
            pcall(function() coroutine.close(thread) end)
            getgenv().espThreads[name] = nil
        end
    end
end

EspTab:Toggle({
    Title = "Esp Player",
    Value = false,
    Callback = function(state)
        getgenv().FeatureStates.EspPlayer = state
        
        if getgenv().espThreads["player"] then
            pcall(function() coroutine.close(getgenv().espThreads["player"]) end)
            getgenv().espThreads["player"] = nil
        end
        
        for part, data in pairs(getgenv().espObjects) do
            if data and data.type == "Player" then
                removeESP(part)
            end
        end
        
        if not state then return end
        
        getgenv().espThreads["player"] = coroutine.create(function()
            local function getDistance(pos)
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                return hrp and (pos - hrp.Position).Magnitude or 0
            end
            
            while getgenv().FeatureStates.EspPlayer do
                for _, char in ipairs(getAllPlayerCharacters()) do
                    if char.Name ~= LocalPlayer.Name and char:GetAttribute("Team") ~= "Nextbot" then
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            local espData = getgenv().espObjects[hrp] or createESP(hrp, "Player", Color3.fromRGB(100, 180, 255))
                            if espData and espData.label then
                                local dist = getDistance(hrp.Position)
                                local downed = char:GetAttribute("Downed")
                                local downedTime = tonumber(char:GetAttribute("DownedTimeLeft")) or 0
                                
                                local displayText, color
                                if downed == true then
                                    color = Color3.fromRGB(255, 60, 60)
                                    displayText = string.format('%s (Downed %.0f)', char.Name, downedTime)
                                else
                                    color = Color3.fromRGB(100, 255, 100)
                                    displayText = string.format('%s\n%.0f studs', char.Name, dist)
                                end
                                
                                espData.label.Text = displayText
                                espData.label.TextColor3 = color
                            end
                        end
                    end
                end
                task.wait(0.3)
            end
        end)
        
        coroutine.resume(getgenv().espThreads["player"])
    end
})

EspTab:Toggle({
    Title = "Esp Ticket",
    Value = false,
    Callback = function(state)
        getgenv().FeatureStates.EspTicket = state
        
        if getgenv().espThreads["ticket"] then
            pcall(function() coroutine.close(getgenv().espThreads["ticket"]) end)
            getgenv().espThreads["ticket"] = nil
        end
        
        for part, data in pairs(getgenv().espObjects) do
            if data and data.type == "Ticket" then
                removeESP(part)
            end
        end
        
        if not state then return end
        
        getgenv().espThreads["ticket"] = coroutine.create(function()
            local function getDistance(pos)
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                return hrp and (pos - hrp.Position).Magnitude or 0
            end
            
            while getgenv().FeatureStates.EspTicket do
                local tickets = getAllTickets()
                for _, ticketModel in ipairs(tickets) do
                    local part = ticketModel:FindFirstChildWhichIsA("BasePart")
                    if part then
                        local espData = getgenv().espObjects[part] or createESP(part, "Ticket", Color3.fromRGB(255, 255, 100))
                        if espData and espData.label then
                            local dist = getDistance(part.Position)
                            espData.label.Text = string.format("%s\n%.0f studs", ticketModel.Name, dist)
                        end
                    end
                end
                task.wait(0.3)
            end
        end)
        
        coroutine.resume(getgenv().espThreads["ticket"])
    end
})

EspTab:Toggle({
    Title = "Esp Nextbot",
    Value = false,
    Callback = function(state)
        getgenv().FeatureStates.EspNextbot = state
        
        if getgenv().espThreads["nextbot"] then
            pcall(function() coroutine.close(getgenv().espThreads["nextbot"]) end)
            getgenv().espThreads["nextbot"] = nil
        end
        
        for part, data in pairs(getgenv().espObjects) do
            if data and data.type == "Nextbot" then
                removeESP(part)
            end
        end
        
        if not state then return end
        
        getgenv().espThreads["nextbot"] = coroutine.create(function()
            local function getDistance(pos)
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                return hrp and (pos - hrp.Position).Magnitude or 0
            end
            
            while getgenv().FeatureStates.EspNextbot do
                for _, npc in ipairs(getAllNextbots()) do
                    local part = npc:FindFirstChild("Root") or 
                                npc:FindFirstChild("Head") or 
                                npc:FindFirstChild("HumanoidRootPart") or
                                npc:FindFirstChildWhichIsA("BasePart")
                    if part then
                        local espData = getgenv().espObjects[part] or createESP(part, "Nextbot", Color3.fromRGB(200, 100, 255))
                        if espData and espData.label then
                            local dist = getDistance(part.Position)
                            local color = Color3.fromRGB(200, 100, 255)
                            if dist <= 60 then
                                local t = math.clamp((dist - 12) / 48, 0, 1)
                                color = Color3.new(1, 0.235 + 0.765 * t, 0.235)
                            end
                            espData.label.Text = string.format("%s\n%.0f studs", npc.Name, dist)
                            espData.label.TextColor3 = color
                        end
                    end
                end
                task.wait(0.3)
            end
        end)
        
        coroutine.resume(getgenv().espThreads["nextbot"])
    end
})

getgenv().tracerThread = nil
getgenv().tracerLines = {}

local function cleanupTracers()
    for _, line in pairs(getgenv().tracerLines) do
        if line then
            pcall(function() line:Remove() end)
        end
    end
    getgenv().tracerLines = {}
end

EspTab:Toggle({
    Title = "Tracer Downed Players",
    Value = false,
    Callback = function(state)
        getgenv().FeatureStates.TracerDowned = state
        
        if getgenv().tracerThread then
            pcall(function() coroutine.close(getgenv().tracerThread) end)
            getgenv().tracerThread = nil
        end
        
        cleanupTracers()
        
        if not state then return end
        
        getgenv().tracerThread = coroutine.create(function()
            while getgenv().FeatureStates.TracerDowned do
                cleanupTracers()
                if Camera and Drawing then
                    for _, char in ipairs(getAllPlayerCharacters()) do
                        if char.Name ~= LocalPlayer.Name and char:GetAttribute("Downed") == true then
                            local hrp = char:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                                if onScreen then
                                    local tracer = Drawing.new("Line")
                                    tracer.Color = Color3.fromRGB(255, 60, 60)
                                    tracer.Thickness = 1.5
                                    tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                                    tracer.To = Vector2.new(pos.X, pos.Y)
                                    tracer.Visible = true
                                    table.insert(getgenv().tracerLines, tracer)
                                end
                            end
                        end
                    end
                end
                task.wait(0.1)
            end
        end)
        
        coroutine.resume(getgenv().tracerThread)
    end
})

-- ==========================================
-- VISUAL TAB
-- ==========================================
getgenv().GameTimerUI = {
    Enabled = false,
    Connection = nil,
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
    sGui.Name = "TimersUI"
    sGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    sGui.Enabled = getgenv().GameTimerUI.Enabled
    
    local timeLabel = Instance.new("TextLabel")
    timeLabel.Name = "TimeLabel"
    timeLabel.Size = UDim2.new(0, 150, 0, 40)
    timeLabel.Position = UDim2.new(0.02, 0, 0.02, 0)
    timeLabel.BackgroundTransparency = 1
    timeLabel.Text = "Time: 0"
    timeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    timeLabel.TextSize = 18
    timeLabel.Font = Enum.Font.Gotham
    timeLabel.TextXAlignment = Enum.TextXAlignment.Left
    timeLabel.Parent = sGui

    local clientLabel = Instance.new("TextLabel")
    clientLabel.Name = "ClientLabel"
    clientLabel.Size = UDim2.new(0, 150, 0, 40)
    clientLabel.Position = UDim2.new(0.02, 0, 0.07, 0)
    clientLabel.BackgroundTransparency = 1
    clientLabel.Text = "Client Time: 00:00"
    clientLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    clientLabel.TextSize = 18
    clientLabel.Font = Enum.Font.Gotham
    clientLabel.TextXAlignment = Enum.TextXAlignment.Left
    clientLabel.Parent = sGui
    
    getgenv().GameTimerUI.ScreenGui = sGui
    getgenv().GameTimerUI.StartTime = tick()
end

local function updateTimer()
    if getgenv().GameTimerUI.Connection then
        getgenv().GameTimerUI.Connection:Disconnect()
        getgenv().GameTimerUI.Connection = nil
    end
    
    getgenv().GameTimerUI.Connection = RunService.Heartbeat:Connect(function()
        if not getgenv().GameTimerUI.ScreenGui or not getgenv().GameTimerUI.ScreenGui.Enabled then return end
        
        local timeLabel = getgenv().GameTimerUI.ScreenGui:FindFirstChild("TimeLabel")
        local clientLabel = getgenv().GameTimerUI.ScreenGui:FindFirstChild("ClientLabel")
        
        if timeLabel and clientLabel then
            local timerVal = nil
            local statsFolder = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Stats")
            if statsFolder then
                timerVal = statsFolder:GetAttribute("Timer")
            elseif workspace:FindFirstChild("Game") then
                timerVal = workspace.Game:GetAttribute("Timer")
            end
            
            if timerVal then
                timeLabel.Text = "Time: " .. tostring(math.floor(timerVal))
            else
                timeLabel.Text = "Time: 0"
            end
            
            local clientTime = tick() - getgenv().GameTimerUI.StartTime
            clientLabel.Text = "Client Time: " .. formatTime(clientTime)
        end
    end)
end

createTimerUI()

VisualTab:Toggle({
    Title = "Show Game Timer",
    Desc = "Displays game timer and client time",
    Value = getgenv().GameTimerUI.Enabled,
    Callback = function(state)
        getgenv().GameTimerUI.Enabled = state
        if getgenv().GameTimerUI.ScreenGui then
            getgenv().GameTimerUI.ScreenGui.Enabled = state
        end
        if state then
            getgenv().GameTimerUI.StartTime = tick()
            updateTimer()
        else
            if getgenv().GameTimerUI.Connection then
                getgenv().GameTimerUI.Connection:Disconnect()
                getgenv().GameTimerUI.Connection = nil
            end
        end
    end
})

VisualTab:Slider({
    Title = "Field of View",
    Desc = "Adjust your field of view",
    Value = { Min = 1, Max = 120, Default = 70 },
    Callback = function(value)
        local num = tonumber(value)
        if num then
            pcall(function()
                workspace.CurrentCamera.FieldOfView = num
            end)
            pcall(function()
                if ReplicatedStorage:FindFirstChild("Shared") and ReplicatedStorage.Shared:FindFirstChild("UserData") then
                    local setSetting = ReplicatedStorage.Shared.UserData.Events.Requests:FindFirstChild("SetSetting")
                    if setSetting then
                        setSetting:FireServer(2, num)
                    end
                end
            end)
        end
    end
})

VisualTab:Divider()

VisualTab:Input({
    Title = "Music ID",
    Desc = "Masukkan ID musik dari Roblox",
    Value = "",
    PlaceholderText = "Contoh: 1837532419",
    ClearTextOnFocus = false,
    Callback = function(musicId)
        if musicId == "" or not tonumber(musicId) then
            WindUI:Notify({
                Title = "Error",
                Content = "Masukkan ID yang valid!",
                Icon = "alert-circle",
                Duration = 3
            })
            return
        end
        
        for _, child in pairs(workspace:GetChildren()) do
            if child:IsA("Sound") and child.Name == "CustomHubMusic" then
                child:Stop()
                child:Destroy()
            end
        end
        
        local sound = Instance.new("Sound")
        sound.Name = "CustomHubMusic"
        sound.Parent = workspace
        sound.SoundId = "rbxassetid://" .. musicId
        sound.Volume = 2
        sound.Looped = true
        sound:Play()
        
        WindUI:Notify({
            Title = "Music Playing",
            Content = "Memutar musik ID: " .. musicId,
            Icon = "music",
            Duration = 3
        })
    end
})

VisualTab:Button({
    Title = "Stop Music",
    Desc = "Menghentikan semua musik",
    Callback = function()
        local stoppedCount = 0
        for _, child in pairs(workspace:GetChildren()) do
            if child:IsA("Sound") and child.Name == "CustomHubMusic" then
                child:Stop()
                child:Destroy()
                stoppedCount = stoppedCount + 1
            end
        end
        WindUI:Notify({
            Title = "Music Stopped",
            Content = "Menghentikan " .. stoppedCount .. " musik",
            Icon = "stop-circle",
            Duration = 3
        })
    end
})

VisualTab:Toggle({
    Title = "bypass battlepass",
    Desc = "when u buy something the battlepass get normally",
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

VisualTab:Input({
    Title = "Camera Stretch Vertical",
    Value = "0.80",
    Placeholder = "Enter vertical stretch value",
    Callback = function(Value)
        local num = tonumber(Value)
        if num then
            getgenv().FeatureStates.CameraStretchVertical = num
        end
    end
})

VisualTab:Input({
    Title = "Camera Stretch Horizontal",
    Value = "0.80",
    Placeholder = "Enter horizontal stretch value",
    Callback = function(Value)
        local num = tonumber(Value)
        if num then
            getgenv().FeatureStates.CameraStretchHorizontal = num
        end
    end
})

getgenv().ScreenStretchEnabled = false
getgenv().ScreenStretchVertical = 0.65
getgenv().ScreenStretchConn = nil

VisualTab:Toggle({
    Title = "Screen Stretch",
    Desc = "Adjust vertical camera scaling",
    Value = false,
    Callback = function(state)
        getgenv().ScreenStretchEnabled = state
        if state then
            if not getgenv().ScreenStretchConn then
                getgenv().ScreenStretchConn = RunService.RenderStepped:Connect(function()
                    if Camera and getgenv().ScreenStretchEnabled then
                        Camera.CFrame = Camera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, getgenv().ScreenStretchVertical, 0, 0, 0, 1)
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

VisualTab:Divider()

-- Headless & Korblox
getgenv().HeadlessKorblox = {
    Enabled = false,
    Connections = {}
}

local HEADLESS_MESH_ID = "rbxassetid://1095708"
local KORBLOX_MESH_ID = "rbxassetid://101851696"
local KORBLOX_TEXTURE_ID = "rbxassetid://101851254"
local DARK_GREY_COLOR = Color3.fromRGB(64, 64, 64)

local function removeFace(head)
    local face = head:FindFirstChild("face")
    if face then face:Destroy() end
end

local function applyHeadless(head)
    if not head then return end
    head.Transparency = 1
    head.CanCollide = false
    removeFace(head)
    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = HEADLESS_MESH_ID
    mesh.Scale = Vector3.new(0.001, 0.001, 0.001)
    mesh.Parent = head
end

local function applyKorbloxR6(character)
    local rightLeg = character:FindFirstChild("Right Leg")
    if not rightLeg then return end
    for _, child in ipairs(rightLeg:GetChildren()) do
        if child:IsA("SpecialMesh") or child:IsA("CharacterMesh") then child:Destroy() end
    end
    rightLeg.Color = DARK_GREY_COLOR
    local korbloxMesh = Instance.new("SpecialMesh")
    korbloxMesh.MeshType = Enum.MeshType.FileMesh
    korbloxMesh.MeshId = KORBLOX_MESH_ID
    korbloxMesh.TextureId = KORBLOX_TEXTURE_ID
    korbloxMesh.Scale = Vector3.new(1, 1, 1)
    korbloxMesh.Parent = rightLeg
end

local function applyKorbloxR15(character)
    local rightUpperLeg = character:FindFirstChild("RightUpperLeg")
    if not rightUpperLeg then return end
    rightUpperLeg.Transparency = 1
    local rightLowerLeg = character:FindFirstChild("RightLowerLeg")
    local rightFoot = character:FindFirstChild("RightFoot")
    if rightLowerLeg then rightLowerLeg.Transparency = 1 end
    if rightFoot then rightFoot.Transparency = 1 end

    local korbloxLeg = Instance.new("Part")
    korbloxLeg.Name = "KorbloxLeg"
    korbloxLeg.Size = Vector3.new(1, 2, 1)
    korbloxLeg.Anchored = false
    korbloxLeg.CanCollide = false
    korbloxLeg.Color = DARK_GREY_COLOR
    korbloxLeg.Parent = character

    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = KORBLOX_MESH_ID
    mesh.TextureId = KORBLOX_TEXTURE_ID
    mesh.Scale = Vector3.new(1, 1, 1)
    mesh.Parent = korbloxLeg

    local weld = Instance.new("Weld")
    weld.Part0 = rightUpperLeg
    weld.Part1 = korbloxLeg
    weld.C0 = CFrame.new(0, -0.8, 0)
    weld.Parent = korbloxLeg
end

local function applyCharacterVisuals(character)
    if not character then return end
    local head = character:FindFirstChild("Head")
    if head then applyHeadless(head) end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        if humanoid.RigType == Enum.HumanoidRigType.R6 then
            applyKorbloxR6(character)
        elseif humanoid.RigType == Enum.HumanoidRigType.R15 then
            applyKorbloxR15(character)
        end
    end
end

VisualTab:Toggle({
    Title = "Headless & Korblox",
    Desc = "Apply headless head and korblox leg",
    Value = getgenv().HeadlessKorblox.Enabled,
    Callback = function(state)
        getgenv().HeadlessKorblox.Enabled = state
        if state then
            if LocalPlayer.Character then applyCharacterVisuals(LocalPlayer.Character) end
            getgenv().HeadlessKorblox.Connections[1] = LocalPlayer.CharacterAdded:Connect(function(char)
                task.wait(0.5)
                applyCharacterVisuals(char)
            end)
        else
            for _, conn in ipairs(getgenv().HeadlessKorblox.Connections) do
                pcall(function() conn:Disconnect() end)
            end
            getgenv().HeadlessKorblox.Connections = {}
            if LocalPlayer.Character then
                local head = LocalPlayer.Character:FindFirstChild("Head")
                if head then head.Transparency = 0 end
            end
        end
    end
})

VisualTab:Toggle({
    Title = "Fix Animation Cola",
    Desc = "Fixes the cola animation glitch",
    Value = getgenv().FeatureStates.FixColaAnimation,
    Callback = function(state)
        getgenv().FeatureStates.FixColaAnimation = state
        if state then
            local toolRemote = getToolActionRemote()
            if toolRemote then
                pcall(function() toolRemote:FireServer(0, 19) end)
                WindUI:Notify({
                    Title = "Animation Fix",
                    Content = "Cola animation fix triggered!",
                    Duration = 3
                })
            end
        end
    end
})

VisualTab:Divider()

local function getCosmeticsFolder()
    if ReplicatedStorage:FindFirstChild("Items") and ReplicatedStorage.Items:FindFirstChild("Cosmetics") then
        return ReplicatedStorage.Items.Cosmetics
    elseif ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Items") and ReplicatedStorage.Assets.Items:FindFirstChild("Cosmetics") then
        return ReplicatedStorage.Assets.Items.Cosmetics
    elseif ReplicatedStorage:FindFirstChild("Cosmetics") then
        return ReplicatedStorage.Cosmetics
    end
    return nil
end

local cosmetic1, cosmetic2 = "", ""

local function findSimilarCosmetic(name)
    local cosmetics = getCosmeticsFolder()
    if not cosmetics then return nil end
    local cleanName = name:gsub("%s+", ""):lower()
    for _, c in ipairs(cosmetics:GetChildren()) do
        if c.Name:gsub("%s+", ""):lower():find(cleanName) then
            return c.Name
        end
    end
    return nil
end

VisualTab:Input({  
    Title = "Current Cosmetic",  
    Placeholder = "Enter Current Cosmetic",  
    Callback = function(v)
        if v == "" then cosmetic1 = "" return end
        local match = findSimilarCosmetic(v)
        if match then
            cosmetic1 = match
            WindUI:Notify({Title = "Cosmetic Changer", Content = "Current: " .. match})
        else
            cosmetic1 = v
            WindUI:Notify({Title = "Cosmetic Changer", Content = "Set current to: " .. v})
        end
    end  
})  

VisualTab:Input({  
    Title = "Select Cosmetic",  
    Placeholder = "like Toxic Inf",  
    Callback = function(v)
        if v == "" then cosmetic2 = "" return end
        local match = findSimilarCosmetic(v)
        if match then
            cosmetic2 = match
            WindUI:Notify({Title = "Cosmetic Changer", Content = "Select: " .. match})
        else
            cosmetic2 = v
            WindUI:Notify({Title = "Cosmetic Changer", Content = "Set target to: " .. v})
        end
    end  
})  

VisualTab:Button({  
    Title = "Apply Cosmetic",  
    Callback = function()  
        pcall(function()
            local cosmetics = getCosmeticsFolder()
            if not cosmetics or cosmetic1 == "" or cosmetic2 == "" then
                WindUI:Notify({Title = "Cosmetic Changer", Content = "Cosmetics folder or targets not found"})
                return
            end
            local a = cosmetics:FindFirstChild(cosmetic1)
            local b = cosmetics:FindFirstChild(cosmetic2)
            if a and b then
                for _, c in ipairs(a:GetChildren()) do c.Parent = b end
                WindUI:Notify({Title = "Cosmetic Changer", Content = "Applied successfully!"})
            end
        end)
    end  
})

VisualTab:Divider()

getgenv().currentEmotes = getgenv().currentEmotes or table.create(6, "")
getgenv().selectEmotes = getgenv().selectEmotes or table.create(6, "")
getgenv().emoteEnabled = getgenv().emoteEnabled or table.create(6, false)

for i = 1, 6 do
    VisualTab:Input({
        Title = "Current Emote " .. i,
        Placeholder = "Enter current emote name",
        Value = getgenv().currentEmotes[i],
        Callback = function(v)
            getgenv().currentEmotes[i] = v
        end
    })

    VisualTab:Input({
        Title = "Select Emote " .. i,
        Placeholder = "Enter select emote name",
        Value = getgenv().selectEmotes[i],
        Callback = function(v)
            getgenv().selectEmotes[i] = v
        end
    })

    VisualTab:Button({
        Title = "Apply Slot " .. i,
        Callback = function()
            getgenv().emoteEnabled[i] = (getgenv().currentEmotes[i] ~= "" and getgenv().selectEmotes[i] ~= "")
            if getgenv().emoteEnabled[i] then
                playEmote(getgenv().selectEmotes[i])
            end
            WindUI:Notify({Title = "Emote Changer", Content = "Slot " .. i .. " applied!"})
        end
    })

    VisualTab:Divider()
end

VisualTab:Button({
    Title = "Reset All Emotes",
    Callback = function()
        for i = 1, 6 do
            getgenv().currentEmotes[i] = ""
            getgenv().selectEmotes[i] = ""
            getgenv().emoteEnabled[i] = false
        end
        WindUI:Notify({Title = "Emote Changer", Content = "All emotes reset!"})
    end
})

VisualTab:Divider()

VisualTab:Input({
    Title = "Fake Streaks",
    Placeholder = "Enter streak value",
    Callback = function(value)
        local num = tonumber(value)
        if num then
            pcall(function()
                LocalPlayer:SetAttribute("Streak", num)
                WindUI:Notify({
                    Title = "Streak",
                    Content = string.format("Streak set to %d", num),
                    Duration = 3
                })
            end)
        end
    end
})

-- ==========================================
-- SETTINGS TAB
-- ==========================================
SettingsTab:Section({Title = "Settings"})

local themeValues = {}
for name, _ in pairs(getgenv().WindUI:GetThemes()) do
    table.insert(themeValues, name)
end

local themeDropdown = SettingsTab:Dropdown({
    Title = "Select Theme",
    Multi = false,
    AllowNone = false,
    Values = themeValues,
    Callback = function(theme)
        getgenv().WindUI:SetTheme(theme)
    end
})

pcall(function() themeDropdown:Select(getgenv().WindUI:GetCurrentTheme()) end)

local currentBackground = "rbxassetid://85878831310179"

local function applyBackground(value)
    if value:match("^https?://") and value:match("%.webm") then
        currentBackground = "video:" .. value
    elseif value:match("^video:") or value:match("^rbxassetid://") then
        currentBackground = value
    elseif value:match("^%d+$") then
        currentBackground = "rbxassetid://" .. value
    else
        currentBackground = ""
    end
    pcall(function() Window:SetBackgroundImage(currentBackground) end)
end

SettingsTab:Input({
    Title = "Background Image/Video",
    Value = currentBackground:match("%d+") or "",
    Placeholder = "Asset ID or Video Link",
    Callback = applyBackground
})

SettingsTab:Dropdown({
    Title = "Recommended Backgrounds",
    Values = {"85878831310179", "no Background"},
    Default = currentBackground:match("%d+"),
    Callback = applyBackground
})

SettingsTab:Button({
    Title = "Remove Background",
    Callback = function()
        applyBackground("")
    end
})

SettingsTab:Toggle({
    Title = "Toggle Window Transparency",
    Callback = function(e)
        pcall(function() Window:ToggleTransparency(e) end)
    end,
    Value = getgenv().WindUI:GetTransparency()
})

pcall(function()
    local ConfigManager = Window.ConfigManager
    if ConfigManager then
        local myConfig = ConfigManager:CreateConfig("WeroShinyConfig")
        SettingsTab:Button({
            Title = "Save Configuration",
            Callback = function()
                myConfig:Save()
                WindUI:Notify({Title = "Configuration", Content = "Settings saved successfully!", Duration = 3})
            end
        })
        SettingsTab:Button({
            Title = "Load Configuration",
            Callback = function()
                myConfig:Load()
                WindUI:Notify({Title = "Configuration", Content = "Settings loaded successfully!", Duration = 3})
            end
        })
    end
end)

Window:SelectTab(1)

WindUI:Notify({
    Title = "From SYFTA",
    Content = "🎄MERRY CHRISTMAS ALL🎄",
    Duration = 3,
    Icon = "heart",
})

-- ==========================================
-- GLOBAL CLEANUP ON PLAYER REMOVING
-- ==========================================
LocalPlayer.CharacterRemoving:Connect(function()
    if getgenv().frontJumpVelocity then
        getgenv().frontJumpVelocity:Destroy()
        getgenv().frontJumpVelocity = nil
    end
    getgenv().FeatureStates.FrontJumpEnabled = false
end)

game:GetService("Players").PlayerRemoving:Connect(function(leaving)
    if leaving == LocalPlayer then
        cleanupESP()
        cleanupTracers()
        
        if getgenv().bhopConnection then getgenv().bhopConnection:Disconnect() end
        if getgenv().infiniteSlideHeartbeat then getgenv().infiniteSlideHeartbeat:Disconnect() end
        if getgenv().infiniteSlideCharacterConn then getgenv().infiniteSlideCharacterConn:Disconnect() end
        if respawnConnection then respawnConnection:Disconnect() end
        if AutoSelfReviveConnection then AutoSelfReviveConnection:Disconnect() end
        if getgenv().InstantReviveConnection then getgenv().InstantReviveConnection:Disconnect() end
        if getgenv().AutoTicketFarmConnection then getgenv().AutoTicketFarmConnection:Disconnect() end
        if getgenv().AutoMoneyFarmConnection then getgenv().AutoMoneyFarmConnection:Disconnect() end
        if getgenv().ScreenStretchConn then getgenv().ScreenStretchConn:Disconnect() end
        if getgenv().AutoCarryConnection then getgenv().AutoCarryConnection:Disconnect() end
        
        if getgenv().AntiAFK and getgenv().AntiAFK.Connection then
            getgenv().AntiAFK.Connection:Disconnect()
            getgenv().AntiAFK.Connection = nil
        end
        
        if getgenv().activeBV then
            getgenv().activeBV:Destroy()
            getgenv().activeBV = nil
        end
        
        if getgenv().GameTimerUI and getgenv().GameTimerUI.ScreenGui then
            getgenv().GameTimerUI.ScreenGui:Destroy()
        end
        
        if getgenv().frontJumpVelocity then
            getgenv().frontJumpVelocity:Destroy()
            getgenv().frontJumpVelocity = nil
        end
        
        for _, toggle in pairs(getgenv().featureToggles) do
            if toggle and toggle.Gui then
                pcall(function() toggle.Gui:Destroy() end)
            end
        end
    end
end)
