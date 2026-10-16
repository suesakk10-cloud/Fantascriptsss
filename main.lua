-- CHILLI HUB v3.0 — Steal An Egg PT
local P=game:GetService("Players")local UIS=game:GetService("UserInputService")
local RS=game:GetService("RunService")local LG=game:GetService("Lighting")
local HS=game:GetService("HttpService")local TS=game:GetService("TeleportService")
local LP=P.LocalPlayer local PG=LP:WaitForChild("PlayerGui")
local old=PG:FindFirstChild("ChilliHub")if old then old:Destroy()end

-- ÍNDICE PT
local IDX={
{n="Frango",r="Comum",v=1,b="Floresta"},{n="Cachorro",r="Comum",v=2,b="Floresta"},{n="Pássaro",r="Incomum",v=8,b="Floresta"},{n="Coruja",r="Raro",v=35,b="Floresta"},{n="Guaxinim",r="Raro",v=45,b="Floresta"},{n="Urso",r="Épico",v=240,b="Floresta"},{n="Raposa",r="Épico",v=180,b="Floresta"},{n="Brr Brr Patapim",r="Lendário",v=1800,b="Floresta"},
{n="Sapo",r="Comum",v=3,b="Lago"},{n="Patinho",r="Comum",v=4,b="Lago"},{n="Peixe-gato",r="Incomum",v=12,b="Lago"},{n="Tartaruga",r="Raro",v=60,b="Lago"},{n="Trulimero",r="Épico",v=260,b="Lago"},{n="Cisne",r="Épico",v=320,b="Lago"},{n="Axoloti",r="Lendário",v=2800,b="Lago"},{n="Leviatã",r="Cósmico",v=220000,b="Lago"},
{n="Jerboa",r="Comum",v=6,b="Deserto"},{n="Fennec",r="Incomum",v=18,b="Deserto"},{n="Camelo",r="Raro",v=75,b="Deserto"},{n="Tob Tobi",r="Épico",v=325,b="Deserto"},{n="Cobra",r="Lendário",v=3600,b="Deserto"},{n="Escorpião",r="Mítico",v=18500,b="Deserto"},{n="Aranha da Areia",r="Mítico",v=16000,b="Deserto"},{n="Esfinge Real",r="Cósmico",v=280000,b="Deserto"},
{n="Tucano",r="Raro",v=110,b="Selva"},{n="Chimpanzé",r="Raro",v=90,b="Selva"},{n="Crocodilo",r="Épico",v=420,b="Selva"},{n="Gorila",r="Lendário",v=4800,b="Selva"},{n="Orangutini",r="Lendário",v=5500,b="Selva"},{n="Aranha",r="Mítico",v=22000,b="Selva"},{n="Tigre",r="Mítico",v=28000,b="Selva"},{n="Cobra Rei",r="Secreto",v=3500000,b="Selva"},
{n="Pinguim",r="Raro",v=130,b="Neve"},{n="Morsa",r="Épico",v=460,b="Neve"},{n="Urso Polar",r="Lendário",v=6500,b="Neve"},{n="Tigre Dentes",r="Mítico",v=30000,b="Neve"},{n="Mamute",r="Mítico",v=35000,b="Neve"},{n="Rei Mamute",r="Cósmico",v=360000,b="Neve"},{n="Iéti",r="Secreto",v=5000000,b="Neve"},{n="Dragão de Gelo",r="Eterno",v=65000000,b="Neve"},
{n="Lagarto de Lava",r="Raro",v=180,b="Vulcão"},{n="Sapo de Lava",r="Épico",v=540,b="Vulcão"},{n="Touro em Chamas",r="Lendário",v=7500,b="Vulcão"},{n="Iguana de Lava",r="Lendário",v=8200,b="Vulcão"},{n="Chili Maluco",r="Mítico",v=45000,b="Vulcão"},{n="Cérbero",r="Secreto",v=8000000,b="Vulcão"},{n="Fênix",r="Eterno",v=85000000,b="Vulcão"},{n="Dragão de Lava",r="Eterno",v=100000000,b="Vulcão"},
{n="Peixe-papagaio",r="Raro",v=220,b="Abismo"},{n="Peixe-espada",r="Épico",v=620,b="Abismo"},{n="Tubarão",r="Lendário",v=9000,b="Abismo"},{n="Orca",r="Mítico",v=52000,b="Abismo"},{n="Tubarão Baleia",r="Cósmico",v=380000,b="Abismo"},{n="Baleia Beluga",r="Cósmico",v=420000,b="Abismo"},{n="Kraken",r="Secreto",v=15000000,b="Abismo"},{n="El Maja",r="Eterno",v=130000000,b="Abismo"},
{n="Dodô",r="Raro",v=260,b="Pré-Histórico"},{n="Pterodátilo",r="Épico",v=780,b="Pré-Histórico"},{n="Anquilossauro",r="Lendário",v=11000,b="Pré-Histórico"},{n="Triceratops",r="Lendário",v=13000,b="Pré-Histórico"},{n="Bronto",r="Mítico",v=58000,b="Pré-Histórico"},{n="Tralaledon",r="Secreto",v=32000000,b="Pré-Histórico"},{n="T-Rex",r="Secreto",v=100000000,b="Pré-Histórico"},{n="Mosassauro",r="Eterno",v=180000000,b="Pré-Histórico"},
{n="Centapede",r="Épico",v=950,b="Cósmico"},{n="Lagarto Cósmico",r="Lendário",v=15000,b="Cósmico"},{n="Gorila Cósmico",r="Lendário",v=18000,b="Cósmico"},{n="La Vacca",r="Cósmico",v=2200000,b="Cósmico"},{n="Dragão Cósmico",r="Secreto",v=60000000,b="Cósmico"},{n="Esqueleto Cósmico",r="Secreto",v=45000000,b="Cósmico"},{n="Lunar Eterno",r="Eterno",v=250000000,b="Cósmico"},{n="Unicórnio",r="Divino",v=1000000000,b="Cósmico"},
{n="Garça",r="Raro",v=320,b="Cerejeira"},{n="Salamandra",r="Épico",v=1100,b="Cerejeira"},{n="Panda Vermelho",r="Mítico",v=68000,b="Cerejeira"},{n="Koi",r="Cósmico",v=12000000,b="Cerejeira"},{n="Coruja da Neve",r="Cósmico",v=7500000,b="Cerejeira"},{n="Veado",r="Secreto",v=145000000,b="Cerejeira"},{n="Tigre Oni",r="Eterno",v=600000000,b="Cerejeira"},{n="Kitsune",r="Divino",v=3200000000,b="Cerejeira"},
{n="Crustáceo",r="Épico",v=1400,b="Titã"},{n="Aracnídeo",r="Lendário",v=22000,b="Titã"},{n="Lâmina Oculta",r="Lendário",v=26000,b="Titã"},{n="Mantaris",r="Cósmico",v=11000000,b="Titã"},{n="Rinotauro",r="Cósmico",v=17500000,b="Titã"},{n="Tubarão Mutante",r="Eterno",v=204000000,b="Titã"},{n="Rei Gorila",r="Eterno",v=880000000,b="Titã"},{n="Chama Noturna",r="Divino",v=3000000000,b="Titã"},
{n="Pomba Radiante",r="Lendário",v=25000,b="Anjos/Demônios"},{n="Cordeiro Alado",r="Mítico",v=85000,b="Anjos/Demônios"},{n="Mariposa Sagrada",r="Cósmico",v=25000000,b="Anjos/Demônios"},{n="Pavão Sagrado",r="Cósmico",v=32000000,b="Anjos/Demônios"},{n="Água-viva Pura",r="Secreto",v=243500000,b="Anjos/Demônios"},{n="Centauro",r="Secreto",v=180000000,b="Anjos/Demônios"},{n="Pégaso",r="Eterno",v=850000000,b="Anjos/Demônios"},{n="Arcanjo",r="Divino",v=6500000000,b="Anjos/Demônios"},
{n="Diabrete",r="Lendário",v=28000,b="Anjos/Demônios"},{n="Touro",r="Mítico",v=92000,b="Anjos/Demônios"},{n="Diabinho",r="Cósmico",v=22000000,b="Anjos/Demônios"},{n="Cão Infernal",r="Cósmico",v=35000000,b="Anjos/Demônios"},{n="Gárgula",r="Secreto",v=210000000,b="Anjos/Demônios"},{n="Presa Afiada",r="Secreto",v=250000000,b="Anjos/Demônios"},{n="Corcel Esqueleto",r="Eterno",v=800000000,b="Anjos/Demônios"},{n="Queimador de Mundos",r="Divino",v=6200000000,b="Anjos/Demônios"},
{n="Lagarto Prisma",r="Raro",v=450,b="Encantada"},{n="Besouro Pétala",r="Épico",v=1800,b="Encantada"},{n="Gaio Encantado",r="Lendário",v=28000,b="Encantada"},{n="Coelho Astral",r="Lendário",v=32000,b="Encantada"},{n="Panda Espírito",r="Mítico",v=95000,b="Encantada"},{n="Raposa Estelar",r="Cósmico",v=18000000,b="Encantada"},{n="Leão Solar",r="Secreto",v=200000000,b="Encantada"},{n="Baleia Celestial",r="Eterno",v=1200000000,b="Encantada"}}

