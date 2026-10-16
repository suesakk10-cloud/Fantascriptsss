-- FANTASCRIPT v1.0
local P=game:GetService("Players")local UIS=game:GetService("UserInputService")
local RS=game:GetService("RunService")local LG=game:GetService("Lighting")
local HS=game:GetService("HttpService")local TS=game:GetService("TeleportService")
local LP=P.LocalPlayer local PG=LP:WaitForChild("PlayerGui")
local old=PG:FindFirstChild("FantaScript")if old then old:Destroy()end

local IDX={
{n="Frango",r="Comum",v=1,b="Floresta"},{n="Cachorro",r="Comum",v=2,b="Floresta"},{n="Pássaro",r="Incomum",v=8,b="Floresta"},{n="Coruja",r="Raro",v=35,b="Floresta"},{n="Guaxinim",r="Raro",v=45,b="Floresta"},{n="Raposa",r="Épico",v=180,b="Floresta"},{n="Urso",r="Épico",v=240,b="Floresta"},{n="Brr Brr Patapim",r="Lendário",v=1800,b="Floresta"},
{n="Sapo",r="Comum",v=3,b="Lago"},{n="Patinho",r="Comum",v=4,b="Lago"},{n="Peixe-gato",r="Incomum",v=12,b="Lago"},{n="Tartaruga",r="Raro",v=60,b="Lago"},{n="Trulimero",r="Épico",v=260,b="Lago"},{n="Cisne",r="Épico",v=320,b="Lago"},{n="Axoloti",r="Lendário",v=2800,b="Lago"},{n="Leviatã",r="Cósmico",v=220000,b="Lago"},
{n="Jerboa",r="Comum",v=6,b="Deserto"},{n="Fennec",r="Incomum",v=18,b="Deserto"},{n="Camelo",r="Raro",v=75,b="Deserto"},{n="Cobra",r="Lendário",v=3600,b="Deserto"},{n="Escorpião",r="Mítico",v=18500,b="Deserto"},{n="Esfinge Real",r="Cósmico",v=280000,b="Deserto"},
{n="Tucano",r="Raro",v=110,b="Selva"},{n="Chimpanzé",r="Raro",v=90,b="Selva"},{n="Crocodilo",r="Épico",v=420,b="Selva"},{n="Gorila",r="Lendário",v=4800,b="Selva"},{n="Tigre",r="Mítico",v=28000,b="Selva"},{n="Cobra Rei",r="Secreto",v=3500000,b="Selva"},
{n="Pinguim",r="Raro",v=130,b="Neve"},{n="Morsa",r="Épico",v=460,b="Neve"},{n="Urso Polar",r="Lendário",v=6500,b="Neve"},{n="Mamute",r="Mítico",v=35000,b="Neve"},{n="Rei Mamute",r="Cósmico",v=360000,b="Neve"},{n="Iéti",r="Secreto",v=5000000,b="Neve"},{n="Dragão de Gelo",r="Eterno",v=65000000,b="Neve"},
{n="Sapo de Lava",r="Épico",v=540,b="Vulcão"},{n="Touro em Chamas",r="Lendário",v=7500,b="Vulcão"},{n="Chili Maluco",r="Mítico",v=45000,b="Vulcão"},{n="Cérbero",r="Secreto",v=8000000,b="Vulcão"},{n="Fênix",r="Eterno",v=85000000,b="Vulcão"},{n="Dragão de Lava",r="Eterno",v=100000000,b="Vulcão"},
{n="Tubarão",r="Lendário",v=9000,b="Abismo"},{n="Orca",r="Mítico",v=52000,b="Abismo"},{n="Kraken",r="Secreto",v=15000000,b="Abismo"},{n="El Maja",r="Eterno",v=130000000,b="Abismo"},
{n="Pterodátilo",r="Épico",v=780,b="Pré-Histórico"},{n="Triceratops",r="Lendário",v=13000,b="Pré-Histórico"},{n="T-Rex",r="Secreto",v=100000000,b="Pré-Histórico"},{n="Mosassauro",r="Eterno",v=180000000,b="Pré-Histórico"},
{n="Cosmic Dragon",r="Secreto",v=60000000,b="Cósmico"},{n="Unicórnio",r="Divino",v=1000000000,b="Cósmico"},{n="Kitsune",r="Divino",v=3200000000,b="Cerejeira"},{n="Nightflame",r="Divino",v=3000000000,b="Titã"},
{n="Arcanjo",r="Divino",v=6500000000,b="Anjos"},{n="Queimador",r="Divino",v=6200000000,b="Demônios"},{n="Leão Solar",r="Secreto",v=200000000,b="Encantada"},{n="Baleia Celestial",r="Eterno",v=1200000000,b="Encantada"}}

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
local St={speed=16,jump=100,fly=false,noclip=false,infJump=false,antiRag=false,espP=false,espE=false,espPet=false,autoSteal=false,antiCap=false}
local function aplicar()local h=hm()if h then h.WalkSpeed=St.speed h.JumpPower=St.jump h.UseJumpPower=true end end
LP.CharacterAdded:Connect(function()task.wait(1)aplicar()end)

