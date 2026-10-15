--[[
    FantaScript Hub v2.5 — main.lua (FUNCIONAL)
    Jogo: Steal an Egg (Roblox)
    Uso: loadstring(game:HttpGet("..."))()
--]]

local Players          = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local RunService       = game:GetService("RunService")
local HttpService      = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

-- Destruir GUI antiga
local old = PlayerGui:FindFirstChild("FantaScriptHub")
if old then old:Destroy() end

--=========================================================
-- CONFIGURAÇÕES RÁPIDAS
--=========================================================
local CONFIG = {
    WebhookURL   = "",  -- Cola aqui o teu webhook do Discord (opcional)
    SpeedValue   = 32,
    JumpPower    = 50,
    AutoStealDelay = 0.5,
}

--=========================================================
-- PALETA (igual à do HTML)
--=========================================================
local C = {
    bgPanel       = Color3.fromRGB(20, 13, 26),
    borderPanel   = Color3.fromRGB(58, 28, 77),
    cardBg        = Color3.fromRGB(28, 18, 36),
    cardBorder    = Color3.fromRGB(46, 24, 61),
    accent        = Color3.fromRGB(217, 38, 86),
    textPrimary   = Color3.fromRGB(245, 240, 248),
    textSecondary = Color3.fromRGB(163, 146, 176),
    success       = Color3.fromRGB(46, 204, 113),
    danger        = Color3.fromRGB(231, 76, 60),
    rowBg         = Color3.fromRGB(34, 22, 44),
    inputBg       = Color3.fromRGB(13, 7, 20),
}

--=========================================================
-- HELPERS
--=========================================================
local function new(class, props)
    local inst = Instance.new(class)
    if props then
        local parent = props.Parent
        props.Parent = nil
        for k, v in pairs(props) do inst[k] = v end
        inst.Parent = parent
    end
    return inst
end

local function corner(parent, r)
    return new("UICorner", {Parent = parent, CornerRadius = UDim.new(0, r or 6)})
end

local function stroke(parent, color, thickness)
    return new("UIStroke", {Parent = parent, Color = color or C.cardBorder, Thickness = thickness or 1})
end

local function makeRow(parent, height)
    local row = new("Frame", {
        Parent = parent,
        Size = UDim2.new(1, 0, 0, height or 42),
        BackgroundColor3 = C.rowBg,
        BackgroundTransparency = 0.55,
        BorderSizePixel = 0,
    })
    corner(row, 6)
    stroke(row, C.cardBorder, 1)
    return row
end

local function addTitle(row, text, widthOffset)
    return new("TextLabel", {
        Parent = row,
        Position = UDim2.new(0, 8, 0, 5),
        Size = UDim2.new(1, -(widthOffset or 16), 0, 14),
        BackgroundTransparency = 1,
        Text = text,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        TextColor3 = C.textPrimary,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
    })
end

local function addDesc(row, text)
    if not text then return end
    return new("TextLabel", {
        Parent = row,
        Position = UDim2.new(0, 8, 0, 21),
        Size = UDim2.new(1, -16, 0, 18),
        BackgroundTransparency = 1,
        Text = text,
        Font = Enum.Font.Gotham,
        TextSize = 9,
        TextColor3 = C.textSecondary,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextWrapped = true,
    })
end

--=========================================================
-- SISTEMA DE NOTIFICAÇÃO (canto do ecrã)
--=========================================================
local notifContainer = new("Frame", {
    Parent = PlayerGui,
    Name = "FantaNotifs",
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -20, 0, 20),
    Size = UDim2.new(0, 250, 0, 200),
    BackgroundTransparency = 1,
})
new("UIListLayout", {
    Parent = notifContainer,
    Padding = UDim.new(0, 6),
    SortOrder = Enum.SortOrder.LayoutOrder,
    VerticalAlignment = Enum.VerticalAlignment.Top,
    HorizontalAlignment = Enum.HorizontalAlignment.Right,
})