local Fav={}local Config={cor="Vermelho"}
local cores={Vermelho=Color3.fromRGB(200,30,40),Roxo=Color3.fromRGB(140,80,220),Azul=Color3.fromRGB(80,140,240),Verde=Color3.fromRGB(60,180,90)}
local function corRar(r)local t={Comum=Color3.fromRGB(180,180,180),Incomum=Color3.fromRGB(80,200,120),Raro=Color3.fromRGB(80,140,255),["Épico"]=Color3.fromRGB(160,80,220),["Lendário"]=Color3.fromRGB(255,180,60),["Mítico"]=Color3.fromRGB(255,80,80),["Cósmico"]=Color3.fromRGB(70,200,220),Secreto=Color3.fromRGB(255,50,180),Eterno=Color3.fromRGB(240,220,60),Divino=Color3.fromRGB(255,255,255)}return t[r]or Color3.fromRGB(140,140,150)end
local function fmt(v)if v>=1e9 then return string.format("%.2fB",v/1e9)elseif v>=1e6 then return string.format("%.2fM",v/1e6)elseif v>=1e3 then return string.format("%.1fK",v/1e3)end return tostring(v)end
local function N(c,p)local i=Instance.new(c)if p then local x=p.Parent;p.Parent=nil;for k,v in pairs(p)do i[k]=v end;i.Parent=x end return i end
local function cr(p,r)N("UICorner",{Parent=p,CornerRadius=UDim.new(0,r or 8)})end
local function st(p,c)N("UIStroke",{Parent=p,Color=c or Color3.fromRGB(55,55,62),Thickness=1})end
local function rt()local c=LP.Character return c and c:FindFirstChild("HumanoidRootPart")end
local function hm()local c=LP.Character return c and c:FindFirstChildOfClass("Humanoid")end
local C={bg=Color3.fromRGB(15,15,18),card=Color3.fromRGB(32,32,38),bd=Color3.fromRGB(55,55,62),grn=Color3.fromRGB(60,180,90),yel=Color3.fromRGB(240,180,50),blu=Color3.fromRGB(80,140,240),txt=Color3.fromRGB(240,240,245),txt2=Color3.fromRGB(150,150,160)}
local St={speed=16,jump=100,fly=false,noclip=false,infJump=false,antiRag=false,antiVoid=false,espP=false,espE=false,espPet=false,autoSteal=false,autoHatch=false,autoSell=false,autoTreadmill=false,antiCapture=false}
local function aplicar()local h=hm()if h then h.WalkSpeed=St.speed h.JumpPower=St.jump h.UseJumpPower=true end end
LP.CharacterAdded:Connect(function()task.wait(1)aplicar()end)

