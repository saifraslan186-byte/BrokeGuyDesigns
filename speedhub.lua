-- ================================
-- Admin Commands Script
-- Similar to Infinite Yield
-- Execute in Roblox Executor
-- ================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

local Prefix = ";"

-- ================================
-- CORE GUI
-- ================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AdminCommands"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui")

-- Command Bar
local CommandFrame = Instance.new("Frame")
CommandFrame.Size = UDim2.new(0, 500, 0, 36)
CommandFrame.Position = UDim2.new(0.5, -250, 1, -60)
CommandFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
CommandFrame.BackgroundTransparency = 0.2
CommandFrame.BorderSizePixel = 0
CommandFrame.Visible = false
CommandFrame.Parent = ScreenGui
Instance.new("UICorner", CommandFrame).CornerRadius = UDim.new(0, 8)

local CommandBox = Instance.new("TextBox")
CommandBox.Size = UDim2.new(1, -10, 1, -6)
CommandBox.Position = UDim2.new(0, 5, 0, 3)
CommandBox.BackgroundTransparency = 1
CommandBox.TextColor3 = Color3.fromRGB(255, 255, 255)
CommandBox.PlaceholderText = "Enter command... (e.g. ws 50)"
CommandBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
CommandBox.TextSize = 16
CommandBox.Font = Enum.Font.GothamMedium
CommandBox.TextXAlignment = Enum.TextXAlignment.Left
CommandBox.ClearTextOnFocus = true
CommandBox.Parent = CommandFrame

-- Notification
local NotifLabel = Instance.new("TextLabel")
NotifLabel.Size = UDim2.new(0, 400, 0, 30)
NotifLabel.Position = UDim2.new(0.5, -200, 0, 10)
NotifLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
NotifLabel.BackgroundTransparency = 0.2
NotifLabel.BorderSizePixel = 0
NotifLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
NotifLabel.TextSize = 14
NotifLabel.Font = Enum.Font.GothamMedium
NotifLabel.Text = ""
NotifLabel.Visible = false
NotifLabel.Parent = ScreenGui
Instance.new("UICorner", NotifLabel).CornerRadius = UDim.new(0, 6)

-- ================================
-- WELCOME GUI
-- ================================
local WelcomeFrame = Instance.new("Frame")
WelcomeFrame.Size = UDim2.new(0, 340, 0, 200)
WelcomeFrame.Position = UDim2.new(0.5, -170, -0.3, 0)
WelcomeFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
WelcomeFrame.BackgroundTransparency = 0.05
WelcomeFrame.BorderSizePixel = 0
WelcomeFrame.ZIndex = 20
WelcomeFrame.Parent = ScreenGui
Instance.new("UICorner", WelcomeFrame).CornerRadius = UDim.new(0, 14)

-- Top accent bar
local AccentBar = Instance.new("Frame")
AccentBar.Size = UDim2.new(1, 0, 0, 4)
AccentBar.BackgroundColor3 = Color3.fromRGB(100, 220, 255)
AccentBar.BorderSizePixel = 0
AccentBar.ZIndex = 21
AccentBar.Parent = WelcomeFrame
Instance.new("UICorner", AccentBar).CornerRadius = UDim.new(0, 4)

local WelcomeTitle = Instance.new("TextLabel")
WelcomeTitle.Size = UDim2.new(1, 0, 0, 44)
WelcomeTitle.Position = UDim2.new(0, 0, 0, 14)
WelcomeTitle.BackgroundTransparency = 1
WelcomeTitle.TextColor3 = Color3.fromRGB(100, 220, 255)
WelcomeTitle.TextSize = 22
WelcomeTitle.Font = Enum.Font.GothamBold
WelcomeTitle.Text = "⚡ Admin Commands"
WelcomeTitle.ZIndex = 21
WelcomeTitle.Parent = WelcomeFrame

local WelcomeSub = Instance.new("TextLabel")
WelcomeSub.Size = UDim2.new(1, -20, 0, 24)
WelcomeSub.Position = UDim2.new(0, 10, 0, 58)
WelcomeSub.BackgroundTransparency = 1
WelcomeSub.TextColor3 = Color3.fromRGB(180, 180, 180)
WelcomeSub.TextSize = 14
WelcomeSub.Font = Enum.Font.Gotham
WelcomeSub.Text = "Welcome, " .. LocalPlayer.Name .. "!"
WelcomeSub.ZIndex = 21
WelcomeSub.Parent = WelcomeFrame

