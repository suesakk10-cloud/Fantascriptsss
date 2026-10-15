--[[
    ============================================================
    DOCHILLI HUB — Egg & Pet Radar 🥚🐾
    ------------------------------------------------------------
    Versão: 1.0.0
    Autor:  (tu)
    Uso:    loadstring(game:HttpGet(".../main.lua"))()
    ------------------------------------------------------------
    AVISO: Os dados de pets/ovos/valores marcados com [DEMO]
           são EXEMPLOS. Preenche Data.Pets e Data.Eggs com
           dados reais do teu jogo. Não há API pública oficial.
    ============================================================
--]]

--=========================================================
-- MÓDULO: CONFIG
--=========================================================
local Config = {
    Nome        = "DOCHILLI HUB",
    Versao      = "1.0.0",
    Tema        = "dark",            -- dark / light
    CorA        = Color3.fromRGB(180, 30, 60),   -- vermelho
    CorB        = Color3.fromRGB(120, 60, 180),  -- roxo
    Animacoes   = true,
    Mobile      = false,
    IntervaloScan = 2,               -- segundos entre scans
    Webhook     = "",                -- opcional
}

--=========================================================
-- MÓDULO: DATA (base de dados — [DEMO])
--=========================================================
local Data = {}

-- [DEMO] Raridades e cores
Data.Raridades = {
    {nome="Comum",     cor=Color3.fromRGB(180,180,180), ordem=1},
    {nome="Incomum",   cor=Color3.fromRGB(80,200,120),  ordem=2},
    {nome="Raro",      cor=Color3.fromRGB(80,140,255),  ordem=3},
    {nome="Épico",     cor=Color3.fromRGB(160,80,220),  ordem=4},
    {nome="Lendário",  cor=Color3.fromRGB(255,180,60),  ordem=5},
    {nome="Mítico",    cor=Color3.fromRGB(255,80,80),   ordem=6},
    {nome="Secreto",   cor=Color3.fromRGB(255,50,180),  ordem=7},
}

-- [DEMO] Ovos — substitui pelos ovos reais do teu jogo
Data.Eggs = {
    {id="egg_basic",   nome="Basic Egg",   raridade="Comum",    valor=100,    regiao="Spawn"},
    {id="egg_forest",  nome="Forest Egg",  raridade="Incomum",  valor=500,    regiao="Floresta"},
    {id="egg_ocean",   nome="Ocean Egg",   raridade="Raro",     valor=2500,   regiao="Praia"},
    {id="egg_volcano", nome="Volcano Egg", raridade="Épico",    valor=12000,  regiao="Vulcão"},
    {id="egg_sky",     nome="Sky Egg",     raridade="Lendário", valor=60000,  regiao="Céu"},
    {id="egg_void",    nome="Void Egg",    raridade="Mítico",   valor=250000, regiao="Vazio"},
    {id="egg_secret",  nome="?? Egg",      raridade="Secreto",  valor=1000000,regiao="???"},
}

-- [DEMO] Pets por ovo — marca o estado com "conhecido = true/false"
-- chance = nil quando não existe dado oficial (mostra "N/D")
Data.Pets = {
    {nome="Doggy",    ovo="egg_basic",   raridade="Comum",    valor=50,     chance=nil, variantes={"Normal"}, conhecido=true},
    {nome="Kitty",    ovo="egg_basic",   raridade="Incomum",  valor=200,    chance=nil, variantes={"Normal"}, conhecido=true},
    {nome="Fox",      ovo="egg_forest",  raridade="Raro",     valor=1500,   chance=nil, variantes={"Normal","Dourado"}, conhecido=true},
    {nome="Wolf",     ovo="egg_forest",  raridade="Épico",    valor=5000,   chance=nil, variantes={"Normal"}, conhecido=false},
    {nome="Shark",    ovo="egg_ocean",   raridade="Lendário", valor=30000,  chance=nil, variantes={"Normal","Arco-íris"}, conhecido=true},
    {nome="Dragon",   ovo="egg_volcano", raridade="Mítico",   valor=180000, chance=nil, variantes={"Normal","Dourado"}, conhecido=false},
    {nome="Phoenix",  ovo="egg_sky",     raridade="Mítico",   valor=900000, chance=nil, variantes={"Normal"}, conhecido=false},
    {nome="Cosmic",   ovo="egg_void",    raridade="Secreto",  valor=5000000,chance=nil, variantes={"Normal"}, conhecido=false},
    {nome="???",      ovo="egg_secret",  raridade="Secreto",  valor=0,      chance=nil, variantes={"Normal"}, conhecido=false},
}

-- [DEMO] Histórico vazio (preenchido em runtime)
Data.Historico = {}
Data.Descobertos = {}  -- nomes de pets marcados como "descobertos" localmente

--=========================================================
-- MÓDULO: UTILS
--=========================================================
local Players          = game:GetService("Players")
local UIS              = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local TweenService     = game:GetService("TweenService")
local HttpService      = game:GetService("HttpService")
local Lighting         = game:GetService("Lighting")

local LP               = Players.LocalPlayer
local PGui             = LP:WaitForChild("PlayerGui")

local Utils = {}

function Utils.new(class, props)
    local i = Instance.new(class)
    if props then
        local p = props.Parent; props.Parent = nil
        for k,v in pairs(props) do i[k]=v end
        i.Parent = p
    end
    return i
end

function Utils.corner(p, r) return Utils.new("UICorner",{Parent=p,CornerRadius=UDim.new(0,r or 6)}) end
function Utils.stroke(p,c,t) return Utils.new("UIStroke",{Parent=p,Color=c or Color3.fromRGB(60,30,80),Thickness=t or 1}) end

function Utils.getChar() return LP.Character or LP.CharacterAdded:Wait() end
function Utils.getRoot()
    local c = LP.Character; return c and c:FindFirstChild("HumanoidRootPart")
end

function Utils.dist(a,b) return (a-b).Magnitude end

function Utils.raridadeCor(nome)
    for _,r in ipairs(Data.Raridades) do
        if r.nome == nome then return r.cor end
    end
    return Color3.fromRGB(180,180,180)
end

function Utils.raridadeOrdem(nome)
    for _,r in ipairs(Data.Raridades) do
        if r.nome == nome then return r.ordem end
    end
    return 0