-- DETEÇÃO COM PATHS REAIS
local function pegarOvos()
local l={}local ovos=workspace:FindFirstChild("Ovos")
if not ovos then return l end
local chest=ovos:FindFirstChild("Chest")
if not chest then return l end
for _,o in ipairs(chest:GetChildren())do
if o:IsA("BasePart")then table.insert(l,o)end
end
return l end

local function getBioma(x,y,z)
local slots=workspace:FindFirstChild("AreaEggSlotsClient")
if not slots then return "?" end
local best,bd=nil,math.huge
for _,s in ipairs(slots:GetChildren())do
local p=s:IsA("Model")and s:FindFirstChild("Hitbox")or nil
if p then
local d=(p.Position-Vector3.new(x,y,z)).Magnitude
if d<bd then bd=d;best=s.Name end end end
if best then
for _,bio in ipairs({"Forest","Lake","Desert","Jungle","Snow","Volcano","Abyss","Prehistoric","Cosmic","Cherry","Titan","Light","Enchanted"})do
if best:find(bio)then return bio end end end
return "?" end

local function pegarPets()
local l={}local p=workspace:FindFirstChild("ClientMountedPets")
if p then for _,o in ipairs(p:GetChildren())do table.insert(l,o)end end
return l end

-- ESP
local espF
local function limparESP()if espF then espF:Destroy()espF=nil end end
local function atualizarESP()
limparESP()
if not(St.espP or St.espE or St.espPet)then return end
espF=N("Folder",{Parent=PG,Name="ChilliESP"})
task.spawn(function()while espF and espF.Parent do
if St.espP then for _,pl in ipairs(P:GetPlayers())do
if pl~=LP and pl.Character then
local hd=pl.Character:FindFirstChild("Head")
if hd and not espF:FindFirstChild("P"..pl.Name)then
local b=N("BillboardGui",{Parent=espF,Name="P"..pl.Name,Adornee=hd,Size=UDim2.new(0,140,0,20),AlwaysOnTop=true,StudsOffset=Vector3.new(0,2.5,0)})
cr(b,6)
N("TextLabel",{Parent=b,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="👤 "..pl.Name,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=cores[Config.cor],TextStrokeTransparency=0})
end end end end
if St.espE then
local ovos=pegarOvos()
for i,o in ipairs(ovos)do
local key="E"..i
if not espF:FindFirstChild(key)then
local bio=getBioma(o.Position.X,o.Position.Y,o.Position.Z)
local b=N("BillboardGui",{Parent=espF,Name=key,Adornee=o,Size=UDim2.new(0,150,0,22),AlwaysOnTop=true,StudsOffset=Vector3.new(0,3,0)})
cr(b,6)
N("TextLabel",{Parent=b,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="🥚 "..bio,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.yel,TextStrokeTransparency=0})
end end end
if St.espPet then
local pets=pegarPets()
for i,p in ipairs(pets)do
local key="PT"..i
local bp=p:IsA("BasePart")and p or p:FindFirstChildWhichIsA("BasePart")
if bp and not espF:FindFirstChild(key)then
local b=N("BillboardGui",{Parent=espF,Name=key,Adornee=bp,Size=UDim2.new(0,140,0,22),AlwaysOnTop=true,StudsOffset=Vector3.new(0,2,0)})
cr(b,6)
N("TextLabel",{Parent=b,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="🐾 "..p.Name,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.grn,TextStrokeTransparency=0})
end end end
task.wait(2)
end end)end