local function pegarOvos()local l={}local o=workspace:FindFirstChild("Ovos")if not o then return l end local c=o:FindFirstChild("Chest")if not c then return l end for _,x in ipairs(c:GetChildren())do if x:IsA("BasePart")then table.insert(l,x)end end return l end
local function pegarPets()local l={}local p=workspace:FindFirstChild("ClientMountedPets")if p then for _,o in ipairs(p:GetChildren())do table.insert(l,o)end end return l end

local espF
local function limparESP()if espF then espF:Destroy()espF=nil end end
local function atualizarESP()limparESP()if not(St.espP or St.espE or St.espPet)then return end espF=N("Folder",{Parent=PG,Name="FantaESP"})
task.spawn(function()while espF and espF.Parent do
if St.espP then for _,pl in ipairs(P:GetPlayers())do if pl~=LP and pl.Character then local hd=pl.Character:FindFirstChild("Head")if hd and not espF:FindFirstChild("P"..pl.Name)then local b=N("BillboardGui",{Parent=espF,Name="P"..pl.Name,Adornee=hd,Size=UDim2.new(0,140,0,20),AlwaysOnTop=true,StudsOffset=Vector3.new(0,2.5,0)})cr(b,6)N("TextLabel",{Parent=b,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="👤 "..pl.Name,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=cores[Config.cor],TextStrokeTransparency=0})end end end end
if St.espE then local ovos=pegarOvos()for i,o in ipairs(ovos)do local key="E"..i if not espF:FindFirstChild(key)then local b=N("BillboardGui",{Parent=espF,Name=key,Adornee=o,Size=UDim2.new(0,140,0,20),AlwaysOnTop=true,StudsOffset=Vector3.new(0,3,0)})cr(b,6)N("TextLabel",{Parent=b,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="🥚 "..o.Name,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.yel,TextStrokeTransparency=0})end end end
if St.espPet then local pets=pegarPets()for i,p in ipairs(pets)do local key="PT"..i local bp=p:IsA("BasePart")and p or p:FindFirstChildWhichIsA("BasePart")if bp and not espF:FindFirstChild(key)then local b=N("BillboardGui",{Parent=espF,Name=key,Adornee=bp,Size=UDim2.new(0,140,0,20),AlwaysOnTop=true,StudsOffset=Vector3.new(0,2,0)})cr(b,6)N("TextLabel",{Parent=b,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="🐾 "..p.Name,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.grn,TextStrokeTransparency=0})end end end
task.wait(2)end end)end