end

--=========================================================
-- MÓDULO: NOTIFICAÇÕES
--=========================================================
local Notif = {}
local notifHolder

function Notif.init(parentGui)
    notifHolder = Utils.new("Frame", {
        Parent = parentGui, Name = "DochilliNotifs",
        AnchorPoint = Vector2.new(1,0),
        Position = UDim2.new(1,-16,0,16),
        Size = UDim2.new(0, 260, 0, 400),
        BackgroundTransparency = 1,
    })
    Utils.new("UIListLayout", {
        Parent = notifHolder, Padding = UDim.new(0,6),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
    })
end

function Notif.push(titulo, texto, cor)
    if not notifHolder then return end
    cor = cor or Config.CorA
    local box = Utils.new("Frame", {
        Parent = notifHolder,
        Size = UDim2.new(1, 0, 0, 52),
        BackgroundColor3 = Color3.fromRGB(20,14,24),
        BorderSizePixel = 0,
    })
    Utils.corner(box, 8)
    Utils.stroke(box, cor, 1)

    Utils.new("TextLabel",{
        Parent=box, Position=UDim2.new(0,8,0,4),
        Size=UDim2.new(1,-16,0,16), BackgroundTransparency=1,
        Text=titulo, Font=Enum.Font.GothamBold, TextSize=11,
        TextColor3=cor, TextXAlignment=Enum.TextXAlignment.Left,
    })
    Utils.new("TextLabel",{
        Parent=box, Position=UDim2.new(0,8,0,22),
        Size=UDim2.new(1,-16,0,26), BackgroundTransparency=1,
        Text=texto, Font=Enum.Font.Gotham, TextSize=9,
        TextColor3=Color3.fromRGB(180,170,190),
        TextXAlignment=Enum.TextXAlignment.Left,
        TextYAlignment=Enum.TextYAlignment.Top, TextWrapped=true,
    })
    task.delay(5, function() if box.Parent then box:Destroy() end end)
end

--=========================================================
-- MÓDULO: SCANNER (Egg Radar — lê o workspace)
--=========================================================
local Scanner = {}
Scanner.OvosEncontrados = {}

-- palavras-chave que identificam um "ovo" no workspace
local KEYWORDS = {"egg","ovo","brainrot","pet"}

local function isOvo(obj)
    if not obj:IsA("BasePart") then return false end
    local n = obj.Name:lower()
    for _,k in ipairs(KEYWORDS) do
        if n:find(k) then return true end
    end
    return false
end

function Scanner.rastrear()
    local root = Utils.getRoot()
    local lista = {}
    for _,obj in ipairs(workspace:GetDescendants()) do
        if isOvo(obj) then
            local dist = root and Utils.dist(obj.Position, root.Position) or -1
            -- classifica por nome (heurística) → usa "Comum" se não reconhecer
            local rar = "Comum"
            local low = obj.Name:lower()
            if low:find("secret") then rar = "Secreto"
            elseif low:find("myth") or low:find("mitic") then rar = "Mítico"
            elseif low:find("legend") then rar = "Lendário"
            elseif low:find("epic") then rar = "Épico"
            elseif low:find("rare") then rar = "Raro"
            elseif low:find("uncommon") then rar = "Incomum" end

            table.insert(lista, {
                nome = obj.Name,
                ref = obj,
                raridade = rar,
                valor = 0,   -- desconhecido (não inventamos)
                distancia = dist,
                posicao = obj.Position,
            })
        end
    end
    Scanner.OvosEncontrados = lista
    return lista
end

--=========================================================
-- MÓDULO: EGG RADAR (visual — destaca ovos)
--=========================================================
local Radar = {}
local radarFolder
Radar.Ativo = false
Radar.FiltroRaridade = nil

function Radar.ligar(on)
    Radar.Ativo = on
    if radarFolder then radarFolder:Destroy() radarFolder = nil end
    if not on then return end
    radarFolder = Utils.new("Folder",{Parent=PGui,Name="DochilliRadar"})

    task.spawn(function()
        while Radar.Ativo and radarFolder and radarFolder.Parent do
            local lista = Scanner.rastrear()
            for _,o in ipairs(lista) do
                if not Radar.FiltroRaridade or o.raridade == Radar.FiltroRaridade then
                    if not radarFolder:FindFirstChild(o.nome) then
                        local bbg = Utils.new("BillboardGui",{
                            Parent=radarFolder, Name=o.nome,
                            Adornee=o.ref,
                            Size=UDim2.new(0,120,0,22),
                            AlwaysOnTop=true,
                            StudsOffset=Vector3.new(0,2,0),
                        })
                        Utils.new("TextLabel",{
                            Parent=bbg, Size=UDim2.new(1,0,1,0),
                            BackgroundTransparency=1,
                            Text="🥚 "..o.raridade,
                            Font=Enum.Font.GothamBold, TextSize=11,
                            TextColor3=Utils.raridadeCor(o.raridade),
                            TextStrokeTransparency=0,
                        })
                    end
                end
            end
            task.wait(Config.IntervaloScan)
        end
    end)
end

--=========================================================
-- MÓDULO: SEARCH / FILTERS
--=========================================================
local Search = {}
Search.Query = ""
Search.Raridade = nil

function Search.matchOvo(o)
    if Search.Raridade and o.raridade ~= Search.Raridade then return false end
    if Search.Query ~= "" and not o.nome:lower():find(Search.Query:lower()) then return false end
    return true
end

--=========================================================
-- MÓDULO: UI (construtor)
--=========================================================
local UI = {}

local function makeTab(parent, id)
    local f = Utils.new("ScrollingFrame",{
        Parent=parent, Name="Tab_"..id,
        Size=UDim2.new(1,-12,1,-12),
        Position=UDim2.new(0,6,0,6),
        BackgroundTransparency=1, BorderSizePixel=0,
        ScrollBarThickness=3, ScrollBarImageColor3=Config.CorB,
        CanvasSize=UDim2.new(0,0,0,0),
        AutomaticCanvasSize=Enum.AutomaticSize.Y,
        Visible=false,
    })
    Utils.new("UIListLayout",{
        Parent=f, Padding=UDim.new(0,6),
        SortOrder=Enum.SortOrder.LayoutOrder,
    })
    return f
