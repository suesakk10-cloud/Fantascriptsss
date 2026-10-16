-- FANTASCRIPT Compacto
local P=game:GetService("Players")local UIS=game:GetService("UserInputService")
local RS=game:GetService("RunService")local LG=game:GetService("Lighting")
local HS=game:GetService("HttpService")local TS=game:GetService("TeleportService")
local LP=P.LocalPlayer local PG=LP:WaitForChild("PlayerGui")
local old=PG:FindFirstChild("FantaScript")if old then old:Destroy()end

local IDX={
{n="Frango",r="Comum",v=1},{n="Cachorro",r="Comum",v=2},{n="Pássaro",r="Incomum",v=8},{n="Coruja",r="Raro",v=35},{n="Guaxinim",r="Raro",v=45},{n="Raposa",r="Épico",v=180},{n="Urso",r="Épico",v=240},{n="Brr Patapim",r="Lendário",v=1800},
{n="Sapo",r="Comum",v=3},{n="Patinho",r="Comum",v=4},{n="Peixe-gato",r="Incomum",v=12},{n="Tartaruga",r="Raro",v=60},{n="Trulimero",r="Épico",v=260},{n="Cisne",r="Épico",v=320},{n="Axoloti",r="Lendário",v=2800},{n="Leviatã",r="Cósmico",v=220000},
{n="Camelo",r="Raro",v=75},{n="Cobra",r="Lendário",v=3600},{n="Escorpião",r="Mítico",v=18500},{n="Esfinge",r="Cósmico",v=280000},
{n="Tucano",r="Raro",v=110},{n="Crocodilo",r="Épico",v=420},{n="Gorila",r="Lendário",v=4800},{n="Tigre",r="Mítico",v=28000},{n="Cobra Rei",r="Secreto",v=3500000},
{n="Pinguim",r="Raro",v=130},{n="Urso Polar",r="Lendário",v=6500},{n="Mamute",r="Mítico",v=35000},{n="Rei Mamute",r="Cósmico",v=360000},{n="Iéti",r="Secreto",v=5000000},{n="Dragão Gelo",r="Eterno",v=65000000},
{n="Chili Maluco",r="Mítico",v=45000},{n="Cérbero",r="Secreto",v=8000000},{n="Fênix",r="Eterno",v=85000000},{n="Dragão Lava",r="Eterno",v=100000000},
{n="Tubarão",r="Lendário",v=9000},{n="Orca",r="Mítico",v=52000},{n="Kraken",r="Secreto",v=15000000},{n="El Maja",r="Eterno",v=130000000},
{n="T-Rex",r="Secreto",v=100000000},{n="Mosassauro",r="Eterno",v=180000000},{n="Unicórnio",r="Divino",v=1000000000},
{n="Kitsune",r="Divino",v=3200000000},{n="Arcanjo",r="Divino",v=6500000000},{n="Queimador",r="Divino",v=6200000000},{n="Baleia Celestial",r="Eterno",v=1200000000}}
local Fav={}
local cores={Marrom=Color3.fromRGB(139,90,60),Bege=Color3.fromRGB(222,196,168),Bege2=Color3.fromRGB(240,225,205),MarromE=Color3.fromRGB(70,45,30),Vermelho=Color3.fromRGB(200,30,40)}
local Config={cor="Marrom",bg="Bege"}
local function corRar(r)local t={Comum=Color3.fromRGB(180,180,180),Incomum=Color3.fromRGB(80,200,120),Raro=Color3.fromRGB(80,140,255),["Épico"]=Color3.fromRGB(160,80,220),["Lendário"]=Color3.fromRGB(255,180,60),["Mítico"]=Color3.fromRGB(255,80,80),["Cósmico"]=Color3.fromRGB(70,200,220),Secreto=Color3.fromRGB(255,50,180),Eterno=Color3.fromRGB(240,220,60),Divino=Color3.fromRGB(255,255,255)}return t[r]or Color3.fromRGB(140,140,150)end
local function fmt(v)if v>=1e9 then return string.format("%.2fB",v/1e9)elseif v>=1e6 then return string.format("%.2fM",v/1e6)elseif v>=1e3 then return string.format("%.1fK",v/1e3)end return tostring(v)end
local function N(c,p)local i=Instance.new(c)if p then local x=p.Parent;p.Parent=nil;for k,v in pairs(p)do i[k]=v end;i.Parent=x end return i end
local function cr(p,r)N("UICorner",{Parent=p,CornerRadius=UDim.new(0,r or 8)})end
local function st(p,c)N("UIStroke",{Parent=p,Color=c or Color3.fromRGB(120,80,55),Thickness=1})end
local function rt()local c=LP.Character return c and c:FindFirstChild("HumanoidRootPart")end
local function hm()local c=LP.Character return c and c:FindFirstChildOfClass("Humanoid")end
local St={speed=16,jump=100,fly=false,noclip=false,infJump=false,antiRag=false,espP=false,espE=false,espPet=false,autoSteal=false,antiCap=false}
local function aplicar()local h=hm()if h then h.WalkSpeed=St.speed h.JumpPower=St.jump h.UseJumpPower=true end end
LP.CharacterAdded:Connect(function()task.wait(1)aplicar()end)
local function pegarOvos()local l={}local o=workspace:FindFirstChild("Ovos")if not o then return l end local c=o:FindFirstChild("Chest")if not c then return l end for _,x in ipairs(c:GetChildren())do if x:IsA("BasePart")then table.insert(l,x)end end return l end
local function pegarPets()local l={}local p=workspace:FindFirstChild("ClientMountedPets")if p then for _,o in ipairs(p:GetChildren())do table.insert(l,o)end end return l end
local espF
local function limparESP()if espF then espF:Destroy()espF=nil end end
local function atualizarESP()limparESP()if not(St.espP or St.espE or St.espPet)then return end espF=N("Folder",{Parent=PG,Name="FantaESP"})
task.spawn(function()while espF and espF.Parent do
if St.espP then for _,pl in ipairs(P:GetPlayers())do if pl~=LP and pl.Character then local hd=pl.Character:FindFirstChild("Head")if hd and not espF:FindFirstChild("P"..pl.Name)then local b=N("BillboardGui",{Parent=espF,Name="P"..pl.Name,Adornee=hd,Size=UDim2.new(0,140,0,20),AlwaysOnTop=true,StudsOffset=Vector3.new(0,2.5,0)})cr(b,6)N("TextLabel",{Parent=b,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="👤 "..pl.Name,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=cores.Vermelho,TextStrokeTransparency=0})end end end end
if St.espE then local ovos=pegarOvos()for i,o in ipairs(ovos)do local k="E"..i if not espF:FindFirstChild(k)then local b=N("BillboardGui",{Parent=espF,Name=k,Adornee=o,Size=UDim2.new(0,120,0,20),AlwaysOnTop=true,StudsOffset=Vector3.new(0,3,0)})cr(b,6)N("TextLabel",{Parent=b,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="🥚 Ovo",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=Color3.fromRGB(255,200,60),TextStrokeTransparency=0})end end end
if St.espPet then local pets=pegarPets()for i,p in ipairs(pets)do local k="PT"..i local bp=p:IsA("BasePart")and p or p:FindFirstChildWhichIsA("BasePart")if bp and not espF:FindFirstChild(k)then local b=N("BillboardGui",{Parent=espF,Name=k,Adornee=bp,Size=UDim2.new(0,120,0,20),AlwaysOnTop=true,StudsOffset=Vector3.new(0,2,0)})cr(b,6)N("TextLabel",{Parent=b,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="🐾 Pet",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=Color3.fromRGB(80,200,80),TextStrokeTransparency=0})end end end
task.wait(2)end end)end
RS.Stepped:Connect(function()
if St.noclip then local c=LP.Character if c then for _,p in ipairs(c:GetDescendants())do if p:IsA("BasePart")then p.CanCollide=false end end end end
if St.antiRag then local h=hm()if h then h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false);h:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)end end
end)
RS.Heartbeat:Connect(function()
if St.antiCap then local r=rt()if r then for _,pl in ipairs(P:GetPlayers())do if pl~=LP and pl.Character then local pr=pl.Character:FindFirstChild("HumanoidRootPart")if pr and(pr.Position-r.Position).Magnitude<15 then local bk=r.CFrame.LookVector*-60 r.CFrame=r.CFrame+Vector3.new(bk.X,10,bk.Z)break end end end end end
end)
UIS.JumpRequest:Connect(function()if St.infJump then local h=hm()if h then h:ChangeState(Enum.HumanoidStateType.Jumping)end end end)
local bv,bg
local function ligarVoo()local r=rt()if not r then return end bv=N("BodyVelocity",{Parent=r,MaxForce=Vector3.new(1e5,1e5,1e5),Velocity=Vector3.new(0,0,0)});bg=N("BodyGyro",{Parent=r,MaxTorque=Vector3.new(1e5,1e5,1e5),P=1000,D=100,CFrame=r.CFrame})end
local function pararVoo()if bv then bv:Destroy()bv=nil end;if bg then bg:Destroy()bg=nil end end
RS.RenderStepped:Connect(function()if not St.fly or not bv then return end local r=rt()if not r then return end local cam=workspace.CurrentCamera;local m=Vector3.new(0,0,0)if UIS:IsKeyDown(Enum.KeyCode.W)then m=m+cam.CFrame.LookVector end if UIS:IsKeyDown(Enum.KeyCode.S)then m=m-cam.CFrame.LookVector end if UIS:IsKeyDown(Enum.KeyCode.A)then m=m-cam.CFrame.RightVector end if UIS:IsKeyDown(Enum.KeyCode.D)then m=m+cam.CFrame.RightVector end if UIS:IsKeyDown(Enum.KeyCode.Space)then m=m+Vector3.new(0,1,0)end bv.Velocity=m*50;bg.CFrame=cam.CFrame end)
local basePos=nil
task.spawn(function()while task.wait(0.5)do if St.autoSteal then local r=rt()if r then basePos=basePos or r.Position local ovos=pegarOvos()if #ovos>0 then local best,bd=nil,1e9 for _,o in ipairs(ovos)do local d=(o.Position-r.Position).Magnitude if d<bd then bd=d;best=o end end if best then r.CFrame=CFrame.new(best.Position+Vector3.new(0,3,0))task.wait(0.15)local pr=best:FindFirstChildOfClass("ProximityPrompt")or best:FindFirstChildWhichIsA("ProximityPrompt",true)if pr then pcall(function()pr:InputHoldBegin()end);task.wait(0.25);pcall(function()pr:InputHoldBegin()end)end task.wait(0.1)r.CFrame=CFrame.new(basePos+Vector3.new(0,3,0))end end end end end end)

-- GUI compacta estilo Amendoin
local gui=N("ScreenGui",{Name="FantaScript",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,Parent=PG,DisplayOrder=999})
local fb=N("TextButton",{Parent=gui,Position=UDim2.new(0,20,0,20),Size=UDim2.new(0,50,0,50),BackgroundColor3=cores.Bege,BorderSizePixel=0,Text="",AutoButtonColor=false,ZIndex=9999,Active=true})
cr(fb,25);st(fb,cores.Marrom,2)
N("TextLabel",{Parent=fb,Position=UDim2.new(0.5,-16,0.5,-16),Size=UDim2.new(0,32,0,32),BackgroundTransparency=1,Text="🔥",Font=Enum.Font.GothamBlack,TextSize=22,ZIndex=10000})

local pan=N("Frame",{Parent=gui,AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0.5,0,0.5,0),Size=UDim2.new(0,520,0,260),BackgroundColor3=cores.Bege2,BorderSizePixel=0,ClipsDescendants=true,ZIndex=1000,Visible=true})
cr(pan,14);st(pan,cores.Marrom,2)
local hd=N("Frame",{Parent=pan,Size=UDim2.new(1,0,0,36),BackgroundColor3=cores.Bege,BorderSizePixel=0})
cr(hd,14)
N("TextLabel",{Parent=hd,Position=UDim2.new(0,14,0,0),Size=UDim2.new(1,-60,1,0),BackgroundTransparency=1,Text="🔥 FantaScript",Font=Enum.Font.GothamBold,TextSize=14,TextColor3=cores.MarromE,TextXAlignment=Enum.TextXAlignment.Left})
local xb=N("TextButton",{Parent=hd,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-10,0.5,0),Size=UDim2.new(0,26,0,26),BackgroundTransparency=1,Text="✕",Font=Enum.Font.GothamBold,TextSize=18,TextColor3=cores.MarromE,AutoButtonColor=false})
xb.MouseButton1Click:Connect(function()pan.Visible=false end)