RS.Stepped:Connect(function()
if St.noclip then local c=LP.Character if c then for _,p in ipairs(c:GetDescendants())do if p:IsA("BasePart")then p.CanCollide=false end end end end
if St.antiRag then local h=hm()if h then h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false);h:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)end end
end)
RS.Heartbeat:Connect(function()
if St.antiCap then local r=rt()if r then for _,pl in ipairs(P:GetPlayers())do if pl~=LP and pl.Character then local pr=pl.Character:FindFirstChild("HumanoidRootPart")if pr and (pr.Position-r.Position).Magnitude<15 then local bk=r.CFrame.LookVector*-60 r.CFrame=r.CFrame+Vector3.new(bk.X,10,bk.Z)break end end end end end
end)
UIS.JumpRequest:Connect(function()if St.infJump then local h=hm()if h then h:ChangeState(Enum.HumanoidStateType.Jumping)end end end)
local bv,bg
local function ligarVoo()local r=rt()if not r then return end bv=N("BodyVelocity",{Parent=r,MaxForce=Vector3.new(1e5,1e5,1e5),Velocity=Vector3.new(0,0,0)});bg=N("BodyGyro",{Parent=r,MaxTorque=Vector3.new(1e5,1e5,1e5),P=1000,D=100,CFrame=r.CFrame})end
local function pararVoo()if bv then bv:Destroy()bv=nil end;if bg then bg:Destroy()bg=nil end end
RS.RenderStepped:Connect(function()if not St.fly or not bv then return end local r=rt()if not r then return end local cam=workspace.CurrentCamera;local m=Vector3.new(0,0,0)if UIS:IsKeyDown(Enum.KeyCode.W)then m=m+cam.CFrame.LookVector end if UIS:IsKeyDown(Enum.KeyCode.S)then m=m-cam.CFrame.LookVector end if UIS:IsKeyDown(Enum.KeyCode.A)then m=m-cam.CFrame.RightVector end if UIS:IsKeyDown(Enum.KeyCode.D)then m=m+cam.CFrame.RightVector end if UIS:IsKeyDown(Enum.KeyCode.Space)then m=m+Vector3.new(0,1,0)end bv.Velocity=m*50;bg.CFrame=cam.CFrame end)
local basePos=nil
task.spawn(function()while task.wait(0.5)do if St.autoSteal then local r=rt()if r then basePos=basePos or r.Position local ovos=pegarOvos()if #ovos>0 then local best,bd=nil,1e9 for _,o in ipairs(ovos)do local d=(o.Position-r.Position).Magnitude if d<bd then bd=d;best=o end end if best then r.CFrame=CFrame.new(best.Position+Vector3.new(0,3,0))task.wait(0.15)local pr=best:FindFirstChildOfClass("ProximityPrompt")or best:FindFirstChildWhichIsA("ProximityPrompt",true)if pr then pcall(function()pr:InputHoldBegin()end);task.wait(0.25);pcall(function()pr:InputHoldEnd()end)end task.wait(0.1)r.CFrame=CFrame.new(basePos+Vector3.new(0,3,0))end end end end end end)

local NH=N("Frame",{Parent=PG,AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-16,0,16),Size=UDim2.new(0,260,0,400),BackgroundTransparency=1,ZIndex=9999})
N("UIListLayout",{Parent=NH,Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder,VerticalAlignment=Enum.VerticalAlignment.Top,HorizontalAlignment=Enum.HorizontalAlignment.Right})
local function aviso(t,m,c)c=c or cores[Config.cor]local b=N("Frame",{Parent=NH,Size=UDim2.new(1,0,0,46),BackgroundColor3=C.card,BorderSizePixel=0,ZIndex=9999})cr(b,8);st(b,c)N("TextLabel",{Parent=b,Position=UDim2.new(0,8,0,4),Size=UDim2.new(1,-16,0,16),BackgroundTransparency=1,Text=t,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=c,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=9999})N("TextLabel",{Parent=b,Position=UDim2.new(0,8,0,22),Size=UDim2.new(1,-16,0,20),BackgroundTransparency=1,Text=m,Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true,ZIndex=9999})task.delay(4,function()if b.Parent then b:Destroy()end end)end

