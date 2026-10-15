-- DOCHILLI HUB v1.2
local P=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local TW=game:GetService("TweenService")
local RS=game:GetService("RunService")
local HS=game:GetService("HttpService")
local LP=P.LocalPlayer
local PG=LP:WaitForChild("PlayerGui")
local old=PG:FindFirstChild("DochilliHub") if old then old:Destroy() end

local C={bg=Color3.fromRGB(18,12,22),card=Color3.fromRGB(30,20,36),bd=Color3.fromRGB(55,30,70),red=Color3.fromRGB(180,30,60),pur=Color3.fromRGB(120,60,180),grn=Color3.fromRGB(60,200,120),yel=Color3.fromRGB(240,180,60),txt=Color3.fromRGB(240,235,245),txt2=Color3.fromRGB(160,150,175)}

local function N(c,p) local i=Instance.new(c) if p then local x=p.Parent;p.Parent=nil;for k,v in pairs(p) do i[k]=v end;i.Parent=x end return i end
local function cr(p,r) N("UICorner",{Parent=p,CornerRadius=UDim.new(0,r or 6)}) end
local function st(p,c) N("UIStroke",{Parent=p,Color=c or C.bd,Thickness=1}) end
local function rt() local c=LP.Character return c and c:FindFirstChild("HumanoidRootPart") end
local function hm() local c=LP.Character return c and c:FindFirstChildOfClass("Humanoid") end

-- ===== BASE DE DADOS DEMO =====
local DB={
    eggs={
        {nome="Basic Egg",rar="Comum",valor=100,cor=Color3.fromRGB(180,180,180)},
        {nome="Forest Egg",rar="Incomum",valor=500,cor=Color3.fromRGB(80,200,120)},
        {nome="Ocean Egg",rar="Raro",valor=2500,cor=Color3.fromRGB(80,140,255)},
        {nome="Volcano Egg",rar="Épico",valor=12000,cor=Color3.fromRGB(160,80,220)},
        {nome="Sky Egg",rar="Lendário",valor=60000,cor=Color3.fromRGB(255,180,60)},
        {nome="Void Egg",rar="Mítico",valor=250000,cor=Color3.fromRGB(255,80,80)},
        {nome="?? Egg",rar="Secreto",valor=1000000,cor=Color3.fromRGB(255,50,180)},
    },
    pets={
        {nome="Doggy",ovo="Basic Egg",rar="Comum",valor=50,cor=Color3.fromRGB(180,180,180),idx=true},
        {nome="Kitty",ovo="Basic Egg",rar="Incomum",valor=200,cor=Color3.fromRGB(80,200,120),idx=true},
        {nome="Fox",ovo="Forest Egg",rar="Raro",valor=1500,cor=Color3.fromRGB(80,140,255),idx=true},
        {nome="Wolf",ovo="Forest Egg",rar="Épico",valor=5000,cor=Color3.fromRGB(160,80,220),idx=false},
        {nome="Shark",ovo="Ocean Egg",rar="Lendário",valor=30000,cor=Color3.fromRGB(255,180,60),idx=true},
        {nome="Dragon",ovo="Volcano Egg",rar="Mítico",valor=180000,cor=Color3.fromRGB(255,80,80),idx=false},
        {nome="Phoenix",ovo="Sky Egg",rar="Mítico",valor=900000,cor=Color3.fromRGB(255,80,80),idx=false},
        {nome="Cosmic",ovo="Void Egg",rar="Secreto",valor=5000000,cor=Color3.fromRGB(255,50,180),idx=false},
    }
}

local Stats={scans=0,erros=0,inicio=tick(),modo="DEMO",modulos={}}

local NH=N("Frame",{Parent=PG,AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-16,0,16),Size=UDim2.new(0,260,0,400),BackgroundTransparency=1,ZIndex=9999})
N("UIListLayout",{Parent=NH,Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder,VerticalAlignment=Enum.VerticalAlignment.Top,HorizontalAlignment=Enum.HorizontalAlignment.Right})
local function nt(t,m,c) c=c or C.red
local b=N("Frame",{Parent=NH,Size=UDim2.new(1,0,0,50),BackgroundColor3=C.card,BorderSizePixel=0,ZIndex=9999})
cr(b,8) st(b,c)
N("TextLabel",{Parent=b,Position=UDim2.new(0,8,0,4),Size=UDim2.new(1,-16,0,16),BackgroundTransparency=1,Text=t,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=c,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=9999})
N("TextLabel",{Parent=b,Position=UDim2.new(0,8,0,22),Size=UDim2.new(1,-16,0,24),BackgroundTransparency=1,Text=m,Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true,ZIndex=9999})
task.delay(5,function() if b.Parent then b:Destroy() end end) end