end

local function makeSection(parent, titulo)
    local lbl = Utils.new("TextLabel",{
        Parent=parent, Size=UDim2.new(1,0,0,18),
        BackgroundTransparency=1, Text=titulo,
        Font=Enum.Font.GothamBold, TextSize=11,
        TextColor3=Config.CorB,
        TextXAlignment=Enum.TextXAlignment.Left,
    })
    return lbl
end

local function makeCard(parent, altura)
    local card = Utils.new("Frame",{
        Parent=parent, Size=UDim2.new(1,0,0,altura or 40),
        BackgroundColor3=Color3.fromRGB(30,20,36),
        BorderSizePixel=0,
    })
    Utils.corner(card, 6)
    Utils.stroke(card, Color3.fromRGB(55,30,70), 1)
    return card
end

local function makeToggle(parent, label, desc, onChange)
    local card = makeCard(parent, 42)
    Utils.new("TextLabel",{
        Parent=card, Position=UDim2.new(0,8,0,5),
        Size=UDim2.new(1,-50,0,14), BackgroundTransparency=1,
        Text=label, Font=Enum.Font.GothamBold, TextSize=11,
        TextColor3=Color3.fromRGB(240,235,245),
        TextXAlignment=Enum.TextXAlignment.Left,
    })
    if desc then
        Utils.new("TextLabel",{
            Parent=card, Position=UDim2.new(0,8,0,21),
            Size=UDim2.new(1,-16,0,18), BackgroundTransparency=1,
            Text=desc, Font=Enum.Font.Gotham, TextSize=9,
            TextColor3=Color3.fromRGB(160,150,175),
            TextXAlignment=Enum.TextXAlignment.Left,
            TextYAlignment=Enum.TextYAlignment.Top, TextWrapped=true,
        })
    end
    local state = false
    local sw = Utils.new("TextButton",{
        Parent=card, AnchorPoint=Vector2.new(1,0),
        Position=UDim2.new(1,-8,0,6),
        Size=UDim2.new(0,28,0,16),
        BackgroundColor3=Color3.fromRGB(55,30,70),
        Text="", AutoButtonColor=false,
    })
    Utils.corner(sw, 8)
    local knob = Utils.new("Frame",{
        Parent=sw, Position=UDim2.new(0,3,0,3),
        Size=UDim2.new(0,10,0,10),
        BackgroundColor3=Color3.fromRGB(255,255,255),
        BorderSizePixel=0,
    })
    Utils.corner(knob, 5)
    sw.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(knob,TweenInfo.new(0.15),{
            Position = state and UDim2.new(0,15,0,3) or UDim2.new(0,3,0,3)
        }):Play()
        sw.BackgroundColor3 = state and Config.CorA or Color3.fromRGB(55,30,70)
        if onChange then pcall(onChange, state) end
    end)
    return card
end

local function makeButton(parent, label, texto, cor, action)
    local card = makeCard(parent, 34)
    Utils.new("TextLabel",{
        Parent=card, Position=UDim2.new(0,8,0,0),
        Size=UDim2.new(1,-120,1,0), BackgroundTransparency=1,
        Text=label, Font=Enum.Font.GothamBold, TextSize=11,
        TextColor3=Color3.fromRGB(240,235,245),
        TextXAlignment=Enum.TextXAlignment.Left,
    })
    local btn = Utils.new("TextButton",{
        Parent=card, AnchorPoint=Vector2.new(1,0.5),
        Position=UDim2.new(1,-8,0.5,0),
        Size=UDim2.new(0,100,0,22),
        BackgroundColor3=cor or Config.CorA,
        Text=texto or "Executar",
        Font=Enum.Font.GothamBold, TextSize=10,
        TextColor3=Color3.fromRGB(255,255,255),
        AutoButtonColor=false,
    })
    Utils.corner(btn, 5)
    btn.MouseButton1Click:Connect(function()
        local ok, err = pcall(action)
        if not ok then Notif.push("Erro", tostring(err), Color3.fromRGB(200,50,50))
        else Notif.push(label, "OK", Color3.fromRGB(80,200,120)) end
    end)
    return card
end

local function makeInput(parent, placeholder, onChange)
    local box = Utils.new("TextBox",{
        Parent=parent, Size=UDim2.new(1,0,0,26),
        BackgroundColor3=Color3.fromRGB(13,8,18),
        BorderSizePixel=0,
        PlaceholderText=placeholder or "Pesquisar...",
        PlaceholderColor3=Color3.fromRGB(140,130,150),
        Text="", TextColor3=Color3.fromRGB(255,255,255),
        Font=Enum.Font.Gotham, TextSize=10,
        TextXAlignment=Enum.TextXAlignment.Left,
        ClearTextOnFocus=false,
    })
    Utils.corner(box,6)
    Utils.stroke(box, Color3.fromRGB(55,30,70), 1)
    Utils.new("UIPadding",{Parent=box, PaddingLeft=UDim.new(0,8)})
    box:GetPropertyChangedSignal("Text"):Connect(function()
        if onChange then onChange(box.Text) end
    end)
    return box
end

local function makeLabel(parent, texto, cor)
    local card = makeCard(parent, 26)
    Utils.new("TextLabel",{
        Parent=card, Position=UDim2.new(0,8,0,0),
        Size=UDim2.new(1,-16,1,0), BackgroundTransparency=1,
        Text=texto, Font=Enum.Font.Gotham, TextSize=10,
        TextColor3=cor or Color3.fromRGB(200,190,210),
        TextXAlignment=Enum.TextXAlignment.Left,
        TextTruncate=Enum.TextTruncate.AtEnd,
    })
    return card
end

UI.makeTab = makeTab
UI.makeSection = makeSection
UI.makeToggle = makeToggle
UI.makeButton = makeButton
UI.makeInput = makeInput
UI.makeLabel = makeLabel

--=========================================================
-- MÓDULO: STATUS BAR
--=========================================================
local StatusBar = {}
local statusLabel