local gui=N("ScreenGui",{Name="FantaScript",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,Parent=PG,DisplayOrder=999})
local fb=N("TextButton",{Parent=gui,Position=UDim2.new(0,20,0,20),Size=UDim2.new(0,54,0,54),BackgroundColor3=C.card,Text="",AutoButtonColor=false,ZIndex=9999,Active=true})cr(fb,27);st(fb,cores[Config.cor],2)
N("TextLabel",{Parent=fb,Position=UDim2.new(0.5,-16,0.5,-16),Size=UDim2.new(0,32,0,32),BackgroundTransparency=1,Text="🔥",Font=Enum.Font.GothamBlack,TextSize=24,ZIndex=10000})
local pan=N("Frame",{Parent=gui,AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0.5,0,0.5,0),Size=UDim2.new(0,600,0,420),BackgroundColor3=C.bg,BorderSizePixel=0,ClipsDescendants=true,ZIndex=1000,Visible=true})cr(pan,16);st(pan,cores[Config.cor],2)
local hd=N("Frame",{Parent=pan,Size=UDim2.new(1,0,0,40),BackgroundColor3=cores[Config.cor],BorderSizePixel=0})cr(hd,16)
N("TextLabel",{Parent=hd,Position=UDim2.new(0,14,0,0),Size=UDim2.new(1,-100,1,0),BackgroundTransparency=1,Text="🔥 FANTASCRIPT",Font=Enum.Font.GothamBlack,TextSize=15,TextColor3=Color3.fromRGB(255,255,255),TextXAlignment=Enum.TextXAlignment.Left})
local xb=N("TextButton",{Parent=hd,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-10,0.5,0),Size=UDim2.new(0,28,0,28),BackgroundColor3=Color3.fromRGB(0,0,0),BackgroundTransparency=0.4,Text="X",Font=Enum.Font.GothamBlack,TextSize=13,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})cr(xb,14)
xb.MouseButton1Click:Connect(function()pan.Visible=false end)
local lM=N("ScrollingFrame",{Parent=pan,Position=UDim2.new(0,8,0,50),Size=UDim2.new(0,110,1,-60),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=cores[Config.cor],CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})N("UIListLayout",{Parent=lM,Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder})
local ce=N("Frame",{Parent=pan,Position=UDim2.new(0,124,0,50),Size=UDim2.new(1,-132,1,-60),BackgroundColor3=C.card,BorderSizePixel=0})cr(ce,12);st(ce,C.bd)
local abas,tb,atual={},{},nil
local function trocarAba(id)if atual and abas[atual]then abas[atual].Visible=false;tb[atual].BackgroundColor3=C.card;tb[atual].TextColor3=C.txt end atual=id if abas[id]then abas[id].Visible=true;tb[id].BackgroundColor3=cores[Config.cor];tb[id].TextColor3=Color3.fromRGB(255,255,255)end end
local function criarAba(nome,id)local b=N("TextButton",{Parent=lM,Size=UDim2.new(1,0,0,32),BackgroundColor3=C.card,Text=nome,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.txt,AutoButtonColor=false})cr(b,10);st(b,C.bd)b.MouseButton1Click:Connect(function()trocarAba(id)end)tb[id]=b local f=N("ScrollingFrame",{Parent=ce,Size=UDim2.new(1,-12,1,-12),Position=UDim2.new(0,6,0,6),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=cores[Config.cor],CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,Visible=false})N("UIListLayout",{Parent=f,Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder})abas[id]=f return f end
local function linha(p,h)local c=N("Frame",{Parent=p,Size=UDim2.new(1,0,0,h or 36),BackgroundColor3=C.card,BorderSizePixel=0})cr(c,8);st(c,C.bd)return c end
local function secao(p,t)local c=N("Frame",{Parent=p,Size=UDim2.new(1,0,0,24),BackgroundColor3=C.bg,BorderSizePixel=0})cr(c,8)N("TextLabel",{Parent=c,Position=UDim2.new(0,8,0,0),Size=UDim2.new(1,-16,1,0),BackgroundTransparency=1,Text="▼ "..t,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=cores[Config.cor],TextXAlignment=Enum.TextXAlignment.Left})end
local function toggle(p,nome,desc,fn)local c=linha(p,42)N("TextLabel",{Parent=c,Position=UDim2.new(0,10,0,4),Size=UDim2.new(1,-60,0,14),BackgroundTransparency=1,Text=nome,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})if desc then N("TextLabel",{Parent=c,Position=UDim2.new(0,10,0,20),Size=UDim2.new(1,-60,0,16),BackgroundTransparency=1,Text=desc,Font=Enum.Font.Gotham,TextSize=8,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true})end local s=false local sw=N("TextButton",{Parent=c,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-10,0.5,0),Size=UDim2.new(0,38,0,20),BackgroundColor3=Color3.fromRGB(60,60,68),Text="",AutoButtonColor=false})cr(sw,10)local kn=N("Frame",{Parent=sw,Position=UDim2.new(0,2,0,2),Size=UDim2.new(0,16,0,16),BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0})cr(kn,8)sw.MouseButton1Click:Connect(function()s=not s kn.Position=s and UDim2.new(1,-18,0,2)or UDim2.new(0,2,0,2)sw.BackgroundColor3=s and C.grn or Color3.fromRGB(60,60,68)if fn then pcall(fn,s)end end)end
local function num(p,nome,valor,fn)local c=linha(p,36)N("TextLabel",{Parent=c,Position=UDim2.new(0,10,0,0),Size=UDim2.new(1,-110,1,0),BackgroundTransparency=1,Text=nome,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})local b=N("TextBox",{Parent=c,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-10,0.5,0),Size=UDim2.new(0,90,0,24),BackgroundColor3=Color3.fromRGB(10,10,12),BorderSizePixel=0,Text=tostring(valor),Font=Enum.Font.GothamBold,TextSize=11,TextColor3=Color3.fromRGB(255,255,255),TextXAlignment=Enum.TextXAlignment.Center,ClearTextOnFocus=false})cr(b,6);st(b,C.bd)b.FocusLost:Connect(function()local n=tonumber(b.Text)if n and fn then pcall(fn,n)end end)end
local function btn(p,nome,texto,cor,fn)local f=linha(p,36)N("TextLabel",{Parent=f,Position=UDim2.new(0,10,0,0),Size=UDim2.new(1,-110,1,0),BackgroundTransparency=1,Text=nome,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})local b=N("TextButton",{Parent=f,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-10,0.5,0),Size=UDim2.new(0,90,0,24),BackgroundColor3=cor or cores[Config.cor],Text=texto,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})cr(b,6)b.MouseButton1Click:Connect(function()local ok,e=pcall(fn)if not ok then aviso("Erro",tostring(e),cores[Config.cor])end end)end
local function info(p,t)local c=linha(p,24)N("TextLabel",{Parent=c,Position=UDim2.new(0,10,0,0),Size=UDim2.new(1,-16,1,0),BackgroundTransparency=1,Text=t,Font=Enum.Font.Gotham,TextSize=10,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd})end