local gui=N("ScreenGui",{Name="DochilliHub",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,Parent=PG,DisplayOrder=999})
local fb=N("TextButton",{Parent=gui,Position=UDim2.new(0,20,0,20),Size=UDim2.new(0,52,0,52),BackgroundColor3=C.bg,Text="",AutoButtonColor=false,ZIndex=9999,Active=true})
cr(fb,26) st(fb,C.red)
N("TextLabel",{Parent=fb,Position=UDim2.new(0.5,-16,0.5,-16),Size=UDim2.new(0,32,0,32),BackgroundTransparency=1,Text="🥚",Font=Enum.Font.GothamBlack,TextSize=22,ZIndex=10000})

local pan=N("Frame",{Parent=gui,AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0.5,0,0.5,0),Size=UDim2.new(0,540,0,560),BackgroundColor3=C.bg,BorderSizePixel=0,ClipsDescendants=true,ZIndex=1000,Visible=true})
cr(pan,12) st(pan,C.pur)
local hd=N("Frame",{Parent=pan,Size=UDim2.new(1,0,0,40),BackgroundColor3=Color3.fromRGB(0,0,0),BackgroundTransparency=0.65,BorderSizePixel=0})
cr(hd,12)
N("TextLabel",{Parent=hd,Position=UDim2.new(0,12,0,0),Size=UDim2.new(1,-100,1,0),BackgroundTransparency=1,Text="🥚 DOCHILLI HUB v1.2",Font=Enum.Font.GothamBold,TextSize=12,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})
local xb=N("TextButton",{Parent=hd,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-12,0.5,0),Size=UDim2.new(0,24,0,24),BackgroundTransparency=1,Text="✕",Font=Enum.Font.GothamBold,TextSize=14,TextColor3=C.txt2,AutoButtonColor=false})
xb.MouseButton1Click:Connect(function() pan.Visible=false end)

local bd=N("Frame",{Parent=pan,Position=UDim2.new(0,8,0,46),Size=UDim2.new(1,-16,1,-54),BackgroundTransparency=1})
local sb=N("ScrollingFrame",{Parent=bd,Size=UDim2.new(0,130,1,0),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=C.pur,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})
N("UIListLayout",{Parent=sb,Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder})
local ct=N("Frame",{Parent=bd,Position=UDim2.new(0,138,0,0),Size=UDim2.new(1,-138,1,0),BackgroundColor3=Color3.fromRGB(25,16,32),BorderSizePixel=0})
cr(ct,8) st(ct,C.bd)

local tabs,tb,cur={},{},nil
local function sTab(id) if cur and tabs[cur] then tabs[cur].Visible=false;tb[cur].BackgroundColor3=C.card;tb[cur].TextColor3=C.txt2 end
cur=id if tabs[id] then tabs[id].Visible=true;tb[id].BackgroundColor3=C.red;tb[id].TextColor3=Color3.fromRGB(255,255,255) end end

local function mTab(id,l,fn)
local b=N("TextButton",{Parent=sb,Size=UDim2.new(1,0,0,26),BackgroundColor3=C.card,Text=l,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left,AutoButtonColor=false})
cr(b,6) st(b,C.bd)
N("UIPadding",{Parent=b,PaddingLeft=UDim.new(0,6)})
b.MouseButton1Click:Connect(function() sTab(id) end)
tb[id]=b
local f=N("ScrollingFrame",{Parent=ct,Size=UDim2.new(1,-12,1,-12),Position=UDim2.new(0,6,0,6),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=C.pur,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,Visible=false})
N("UIListLayout",{Parent=f,Padding=UDim.new(0,5),SortOrder=Enum.SortOrder.LayoutOrder})
tabs[id]=f Stats.modulos[id]=true fn(f) end