-- LOOPS
RS.Stepped:Connect(function()
if St.noclip then local c=LP.Character if c then for _,p in ipairs(c:GetDescendants())do if p:IsA("BasePart")then p.CanCollide=false end end end end
if St.antiRag then local h=hm()if h then h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false);h:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)end end
end)
RS.Heartbeat:Connect(function()
if St.antiVoid then local r=rt()if r and r.Position.Y<-80 then r.CFrame=CFrame.new(0,50,0)end end
-- ANTI-CAPTURA V2: foge se alguém estiver a <15 studs
if St.antiCapture then
local r=rt()
if r then
for _,pl in ipairs(P:GetPlayers())do
if pl~=LP and pl.Character then
local pr=pl.Character:FindFirstChild("HumanoidRootPart")
if pr and (pr.Position-r.Position).Magnitude<15 then
local back=r.CFrame.LookVector*-50
r.CFrame=r.CFrame+Vector3.new(back.X,10,back.Z)
break end end end end end
end)
UIS.JumpRequest:Connect(function()if St.infJump then local h=hm()if h then h:ChangeState(Enum.HumanoidStateType.Jumping)end end end)

-- FLY
local bv,bg
local function ligarVoo()local r=rt()if not r then return end bv=N("BodyVelocity",{Parent=r,MaxForce=Vector3.new(1e5,1e5,1e5),Velocity=Vector3.new(0,0,0)});bg=N("BodyGyro",{Parent=r,MaxTorque=Vector3.new(1e5,1e5,1e5),P=1000,D=100,CFrame=r.CFrame})end
local function pararVoo()if bv then bv:Destroy()bv=nil end;if bg then bg:Destroy()bg=nil end end
RS.RenderStepped:Connect(function()if not St.fly or not bv then return end
local r=rt()if not r then return end
local cam=workspace.CurrentCamera;local m=Vector3.new(0,0,0)
if UIS:IsKeyDown(Enum.KeyCode.W)then m=m+cam.CFrame.LookVector end
if UIS:IsKeyDown(Enum.KeyCode.S)then m=m-cam.CFrame.LookVector end
if UIS:IsKeyDown(Enum.KeyCode.A)then m=m-cam.CFrame.RightVector end
if UIS:IsKeyDown(Enum.KeyCode.D)then m=m+cam.CFrame.RightVector end
if UIS:IsKeyDown(Enum.KeyCode.Space)then m=m+Vector3.new(0,1,0)end
bv.Velocity=m*50;bg.CFrame=cam.CFrame end)