local function notify(title, msg, color)
    color = color or C.accent
    local box = new("Frame", {
        Parent = notifContainer,
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundColor3 = C.cardBg,
        BorderSizePixel = 0,
    })
    corner(box, 6)
    stroke(box, color, 1)

    new("TextLabel", {
        Parent = box,
        Position = UDim2.new(0, 8, 0, 4),
        Size = UDim2.new(1, -16, 0, 16),
        BackgroundTransparency = 1,
        Text = title,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        TextColor3 = color,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    new("TextLabel", {
        Parent = box,
        Position = UDim2.new(0, 8, 0, 20),
        Size = UDim2.new(1, -16, 0, 26),
        BackgroundTransparency = 1,
        Text = msg,
        Font = Enum.Font.Gotham,
        TextSize = 9,
        TextColor3 = C.textSecondary,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextWrapped = true,
    })

    task.delay(4, function()
        if box and box.Parent then
            TweenService:Create(box, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
            task.wait(0.3)
            box:Destroy()
        end
    end)
end

--=========================================================
-- WEBHOOK (Discord)
--=========================================================
local function sendWebhook(title, msg)
    if CONFIG.WebhookURL == "" then return end
    pcall(function()
        HttpService:PostAsync(CONFIG.WebhookURL, HttpService:JSONEncode({
            content = nil,
            embeds = {{
                title = title,
                description = msg,
                color = 217 * 65536 + 38 * 256 + 86,
            }}
        }))
    end)
end

--=========================================================
-- FUNÇÕES REAIS DO JOGO
--=========================================================
local Funcs = {}

-- Função auxiliar: pegar personagem
local function getChar()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function getHumanoid()
    local char = getChar()
    return char and char:FindFirstChildOfClass("Humanoid")
end

-- 1. SPEED BOOST
function Funcs.setSpeed(on)
    local hum = getHumanoid()
    if hum then
        hum.WalkSpeed = on and CONFIG.SpeedValue or 16
        notify("Speed", on and "Velocidade ativada (" .. CONFIG.SpeedValue .. ")" or "Velocidade normal", C.success)
    end
end

-- 2. INFINITE JUMP
local infiniteJumpConn = nil
function Funcs.setInfiniteJump(on)
    if infiniteJumpConn then infiniteJumpConn:Disconnect() infiniteJumpConn = nil end
    if not on then return end
    infiniteJumpConn = UserInputService.JumpRequest:Connect(function()
        local hum = getHumanoid()
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

-- 3. INVISIBILITY
function Funcs.setInvisible(on)
    local char = getChar()
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = on and 0.9 or 0
            elseif part:IsA("Decal") then
                part.Transparency = on and 1 or 0
            end
        end
    end
end

-- 4. ANTI RAGDOLL
local antiRagdollConn = nil
function Funcs.setAntiRagdoll(on)
    if antiRagdollConn then antiRagdollConn:Disconnect() antiRagdollConn = nil end
    if not on then return end
    antiRagdollConn = RunService.Heartbeat:Connect(function()
        local hum = getHumanoid()
        if hum then
            hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        end
    end)
end

-- 5. AUTO STEAL (teleporte para o ovo mais próximo)
local autoStealRunning = false
function Funcs.setAutoSteal(on)
    autoStealRunning = on
    if not on then return end
    task.spawn(function()
        while autoStealRunning do
            local char = getChar()
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                -- Procura ovos no workspace (nome comum no jogo)
                local bestEgg, bestDist = nil, math.huge
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and (obj.Name:lower():find("egg") or obj.Name:lower():find("ovo")) then
                        local dist = (obj.Position - root.Position).Magnitude
                        if dist < bestDist and dist > 5 then
                            bestDist = dist
                            bestEgg = obj
                        end
                    end
                end
                if bestEgg then
                    root.CFrame = CFrame.new(bestEgg.Position + Vector3.new(0, 3, 0))
                    task.wait(0.1)
                    -- Tenta ativar o prompt de roubo (ProximityPrompt)
                    local prompt = bestEgg:FindFirstChildOfClass("ProximityPrompt")
                    if prompt then
                        pcall(function() prompt:InputHoldBegin() end)
                        task.wait(0.3)
                        pcall(function() prompt:InputHoldEnd() end)
                    end
                end
            end
            task.wait(CONFIG.AutoStealDelay)
        end
    end)
end

-- 6. AUTO HATCH
local autoHatchRunning = false
function Funcs.setAutoHatch(on)
    autoHatchRunning = on
    if not on then return end
    task.spawn(function()
        while autoHatchRunning do
            -- Procura por ProximityPrompts de "hatch" perto do jogador
            local char = getChar()
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") and (obj.ActionText:lower():find("hatch") or obj.ActionText:lower():find("chocar")) then
                        local parent = obj.Parent
                        if parent and parent:IsA("BasePart") then
                            local dist = (parent.Position - root.Position).Magnitude
                            if dist < 15 then
                                pcall(function() obj:InputHoldBegin() end)
                                task.wait(0.2)
                                pcall(function() obj:InputHoldEnd() end)
                            end
                        end
                    end
                end
            end
            task.wait(1)
        end
    end)
end

-- 7. AUTO SELL
local autoSellRunning = false
function Funcs.setAutoSell(on)
    autoSellRunning = on
    if not on then return end
    task.spawn(function()
        while autoSellRunning do
            local char = getChar()
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") and (obj.ActionText:lower():find("sell") or obj.ActionText:lower():find("vender")) then
                        local parent = obj.Parent
                        if parent and parent:IsA("BasePart") then
                            local dist = (parent.Position - root.Position).Magnitude
                            if dist < 20 then
                                pcall(function() obj:InputHoldBegin() end)
                                task.wait(0.2)
                                pcall(function() obj:InputHoldEnd() end)
                            end
                        end
                    end
                end
            end
            task.wait(2)
        end
    end)
end

-- 8. AUTO TREADMILL
local autoTreadmillRunning = false
function Funcs.setAutoTreadmill(on)
    autoTreadmillRunning = on
    if not on then return end
    task.spawn(function()
        while autoTreadmillRunning do
            local char = getChar()
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                -- Procura por esteira (nome comum: "Treadmill")
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and obj.Name:lower():find("treadmill") then
                        root.CFrame = CFrame.new(obj.Position + Vector3.new(0, 5, 0))
                        break
                    end
                end
            end
            task.wait(2)
        end
    end)
end

-- 9. ESP PLAYER INFO
local espFolder = nil
function Funcs.setESP(on)
    if espFolder then espFolder:Destroy() espFolder = nil end
    if not on then return end
    espFolder = new("Folder", {Parent = PlayerGui, Name = "FantaESP"})
    task.spawn(function()
        while espFolder and espFolder.Parent do
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character then
                    local head = plr.Character:FindFirstChild("Head")
                    if head then
                        local billboard = espFolder:FindFirstChild(plr.Name)
                        if not billboard then
                            billboard = new("BillboardGui", {
                                Parent = espFolder,
                                Name = plr.Name,
                                Size = UDim2.new(0, 100, 0, 30),
                                StudsOffset = Vector3.new(0, 2.5, 0),
                                AlwaysOnTop = true,
                            })
                            new("TextLabel", {
                                Parent = billboard,
                                Size = UDim2.new(1, 0, 1, 0),
                                BackgroundTransparency = 1,
                                Text = plr.Name,
                                Font = Enum.Font.GothamBold,
                                TextSize = 12,
                                TextColor3 = C.accent,
                                TextStrokeTransparency = 0,
                            })
                        end
                        billboard.Adornee = head
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end

--=========================================================
-- CONSTRUTOR DE CONTROLES (agora com funções reais)
--=========================================================
local function buildControl(parent, ctrl)
    if ctrl.type == "search" then
        local box = new("TextBox", {
            Parent = parent,
            Size = UDim2.new(1, 0, 0, 26),
            BackgroundColor3 = C.inputBg,
            BorderSizePixel = 0,
            PlaceholderText = ctrl.placeholder or "Pesquisar...",
            PlaceholderColor3 = C.textSecondary,
            Text = "",
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Font = Enum.Font.Gotham,
            TextSize = 10,
            TextXAlignment = Enum.TextXAlignment.Left,
            ClearTextOnFocus = false,
        })
        corner(box, 6)
        stroke(box, C.cardBorder, 1)
        new("UIPadding", {Parent = box, PaddingLeft = UDim.new(0, 8)})
        return
    end

    if ctrl.type == "toggle" then
        local row = makeRow(parent, 42)
        addTitle(row, ctrl.label, 50)
        addDesc(row, ctrl.desc)
        local state = ctrl.default and true or false
        local sw = new("TextButton", {
            Parent = row,
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, -8, 0, 6),
            Size = UDim2.new(0, 28, 0, 16),
            BackgroundColor3 = state and C.accent or C.cardBorder,
            Text = "",
            AutoButtonColor = false,
        })
        corner(sw, 8)
        local knob = new("Frame", {
            Parent = sw,
            Position = state and UDim2.new(0, 15, 0, 3) or UDim2.new(0, 3, 0, 3),
            Size = UDim2.new(0, 10, 0, 10),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BorderSizePixel = 0,
        })
        corner(knob, 5)

        sw.MouseButton1Click:Connect(function()
            state = not state
            TweenService:Create(knob, TweenInfo.new(0.15), {
                Position = state and UDim2.new(0, 15, 0, 3) or UDim2.new(0, 3, 0, 3)
            }):Play()
            sw.BackgroundColor3 = state and C.accent or C.cardBorder

            -- Chama a função real, se existir
            if ctrl.action then
                pcall(ctrl.action, state)
            end
            sendWebhook("FantaScript", ctrl.label .. " -> " .. (state and "ON" or "OFF"))
        end)
        return
    end

    if ctrl.type == "number" then
        local row = makeRow(parent, 42)
        addTitle(row, ctrl.label, 80)
        local box = new("TextBox", {
            Parent = row,
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, -8, 0, 5),
            Size = UDim2.new(0, 55, 0, 18),
            BackgroundColor3 = C.inputBg,
            BorderSizePixel = 0,
            Text = tostring(ctrl.value or 0),
            Font = Enum.Font.Gotham,
            TextSize = 10,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextXAlignment = Enum.TextXAlignment.Right,
            ClearTextOnFocus = false,
        })
        corner(box, 4)
        stroke(box, C.cardBorder, 1)
        new("UIPadding", {Parent = box, PaddingRight = UDim.new(0, 6)})
        addDesc(row, ctrl.desc)
        box.FocusLost:Connect(function()
            local num = tonumber(box.Text)
            if num and ctrl.onChange then ctrl.onChange(num) end
        end)
        return
    end

    if ctrl.type == "select" then
        local row = makeRow(parent, 42)
        addTitle(row, ctrl.label, 100)
        local idx = 1
        local btn = new("TextButton", {
            Parent = row,
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, -8, 0, 5),
            Size = UDim2.new(0, 92, 0, 18),
            BackgroundColor3 = C.inputBg,
            Text = ctrl.options[1],
            Font = Enum.Font.Gotham,
            TextSize = 10,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            AutoButtonColor = false,
        })
        corner(btn, 4)
        stroke(btn, C.cardBorder, 1)
        btn.MouseButton1Click:Connect(function()
            idx = (idx % #ctrl.options) + 1
            btn.Text = ctrl.options[idx]
            if ctrl.onChange then ctrl.onChange(ctrl.options[idx]) end
        end)
        addDesc(row, ctrl.desc)
        return
    end

    if ctrl.type == "static" then
        local row = makeRow(parent, 28)
        addTitle(row, ctrl.label, 150)
        new("TextLabel", {
            Parent = row,
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -8, 0.5, 0),
            Size = UDim2.new(0, 150, 0, 16),
            BackgroundTransparency = 1,
            Text = ctrl.value or "",
            Font = Enum.Font.GothamBold,
            TextSize = 11,
            TextColor3 = ctrl.color or C.textPrimary,
            TextXAlignment = Enum.TextXAlignment.Right,
        })
        return
    end

    if ctrl.type == "button" then
        local row = makeRow(parent, 32)
        addTitle(row, ctrl.label, 110)
        local btn = new("TextButton", {
            Parent = row,
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -8, 0.5, 0),
            Size = UDim2.new(0, 100, 0, 20),
            BackgroundColor3 = ctrl.danger and C.danger or C.accent,
            Text = ctrl.text or "Executar",
            Font = Enum.Font.GothamBold,
            TextSize = 10,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            AutoButtonColor = false,
        })
        corner(btn, 4)
        if ctrl.action then
            btn.MouseButton1Click:Connect(function()
                pcall(ctrl.action)
                notify(ctrl.label, "Executado!", C.accent)
            end)
        end
        return
    end
end

--=========================================================
-- SCREEN GUI
--=========================================================
local gui = new("ScreenGui", {
    Name = "FantaScriptHub",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent = PlayerGui,
})

local floatBtn = new("TextButton", {
    Parent = gui,
    Name = "FloatingBtn",
    Position = UDim2.new(0, 20, 0, 20),
    Size = UDim2.new(0, 48, 0, 48),
    BackgroundColor3 = C.bgPanel,
    Text = "",
    AutoButtonColor = false,
    ZIndex = 9999,
})
corner(floatBtn, 24)
stroke(floatBtn, C.accent, 2)
new("TextLabel", {
    Parent = floatBtn,
    Size = UDim2.new(0, 30, 0, 30),
    Position = UDim2.new(0.5, -15, 0.5, -15),
    BackgroundColor3 = C.accent,
    Text = "F",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.GothamBlack,
    TextSize = 16,
    ZIndex = 10000,
})

local panel = new("Frame", {
    Parent = gui,
    Name = "Panel",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, 460, 0, 510),
    BackgroundColor3 = C.bgPanel,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Visible = true,
    ZIndex = 1000,
})
corner(panel, 14)
stroke(panel, C.borderPanel, 1.5)