local function cd(p,h) local c=N("Frame",{Parent=p,Size=UDim2.new(1,0,0,h or 40),BackgroundColor3=C.card,BorderSizePixel=0}) cr(c,6) st(c,C.bd) return c end
local function lb(p,t,c) local f=cd(p,26)
N("TextLabel",{Parent=f,Position=UDim2.new(0,8,0,0),Size=UDim2.new(1,-16,1,0),BackgroundTransparency=1,Text=t,Font=Enum.Font.Gotham,TextSize=10,TextColor3=c or C.txt,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd}) end
local function bt(p,l,t,c,fn) local f=cd(p,34)
N("TextLabel",{Parent=f,Position=UDim2.new(0,8,0,0),Size=UDim2.new(1,-120,1,0),BackgroundTransparency=1,Text=l,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})
local b=N("TextButton",{Parent=f,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-8,0.5,0),Size=UDim2.new(0,100,0,22),BackgroundColor3=c or C.red,Text=t or "OK",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})
cr(b,5)
b.MouseButton1Click:Connect(function() local ok,e=pcall(fn) if not ok then Stats.erros+=1; nt("Erro",tostring(e),C.red) end end) end
local function tg(p,l,d,fn) local f=cd(p,42)
N("TextLabel",{Parent=f,Position=UDim2.new(0,8,0,5),Size=UDim2.new(1,-50,0,14),BackgroundTransparency=1,Text=l,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})
if d then N("TextLabel",{Parent=f,Position=UDim2.new(0,8,0,21),Size=UDim2.new(1,-16,0,16),BackgroundTransparency=1,Text=d,Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true}) end
local s=false
local sw=N("TextButton",{Parent=f,AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-8,0,6),Size=UDim2.new(0,28,0,16),BackgroundColor3=C.bd,Text="",AutoButtonColor=false})
cr(sw,8)
local kn=N("Frame",{Parent=sw,Position=UDim2.new(0,3,0,3),Size=UDim2.new(0,10,0,10),BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0})
cr(kn,5)
sw.MouseButton1Click:Connect(function() s=not s
TW:Create(kn,TweenInfo.new(0.15),{Position=s and UDim2.new(0,15,0,3) or UDim2.new(0,3,0,3)}):Play()
sw.BackgroundColor3=s and C.red or C.bd
if fn then pcall(fn,s) end end) end

-- ===== FUNÇÕES REAIS =====
local St={speed=16,espOn=false,noclip=false,fly=false,infJump=false,antiRag=false,radarOn=false,alertsOn=false}

local function applySpeed() local h=hm() if h then h.WalkSpeed=St.speed end end
local function applyNoclip() if St.noclip then local c=LP.Character if c then for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end end end
local function applyAntiRag() if St.antiRag then local h=hm() if h then h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false);h:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false) end end end

local espFolder
local function refreshESP()
if espFolder then espFolder:Destroy() espFolder=nil end
if not St.espOn then return end
espFolder=N("Folder",{Parent=gui,Name="ESP"})
for _,pl in ipairs(P:GetPlayers()) do
if pl~=LP and pl.Character then local hd=pl.Character:FindFirstChild("Head")
if hd then local bbg=N("BillboardGui",{Parent=espFolder,Adornee=hd,Size=UDim2.new(0,120,0,20),StudsOffset=Vector3.new(0,2.5,0),AlwaysOnTop=true})
N("TextLabel",{Parent=bbg,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=pl.Name,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.red,TextStrokeTransparency=0}) end end end end

UIS.JumpRequest:Connect(function() if St.infJump then local h=hm() if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end end)
RS.Stepped:Connect(function() applyNoclip();applyAntiRag() end)