-- AUTO STEAL V2 (teleporta, pega, volta à base)
local basePos=nil
task.spawn(function()
while task.wait(0.5)do
if St.autoSteal then
local r=rt()
if r then
basePos=basePos or r.Position
local ovos=pegarOvos()
if #ovos>0 then
local best,bd=nil,1e9
for _,o in ipairs(ovos)do
local d=(o.Position-r.Position).Magnitude
if d<bd then bd=d;best=o end end
if best then
r.CFrame=CFrame.new(best.Position+Vector3.new(0,3,0))
task.wait(0.15)
local pr=best:FindFirstChildOfClass("ProximityPrompt")or best:FindFirstChildWhichIsA("ProximityPrompt",true)
if pr then pcall(function()pr:InputHoldBegin()end);task.wait(0.25);pcall(function()pr:InputHoldEnd()end)end
task.wait(0.1)
r.CFrame=CFrame.new(basePos+Vector3.new(0,3,0))
end end end end end end)

-- AUTO PROMPTS
task.spawn(function()while task.wait(1)do
if St.autoHatch or St.autoSell then
local r=rt()
if r then
for _,o in ipairs(workspace:GetDescendants())do
if o:IsA("ProximityPrompt")then
local at=o.ActionText:lower()
local ok=false
if St.autoHatch and(at:find("hatch")or at:find("chocar"))then ok=true end
if St.autoSell and(at:find("sell")or at:find("vender"))then ok=true end
if ok and o.Parent and o.Parent:IsA("BasePart")and(o.Parent.Position-r.Position).Magnitude<25 then
pcall(function()o:InputHoldBegin()end);task.wait(0.15);pcall(function()o:InputHoldEnd()end)end end end end end end end)

-- NOTIFICAÇÕES
local NH=N("Frame",{Parent=PG,AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-16,0,16),Size=UDim2.new(0,260,0,400),BackgroundTransparency=1,ZIndex=9999})
N("UIListLayout",{Parent=NH,Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder,VerticalAlignment=Enum.VerticalAlignment.Top,HorizontalAlignment=Enum.HorizontalAlignment.Right})
local function aviso(t,m,c)c=c or cores[Config.cor]
local b=N("Frame",{Parent=NH,Size=UDim2.new(1,0,0,46),BackgroundColor3=C.card,BorderSizePixel=0,ZIndex=9999})
cr(b,8);st(b,c)
N("TextLabel",{Parent=b,Position=UDim2.new(0,8,0,4),Size=UDim2.new(1,-16,0,16),BackgroundTransparency=1,Text=t,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=c,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=9999})
N("TextLabel",{Parent=b,Position=UDim2.new(0,8,0,22),Size=UDim2.new(1,-16,0,20),BackgroundTransparency=1,Text=m,Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true,ZIndex=9999})
task.delay(4,function()if b.Parent then b:Destroy()end end)end

