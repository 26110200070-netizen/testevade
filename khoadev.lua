--[[
    Evade Script - Full Features
    - ESP Player (Hiển thị tên đỏ nếu người chơi gục)
    - Auto Revive Instant (Tự động cứu, bỏ qua thời gian chờ, chạy tới gần là hồi sinh)
    - Custom FOV (Chỉnh tầm nhìn xa hơn)
    - Auto Carry (Tới gần đồng đội gục tự động bế lên)
    - Auto Forward Jump (Nhảy về phía trước có chỉnh tốc độ, mặc định 50)
    - UI: WindUI
--]]

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Load WindUI Library
local WindUI
local loadSuccess, loadResult = pcall(function()
    return loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()
end)

if not loadSuccess or not loadResult then
    local s2, r2 = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
    end)
    if s2 and r2 then
        WindUI = r2
    end
end

if not WindUI then
    pcall(function()
        if readfile and isfile and isfile("windUI.lua") then
            WindUI = loadstring(readfile("windUI.lua"))()
        end
    end)
end

if not WindUI then
    warn("[Evade Script] Không thể tải thư viện WindUI. Vui lòng kiểm tra kết nối mạng của executor.")
    return
end

-- Configuration Table
local Config = {
    -- ESP
    ESPEnabled = false,
    ESPHighlight = true,
    
    -- Auto Revive
    AutoRevive = false,
    ReviveDistance = 25,
    
    -- Auto Carry
    AutoCarry = false,
    CarryDistance = 15,
    
    -- FOV
    FOVEnabled = false,
    FOVValue = 90,
    DefaultFOV = 70,
    
    -- Forward Jump
    AutoForwardJump = false,
    ForwardJumpSpeed = 50,
    JumpKeybind = Enum.KeyCode.V
}

-- Remotes Finder
local function getRemote(name)
    local events = ReplicatedStorage:FindFirstChild("Events")
    if events then
        return events:FindFirstChild(name)
    end
    return nil
end

-- Check if Player is Downed
local function isPlayerDowned(player)
    if not player then return false end
    
    -- Check Evade Tickets Folder
    local gameFolder = workspace:FindFirstChild("Game")
    if gameFolder then
        local effects = gameFolder:FindFirstChild("Effects")
        if effects then
            local tickets = effects:FindFirstChild("Tickets")
            if tickets and tickets:FindFirstChild(player.Name) then
                return true
            end
        end
    end
    
    local char = player.Character
    if not char then return false end
    
    -- Check Attributes
    if char:GetAttribute("Downed") == true 
       or char:GetAttribute("Down") == true 
       or char:GetAttribute("IsDowned") == true then
        return true
    end
    
    -- Check Children Objects/Tags
    if char:FindFirstChild("Downed") 
       or char:FindFirstChild("BleedOut") 
       or char:FindFirstChild("Revive") 
       or char:FindFirstChild("DownedPrompt") then
        return true
    end
    
    if CollectionService:HasTag(char, "Downed") then
        return true
    end
    
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum and hum.Health <= 0 then
        return true
    end
    
    return false
end

-- Get all downed targets (Tickets & Characters)
local function getDownedTargets()
    local targets = {}
    local seenNames = {}
    
    -- 1. Check workspace.Game.Effects.Tickets
    local gameFolder = workspace:FindFirstChild("Game")
    if gameFolder then
        local effects = gameFolder:FindFirstChild("Effects")
        if effects then
            local tickets = effects:FindFirstChild("Tickets")
            if tickets then
                for _, ticket in ipairs(tickets:GetChildren()) do
                    local hrp = ticket:FindFirstChild("HumanoidRootPart") or ticket:FindFirstChildWhichIsA("BasePart")
                    if hrp then
                        seenNames[ticket.Name] = true
                        table.insert(targets, {
                            Name = ticket.Name,
                            Instance = ticket,
                            Position = hrp.Position,
                            RootPart = hrp
                        })
                    end
                end
            end
        end
    end
    
    -- 2. Check Players directly
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and not seenNames[plr.Name] and isPlayerDowned(plr) then
            local char = plr.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head")
                if hrp then
                    seenNames[plr.Name] = true
                    table.insert(targets, {
                        Name = plr.Name,
                        Player = plr,
                        Instance = char,
                        Position = hrp.Position,
                        RootPart = hrp
                    })
                end
            end
        end
    end
    
    return targets