local flyBV,flyBG
local function startFly() local r=rt() if not r then return end
flyBV=N("BodyVelocity",{Parent=r,MaxForce=Vector3.new(1e5,1e5,1e5),Velocity=Vector3.new(0,0,0)})
flyBG=N("BodyGyro",{Parent=r,MaxTorque=Vector3.new(1e5,1e5,1e5),P=1000,D=100,CFrame=r.CFrame}) end
local function stopFly() if flyBV then flyBV:Destroy() flyBV=nil end; if flyBG then flyBG:Destroy() flyBG=nil end end
RS.RenderStepped:Connect(function()
if not St.fly or not flyBV then return end
local r=rt() if not r then return end
local cam=workspace.CurrentCamera
local mv=Vector3.new(0,0,0)
if UIS:IsKeyDown(Enum.KeyCode.W) then mv+=cam.CFrame.LookVector end
if UIS:IsKeyDown(Enum.KeyCode.S) then mv-=cam.CFrame.LookVector end
if UIS:IsKeyDown(Enum.KeyCode.A) then mv-=cam.CFrame.RightVector end
if UIS:IsKeyDown(Enum.KeyCode.D) then mv+=cam.CFrame.RightVector end
if UIS:IsKeyDown(Enum.KeyCode.Space) then mv+=Vector3.new(0,1,0) end
flyBV.Velocity=mv*50
flyBG.CFrame=cam.CFrame end)

-- Scanner de ovos no mapa
local function scan()
local r=rt() local l={}
if not r then return l end
for _,o in ipairs(workspace:GetDescendants()) do
if o:IsA("BasePart") then local n=o.Name:lower()
if n:find("egg") or n:find("ovo") or n:find("brainrot") then
table.insert(l,{nome=o.Name,dist=(o.Position-r.Position).Magnitude,pos=o.Position,ref=o}) end end end
table.sort(l,function(a,b) return a.dist<b.dist end)
Stats.scans+=1
return l end

-- Radar visual contínuo
local radarFolder
local function setRadar(on)
St.radarOn=on
if radarFolder then radarFolder:Destroy() radarFolder=nil end
if not on then return end
radarFolder=N("Folder",{Parent=gui,Name="Radar"})
task.spawn(function()
while St.radarOn and radarFolder and radarFolder.Parent do
for _,o in ipairs(scan()) do
if not radarFolder:FindFirstChild(o.nome) then
local bbg=N("BillboardGui",{Parent=radarFolder,Name=o.nome,Adornee=o.ref,Size=UDim2.new(0,100,0,20),AlwaysOnTop=true,StudsOffset=Vector3.new(0,2,0)})
N("TextLabel",{Parent=bbg,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="🥚",Font=Enum.Font.GothamBold,TextSize=18,TextStrokeTransparency=0}) end end
task.wait(2)
end end)
end

-- ===== ABA HOME =====
mTab("home","🏠 Início",function(t)
lb(t,"DOCHILLI HUB v1.2")
lb(t,"Modo: "..Stats.modo)
lb(t,"Funções universais funcionais.")
lb(t,"Dados pets são demo.")
end)

-- ===== ABA PLAYER =====
mTab("plr","👤 Player",function(t)
tg(t,"Speed Boost","Mais rápido.",function(v) St.speed=v and 32 or 16; applySpeed() end)
tg(t,"Infinite Jump","Pulo no ar.",function(v) St.infJump=v end)
tg(t,"Noclip","Atravessar paredes.",function(v) St.noclip=v end)
tg(t,"Anti-Ragdoll","Não cai.",function(v) St.antiRag=v end)
tg(t,"Fly","WASD + Space.",function(v) St.fly=v if v then startFly() else stopFly() end end)
tg(t,"ESP Players","Nomes.",function(v) St.espOn=v refreshESP() end)
bt(t,"Reset Character","Reset",C.red,function() local c=LP.Character if c then c:BreakJoints() end end)
end)