local t=criarAba("🏠 Início","home")
info(t,"FANTASCRIPT v1.0")
info(t,"Steal An Egg — Português")
info(t,"Right Shift abre/fecha")

t=criarAba("👤 Player","plr")
secao(t,"Movimento")
num(t,"Velocidade (0-1000)",16,function(n)if n<0 then n=0 end if n>1000 then n=1000 end St.speed=n aplicar()aviso("Velocidade",n.." studs",C.grn)end)
num(t,"Força do Pulo",100,function(n)St.jump=n aplicar()end)
toggle(t,"Pulo Infinito","Pula no ar.",function(v)St.infJump=v end)
toggle(t,"Voo","WASD + Space.",function(v)St.fly=v if v then ligarVoo()else pararVoo()end end)
toggle(t,"Atravessar Paredes","Noclip.",function(v)St.noclip=v end)
secao(t,"Defesa")
toggle(t,"Anti Queda","Não cai.",function(v)St.antiRag=v end)
toggle(t,"Anti Captura V2","Foge se alguém se aproximar.",function(v)St.antiCap=v end)
btn(t,"Resetar Personagem","Resetar",cores[Config.cor],function()local c=LP.Character if c then c:BreakJoints()end end)

t=criarAba("👁 Visual","vis")
secao(t,"ESP")
toggle(t,"ESP Jogadores","Nomes.",function(v)St.espP=v atualizarESP()end)
toggle(t,"ESP Ovos","Marcadores 🥚.",function(v)St.espE=v atualizarESP()end)
toggle(t,"ESP Pets","Marcadores 🐾.",function(v)St.espPet=v atualizarESP()end)
btn(t,"Limpar ESP","Limpar",cores[Config.cor],function()St.espP=false St.espE=false St.espPet=false atualizarESP()end)
secao(t,"Iluminação")
btn(t,"Claridade Total","Ligar",C.yel,function()LG.Brightness=3 LG.ClockTime=14 LG.FogEnd=1e6 LG.GlobalShadows=false end)
btn(t,"Remover Névoa","Ligar",C.yel,function()LG.FogEnd=1e6 end)