-- Coluna esquerda de categorias
local catCol=N("Frame",{Parent=pan,Position=UDim2.new(0,10,0,46),Size=UDim2.new(0,130,1,-56),BackgroundTransparency=1})
N("UIListLayout",{Parent=catCol,Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder})
-- Área de conteúdo
local contArea=N("Frame",{Parent=pan,Position=UDim2.new(0,150,0,46),Size=UDim2.new(1,-160,1,-56),BackgroundColor3=cores.Bege,BorderSizePixel=0})
cr(contArea,10);st(contArea,cores.Marrom,1)

local abas,tb,atual={},{},nil
local function trocarAba(id)
if atual and abas[atual]then abas[atual].Visible=false;tb[atual].BackgroundColor3=cores.Bege;tb[atual].TextColor3=cores.MarromE end
atual=id
if abas[id]then abas[id].Visible=true;tb[id].BackgroundColor3=cores.Marrom;tb[id].TextColor3=Color3.fromRGB(255,255,255)end end
local function criarAba(nome,id)
local b=N("TextButton",{Parent=catCol,Size=UDim2.new(1,0,0,32),BackgroundColor3=cores.Bege,BorderSizePixel=0,Text=nome,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=cores.MarromE,AutoButtonColor=false})
cr(b,10);st(b,cores.Marrom,1)
b.MouseButton1Click:Connect(function()trocarAba(id)end)
tb[id]=b
local f=N("ScrollingFrame",{Parent=contArea,Size=UDim2.new(1,-12,1,-12),Position=UDim2.new(0,6,0,6),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=cores.Marrom,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,Visible=false})
N("UIListLayout",{Parent=f,Padding=UDim.new(0,3),SortOrder=Enum.SortOrder.LayoutOrder})
abas[id]=f
return f end