-- ===== ABA EGG RADAR + SERVER SEARCH =====
mTab("radar","🔍 Egg Radar",function(t)
lb(t,"📡 Ovos no mapa do servidor atual:")
bt(t,"Scan servidor atual","Scan",C.pur,function()
local l=scan() nt("Radar",#l.." ovos no servidor",C.pur) end)
local lf=N("ScrollingFrame",{Parent=t,Size=UDim2.new(1,0,0,180),BackgroundColor3=Color3.fromRGB(15,10,20),BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=C.red,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})
cr(lf,6) N("UIListLayout",{Parent=lf,Padding=UDim.new(0,3),SortOrder=Enum.SortOrder.LayoutOrder})
bt(t,"Listar ovos","Listar",C.red,function()
for _,c in ipairs(lf:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
for _,o in ipairs(scan()) do
local row=N("TextButton",{Parent=lf,Size=UDim2.new(1,0,0,24),BackgroundColor3=C.card,Text="",AutoButtonColor=false})
cr(row,4)
N("TextLabel",{Parent=row,Position=UDim2.new(0,6,0,0),Size=UDim2.new(1,-12,1,0),BackgroundTransparency=1,Text=string.format("%s (%.0f)",o.nome,o.dist),Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})
row.MouseButton1Click:Connect(function() local r=rt() if r then r.CFrame=CFrame.new(o.pos+Vector3.new(0,3,0)) end end) end end)
tg(t,"Radar visual contínuo","Marcadores em todos os ovos.",setRadar)
lb(t,"🌐 Comparar servidores públicos:")
local srvL=N("ScrollingFrame",{Parent=t,Size=UDim2.new(1,0,0,140),BackgroundColor3=Color3.fromRGB(15,10,20),BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=C.pur,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})
cr(srvL,6) N("UIListLayout",{Parent=srvL,Padding=UDim.new(0,3),SortOrder=Enum.SortOrder.LayoutOrder})
bt(t,"Buscar servidores","Buscar",C.pur,function()
for _,c in ipairs(srvL:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
local url="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=50"
local ok,body=pcall(function() return HS:JSONDecode(game:HttpGet(url)) end)
if ok and body and body.data then
for _,s in ipairs(body.data) do
local row=N("TextButton",{Parent=srvL,Size=UDim2.new(1,0,0,22),BackgroundColor3=C.card,Text="",AutoButtonColor=false})
cr(row,4)
N("TextLabel",{Parent=row,Position=UDim2.new(0,6,0,0),Size=UDim2.new(1,-12,1,0),BackgroundTransparency=1,Text=string.format("Servidor: %d/%d jogadores",s.playing,s.maxPlayers),Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})
row.MouseButton1Click:Connect(function() pcall(function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,s.id,LP) end) end) end
nt("Servers","Encontrados "..#body.data,C.pur)
else nt("Servers","Falhou (API protegida)",C.yel) end end)
end)

-- ===== ABA EGG → PET PANEL =====
mTab("eggpet","🥚→🐾 Pet Panel",function(t)
lb(t,"Escolhe um ovo à esquerda:")
local eggsL=N("ScrollingFrame",{Parent=t,Size=UDim2.new(1,0,0,150),BackgroundColor3=Color3.fromRGB(15,10,20),BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=C.red,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})
cr(eggsL,6) N("UIListLayout",{Parent=eggsL,Padding=UDim.new(0,3),SortOrder=Enum.SortOrder.LayoutOrder})
local petsL=N("ScrollingFrame",{Parent=t,Size=UDim2.new(1,0,0,200),BackgroundColor3=Color3.fromRGB(15,10,20),BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=C.pur,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})
cr(petsL,6) N("UIListLayout",{Parent=petsL,Padding=UDim.new(0,3),SortOrder=Enum.SortOrder.LayoutOrder})

local function showPets(ovoNome)
for _,c in ipairs(petsL:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
local h=N("TextLabel",{Parent=petsL,Size=UDim2.new(1,0,0,20),BackgroundTransparency=1,Text="Pets de: "..ovoNome,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.pur,TextXAlignment=Enum.TextXAlignment.Left})
local count=0
for _,p in ipairs(DB.pets) do
if p.ovo==ovoNome then
count+=1
local card=N("Frame",{Parent=petsL,Size=UDim2.new(1,0,0,42),BackgroundColor3=C.card,BorderSizePixel=0})
cr(card,4)
N("TextLabel",{Parent=card,Position=UDim2.new(0,6,0,2),Size=UDim2.new(1,-12,0,14),BackgroundTransparency=1,Text=p.nome.." ["..p.rar.."]",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=p.cor,TextXAlignment=Enum.TextXAlignment.Left})
N("TextLabel",{Parent=card,Position=UDim2.new(0,6,0,16),Size=UDim2.new(1,-12,0,12),BackgroundTransparency=1,Text="Valor: "..p.valor.." | Index: "..(p.idx and "✓ DESCOBERTO" or "✗ DESCONHECIDO"),Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left})
end end
if count==0 then N("TextLabel",{Parent=petsL,Size=UDim2.new(1,0,0,20),BackgroundTransparency=1,Text="Nenhum pet conhecido deste ovo.",Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left}) end
end

for _,e in ipairs(DB.eggs) do
local row=N("TextButton",{Parent=eggsL,Size=UDim2.new(1,0,0,26),BackgroundColor3=C.card,Text="",AutoButtonColor=false})
cr(row,4)
N("TextLabel",{Parent=row,Position=UDim2.new(0,6,0,0),Size=UDim2.new(1,-12,1,0),BackgroundTransparency=1,Text=e.nome.." ["..e.rar.."] - "..e.valor,Font=Enum.Font.Gotham,TextSize=9,TextColor3=e.cor,TextXAlignment=Enum.TextXAlignment.Left})
row.MouseButton1Click:Connect(function() showPets(e.nome) end)
end
end)

-- ===== ABA TOP 24H =====
local Top={historico={}}
local function registarSnapshot()
local l=scan() local r={tick(),#l,0}
for _,o in ipairs(l) do r[3]+=o.dist end
table.insert(Top.historico,{t=tick(),count=#l,distMedia=r[3]/math.max(#l,1)})
if #Top.historico>48 then table.remove(Top.historico,1) end end
registarSnapshot()
task.spawn(function() while true do task.wait(1800); registarSnapshot() end end)

mTab("top","🏆 TOP 24H",function(t)
lb(t,"Tracker de evolução (24h)")
local info=lb(t,"Snapshots registados: "..#Top.historico)
bt(t,"Snapshot manual","Registar",C.pur,function()
registarSnapshot() info.Text="Snapshots: "..#Top.historico
nt("Top","Snapshot guardado",C.pur) end)
bt(t,"Ver histórico","Mostrar",C.red,function()
local txt=""
for i,s in ipairs(Top.historico) do
txt=txt..string.format("Há %d min: %d ovos\n",math.floor((tick()-s.t)/60),s.count)
end
nt("Histórico",txt~="" and txt or "Sem dados ainda",C.pur) end)
end)

-- ===== ABA VALUE SCANNER =====
mTab("values","💰 Value Scan",function(t)
lb(t,"Ordenado por valor (do mais alto)")
local list=N("ScrollingFrame",{Parent=t,Size=UDim2.new(1,0,0,400),BackgroundColor3=Color3.fromRGB(15,10,20),BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=C.yel,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})
cr(list,6) N("UIListLayout",{Parent=list,Padding=UDim.new(0,3),SortOrder=Enum.SortOrder.LayoutOrder})
local ord={}
for _,p in ipairs(DB.pets) do table.insert(ord,p) end
table.sort(ord,function(a,b) return a.valor>b.valor end)
for i,p in ipairs(ord) do
local card=N("Frame",{Parent=list,Size=UDim2.new(1,0,0,30),BackgroundColor3=C.card,BorderSizePixel=0})
cr(card,4)
N("TextLabel",{Parent=card,Position=UDim2.new(0,6,0,0),Size=UDim2.new(1,-12,1,0),BackgroundTransparency=1,Text=string.format("#%d  %s  →  %d  (%s)",i,p.nome,p.valor,p.rar),Font=Enum.Font.Gotham,TextSize=10,TextColor3=p.cor,TextXAlignment=Enum.TextXAlignment.Left})
end
bt(t,"🤑 Oportunidade","Scan",C.grn,function()
local melhor=ord[1]
nt("Oportunidade","Melhor valor: "..melhor.nome.." ("..melhor.valor..")",C.grn) end)
end)

-- ===== ABA LIVE ALERTS =====
mTab("alerts","🔔 Live Alerts",function(t)
lb(t,"Alertas em tempo real")
tg(t,"Alertas de ovos raros","Avisa quando aparecer ovo Raro+.",function(v)
St.alertsOn=v
if v then task.spawn(function()
local vistos={}
while St.alertsOn do
task.wait(5)
for _,o in ipairs(scan()) do
local n=o.nome:lower()
if not vistos[o.nome] and (n:find("secret") or n:find("myth") or n:find("legend") or n:find("rare")) then
vistos[o.nome]=true
nt("🎉 Ovo raro!",o.nome,C.yel) end end end end) end end)
tg(t,"Alertas de jogador","Avisa quando entra jogador novo.",function(v)
if v then P.PlayerAdded:Connect(function(pl) nt("👤 Jogador",pl.Name.." entrou",C.pur) end) end end)
bt(t,"Testar alerta","Testar",C.pur,function() nt("Teste","Alerta funcionou!",C.grn) end)
end)

-- ===== ABA STATS & DIAGNÓSTICO =====
mTab("stats","📊 Stats",function(t)
local info=lb(t,"")
local function upd()
local up=tick()-Stats.inicio
info.Text=string.format("Uptime: %dm%ds | Scans: %d | Erros: %d",math.floor(up/60),math.floor(up%60),Stats.scans,Stats.erros) end
upd()
bt(t,"Exportar estatísticas","Exportar",C.pur,function()
local dados={uptime=math.floor(tick()-Stats.inicio),scans=Stats.scans,erros=Stats.erros,modo=Stats.modo,versao="1.2"}
local json=HS:JSONEncode(dados)
if setclipboard then setclipboard(json) end
nt("Exportar","Estatísticas copiadas!",C.grn) end)
bt(t,"Diagnóstico de erros","Rodar",C.yel,function()
local prob={}
if not rt() then table.insert(prob,"Sem personagem") end
if Stats.scans==0 then table.insert(prob,"Nenhum scan feito") end
if not gui or not gui.Parent then table.insert(prob,"GUI desapareceu") end
if #prob==0 then nt("Diagnóstico","Tudo OK! ✓",C.grn)
else nt("Diagnóstico",table.concat(prob,"\n"),C.yel) end end)
bt(t,"Atualizar info","Refresh",C.pur,upd)
lb(t,"Performance:",C.pur)
lb(t,"FPS: "..math.floor(1/RS.RenderStepped:Wait()))
lb(t,"Ping: "..math.floor(LP:GetNetworkPing()*1000).."ms")
end)

-- ===== ABA MÓDULOS =====
mTab("mods","⚙ Módulos",function(t)
lb(t,"Estado dos módulos:")
for id,on in pairs(Stats.modulos) do
local status=on and "✓ ATIVO" or "✗ FALHA"
local cor=on and C.grn or C.red
lb(t,id..": "..status,cor) end
end)

-- ===== ABA MODO DEMO =====
mTab("demo","🎮 Demo Mode",function(t)
lb(t,"Estado: "..Stats.modo)
tg(t,"Modo demonstração","Usa dados fictícios (pets/valores).",function(v)
Stats.modo=v and "DEMO" or "REAL"
nt("Modo",Stats.modo,C.pur) end)
lb(t,"No modo REAL precisas de:")
lb(t,"1. Preencher DB.eggs e DB.pets")
lb(t,"2. Obter os RemoteEvents do jogo")
lb(t,"3. Adaptar a função scan()")
end)

-- ===== ABA SERVER =====
mTab("srv","🌐 Server",function(t)
lb(t,"Job ID: "..string.sub(game.JobId,1,12).."...")
lb(t,"Jogadores: "..#P:GetPlayers().."/"..P.MaxPlayers)
bt(t,"Copiar Job ID","Copiar",C.pur,function() if setclipboard then setclipboard(game.JobId) end nt("Server","Copiado!",C.pur) end)
bt(t,"Rejoin","Rejoin",C.red,function() pcall(function() game:GetService("TeleportService"):Teleport(game.PlaceId,LP) end) end)
end)

-- ===== DRAG =====
local function drag(h,tg,cl)
local drag,startP,moved,startT=false,nil,false,0
h.InputBegan:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
drag=true; moved=false; startT=tick(); startP=i.Position end end)
h.InputEnded:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
if drag and not moved and (tick()-startT)<0.3 and cl then cl() end
drag=false end end)
UIS.InputChanged:Connect(function(i)
if not drag then return end
if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then
local d=i.Position-startP
if math.abs(d.X)>5 or math.abs(d.Y)>5 then moved=true end
tg.Position=UDim2.new(tg.Position.X.Scale,tg.Position.X.Offset+d.X,tg.Position.Y.Scale,tg.Position.Y.Offset+d.Y)
startP=i.Position end end) end

drag(hd,pan)
drag(fb,fb,function() pan.Visible=not pan.Visible end)

sTab("home")
nt("DOCHILLI HUB v1.2","Carregado! Clica na bolinha 🥚",C.grn)
print("[DOCHILLI HUB] v1.2 carregado.")