-- GUI
local gui=N("ScreenGui",{Name="ChilliHub",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,Parent=PG,DisplayOrder=999})
local fb=N("TextButton",{Parent=gui,Position=UDim2.new(0,20,0,20),Size=UDim2.new(0,52,0,52),BackgroundColor3=C.card,Text="",AutoButtonColor=false,ZIndex=9999})cr(fb,26);st(fb,cores[Config.cor],2)
N("TextLabel",{Parent=fb,Position=UDim2.new(0.5,-16,0.5,-16),Size=UDim2.new(0,32,0,32),BackgroundTransparency=1,Text="🔥",Font=Enum.Font.GothamBlack,TextSize=22,ZIndex=10000})
local pan=N("Frame",{Parent=gui,AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0.5,0,0.5,0),Size=UDim2.new(0,600,0,420),BackgroundColor3=C.bg,BorderSizePixel=0,ClipsDescendants=true,ZIndex=1000,Visible=true})
cr(pan,14);st(pan,cores[Config.cor],2)
local hd=N("Frame",{Parent=pan,Size=UDim2.new(1,0,0,38),BackgroundColor3=cores[Config.cor],BorderSizePixel=0})cr(hd,14)
N("TextLabel",{Parent=hd,Position=UDim2.new(0,14,0,0),Size=UDim2.new(1,-100,1,0),BackgroundTransparency=1,Text="🔥 CHILLI HUB v3.0",Font=Enum.Font.GothamBlack,TextSize=14,TextColor3=Color3.fromRGB(255,255,255),TextXAlignment=Enum.TextXAlignment.Left})
local xb=N("TextButton",{Parent=hd,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-10,0.5,0),Size=UDim2.new(0,26,0,26),BackgroundColor3=Color3.fromRGB(0,0,0),BackgroundTransparency=0.4,Text="X",Font=Enum.Font.GothamBlack,TextSize=13,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})cr(xb,6)
xb.MouseButton1Click:Connect(function()pan.Visible=false end)
local lM=N("ScrollingFrame",{Parent=pan,Position=UDim2.new(0,8,0,46),Size=UDim2.new(0,110,1,-56),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=cores[Config.cor],CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})
N("UIListLayout",{Parent=lM,Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder})
local rM=N("ScrollingFrame",{Parent=pan,AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-8,0,46),Size=UDim2.new(0,110,1,-56),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=cores[Config.cor],CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})
N("UIListLayout",{Parent=rM,Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder})
local ce=N("Frame",{Parent=pan,Position=UDim2.new(0,124,0,46),Size=UDim2.new(1,-248,1,-88),BackgroundColor3=C.card,BorderSizePixel=0})cr(ce,10);st(ce,C.bd)
local abas,tb,atual={},{},nil
local function trocarAba(id)if atual and abas[atual]then abas[atual].Visible=false;tb[atual].BackgroundColor3=C.card;tb[atual].TextColor3=C.txt end
atual=id
if abas[id]then abas[id].Visible=true;tb[id].BackgroundColor3=cores[Config.cor];tb[id].TextColor3=Color3.fromRGB(255,255,255)end end
local function criarAba(nome,id,lado)local m=lado=="L"and lM or rM
local b=N("TextButton",{Parent=m,Size=UDim2.new(1,0,0,30),BackgroundColor3=C.card,Text=nome,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.txt,AutoButtonColor=false})
cr(b,8);st(b,C.bd)
b.MouseButton1Click:Connect(function()trocarAba(id)end)
tb[id]=b
local f=N("ScrollingFrame",{Parent=ce,Size=UDim2.new(1,-12,1,-12),Position=UDim2.new(0,6,0,6),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=cores[Config.cor],CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,Visible=false})
N("UIListLayout",{Parent=f,Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder})
abas[id]=f return f end
local function linha(p,h)local c=N("Frame",{Parent=p,Size=UDim2.new(1,0,0,h or 36),BackgroundColor3=C.card,BorderSizePixel=0})cr(c,8);st(c,C.bd)return c end
local function secao(p,t)local c=N("Frame",{Parent=p,Size=UDim2.new(1,0,0,24),BackgroundColor3=C.bg,BorderSizePixel=0})cr(c,8)
N("TextLabel",{Parent=c,Position=UDim2.new(0,8,0,0),Size=UDim2.new(1,-16,1,0),BackgroundTransparency=1,Text="▼ "..t,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=cores[Config.cor],TextXAlignment=Enum.TextXAlignment.Left})end
local function toggle(p,nome,desc,fn)local c=linha(p,42)
N("TextLabel",{Parent=c,Position=UDim2.new(0,10,0,4),Size=UDim2.new(1,-60,0,14),BackgroundTransparency=1,Text=nome,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})
if desc then N("TextLabel",{Parent=c,Position=UDim2.new(0,10,0,20),Size=UDim2.new(1,-60,0,16),BackgroundTransparency=1,Text=desc,Font=Enum.Font.Gotham,TextSize=8,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true})end
local s=false
local sw=N("TextButton",{Parent=c,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-10,0.5,0),Size=UDim2.new(0,38,0,20),BackgroundColor3=Color3.fromRGB(60,60,68),Text="",AutoButtonColor=false})
cr(sw,10)
local kn=N("Frame",{Parent=sw,Position=UDim2.new(0,2,0,2),Size=UDim2.new(0,16,0,16),BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0})
cr(kn,8)
sw.MouseButton1Click:Connect(function()s=not s
kn.Position=s and UDim2.new(1,-18,0,2)or UDim2.new(0,2,0,2)
sw.BackgroundColor3=s and C.grn or Color3.fromRGB(60,60,68)
if fn then pcall(fn,s)end end)end
local function num(p,nome,valor,fn)local c=linha(p,36)
N("TextLabel",{Parent=c,Position=UDim2.new(0,10,0,0),Size=UDim2.new(1,-110,1,0),BackgroundTransparency=1,Text=nome,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})
local b=N("TextBox",{Parent=c,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-10,0.5,0),Size=UDim2.new(0,90,0,24),BackgroundColor3=Color3.fromRGB(10,10,12),BorderSizePixel=0,Text=tostring(valor),Font=Enum.Font.GothamBold,TextSize=11,TextColor3=Color3.fromRGB(255,255,255),TextXAlignment=Enum.TextXAlignment.Center,ClearTextOnFocus=false})
cr(b,6);st(b,C.bd)
b.FocusLost:Connect(function()local n=tonumber(b.Text)if n and fn then pcall(fn,n)end end)end
local function btn(p,nome,texto,cor,fn)local f=linha(p,36)
N("TextLabel",{Parent=f,Position=UDim2.new(0,10,0,0),Size=UDim2.new(1,-110,1,0),BackgroundTransparency=1,Text=nome,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})
local b=N("TextButton",{Parent=f,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-10,0.5,0),Size=UDim2.new(0,90,0,24),BackgroundColor3=cor or cores[Config.cor],Text=texto,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})
cr(b,6)
b.MouseButton1Click:Connect(function()local ok,e=pcall(fn)if not ok then aviso("Erro",tostring(e),cores[Config.cor])end end)end
local function info(p,t)local c=linha(p,24)
N("TextLabel",{Parent=c,Position=UDim2.new(0,10,0,0),Size=UDim2.new(1,-16,1,0),BackgroundTransparency=1,Text=t,Font=Enum.Font.Gotham,TextSize=10,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd})end

-- ABAS
local t=criarAba("🏠 Início","home","L")
info(t,"CHILLI HUB v3.0")
info(t,"Steal An Egg — Português")
info(t,"Right Shift abre/fecha")

t=criarAba("👤 Player","plr","L")
secao(t,"Movimento")
num(t,"Velocidade (0-1000)",16,function(n)if n<0 then