local function linha(p,h)
local c=N("Frame",{Parent=p,Size=UDim2.new(1,0,0,h or 32),BackgroundColor3=cores.Bege2,BorderSizePixel=0})
cr(c,8);st(c,cores.Bege,1)
return c end
local function toggle(p,nome,init,fn)
local c=linha(p,34)
N("TextLabel",{Parent=c,Position=UDim2.new(0,10,0,0),Size=UDim2.new(1,-56,1,0),BackgroundTransparency=1,Text=nome,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=cores.MarromE,TextXAlignment=Enum.TextXAlignment.Left})
local s=init or false
local sw=N("TextButton",{Parent=c,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-8,0.5,0),Size=UDim2.new(0,42,0,22),BackgroundColor3=s and cores.Marrom or Color3.fromRGB(180,160,140),BorderSizePixel=0,Text="",AutoButtonColor=false})
cr(sw,11)
local kn=N("Frame",{Parent=sw,Position=s and UDim2.new(1,-20,0.5,-9)or UDim2.new(0,2,0.5,-9),Size=UDim2.new(0,18,0,18),BackgroundColor3=cores.Bege2,BorderSizePixel=0})
cr(kn,9)
sw.MouseButton1Click:Connect(function()s=not s
kn.Position=s and UDim2.new(1,-20,0.5,-9)or UDim2.new(0,2,0.5,-9)
sw.BackgroundColor3=s and cores.Marrom or Color3.fromRGB(180,160,140)
if fn then pcall(fn,s)end end)end
local function num(p,nome,valor,fn)
local c=linha(p,34)
N("TextLabel",{Parent=c,Position=UDim2.new(0,10,0,0),Size=UDim2.new(1,-110,1,0),BackgroundTransparency=1,Text=nome,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=cores.MarromE,TextXAlignment=Enum.TextXAlignment.Left})
local b=N("TextBox",{Parent=c,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-8,0.5,0),Size=UDim2.new(0,90,0,24),BackgroundColor3=cores.Bege2,BorderSizePixel=0,Text=tostring(valor),Font=Enum.Font.GothamBold,TextSize=11,TextColor3=cores.MarromE,TextXAlignment=Enum.TextXAlignment.Center,ClearTextOnFocus=false})
cr(b,8);st(b,cores.Marrom,1)
b.FocusLost:Connect(function()local n=tonumber(b.Text)if n and fn then pcall(fn,n)end end)end
local function btn(p,nome,texto,fn)
local c=linha(p,34)
N("TextLabel",{Parent=c,Position=UDim2.new(0,10,0,0),Size=UDim2.new(1,-110,1,0),BackgroundTransparency=1,Text=nome,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=cores.MarromE,TextXAlignment=Enum.TextXAlignment.Left})
local b=N("TextButton",{Parent=c,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-8,0.5,0),Size=UDim2.new(0,90,0,24),BackgroundColor3=cores.Marrom,BorderSizePixel=0,Text=texto,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})
cr(b,8)
b.MouseButton1Click:Connect(function()pcall(fn)end)end
local function info(p,t)
local c=linha(p,26)
N("TextLabel",{Parent=c,Position=UDim2.new(0,10,0,0),Size=UDim2.new(1,-16,1,0),BackgroundTransparency=1,Text=t,Font=Enum.Font.Gotham,TextSize=10,TextColor3=cores.MarromE,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd})end