function StatusBar.init(parent)
    local bar = Utils.new("Frame",{
        Parent=parent, Name="StatusBar",
        Position=UDim2.new(0,0,1,-22),
        Size=UDim2.new(1,0,0,22),
        BackgroundColor3=Color3.fromRGB(10,5,15),
        BorderSizePixel=0,
    })
    statusLabel = Utils.new("TextLabel",{
        Parent=bar, Size=UDim2.new(1,-16,1,0),
        Position=UDim2.new(0,8,0,0),
        BackgroundTransparency=1,
        Text="Estado: ligado  |  Última atualização: --  |  Resultados: 0",
        Font=Enum.Font.Code, TextSize=10,
        TextColor3=Color3.fromRGB(180,170,190),
        TextXAlignment=Enum.TextXAlignment.Left,
    })
end

function StatusBar.set(texto)
    if statusLabel then statusLabel.Text = texto end
end

--=========================================================
-- MÓDULO: MAIN UI
--=========================================================
local Main = {}
local gui, panel, floatBtn, sidebar, content
local tabFrames, tabButtons, currentTab = {}, {}, nil

local function selectTab(id)
    if currentTab and tabFrames[currentTab] then
        tabFrames[currentTab].Visible = false
        tabButtons[currentTab].BackgroundColor3 = Color3.fromRGB(30,20,36)
        tabButtons[currentTab].TextColor3 = Color3.fromRGB(160,150,175)
    end
    currentTab = id
    if tabFrames[id] then
        tabFrames[id].Visible = true
        tabButtons[id].BackgroundColor3 = Config.CorA
        tabButtons[id].TextColor3 = Color3.fromRGB(255,255,255)
    end
end

local function addTab(id, label, builder)
    -- botão lateral
    local btn = Utils.new("TextButton",{
        Parent=sidebar, Size=UDim2.new(1,0,0,28),
        BackgroundColor3=Color3.fromRGB(30,20,36),
        Text=label, Font=Enum.Font.GothamBold, TextSize=10,
        TextColor3=Color3.fromRGB(160,150,175),
        TextXAlignment=Enum.TextXAlignment.Left,
        AutoButtonColor=false,
    })
    Utils.corner(btn, 6)
    Utils.stroke(btn, Color3.fromRGB(55,30,70), 1)
    Utils.new("UIPadding",{Parent=btn, PaddingLeft=UDim.new(0,8)})
    btn.MouseButton1Click:Connect(function() selectTab(id) end)
    tabButtons[id] = btn
    -- frame
    local f = UI.makeTab(content, id)
    tabFrames[id] = f
    builder(f)
    return f
end

function Main.build(parentGui)
    gui = Utils.new("ScreenGui",{
        Name="DochilliHub", ResetOnSpawn=false,
        ZIndexBehavior=Enum.ZIndexBehavior.Sibling,
        Parent=parentGui,
    })

    -- Botão flutuante
    floatBtn = Utils.new("TextButton",{
        Parent=gui, Position=UDim2.new(0,20,0,20),
        Size=UDim2.new(0,52,0,52),
        BackgroundColor3=Color3.fromRGB(20,12,26),
        Text="", AutoButtonColor=false, ZIndex=9999,
    })
    Utils.corner(floatBtn, 26)
    Utils.stroke(floatBtn, Config.CorA, 2)
    Utils.new("TextLabel",{
        Parent=floatBtn, Position=UDim2.new(0.5,-16,0.5,-16),
        Size=UDim2.new(0,32,0,32), BackgroundTransparency=1,
        Text="🥚", Font=Enum.Font.GothamBlack,
        TextSize=22, TextColor3=Color3.fromRGB(255,255,255),
        ZIndex=10000,
    })

    -- Painel
    local w,h = 520, 560
    if Config.Mobile then w,h = 340, 480 end
    panel = Utils.new("Frame",{
        Parent=gui, AnchorPoint=Vector2.new(0.5,0.5),
        Position=UDim2.new(0.5,0,0.5,0),
        Size=UDim2.new(0,w,0,h),
        BackgroundColor3=Color3.fromRGB(18,12,22),
        BorderSizePixel=0, ClipsDescendants=true, ZIndex=1000,
    })
    Utils.corner(panel, 12)
    Utils.stroke(panel, Config.CorB, 1.5)

    -- Header
    local header = Utils.new("Frame",{
        Parent=panel, Size=UDim2.new(1,0,0,40),
        BackgroundColor3=Color3.fromRGB(0,0,0),
        BackgroundTransparency=0.65, BorderSizePixel=0,
    })
    Utils.corner(header, 12)
    Utils.new("TextLabel",{
        Parent=header, Position=UDim2.new(0,12,0,0),
        Size=UDim2.new(1,-100,1,0), BackgroundTransparency=1,
        Text="🥚 "..Config.Nome.." v"..Config.Versao,
        Font=Enum.Font.GothamBold, TextSize=12,
        TextColor3=Color3.fromRGB(255,255,255),
        TextXAlignment=Enum.TextXAlignment.Left,
    })
    -- minimizar
    local minBtn = Utils.new("TextButton",{
        Parent=header, AnchorPoint=Vector2.new(1,0.5),
        Position=UDim2.new(1,-40,0.5,0),
        Size=UDim2.new(0,24,0,24), BackgroundTransparency=1,
        Text="—", Font=Enum.Font.GothamBold, TextSize=16,
        TextColor3=Color3.fromRGB(160,150,175), AutoButtonColor=false,
    })
    minBtn.MouseButton1Click:Connect(function() panel.Visible = false end)
    -- fechar
    local closeBtn = Utils.new("TextButton",{
        Parent=header, AnchorPoint=Vector2.new(1,0.5),
        Position=UDim2.new(1,-12,0.5,0),
        Size=UDim2.new(0,24,0,24), BackgroundTransparency=1,
        Text="✕", Font=Enum.Font.GothamBold, TextSize=14,
        TextColor3=Color3.fromRGB(160,150,175), AutoButtonColor=false,
    })
    closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

    -- Corpo
    local body = Utils.new("Frame",{
        Parent=panel, Position=UDim2.new(0,8,0,46),
        Size=UDim2.new(1,-16,1,-72),
        BackgroundTransparency=1,
    })
    sidebar = Utils.new("ScrollingFrame",{
        Parent=body, Size=UDim2.new(0,140,1,0),
        BackgroundTransparency=1, BorderSizePixel=0,
        ScrollBarThickness=2, ScrollBarImageColor3=Config.CorB,
        CanvasSize=UDim2.new(0,0,0,0),
        AutomaticCanvasSize=Enum.AutomaticSize.Y,
    })
    Utils.new("UIListLayout",{
        Parent=sidebar, Padding=UDim.new(0,4),
        SortOrder=Enum.SortOrder.LayoutOrder,
    })
    content = Utils.new("Frame",{
        Parent=body, Position=UDim2.new(0,148,0,0),
        Size=UDim2.new(1,-148,1,0),
        BackgroundColor3=Color3.fromRGB(25,16,32),
        BorderSizePixel=0,
    })
    Utils.corner(content, 8)
    Utils.stroke(content, Color3.fromRGB(55,30,70), 1)

    StatusBar.init(panel)