end

-- Auto Revive Function (Instant Bypass)
local function performInstantRevive(target)
    local interact = getRemote("Interact")
    local charTask = getRemote("CharacterTask")
    
    if interact then
        -- Gửi tín hiệu hoàn tất cứu bỏ qua thời gian đếm ngược
        interact:FireServer(target.Name, true)
        interact:FireServer(target.Instance, true)
        interact:FireServer(target.Name, false)
        interact:FireServer(target.Name)
    end
    if charTask then
        charTask:FireServer("Revive", target.Instance)
        charTask:FireServer("Revive", target.Name)
    end
end

-- Auto Revive Loop
task.spawn(function()
    while true do
        task.wait(0.08)
        if Config.AutoRevive then
            local myChar = LocalPlayer.Character
            local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
            if myHrp then
                local downedList = getDownedTargets()
                for _, target in ipairs(downedList) do
                    local dist = (myHrp.Position - target.Position).Magnitude
                    if dist <= Config.ReviveDistance then
                        performInstantRevive(target)
                    end
                end
            end
        end
    end
end)

-- Auto Carry Function
local function performCarry(target)
    local interact = getRemote("Interact")
    local charTask = getRemote("CharacterTask")
    local action = getRemote("Action")
    
    if interact then
        interact:FireServer(target.Name, "Carry")
        interact:FireServer("Carry", target.Name)
        interact:FireServer(target.Instance, "Carry")
    end
    if charTask then
        charTask:FireServer("Carry", target.Instance)
        charTask:FireServer("Carry", target.Name)
    end
    if action then
        action:FireServer("Carry", target.Name)
        action:FireServer("Carry", target.Instance)
    end
end

-- Auto Carry Loop
task.spawn(function()
    while true do
        task.wait(0.12)
        if Config.AutoCarry then
            local myChar = LocalPlayer.Character
            local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
            if myHrp then
                local downedList = getDownedTargets()
                for _, target in ipairs(downedList) do
                    local dist = (myHrp.Position - target.Position).Magnitude
                    if dist <= Config.CarryDistance then
                        performCarry(target)
                    end
                end
            end
        end
    end
end)

-- Forward Jump Function
local jumpDebounce = false
local function performForwardJump(speed)
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum or hum.Health <= 0 then return end
    
    if jumpDebounce then return end
    jumpDebounce = true
    
    -- Kích hoạt nhảy
    hum.Jump = true
    
    -- Tính hướng nhìn phía trước
    local look = Camera.CFrame.LookVector
    local forwardDir = Vector3.new(look.X, 0, look.Z)
    if forwardDir.Magnitude > 0.05 then
        forwardDir = forwardDir.Unit
    else
        forwardDir = hrp.CFrame.LookVector
    end
    
    -- Tác động vận tốc lao về phía trước với tốc độ cấu hình
    local currentY = hrp.AssemblyLinearVelocity.Y
    local jumpY = math.max(currentY, 36)
    
    hrp.AssemblyLinearVelocity = Vector3.new(
        forwardDir.X * speed,
        jumpY,
        forwardDir.Z * speed
    )
    
    task.delay(0.2, function()
        jumpDebounce = false
    end)
end

-- Jump Listeners
UserInputService.JumpRequest:Connect(function()
    if Config.AutoForwardJump then
        performForwardJump(Config.ForwardJumpSpeed)
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Config.JumpKeybind then
        performForwardJump(Config.ForwardJumpSpeed)
    end
end)

-- FOV Controller
RunService.RenderStepped:Connect(function()
    if Config.FOVEnabled then
        if Camera.FieldOfView ~= Config.FOVValue then
            Camera.FieldOfView = Config.FOVValue
        end
    end
end)

-- Player ESP System (Tên đỏ nếu gục)
local espStorage = {}