local header = new("Frame", {
    Parent = panel,
    Name = "Header",
    Size = UDim2.new(1, 0, 0, 40),
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = 0.7,
    BorderSizePixel = 0,
})
corner(header, 14)
new("TextLabel", {
    Parent = header,
    Position = UDim2.new(0, 12, 0, 0),
    Size = UDim2.new(1, -60, 1, 0),
    BackgroundTransparency = 1,
    Text = "FantaScript — Steal & Sources Hub",
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    TextColor3 = C.textPrimary,
    TextXAlignment = Enum.TextXAlignment.Left,
})
local closeBtn = new("TextButton", {
    Parent = header,
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -12, 0.5, 0),
    Size = UDim2.new(0, 24, 0, 24),
    BackgroundTransparency = 1,
    Text = "✕",
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    TextColor3 = C.textSecondary,
    AutoButtonColor = false,
})
closeBtn.MouseButton1Click:Connect(function() panel.Visible = false end)

local body = new("Frame", {
    Parent = panel,
    Position = UDim2.new(0, 8, 0, 48),
    Size = UDim2.new(1, -16, 1, -56),
    BackgroundTransparency = 1,
})
local sidebar = new("ScrollingFrame", {
    Parent = body,
    Size = UDim2.new(0, 130, 1, 0),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 2,
    ScrollBarImageColor3 = C.accent,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
})
new("UIListLayout", {
    Parent = sidebar,
    Padding = UDim.new(0, 4),
    SortOrder = Enum.SortOrder.LayoutOrder,
})
local content = new("Frame", {
    Parent = body,
    Position = UDim2.new(0, 138, 0, 0),
    Size = UDim2.new(1, -138, 1, 0),
    BackgroundColor3 = C.cardBg,
    BorderSizePixel = 0,
})
corner(content, 8)
stroke(content, C.cardBorder, 1)