t=criarAba("🌾 Farm","farm")
secao(t,"Auto Steal V2")
toggle(t,"Auto Steal","TP ao ovo + volta à base.",function(v)St.autoSteal=v end)
btn(t,"TP Ovo Próximo","TP",C.blu,function()local r=rt()if not r then return end local o=pegarOvos()if #o>0 then r.CFrame=CFrame.new(o[1].Position+Vector3.new(0,3,0))aviso("TP","Feito",C.blu)end end)

t=criarAba("🌐 Servidor","srv")
info(t,"Job ID: "..string.sub(game.JobId,1,10).."...")
info(t,"Jogadores: "..#P:GetPlayers().."/"..P.MaxPlayers)
btn(t,"Trocar Servidor","Hop",cores[Config.cor],function()local u="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=50"local ok,b=pcall(function()return HS:JSONDecode(game:HttpGet(u))end)if ok and b and b.data then for _,s in ipairs(b.data)do if s.playing<s.maxPlayers and s.id~=game.JobId then pcall(function()TS:TeleportToPlaceInstance(game.PlaceId,s.id,LP)end)return end end end aviso("Hop","Sem servidor",cores[Config.cor])end)
btn(t,"Reentrar","Rejoin",cores[Config.cor],function()pcall(function()TS:Teleport(game.PlaceId,LP)end)end)
btn(t,"Copiar Job ID","Copiar",C.yel,function()if setclipboard then setclipboard(game.JobId)end aviso("Servidor","Copiado!",C.grn)end)

local pan2=N("Frame",{Parent=gui,AnchorPoint=Vector2.new(0,1),Position=UDim2.new(0,20,1,-20),Size=UDim2.new(0,300,0,360),BackgroundColor3=C.bg,BorderSizePixel=0,ZIndex=1100})cr(pan2,16);st(pan2,cores[Config.cor],2)
local hd2=N("Frame",{Parent=pan2,Size=UDim2.new(1,0,0,34),BackgroundColor3=cores[Config.cor],BorderSizePixel=0})cr(hd2,16)
N("TextLabel",{Parent=hd2,Position=UDim2.new(0,12,0,0),Size=UDim2.new(1,-50,1,0),BackgroundTransparency=1,Text="🥚 PAINEL DE PETS",Font=Enum.Font.GothamBlack,TextSize=13,TextColor3=Color3.fromRGB(255,255,255),TextXAlignment=Enum.TextXAlignment.Left})
local xb2=N("TextButton",{Parent=hd2,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-8,0.5,0),Size=UDim2.new(0,22,0,22),BackgroundColor3=Color3.fromRGB(0,0,0),BackgroundTransparency=0.4,Text="X",Font=Enum.Font.GothamBlack,TextSize=11,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})cr(xb2,6)
xb2.MouseButton1Click:Connect(function()pan2.Visible=false end)
local lista=N("ScrollingFrame",{Parent=pan2,Position=UDim2.new(0,8,0,42),Size=UDim2.new(1,-16,1,-50),BackgroundColor3=Color3.fromRGB(10,10,12),BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=cores[Config.cor],CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})cr(lista,10)
N("UIListLayout",{Parent=lista,Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder})
local ord={}for _,p in ipairs(IDX)do table.insert(ord,p)end
table.sort(ord,function(a,b)return a.v>b.v end)
for _,p in ipairs(ord)do
local card=N("Frame",{Parent=lista,Size=UDim2.new(1,0,0,52),BackgroundColor3=C.card,BorderSizePixel=0})cr(card,10);st(card,corRar(p.r))
N("TextLabel",{Parent=card,Position=UDim2.new(0,8,0,4),Size=UDim2.new(1,-100,0,14),BackgroundTransparency=1,Text=p.n,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=corRar(p.r),TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd})
N("TextLabel",{Parent=card,Position=UDim2.new(0,8,0,20),Size=UDim2.new(1,-100,0,14),BackgroundTransparency=1,Text="$"..fmt(p.v).."/s",Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.grn,TextXAlignment=Enum.TextXAlignment.Left})
N("TextLabel",{Parent=card,Position=UDim2.new(0,8,0,34),Size=UDim2.new(1,-100,0,14),BackgroundTransparency=1,Text=p.r.." • "..p.b,Font=Enum.Font.Gotham,TextSize=8,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left})
local bS=N("TextButton",{Parent=card,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-46,0.5,0),Size=UDim2.new(0,56,0,26),BackgroundColor3=C.grn,Text="Roubar",Font=Enum.Font.GothamBold,TextSize=9,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})cr(bS,8)
bS.MouseButton1Click:Connect(function()aviso("Steal",p.n,C.grn)end)
local bF=N("TextButton",{Parent=card,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-8,0.5,0),Size=UDim2.new(0,28,0,26),BackgroundColor3=Fav[p.n]and C.yel or Color3.fromRGB(60,60,68),Text=Fav[p.n]and "★"or "☆",Font=Enum.Font.GothamBold,TextSize=12,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})cr(bF,8)
bF.MouseButton1Click:Connect(function()Fav[p.n]=not Fav[p.n]bF.Text=Fav[p.n]and "★"or "☆"bF.BackgroundColor3=Fav[p.n]and C.yel or Color3.fromRGB(60,60,68)end)
end
local fb2=N("TextButton",{Parent=gui,Position=UDim2.new(0,20,0,84),Size=UDim2.new(0,54,0,54),BackgroundColor3=C.card,Text="",AutoButtonColor=false,ZIndex=9999,Active=true})cr(fb2,27);st(fb2,C.yel,2)
N("TextLabel",{Parent=fb2,Position=UDim2.new(0.5,-16,0.5,-16),Size=UDim2.new(0,32,0,32),BackgroundTransparency=1,Text="🥚",Font=Enum.Font.GothamBlack,TextSize=24,ZIndex=10000})

local function arrastar(h,tg,cl)local d,s,m,st=false,nil,false,0
h.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then d=true;m=false;st=tick();s=i.Position end end)
h.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then if d and not m and(tick()-st)<0.3 and cl then cl()end d=false end end)
UIS.InputChanged:Connect(function(i)if not d then return end if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then local dd=i.Position-s if math.abs(dd.X)>5 or math.abs(dd.Y)>5 then m=true end tg.Position=UDim2.new(tg.Position.X.Scale,tg.Position.X.Offset+dd.X,tg.Position.Y.Scale,tg.Position.Y.Offset+dd.Y)s=i.Position end end)end
arrastar(hd,pan)arrastar(fb,fb,function()pan.Visible=not pan.Visible end)
arrastar(hd2,pan2)arrastar(fb2,fb2,function()pan2.Visible=not pan2.Visible end)
UIS.InputBegan:Connect(function(i,g)if g then return end if i.KeyCode==Enum.KeyCode.RightShift then pan.Visible=not pan.Visible end end)
trocarAba("home")
aviso("🔥 FANTASCRIPT","Carregado!",C.grn)
print("[FANTASCRIPT] Carregado.")