local function createESPForPlayer(player)
    if player == LocalPlayer then return end
    
    local function setup(char)
        task.wait(0.2)
        local head = char:WaitForChild("Head", 5)
        local hrp = char:WaitForChild("HumanoidRootPart", 5)
        if not head or not hrp then return end
        
        -- BillboardGui
        local bbg = Instance.new("BillboardGui")
        bbg.Name = "Evade_ESP_" .. player.Name
        bbg.Adornee = head
        bbg.Size = UDim2.new(0, 200, 0, 45)
        bbg.StudsOffset = Vector3.new(0, 2.8, 0)
        bbg.AlwaysOnTop = true
        bbg.ResetOnSpawn = false
        bbg.Enabled = Config.ESPEnabled
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Name = "NameLabel"
        nameLabel.BackgroundTransparency = 1
        nameLabel.Size = UDim2.new(1, 0, 0.55, 0)
        nameLabel.Position = UDim2.new(0, 0, 0, 0)
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextSize = 13
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextStrokeTransparency = 0
        nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        nameLabel.Text = player.DisplayName
        nameLabel.Parent = bbg
        
        local infoLabel = Instance.new("TextLabel")
        infoLabel.Name = "InfoLabel"
        infoLabel.BackgroundTransparency = 1
        infoLabel.Size = UDim2.new(1, 0, 0.45, 0)
        infoLabel.Position = UDim2.new(0, 0, 0.55, 0)
        infoLabel.Font = Enum.Font.GothamMedium
        infoLabel.TextSize = 11
        infoLabel.TextColor3 = Color3.fromRGB(180, 255, 180)
        infoLabel.TextStrokeTransparency = 0
        infoLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        infoLabel.Text = "0 studs"
        infoLabel.Parent = bbg
        
        -- Highlight
        local hl = Instance.new("Highlight")
        hl.Name = "Evade_HL_" .. player.Name
        hl.Adornee = char
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hl.FillTransparency = 0.65
        hl.OutlineTransparency = 0.1
        hl.FillColor = Color3.fromRGB(50, 220, 255)
        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
        hl.Enabled = Config.ESPEnabled and Config.ESPHighlight
        
        -- Parent GUI safely
        local coreGui = game:GetService("CoreGui")
        local guiParent = coreGui:FindFirstChild("RobloxGui") or LocalPlayer:FindFirstChildOfClass("PlayerGui") or coreGui
        bbg.Parent = guiParent
        hl.Parent = char
        
        espStorage[player] = {
            Billboard = bbg,
            Highlight = hl,
            NameLabel = nameLabel,
            InfoLabel = infoLabel,
            Character = char,
            RootPart = hrp
        }
    end
    
    if player.Character then
        setup(player.Character)
    end
    player.CharacterAdded:Connect(setup)
end

local function removeESPForPlayer(player)
    local entry = espStorage[player]
    if entry then
        if entry.Billboard then entry.Billboard:Destroy() end
        if entry.Highlight then entry.Highlight:Destroy() end
        espStorage[player] = nil
    end
end

for _, plr in ipairs(Players:GetPlayers()) do
    createESPForPlayer(plr)
end
Players.PlayerAdded:Connect(createESPForPlayer)
Players.PlayerRemoving:Connect(removeESPForPlayer)

-- ESP Update Loop
RunService.RenderStepped:Connect(function()
    if not Config.ESPEnabled then
        for _, entry in pairs(espStorage) do
            if entry.Billboard and entry.Billboard.Enabled then entry.Billboard.Enabled = false end
            if entry.Highlight and entry.Highlight.Enabled then entry.Highlight.Enabled = false end
        end
        return
    end
    
    local myChar = LocalPlayer.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
    
    for plr, entry in pairs(espStorage) do
        if plr.Parent and entry.Character and entry.Character.Parent and entry.RootPart and entry.RootPart.Parent then
            entry.Billboard.Enabled = true
            entry.Highlight.Enabled = Config.ESPHighlight
            
            local dist = myHrp and math.floor((myHrp.Position - entry.RootPart.Position).Magnitude) or 0
            local downed = isPlayerDowned(plr)
            
            if downed then
                -- Hiển thị tên ĐỎ nếu người chơi gục
                entry.NameLabel.TextColor3 = Color3.fromRGB(255, 45, 45)
                entry.NameLabel.Text = "[GỤC] " .. plr.DisplayName .. " (@" .. plr.Name .. ")"
                entry.InfoLabel.TextColor3 = Color3.fromRGB(255, 130, 130)
                entry.InfoLabel.Text = string.format("%d studs | CẦN CỨU", dist)
                
                entry.Highlight.FillColor = Color3.fromRGB(255, 30, 30)
                entry.Highlight.OutlineColor = Color3.fromRGB(255, 60, 60)
            else
                -- Người chơi bình thường
                entry.NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                entry.NameLabel.Text = plr.DisplayName
                entry.InfoLabel.TextColor3 = Color3.fromRGB(120, 255, 140)
                entry.InfoLabel.Text = string.format("%d studs", dist)
                
                entry.Highlight.FillColor = Color3.fromRGB(30, 180, 255)
                entry.Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            end
        else
            if entry.Billboard then entry.Billboard.Enabled = false end
            if entry.Highlight then entry.Highlight.Enabled = false end
        end
    end
end)