local tabFrames, tabButtons, currentTab = {}, {}, nil
local function selectTab(id)
    if currentTab and tabFrames[currentTab] and tabButtons[currentTab] then
        tabFrames[currentTab].Visible = false
        tabButtons[currentTab].BackgroundColor3 = C.cardBg
        tabButtons[currentTab].TextColor3 = C.textSecondary
    end
    currentTab = id
    if tabFrames[id] and tabButtons[id] then
        tabFrames[id].Visible = true
        tabButtons[id].BackgroundColor3 = C.accent
        tabButtons[id].TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

--=========================================================
-- DADOS DAS ABAS (com ações reais)
--=========================================================
local tabs = {
    { id = "home", label = "1. Home", controls = {
        {type="static", label="FantaScript Hub v2.5"},
        {type="static", label="Painel funcional para Steal an Egg."},
    }},

    { id = "player", label = "4. Player", controls = {
        {type="search", placeholder="Pesquisar Player..."},
        {type="toggle", label="Speed Boost", desc="Aumenta a velocidade de movimento.", action=Funcs.setSpeed},
        {type="number", label="Boost Speed Value", value=32, desc="Valor da velocidade.", onChange=function(v) CONFIG.SpeedValue = v end},
        {type="toggle", label="Infinite Jump", desc="Pulo infinito no ar.", action=Funcs.setInfiniteJump},
        {type="toggle", label="Invisibility", desc="Torna o personagem invisível.", action=Funcs.setInvisible},
        {type="toggle", label="Anti Ragdoll", desc="Impede cair no chão.", action=Funcs.setAntiRagdoll},
        {type="toggle", label="ESP Player Info", desc="Mostra nome dos jogadores.", action=Funcs.setESP},
    }},

    { id = "autosteal", label = "3. Auto Steal", controls = {
        {type="search", placeholder="Pesquisar Steal..."},
        {type="toggle", label="Auto Steal", desc="Teleporta e rouba o ovo mais próximo.", action=Funcs.setAutoSteal},
        {type="number", label="Auto Steal Delay", value=0.5, desc="Intervalo entre roubos.", onChange=function(v) CONFIG.AutoStealDelay = v end},
    }},

    { id = "farm", label = "2. Farm", controls = {
        {type="search", placeholder="Pesquisar Farm..."},
        {type="toggle", label="Auto Hatch", desc="Abre ovos automaticamente no ninho.", action=Funcs.setAutoHatch},
        {type="toggle", label="Auto Sell", desc="Vende ovos/pets repetidos.", action=Funcs.setAutoSell},
        {type="toggle", label="Auto Treadmill", desc="Fica na esteira a ganhar dinheiro.", action=Funcs.setAutoTreadmill},
    }},

    { id = "discord", label = "9. Discord", controls = {
        {type="search", placeholder="Webhook URL..."},
        {type="button", label="Guardar Webhook", text="Guardar", action=function()
            -- O texto do search box é lido no próximo FocusLost
            notify("Webhook", "Clica no campo acima e cola o URL.", C.accent)
        end},
        {type="button", label="Testar Webhook", text="Testar", action=function()
            sendWebhook("Teste", "O teu webhook está a funcionar!")
            notify("Webhook", "Mensagem enviada (se URL estiver correta).", C.success)
        end},
    }},
}