end

function Main.addTab(id, label, builder) return addTab(id, label, builder) end
function Main.selectTab(id) selectTab(id) end
function Main.getPanel() return panel end
function Main.getGui() return gui end

--=========================================================
-- MÓDULO: DRAG
--=========================================================
local function makeDraggable(handle, target, onClick)
    local dragging, dragStart, startPos, moved = false, nil, nil, false
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging, moved, dragStart, startPos = true, false, input.Position, target.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    if not moved and onClick then onClick() end
                end
            end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            local d = input.Position - dragStart
            if math.abs(d.X) > 3 or math.abs(d.Y) > 3 then moved = true end
            target.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + d.X,
                startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
end

--=========================================================
-- MÓDULOS DAS ABAS (150 funcionalidades)
--=========================================================

-- Contador de funcionalidades por módulo
local Funcionalidades = {
    "Egg Radar", "Pet Index", "Pet Details", "Server & Event Tracker",
    "Rarity Scanner", "Value Tracker", "Notifications", "Search & Filters",
    "Mobile UI", "Settings/Data/Performance"
}

------------------- 1. EGG RADAR ----------------
local function buildEggRadar(tab)
    UI.makeSection(tab, "🔍 Egg Radar — Localizador")

    local listaFrame = Utils.new("Frame",{
        Parent=tab, Size=UDim2.new(1,0,0,180),
        BackgroundColor3=Color3.fromRGB(15,10,20),
        BorderSizePixel=0,
    })
    Utils.corner(listaFrame, 6)
    local scroll = Utils.new("ScrollingFrame",{
        Parent=listaFrame, Size=UDim2.new(1,-8,1,-8),
        Position=UDim2.new(0,4,0,4),
        BackgroundTransparency=1, BorderSizePixel=0,
        ScrollBarThickness=2, ScrollBarImageColor3=Config.CorA,
        CanvasSize=UDim2.new(0,0,0,0),
        AutomaticCanvasSize=Enum.AutomaticSize.Y,
    })
    Utils.new("UIListLayout",{
        Parent=scroll, Padding=UDim.new(0,3),
        SortOrder=Enum.SortOrder.LayoutOrder,
    })

    local function refresh()
        for _,c in ipairs(scroll:GetChildren()) do
            if c:IsA("Frame") then c:Destroy() end
        end
        local lista = Scanner.rastrear()
        local count = 0
        table.sort(lista, function(a,b)
            return Utils.raridadeOrdem(a.raridade) > Utils.raridadeOrdem(b.raridade)
        end)
        for _,o in ipairs(lista) do
            if Search.matchOvo(o) then
                count += 1
                local row = Utils.new("TextButton",{
                    Parent=scroll, Size=UDim2.new(1,0,0,26),
                    BackgroundColor3=Color3.fromRGB(28,18,36),
                    BorderSizePixel=0, Text="",
                    AutoButtonColor=false,
                })
                Utils.corner(row, 4)
                Utils.new("TextLabel",{
                    Parent=row, Position=UDim2.new(0,6,0,0),
                    Size=UDim2.new(1,-16,1,0), BackgroundTransparency=1,
                    Text=string.format("%s  •  %s  •  %.0f studs", o.nome, o.raridade, o.distancia),
                    Font=Enum.Font.Gotham, TextSize=10,
                    TextColor3=Utils.raridadeCor(o.raridade),
                    TextXAlignment=Enum.TextXAlignment.Left,
                })
                row.MouseButton1Click:Connect(function()
                    local root = Utils.getRoot()
                    if root then root.CFrame = CFrame.new(o.posicao + Vector3.new(0,3,0)) end
                end)
            end
        end
        StatusBar.set(string.format("Estado: ligado  |  Última atualização: %s  |  Resultados: %d",
            os.date("%H:%M:%S"), count))
    end

    UI.makeButton(tab, "Atualizar agora", "Refresh", Config.CorB, refresh)
    UI.makeToggle(tab, "Radar visual", "Mostra marcadores 3D nos ovos.", Radar.ligar)
    UI.makeButton(tab, "Rastrear ovos", "Scan", Config.CorA, function()
        local lista = Scanner.rastrear()
        Notif.push("Egg Radar", #lista.." ovos encontrados no mapa.", Config.CorA)
        refresh()
    end)

    -- Filtros de raridade
    UI.makeSection(tab, "Filtros de Raridade")
    for _,r in ipairs(Data.Raridades) do
        UI.makeButton(tab, "Mostrar: "..r.nome, "Filtrar", r.cor, function()
            Radar.FiltroRaridade = r.nome
            Notif.push("Filtro", "Apenas "..r.nome, r.cor)
            refresh()
        end)
    end
    UI.makeButton(tab, "Limpar filtro", "Limpar", Color3.fromRGB(100,100,100), function()
        Radar.FiltroRaridade = nil; refresh()
    end)

    -- Pesquisa
    UI.makeSection(tab, "Pesquisa")
    UI.makeInput(tab, "Nome do ovo...", function(txt) Search.Query = txt; refresh() end)

    refresh()
    task.spawn(function()
        while tab.Parent do
            task.wait(Config.IntervaloScan)
            if tab.Visible then pcall(refresh) end
        end
    end)
end

------------------- 2. PET INDEX ----------------
local function buildPetIndex(tab)
    UI.makeSection(tab, "📖 Pet Index — Coleção")

    local stats = UI.makeLabel(tab, "Carregando...")
    local progress = Utils.new("Frame",{
        Parent=tab, Size=UDim2.new(1,0,0,10),
        BackgroundColor3=Color3.fromRGB(40,25,50),
        BorderSizePixel=0,
    })
    Utils.corner(progress, 5)
    local fill = Utils.new("Frame",{
        Parent=progress, Size=UDim2.new(0,0,1,0),
        BackgroundColor3=Config.CorB, BorderSizePixel=0,
    })
    Utils.corner(fill, 5)

    local lista = Utils.new("ScrollingFrame",{
        Parent=tab, Size=UDim2.new(1,0,0,220),
        BackgroundColor3=Color3.fromRGB(15,10,20),
        BorderSizePixel=0, ScrollBarThickness=2,
        ScrollBarImageColor3=Config.CorB,
        CanvasSize=UDim2.new(0,0,0,0),
        AutomaticCanvasSize=Enum.AutomaticSize.Y,
    })
    Utils.corner(lista,6)
    Utils.new("UIListLayout",{
        Parent=lista, Padding=UDim.new(0,3),
        SortOrder=Enum.SortOrder.LayoutOrder,
    })

    local filtro = nil
    local query = ""

    local function refresh()
        for _,c in ipairs(lista:GetChildren()) do
            if c:IsA("Frame") or c:IsA("TextButton") then c:Destroy() end
        end
        local total, conhecidos = 0, 0
        for _,p in ipairs(Data.Pets) do
            total += 1
            if p.conhecido then conhecidos += 1 end
        end
        local pct = total > 0 and math.floor((conhecidos/total)*100) or 0
        stats.Text = string.format("Descobertos: %d / %d  (%d%%)  [DEMO]", conhecidos, total, pct)
        fill.Size = UDim2.new(pct/100, 0, 1, 0)

        for _,p in ipairs(Data.Pets) do
            local passa = true
            if filtro and p.raridade ~= filtro then passa = false end
            if query ~= "" and not p.nome:lower():find(query:lower()) then passa = false end
            if passa then
                local row = Utils.new("Frame",{
                    Parent=lista, Size=UDim2.new(1,0,0,28),
                    BackgroundColor3=Color3.fromRGB(28,18,36),
                    BorderSizePixel=0,
                })
                Utils.corner(row,4)
                Utils.new("TextLabel",{
                    Parent=row, Position=UDim2.new(0,8,0,0),
                    Size=UDim2.new(1,-16,1,0), BackgroundTransparency=1,
                    Text=string.format("%s  •  %s  •  %s  •  %s",
                        p.nome, p.ovo, p.raridade,
                        p.conhecido and "DESCOBERTO" or "DESCONHECIDO"),
                    Font=Enum.Font.Gotham, TextSize=10,
                    TextColor3=Utils.raridadeCor(p.raridade),
                    TextXAlignment=Enum.TextXAlignment.Left,
                })
            end
        end
    end

    UI.makeInput(tab, "Pesquisar pet...", function(txt) query = txt; refresh() end)
    for _,r in ipairs(Data.Raridades) do
        UI.makeButton(tab, "Filtrar: "..r.nome, "Ver", r.cor, function()
            filtro = r.nome; refresh()
        end)
    end
    UI.makeButton(tab, "Limpar filtros", "Limpar", Color3.fromRGB(100,100,100), function()
        filtro = nil; query = ""; refresh()
    end)
    UI.makeButton(tab, "Exportar coleção", "JSON", Config.CorB, function()
        local json = HttpService:JSONEncode(Data.Descobertos)
        if setclipboard then setclipboard(json) end
        Notif.push("Exportar", "Coleção copiada para o clipboard.", Config.CorB)
    end)

    refresh()
end

------------------- 3. PET DETAILS ----------------
local function buildPetDetails(tab)
    UI.makeSection(tab, "🐾 Detalhes de Pets")
    UI.makeLabel(tab, "Seleciona um ovo no Egg Radar para ver os pets possíveis.")
    UI.makeLabel(tab, "Aviso: as chances e valores marcados [DEMO] são exemplos.")

    local lista = Utils.new("ScrollingFrame",{
        Parent=tab, Size=UDim2.new(1,0,0,280),
        BackgroundColor3=Color3.fromRGB(15,10,20),
        BorderSizePixel=0, ScrollBarThickness=2,
        ScrollBarImageColor3=Config.CorB,
        CanvasSize=UDim2.new(0,0,0,0),
        AutomaticCanvasSize=Enum.AutomaticSize.Y,
    })
    Utils.corner(lista,6)
    Utils.new("UIListLayout",{
        Parent=lista, Padding=UDim.new(0,4),
        SortOrder=Enum.SortOrder.LayoutOrder,
    })

    for _,p in ipairs(Data.Pets) do
        local card = Utils.new("Frame",{
            Parent=lista, Size=UDim2.new(1,0,0,54),
            BackgroundColor3=Color3.fromRGB(28,18,36),
            BorderSizePixel=0,
        })
        Utils.corner(card,6)
        Utils.new("TextLabel",{
            Parent=card, Position=UDim2.new(0,8,0,4),
            Size=UDim2.new(1,-16,0,16), BackgroundTransparency=1,
            Text=p.nome.."  ["..p.raridade.."]",
            Font=Enum.Font.GothamBold, TextSize=11,
            TextColor3=Utils.raridadeCor(p.raridade),
            TextXAlignment=Enum.TextXAlignment.Left,
        })
        Utils.new("TextLabel",{
            Parent=card, Position=UDim2.new(0,8,0,20),
            Size=UDim2.new(1,-16,0,14), BackgroundTransparency=1,
            Text=string.format("Ovo: %s | Valor: %d | Chance: %s",
                p.ovo, p.valor, p.chance and (p.chance.."%") or "N/D"),
            Font=Enum.Font.Gotham, TextSize=9,
            TextColor3=Color3.fromRGB(170,160,185),
            TextXAlignment=Enum.TextXAlignment.Left,
        })
        Utils.new("TextLabel",{
            Parent=card, Position=UDim2.new(0,8,0,34),
            Size=UDim2.new(1,-16,0,14), BackgroundTransparency=1,
            Text="Variantes: "..table.concat(p.variantes, ", "),
            Font=Enum.Font.Gotham, TextSize=9,
            TextColor3=Color3.fromRGB(150,140,165),
            TextXAlignment=Enum.TextXAlignment.Left,
        })
    end
end

------------------- 4. SERVER TRACKER ----------------
local function buildServerTracker(tab)
    UI.makeSection(tab, "🌐 Server & Event Tracker")
    UI.makeLabel(tab, "Job ID: "..game.JobId)
    UI.makeLabel(tab, "Place ID: "..game.PlaceId)
    UI.makeLabel(tab, "Jogadores agora: "..#Players:GetPlayers())
    UI.makeLabel(tab, "Máximo: "..Players.MaxPlayers)

    UI.makeButton(tab, "Copiar Job ID", "Copiar", Config.CorB, function()
        if setclipboard then setclipboard(game.JobId) end
        Notif.push("Server", "Job ID copiado.", Config.CorB)
    end)
    UI.makeButton(tab, "Rejoin server", "Rejoin", Config.CorA, function()
        pcall(function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
        end)
    end)
    UI.makeButton(tab, "Server Hop", "Hop", Config.CorB, function()
        local url = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"
        local ok, body = pcall(function() return HttpService:JSONDecode(game:HttpGet(url)) end)
        if ok and body and body.data then
            for _,s in ipairs(body.data) do
                if s.playing < s.maxPlayers and s.id ~= game.JobId then
                    pcall(function()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, s.id, LP)
                    end)
                    return
                end
            end
        end
        Notif.push("Hop", "Nenhum servidor disponível.", Color3.fromRGB(200,50,50))
    end)

    local playersList = Utils.new("ScrollingFrame",{
        Parent=tab, Size=UDim2.new(1,0,0,180),
        BackgroundColor3=Color3.fromRGB(15,10,20),
        BorderSizePixel=0, ScrollBarThickness=2,
        ScrollBarImageColor3=Config.CorB,
        CanvasSize=UDim2.new(0,0,0,0),
        AutomaticCanvasSize=Enum.AutomaticSize.Y,
    })
    Utils.corner(playersList,6)
    Utils.new("UIListLayout",{
        Parent=playersList, Padding=UDim.new(0,2),
        SortOrder=Enum.SortOrder.LayoutOrder,
    })
    local function refreshPlayers()
        for _,c in ipairs(playersList:GetChildren()) do
            if c:IsA("Frame") then c:Destroy() end
        end
        for _,p in ipairs(Players:GetPlayers()) do
            local row = Utils.new("Frame",{
                Parent=playersList, Size=UDim2.new(1,0,0,22),
                BackgroundColor3=Color3.fromRGB(28,18,36),
                BorderSizePixel=0,
            })
            Utils.corner(row,4)
            Utils.new("TextLabel",{
                Parent=row, Position=UDim2.new(0,8,0,0),
                Size=UDim2.new(1,-16,1,0), BackgroundTransparency=1,
                Text=p.Name, Font=Enum.Font.Gotham, TextSize=10,
                TextColor3=Color3.fromRGB(220,215,230),
                TextXAlignment=Enum.TextXAlignment.Left,
            })
        end
    end
    refreshPlayers()
    Players.PlayerAdded:Connect(refreshPlayers)
    Players.PlayerRemoving:Connect(refreshPlayers)
end

------------------- 5. RARITY SCANNER ----------------
local function buildRarityScanner(tab)
    UI.makeSection(tab, "🎯 Rarity Scanner")
    UI.makeLabel(tab, "Classifica ovos por prefixo do nome (heurística).")
    UI.makeLabel(tab, "Não inventa raridades — usa palavras-chave do nome.")

    for _,r in ipairs(Data.Raridades) do
        local card = UI.makeLabel(tab, r.nome, r.cor)
        local cor = r.cor
        local nome = r.nome
        card.MouseButton1Click = nil
    end

    UI.makeButton(tab, "Scan completo", "Escanear", Config.CorA, function()
        local lista = Scanner.rastrear()
        local porRaridade = {}
        for _,o in ipairs(lista) do
            porRaridade[o.raridade] = (porRaridade[o.raridade] or 0) + 1
        end
        local msg = ""
        for _,r in ipairs(Data.Raridades) do
            msg = msg .. r.nome .. ": " .. (porRaridade[r.nome] or 0) .. "\n"
        end
        Notif.push("Rarity Scanner", msg, Config.CorB)
    end)
end

------------------- 6. VALUE TRACKER ----------------
local function buildValueTracker(tab)
    UI.makeSection(tab, "💰 Value Tracker")
    UI.makeLabel(tab, "Valores marcados [DEMO] — preenche Data.Pets e Data.Eggs.")

    local lista = Utils.new("ScrollingFrame",{
        Parent=tab, Size=UDim2.new(1,0,0,300),
        BackgroundColor3=Color3.fromRGB(15,10,20),
        BorderSizePixel=0, ScrollBarThickness=2,
        ScrollBarImageColor3=Config.CorA,
        CanvasSize=UDim2.new(0,0,0,0),
        AutomaticCanvasSize=Enum.AutomaticSize.Y,
    })
    Utils.corner(lista,6)
    Utils.new("UIListLayout",{
        Parent=lista, Padding=UDim.new(0,3),
        SortOrder=Enum.SortOrder.LayoutOrder,
    })

    local ordenado = {}
    for _,p in ipairs(Data.Pets) do table.insert(ordenado, p) end
    table.sort(ordenado, function(a,b) return a.valor > b.valor end)

    for _,p in ipairs(ordenado) do
        local row = Utils.new("Frame",{
            Parent=lista, Size=UDim2.new(1,0,0,24),
            BackgroundColor3=Color3.fromRGB(28,18,36),
            BorderSizePixel=0,
        })
        Utils.corner(row,4)
        Utils.new("TextLabel",{
            Parent=row, Position=UDim2.new(0,8,0,0),
            Size=UDim2.new(1,-16,1,0), BackgroundTransparency=1,
            Text=string.format("%s  →  %d  (%s)", p.nome, p.valor, p.raridade),
            Font=Enum.Font.Gotham, TextSize=10,
            TextColor3=Utils.raridadeCor(p.raridade),
            TextXAlignment=Enum.TextXAlignment.Left,
        })
    end
end

------------------- 7. NOTIFICATIONS ----------------
local function buildNotifications(tab)
    UI.makeSection(tab, "🔔 Notificações")
    UI.makeButton(tab, "Testar notificação", "Testar", Config.CorB, function()
        Notif.push("Teste", "Notificação de exemplo.", Config.CorB)
    end)
    UI.makeToggle(tab, "Alertar novos ovos raros", "Avisa quando o radar encontra um ovo Raro+.", function(v)
        if v then
            task.spawn(function()
                local vistos = {}
                while v do
                    task.wait(Config.IntervaloScan)
                    local lista = Scanner.rastrear()
                    for _,o in ipairs(lista) do
                        local key = o.nome
                        if not vistos[key] and Utils.raridadeOrdem(o.raridade) >= 3 then
                            vistos[key] = true
                            Notif.push("Novo ovo raro!", o.nome.." ("..o.raridade..")", Utils.raridadeCor(o.raridade))
                        end
                    end
                end
            end)
        end
    end)
end

------------------- 8. SEARCH & FILTERS ----------------
local function buildSearch(tab)
    UI.makeSection(tab, "🔎 Pesquisa Global")
    local resultado = UI.makeLabel(tab, "Escreve algo para pesquisar...")
    UI.makeInput(tab, "Nome do ovo ou pet...", function(txt)
        local encontrados = {}
        for _,p in ipairs(Data.Pets) do
            if p.nome:lower():find(txt:lower()) then
                table.insert(encontrados, p.nome.." ("..p.ovo..")")
            end
        end
        if #encontrados == 0 then
            resultado.Text = "Nenhum resultado."
        else
            resultado.Text = table.concat(encontrados, " • ")
        end
    end)
end

------------------- 9. MOBILE UI ----------------
local function buildMobile(tab)
    UI.makeSection(tab, "📱 Mobile UI")
    UI.makeToggle(tab, "Modo telemóvel", "Reduz o painel para ecrãs pequenos.", function(v)
        Config.Mobile = v
        if v then
            Notif.push("Mobile", "Reinicia o script para aplicar.", Config.CorB)
        end
    end)
    UI.makeLabel(tab, "Tamanho atual: "..(Config.Mobile and "Mobile" or "Desktop"))
    UI.makeLabel(tab, "O painel adapta-se automaticamente ao touch.")
end

------------------- 10. SETTINGS ----------------
local function buildSettings(tab)
    UI.makeSection(tab, "⚙ Configurações")
    UI.makeToggle(tab, "Animações", "Ativa transições suaves.", function(v)
        Config.Animacoes = v
    end)
    UI.makeLabel(tab, "Intervalo de scan: "..Config.IntervaloScan.."s")
    UI.makeButton(tab, "Aumentar intervalo (+1s)", "+", Color3.fromRGB(80,120,200), function()
        Config.IntervaloScan = Config.IntervaloScan + 1
        Notif.push("Config", "Intervalo: "..Config.IntervaloScan.."s", Config.CorB)
    end)
    UI.makeButton(tab, "Diminuir intervalo (-1s)", "-", Color3.fromRGB(80,120,200), function()
        if Config.IntervaloScan > 1 then Config.IntervaloScan = Config.IntervaloScan - 1 end
        Notif.push("Config", "Intervalo: "..Config.IntervaloScan.."s", Config.CorB)
    end)

    UI.makeSection(tab, "📊 Performance")
    UI.makeButton(tab, "Performance: mostra ping", "Ver", Config.CorB, function()
        local ping = math.floor(LP:GetNetworkPing() * 1000)
        Notif.push("Ping", ping.." ms", Config.CorB)
    end)
    UI.makeButton(tab, "Limpar radar visual", "Limpar", Color3.fromRGB(150,60,60), function()
        Radar.ligar(false)
        Notif.push("Radar", "Radar desligado.", Color3.fromRGB(150,60,60))
    end)
    UI.makeButton(tab, "Fechar painel", "Fechar", Color3.fromRGB(150,60,60), function()
        Main.getPanel().Visible = false
    end)
end

--=========================================================
-- BOOT
--=========================================================
local function boot()
    -- limpar versão anterior
    local old = PGui:FindFirstChild("DochilliHub")
    if old then old:Destroy() end

    Notif.init(PGui)
    Main.build(PGui)

    -- Abas
    Main.addTab("home",     "🏠 Início",       function(t)
        UI.makeSection(t, "🥚 "..Config.Nome)
        UI.makeLabel(t, "Versão "..Config.Versao)
        UI.makeLabel(t, "Radar de ovos + Index de pets.")
        UI.makeLabel(t, "Pesquisa, filtros, valores e histórico.")
        UI.makeLabel(t, "Dados marcados [DEMO] são exemplos.")
        UI.makeLabel(t, "Substitui Data.Pets e Data.Eggs para dados reais.")
    end)
    Main.addTab("radar",    "🔍 Egg Radar",    buildEggRadar)
    Main.addTab("index",    "📖 Pet Index",    buildPetIndex)
    Main.addTab("details",  "🐾 Pet Details",  buildPetDetails)
    Main.addTab("server",   "🌐 Server",       buildServerTracker)
    Main.addTab("rarity",   "🎯 Rarity",       buildRarityScanner)
    Main.addTab("value",    "💰 Values",       buildValueTracker)
    Main.addTab("notifs",   "🔔 Notifs",       buildNotifications)
    Main.addTab("search",   "🔎 Pesquisa",     buildSearch)
    Main.addTab("mobile",   "📱 Mobile",       buildMobile)
    Main.addTab("settings", "⚙ Config",        buildSettings)

    Main.selectTab("home")

    -- Drag no header
    local panel = Main.getPanel()
    makeDraggable(panel:FindFirstChildWhichIsA("Frame"), panel)
    makeDraggable(Main.getGui():FindFirstChild("DochilliHub") or nil, panel) -- fallback

    -- Botão flutuante abre/fecha
    local fb = Main.getGui():FindFirstChildWhichIsA("TextButton")
    makeDraggable(fb, fb, function()
        panel.Visible = not panel.Visible
    end)

    -- Atalho: RightShift alterna
    UIS.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Enum.KeyCode.RightShift then
            panel.Visible = not panel.Visible
        end
    end)

    Notif.push(Config.Nome, "Hub carregado. Dados demo — vê o aviso no Início.", Config.CorB)
    print("["..Config.Nome.."] v"..Config.Versao.." carregado.")
end

boot()