-- BUILD WINDUI INTERFACE
local Window = WindUI:CreateWindow({
    Title = "Evade Master Hub",
    Icon = "shield-alert",
    Author = "Evade Support Script",
    Folder = "EvadeHubConfig",
    Size = UDim2.fromOffset(580, 480),
    Theme = "Dark",
    Acrylic = false,
    SideBarWidth = 190,
    OpenButton = {
        Title = "Mở Evade Hub",
        CornerRadius = UDim.new(1, 0),
        StrokeThickness = 2,
        Enabled = true,
        Color = ColorSequence.new(
            Color3.fromHex("#FF3366"),
            Color3.fromHex("#3399FF")
        )
    }
})

-- Topbar Quick Notify Button
Window:CreateTopbarButton("quick-theme", "moon", function()
    local newTheme = WindUI:GetCurrentTheme() == "Dark" and "Light" or "Dark"
    WindUI:SetTheme(newTheme)
    WindUI:Notify({
        Title = "Giao diện",
        Content = "Đã chuyển theme: " .. newTheme,
        Duration = 2
    })
end, 990)

-- Sections & Tabs
local MainSection = Window:Section({ Title = "CHỨC NĂNG CHÍNH", Opened = true })
local VisualSection = Window:Section({ Title = "HIỂN THỊ & GIAO DIỆN", Opened = true })

local TabMain = MainSection:Tab({ Title = "Hồi Sinh & Nhặt", Icon = "heart-pulse", Desc = "Tự động cứu và bế đồng đội" })
local TabMove = MainSection:Tab({ Title = "Nhảy Phía Trước", Icon = "zap", Desc = "Cấu hình tốc độ nhảy lướt" })
local TabVisual = VisualSection:Tab({ Title = "ESP & Tầm Nhìn", Icon = "eye", Desc = "ESP người chơi và chỉnh FOV" })

-- TAB 1: AUTO REVIVE & CARRY
TabMain:Toggle({
    Title = "Tự Động Cứu (Auto Revive)",
    Desc = "Lại gần đồng đội gục tự động hồi sinh bỏ qua thời gian chờ",
    Value = Config.AutoRevive,
    Callback = function(state)
        Config.AutoRevive = state
        WindUI:Notify({
            Title = "Auto Revive",
            Content = state and "Đã BẬT tự động cứu không chờ" or "Đã TẮT tự động cứu",
            Icon = state and "check" or "x",
            Duration = 2
        })
    end
})

TabMain:Slider({
    Title = "Khoảng Cách Tự Động Cứu",
    Desc = "Khoảng cách phát hiện đồng đội để hồi sinh ngay",
    Value = { Min = 5, Max = 50, Default = Config.ReviveDistance },
    Step = 1,
    Callback = function(val)
        Config.ReviveDistance = val
    end
})

TabMain:Divider()

TabMain:Toggle({
    Title = "Tự Động Bế (Auto Carry)",
    Desc = "Lại gần đồng đội gục tự động bế lên",
    Value = Config.AutoCarry,
    Callback = function(state)
        Config.AutoCarry = state
        WindUI:Notify({
            Title = "Auto Carry",
            Content = state and "Đã BẬT tự động bế" or "Đã TẮT tự động bế",
            Icon = state and "check" or "x",
            Duration = 2
        })
    end
})

TabMain:Slider({
    Title = "Khoảng Cách Tự Động Bế",
    Desc = "Khoảng cách tới đồng đội để tự động bế lên",
    Value = { Min = 5, Max = 30, Default = Config.CarryDistance },
    Step = 1,
    Callback = function(val)
        Config.CarryDistance = val
    end
})