-- ABAS
local t=criarAba("🌾 Farm","farm")
toggle(t,"Auto Steal","Rouba ovos + volta",function(v)St.autoSteal=v end)
toggle(t,"Anti Captura","Foge se alguém chegar perto",function(v)St.antiCap=v end)
toggle(t,"Auto Chocar","Choca ovos automaticamente")
toggle(t,"Auto Vender","Vende pets repetidos")
toggle(t,"Auto Esteira","Fica na esteira")
btn(t,"TP Ovo Próximo","TP",function()local r=rt()if not r then return end local o=pegarOvos()if #o>0 then r.CFrame=CFrame.new(o[1].Position+Vector3.new(0,3,0))end end)

t=criarAba("👤 Player","plr")
num(t,"Velocidade",16,function(n)if n<0 then n=0 end if n>1000 then n=1000 end St.speed=n aplicar()end)
num(t,"Pulo",100,function(n)St.jump=n aplicar()end)
toggle(t,"Pulo Infinito",false,function(v)St.infJump=v end)
toggle(t,"Voo",false,function(v)St.fly=v if v then ligarVoo()else pararVoo()end end)
toggle(t,"Noclip",false,function(v)St.noclip=v end)
toggle(t,"Anti Queda",false,function(v)St.antiRag=v end)
btn(t,"Reset","Resetar",function()local c=LP.Character if c then c:BreakJoints()end end)

t=criarAba("👁 Visual","vis")
toggle(t,"ESP Jogadores",false,function(v)St.espP=v atualizarESP()end)
toggle(t,"ESP Ovos",false,function(v)St.espE=v atualizarESP()end)
toggle(t,"ESP Pets",false,function(v)St.espPet=v atualizarESP()end)
btn(t,"Limpar ESP","Limpar",function()St.espP=false St.espE=false St.espPet=false atualizarESP()end)
btn(t,"Claridade","Ligar",function()LG.Brightness=3 LG.ClockTime=14 LG.GlobalShadows=false end)
btn(t,"Sem Névoa","Ligar",function()LG.FogEnd=1e6 end)

t=criarAba("🌐 Server","srv")
info(t,"Job ID: "..string.sub(game.JobId,1,10).."...")
info(t,"Jogadores: "..#P:GetPlayers().."/"..P.MaxPlayers)
btn(t,"Trocar Servidor","Hop",function()local u="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=50"local ok,b=pcall(function()return HS:JSONDecode(game:HttpGet(u))end)if ok and b and b.data then for _,s in ipairs(b.data)do if s.playing<s.maxPlayers and s.id~=game.JobId then pcall(function()TS:TeleportToPlaceInstance(game.PlaceId,s.id,LP)end)return end end end end)
btn(t,"Reentrar","Rejoin",function()pcall(function()TS:Teleport(game.PlaceId,LP)end)end)
btn(t,"Copiar Job ID","Copiar",function()if setclipboard then setclipboard(game.JobId)end end)

t=criarAba("🥚 Pets","pets")
info(t,"Lista de pets:")
local lista=N("ScrollingFrame",{Parent=t,Size=UDim2.new(1,0,0,220),BackgroundColor3=cores.Bege2,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=cores.Marrom,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})
cr(lista,8)
N("UIListLayout",{Parent=lista,Padding=UDim.new(0,3),SortOrder=Enum.SortOrder.LayoutOrder})
local ord={}for _,p in ipairs(IDX)do table.insert(ord,p)end
table.sort(ord,function(a,b)return a.v>b.v end)
for _,p in ipairs(ord)do
local c=N("Frame",{Parent=lista,Size=UDim2.new(1,0,0,28),BackgroundColor3=cores.Bege,BorderSizePixel=0})
cr(c,6);st(c,corRar(p.r),1)
N("TextLabel",{Parent=c,Position=UDim2.new(0,8,0,0),Size=UDim2.new(1,-60,1,0),BackgroundTransparency=1,Text=p.n,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=corRar(p.r),TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd})
N("TextLabel",{Parent=c,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-8,0.5,0),Size=UDim2.new(0,55,1,0),BackgroundTransparency=1,Text="$"..fmt(p.v),Font=Enum.Font.GothamBold,TextSize=9,TextColor3=cores.MarromE,TextXAlignment=Enum.TextXAlignment.Right})
end
btn(t,"Fechar painel","Fechar",function()pan.Visible=false end)

-- Drag
local function arrastar(h,tg,cl)local d,s,m,st=false,nil,false,0
h.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then d=true;m=false;st=tick();s=i.Position end end)
h.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then if d and not m and(tick()-st)<0.3 and cl then cl()end d=false end end)
UIS.InputChanged:Connect(function(i)if not d then return end if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then local dd=i.Position-s if math.abs(dd.X)>5 or math.abs(dd.Y)>5 then m=true end tg.Position=UDim2.new(tg.Position.X.Scale,tg.Position.X.Offset+dd.X,tg.Position.Y.Scale,tg.Position.Y.Offset+dd.Y)s=i.Position end end)end
arrastar(hd,pan)arrastar(fb,fb,function()pan.Visible=not pan.Visible end)
UIS.InputBegan:Connect(function(i,g)if g then return end if i.KeyCode==Enum.KeyCode.RightShift then pan.Visible=not pan.Visible end end)
trocarAba("farm")
print("[FANTASCRIPT] Compacto carregado.")