local WelcomeInfo = Instance.new("TextLabel")
WelcomeInfo.Size = UDim2.new(1, -20, 0, 40)
WelcomeInfo.Position = UDim2.new(0, 10, 0, 86)
WelcomeInfo.BackgroundTransparency = 1
WelcomeInfo.TextColor3 = Color3.fromRGB(140, 140, 140)
WelcomeInfo.TextSize = 13
WelcomeInfo.Font = Enum.Font.Gotham
WelcomeInfo.TextWrapped = true
WelcomeInfo.Text = "Press  [ ; ]  to open the command bar\nType  cmds  to list all commands"
WelcomeInfo.ZIndex = 21
WelcomeInfo.Parent = WelcomeFrame

-- Command count badge
local BadgeFrame = Instance.new("Frame")
BadgeFrame.Size = UDim2.new(0, 160, 0, 28)
BadgeFrame.Position = UDim2.new(0.5, -80, 0, 132)
BadgeFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
BadgeFrame.BorderSizePixel = 0
BadgeFrame.ZIndex = 21
BadgeFrame.Parent = WelcomeFrame
Instance.new("UICorner", BadgeFrame).CornerRadius = UDim.new(0, 8)

local BadgeLabel = Instance.new("TextLabel")
BadgeLabel.Size = UDim2.new(1, 0, 1, 0)
BadgeLabel.BackgroundTransparency = 1
BadgeLabel.TextColor3 = Color3.fromRGB(100, 220, 255)
BadgeLabel.TextSize = 13
BadgeLabel.Font = Enum.Font.GothamMedium
BadgeLabel.Text = "✦ 15 Commands Loaded"
BadgeLabel.ZIndex = 22
BadgeLabel.Parent = BadgeFrame

-- Close button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(1, -20, 0, 32)
CloseBtn.Position = UDim2.new(0, 10, 0, 158)
CloseBtn.BackgroundColor3 = Color3.fromRGB(100, 220, 255)
CloseBtn.BorderSizePixel = 0
CloseBtn.TextColor3 = Color3.fromRGB(10, 10, 10)
CloseBtn.Text = "Let's Go →"
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.ZIndex = 21
CloseBtn.Parent = WelcomeFrame
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

-- Animate welcome in
local tweenIn = TweenService:Create(WelcomeFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.5, -170, 0.5, -100)
})
tweenIn:Play()

CloseBtn.MouseButton1Click:Connect(function()
    local tweenOut = TweenService:Create(WelcomeFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, -170, -0.3, 0)
    })
    tweenOut:Play()
    tweenOut.Completed:Connect(function() WelcomeFrame:Destroy() end)
end)

-- Auto-close after 6 seconds
task.delay(6, function()
    if WelcomeFrame and WelcomeFrame.Parent then
        local tweenOut = TweenService:Create(WelcomeFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, -170, -0.3, 0)
        })
        tweenOut:Play()
        tweenOut.Completed:Connect(function() WelcomeFrame:Destroy() end)
    end
end)

-- ================================
-- UTILITIES
-- ================================
local function Notify(msg, color)
    color = color or Color3.fromRGB(100, 220, 255)
    NotifLabel.Text = " ✦ " .. msg
    NotifLabel.TextColor3 = color
    NotifLabel.Visible = true
    task.delay(3, function() NotifLabel.Visible = false end)
end