-- TAB 2: AUTO FORWARD JUMP
TabMove:Toggle({
    Title = "Auto Nhảy Phía Trước (Phím Nhảy)",
    Desc = "Khi bấm nút Nhảy (Space), nhân vật tự động phóng về phía trước",
    Value = Config.AutoForwardJump,
    Callback = function(state)
        Config.AutoForwardJump = state
        WindUI:Notify({
            Title = "Auto Forward Jump",
            Content = state and "Đã BẬT phóng nhảy khi bấm Space" or "Đã TẮT",
            Icon = state and "check" or "x",
            Duration = 2
        })
    end
})

TabMove:Input({
    Title = "Tốc Độ Nhảy (Input Mặc Định 50)",
    Desc = "Nhập tốc độ lướt về phía trước (mặc định 50)",
    Value = tostring(Config.ForwardJumpSpeed),
    Callback = function(text)
        local num = tonumber(text)
        if num and num > 0 then
            Config.ForwardJumpSpeed = num
            WindUI:Notify({
                Title = "Tốc Độ Nhảy",
                Content = "Đã cập nhật tốc độ: " .. tostring(num),
                Duration = 2
            })
        end
    end
})

TabMove:Slider({
    Title = "Thanh Trượt Tốc Độ Nhảy",
    Desc = "Kéo để chỉnh tốc độ nhanh chóng",
    Value = { Min = 10, Max = 200, Default = 50 },
    Step = 1,
    Callback = function(val)
        Config.ForwardJumpSpeed = val
    end
})

TabMove:Button({
    Title = "Kích Hoạt Nhảy Ngay",
    Desc = "Bấm để nhân vật lập tức nhảy vọt về phía trước một lần",
    Icon = "arrow-up-right",
    Callback = function()
        performForwardJump(Config.ForwardJumpSpeed)
    end
})

TabMove:Paragraph({
    Title = "Mẹo Sử Dụng",
    Desc = "Bạn có thể bấm trực tiếp nút Nhảy Ngay ở trên hoặc bấm phím Space khi bật toggle để bay vượt chướng ngại vật cực mượt!",
    Image = "info",
    ImageSize = 20
})

-- TAB 3: ESP & FOV
TabVisual:Toggle({
    Title = "ESP Người Chơi (ESP Player)",
    Desc = "Hiển thị tên người chơi xuyên tường, tên chuyển ĐỎ khi người chơi gục",
    Value = Config.ESPEnabled,
    Callback = function(state)
        Config.ESPEnabled = state
        WindUI:Notify({
            Title = "Player ESP",
            Content = state and "Đã BẬT ESP người chơi" or "Đã TẮT ESP",
            Icon = state and "check" or "x",
            Duration = 2
        })
    end
})

TabVisual:Toggle({
    Title = "ESP Viền Nhân Vật (Highlight)",
    Desc = "Hiển thị khung viền màu quanh nhân vật xuyên tường",
    Value = Config.ESPHighlight,
    Callback = function(state)
        Config.ESPHighlight = state
    end
})

TabVisual:Divider()

TabVisual:Toggle({
    Title = "Bật Chỉnh FOV (Tầm Nhìn Xa)",
    Desc = "Mở rộng góc nhìn camera xa hơn bao quát bản đồ",
    Value = Config.FOVEnabled,
    Callback = function(state)
        Config.FOVEnabled = state
        if not state then
            Camera.FieldOfView = Config.DefaultFOV
        else
            Camera.FieldOfView = Config.FOVValue
        end
        WindUI:Notify({
            Title = "Field Of View",
            Content = state and "Đã kích hoạt FOV tùy chỉnh" or "Đã khôi phục FOV mặc định",
            Duration = 2
        })
    end
})

TabVisual:Slider({
    Title = "Góc Nhìn FOV",
    Desc = "Điều chỉnh góc nhìn từ 70 đến 120",
    Value = { Min = 70, Max = 120, Default = 90 },
    Step = 1,
    Callback = function(val)
        Config.FOVValue = val
        if Config.FOVEnabled then
            Camera.FieldOfView = val
        end
    end
})

-- Thông báo khi script khởi chạy thành công
WindUI:Notify({
    Title = "Evade Hub Đã Tải!",
    Content = "Tất cả chức năng đã sẵn sàng để sử dụng.",
    Icon = "check-check",
    Duration = 3
})