--=========================================================
-- CONSTRUÇÃO DAS ABAS
--=========================================================
for _, tab in ipairs(tabs) do
    local btn = new("TextButton", {
        Parent = sidebar,
        Size = UDim2.new(1, 0, 0, 26),
        BackgroundColor3 = C.cardBg,
        Text = tab.label,
        Font = Enum.Font.GothamBold,
        TextSize = 10,
        TextColor3 = C.textSecondary,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutoButtonColor = false,
    })
    corner(btn, 6)
    stroke(btn, C.cardBorder, 1)
    new("UIPadding", {Parent = btn, PaddingLeft = UDim.new(0, 8)})
    btn.MouseButton1Click:Connect(function() selectTab(tab.id) end)
    tabButtons[tab.id] = btn

    local frame = new("ScrollingFrame", {
        Parent = content,
        Name = "Tab_" .. tab.id,
        Size = UDim2.new(1, -12, 1, -12),
        Position = UDim2.new(0, 6, 0, 6),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = C.accent,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false,
    })
    new("UIListLayout", {
        Parent = frame,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })
    tabFrames[tab.id] = frame

    for _, ctrl in ipairs(tab.controls) do
        buildControl(frame, ctrl)
    end
end

--=========================================================
-- DRAG (bolinha + painel)
--=========================================================
local function makeDraggable(handle, target, onClick)
    local dragging, dragStart, startPos, moved = false, nil, nil, false
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging  = true
            moved     = false
            dragStart = input.Position
            startPos  = target.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    if not moved and onClick then onClick() end
                end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            if math.abs(delta.X) > 3 or math.abs(delta.Y) > 3 then
                moved = true
            end
            target.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

makeDraggable(header, panel)
makeDraggable(floatBtn, floatBtn, function()
    panel.Visible = not panel.Visible
end)

selectTab("home")
notify("FantaScript", "Hub carregado! Abre as abas Player, Farm e Auto Steal para testar.", C.success)
print("[FantaScript] main.lua funcional carregado.")