local function GetPlayer(name)
    name = name:lower()
    if name == "me" then return LocalPlayer end
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Name:lower():sub(1, #name) == name then return p end
    end
end

local function GetHRP(player)
    local char = player and player.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function GetHumanoid(player)
    local char = player and player.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

-- ================================
-- ESP
-- ================================
local ESPEnabled = false
local ESPObjects = {}
local ESPConnections = {}

local function CreateESPBox(player)
    if player == LocalPlayer then return end
    local bb = Instance.new("BillboardGui")
    bb.Name = "ESP_" .. player.Name
    bb.Size = UDim2.new(0, 110, 0, 50)
    bb.StudsOffset = Vector3.new(0, 3.5, 0)
    bb.AlwaysOnTop = true

    local nameLbl = Instance.new("TextLabel")
    nameLbl.Size = UDim2.new(1, 0, 0, 20)
    nameLbl.BackgroundTransparency = 1
    nameLbl.TextColor3 = Color3.fromRGB(255, 255, 80)
    nameLbl.TextSize = 13
    nameLbl.Font = Enum.Font.GothamBold
    nameLbl.Text = player.Name
    nameLbl.Parent = bb

    local hpBg = Instance.new("Frame")
    hpBg.Size = UDim2.new(1, 0, 0, 6)
    hpBg.Position = UDim2.new(0, 0, 0, 22)
    hpBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    hpBg.BorderSizePixel = 0
    hpBg.Parent = bb

    local hpBar = Instance.new("Frame")
    hpBar.Name = "HP"
    hpBar.Size = UDim2.new(1, 0, 1, 0)
    hpBar.BackgroundColor3 = Color3.fromRGB(80, 220, 80)
    hpBar.BorderSizePixel = 0
    hpBar.Parent = hpBg

    local distLbl = Instance.new("TextLabel")
    distLbl.Name = "Dist"
    distLbl.Size = UDim2.new(1, 0, 0, 16)
    distLbl.Position = UDim2.new(0, 0, 0, 30)
    distLbl.BackgroundTransparency = 1
    distLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
    distLbl.TextSize = 11
    distLbl.Font = Enum.Font.Gotham
    distLbl.Text = "? studs"
    distLbl.Parent = bb

    ESPObjects[player] = bb

    local conn = RunService.RenderStepped:Connect(function()
        if not ESPEnabled then bb:Destroy() ESPObjects[player] = nil return end
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hrp then
            bb.Adornee = hrp
            local myHRP = GetHRP(LocalPlayer)
            if myHRP then distLbl.Text = math.floor((hrp.Position - myHRP.Position).Magnitude) .. " studs" end
            if hum then
                local pct = hum.Health / hum.MaxHealth
                hpBar.Size = UDim2.new(pct, 0, 1, 0)
                hpBar.BackgroundColor3 = pct > 0.6 and Color3.fromRGB(80,220,80) or pct > 0.3 and Color3.fromRGB(255,200,0) or Color3.fromRGB(255,60,60)
            end
        else bb.Adornee = nil end
    end)
    ESPConnections[player] = conn
end

local function EnableESP()
    ESPEnabled = true
    for _, p in ipairs(Players:GetPlayers()) do CreateESPBox(p) end
    Players.PlayerAdded:Connect(function(p)
        if ESPEnabled then task.wait(1) CreateESPBox(p) end
    end)
end

local function DisableESP()
    ESPEnabled = false
    for _, b in pairs(ESPObjects) do b:Destroy() end
    ESPObjects = {}
    for _, c in pairs(ESPConnections) do c:Disconnect() end
    ESPConnections = {}
end

-- ================================
-- COMMANDS
-- ================================
local Commands = {}

Commands["ws"] = function(args)
    local hum = GetHumanoid(LocalPlayer)
    if hum then hum.WalkSpeed = tonumber(args[1]) or 16 Notify("WalkSpeed: " .. (tonumber(args[1]) or 16)) end
end
Commands["walkspeed"] = Commands["ws"]
Commands["speed"] = Commands["ws"]

Commands["jp"] = function(args)
    local hum = GetHumanoid(LocalPlayer)
    if hum then hum.JumpPower = tonumber(args[1]) or 50 Notify("JumpPower: " .. (tonumber(args[1]) or 50)) end
end
Commands["jumppower"] = Commands["jp"]

local ijEnabled, ijConn = false, nil
Commands["ijump"] = function()
    ijEnabled = not ijEnabled
    if ijEnabled then
        ijConn = UserInputService.JumpRequest:Connect(function()
            local hum = GetHumanoid(LocalPlayer)
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end)
        Notify("Infinite Jump: ON", Color3.fromRGB(100,255,100))
    else
        if ijConn then ijConn:Disconnect() end
        Notify("Infinite Jump: OFF", Color3.fromRGB(255,100,100))
    end
end

Commands["esp"] = function()
    if ESPEnabled then DisableESP() Notify("ESP: OFF", Color3.fromRGB(255,100,100))
    else EnableESP() Notify("ESP: ON", Color3.fromRGB(100,255,100)) end
end

local noclipEnabled, noclipConn = false, nil
Commands["noclip"] = function()
    noclipEnabled = not noclipEnabled
    if noclipEnabled then
        noclipConn = RunService.Stepped:Connect(function()
            local char = LocalPlayer.Character
            if char then for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end
        end)
        Notify("Noclip: ON", Color3.fromRGB(100,255,100))
    else
        if noclipConn then noclipConn:Disconnect() end
        local char = LocalPlayer.Character
        if char then for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = true end end end
        Notify("Noclip: OFF", Color3.fromRGB(255,100,100))
    end
end

Commands["god"] = function()
    local hum = GetHumanoid(LocalPlayer)
    if hum then hum.MaxHealth = math.huge hum.Health = math.huge Notify("God Mode: ON", Color3.fromRGB(100,255,100)) end
end
Commands["ungod"] = function()
    local hum = GetHumanoid(LocalPlayer)
    if hum then hum.MaxHealth = 100 hum.Health = 100 Notify("God Mode: OFF") end
end

local flyEnabled, flyConn, flyBV, flyBG = false, nil, nil, nil
Commands["fly"] = function()
    flyEnabled = not flyEnabled
    local hrp = GetHRP(LocalPlayer)
    local hum = GetHumanoid(LocalPlayer)
    if not hrp or not hum then return end
    if flyEnabled then
        hum.PlatformStand = true
        flyBV = Instance.new("BodyVelocity")
        flyBV.MaxForce = Vector3.new(1e5,1e5,1e5)
        flyBV.Velocity = Vector3.zero
        flyBV.Parent = hrp
        flyBG = Instance.new("BodyGyro")
        flyBG.MaxTorque = Vector3.new(1e5,1e5,1e5)
        flyBG.P = 1e4
        flyBG.Parent = hrp
        flyConn = RunService.RenderStepped:Connect(function()
            if not flyEnabled then return end
            local cf = Camera.CFrame
            local vel = Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel += cf.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel -= cf.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel -= cf.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel += cf.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel += Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then vel -= Vector3.new(0,1,0) end
            flyBV.Velocity = vel * 60
            flyBG.CFrame = cf
        end)
        Notify("Fly: ON", Color3.fromRGB(100,255,100))
    else
        hum.PlatformStand = false
        if flyBV then flyBV:Destroy() end
        if flyBG then flyBG:Destroy() end
        if flyConn then flyConn:Disconnect() end
        Notify("Fly: OFF", Color3.fromRGB(255,100,100))
    end
end

Commands["tp"] = function(args)
    if not args[1] then Notify("Usage: tp [player]", Color3.fromRGB(255,150,50)) return end
    local t = GetPlayer(args[1])
    local a, b = GetHRP(LocalPlayer), t and GetHRP(t)
    if a and b then a.CFrame = b.CFrame + Vector3.new(3,0,0) Notify("Teleported to " .. t.Name)
    else Notify("Player not found", Color3.fromRGB(255,80,80)) end
end

Commands["bring"] = function(args)
    if not args[1] then Notify("Usage: bring [player]", Color3.fromRGB(255,150,50)) return end
    local t = GetPlayer(args[1])
    local a, b = GetHRP(LocalPlayer), t and GetHRP(t)
    if a and b then b.CFrame = a.CFrame + Vector3.new(3,0,0) Notify("Brought " .. t.Name)
    else Notify("Player not found", Color3.fromRGB(255,80,80)) end
end

Commands["char"] = function(args)
    local s = tonumber(args[1]) or 1
    local hum = GetHumanoid(LocalPlayer)
    if hum then
        hum.BodyDepthScale.Value = s
        hum.BodyHeightScale.Value = s
        hum.BodyWidthScale.Value = s
        hum.HeadScale.Value = s
        Notify("Char scale: " .. s)
    end
end

Commands["invis"] = function()
    local char = LocalPlayer.Character
    if char then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") or p:IsA("Decal") then p.Transparency = 1 end
        end
        Notify("Invisible (local)", Color3.fromRGB(200,200,255))
    end
end
Commands["vis"] = function()
    local char = LocalPlayer.Character
    if char then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") or p:IsA("Decal") then p.Transparency = 0 end
        end
        Notify("Visible")
    end
end

Commands["reset"] = function()
    local hum = GetHumanoid(LocalPlayer)
    if hum then hum.Health = 0 end
end

Commands["cmds"] = function()
    local list = {}
    for k in pairs(Commands) do table.insert(list, Prefix..k) end
    table.sort(list)
    print("=== Admin Commands ===")
    for _, v in ipairs(list) do print(v) end
    Notify("Commands printed to console (F9)", Color3.fromRGB(150,150,255))
end
Commands["help"] = Commands["cmds"]

-- ================================
-- INPUT HANDLER
-- ================================
UserInputService.InputBegan:Connect(function(input, gpe)
    if input.KeyCode == Enum.KeyCode.Semicolon and not gpe then
        CommandFrame.Visible = not CommandFrame.Visible
        if CommandFrame.Visible then CommandBox:CaptureFocus() CommandBox.Text = "" end
    end
end)

CommandBox.FocusLost:Connect(function(entered)
    if entered then
        local text = CommandBox.Text:lower():gsub("^%s+",""):gsub("%s+$","")
        if text ~= "" then
            if text:sub(1,#Prefix) == Prefix then text = text:sub(#Prefix+1) end
            local parts = text:split(" ")
            local cmd = parts[1]
            local args = {}
            for i=2,#parts do table.insert(args, parts[i]) end
            if Commands[cmd] then
                local ok, err = pcall(Commands[cmd], args)
                if not ok then Notify("Error: "..tostring(err), Color3.fromRGB(255,80,80)) end
            else
                Notify("Unknown: "..cmd, Color3.fromRGB(255,150,50))
            end
        end
    end
    CommandBox.Text = ""
    CommandFrame.Visible = false
end)

Notify("Admin Loaded! Press [ ; ] to open", Color3.fromRGB(100,220,255))
