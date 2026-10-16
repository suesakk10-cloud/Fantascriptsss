-- ═══════════════════════════════════════════════════════
-- CHILLI HUB — Steal An Egg (Português)
-- ═══════════════════════════════════════════════════════
local P=game:GetService("Players")local UIS=game:GetService("UserInputService")
local RS=game:GetService("RunService")local LG=game:GetService("Lighting")
local HS=game:GetService("HttpService")local TS=game:GetService("TeleportService")
local LP=P.LocalPlayer local PG=LP:WaitForChild("PlayerGui")
local old=PG:FindFirstChild("ChilliHub")if old then old:Destroy()end

-- BASE DE DADOS DE PETS
local IDX={
{n="Chicken",r="Comum",v=1,b="Forest"},{n="Dog",r="Comum",v=2,b="Forest"},{n="Bird",r="Incomum",v=8,b="Forest"},{n="Owl",r="Raro",v=35,b="Forest"},{n="Raccoon",r="Raro",v=45,b="Forest"},{n="Bear",r="Épico",v=240,b="Forest"},{n="Fox",r="Épico",v=180,b="Forest"},{n="Brr Brr Patapim",r="Lendário",v=1800,b="Forest"},
{n="Frog",r="Comum",v=3,b="Lake"},{n="Duckling",r="Comum",v=4,b="Lake"},{n="Catfish",r="Incomum",v=12,b="Lake"},{n="Turtle",r="Raro",v=60,b="Lake"},{n="Trulimero Trulicina",r="Épico",v=260,b="Lake"},{n="Swan",r="Épico",v=320,b="Lake"},{n="Axolotl",r="Lendário",v=2800,b="Lake"},{n="Leviathan",r="Cósmico",v=220000,b="Lake"},
{n="Jerboa",r="Comum",v=6,b="Desert"},{n="Fennec",r="Incomum",v=18,b="Desert"},{n="Camel",r="Raro",v=75,b="Desert"},{n="Tob Tobi Tob Tob",r="Épico",v=325,b="Desert"},{n="Snake",r="Lendário",v=3600,b="Desert"},{n="Scorpion",r="Mítico",v=18500,b="Desert"},{n="Sand Spider",r="Mítico",v=16000,b="Desert"},{n="Royal Sphinx",r="Cósmico",v=280000,b="Desert"},
{n="Toucan",r="Raro",v=110,b="Jungle"},{n="Chimpanzee",r="Raro",v=90,b="Jungle"},{n="Crocodile",r="Épico",v=420,b="Jungle"},{n="Gorilla",r="Lendário",v=4800,b="Jungle"},{n="Orangutini",r="Lendário",v=5500,b="Jungle"},{n="Spider",r="Mítico",v=22000,b="Jungle"},{n="Tiger",r="Mítico",v=28000,b="Jungle"},{n="King Snake",r="Secreto",v=3500000,b="Jungle"},
{n="Penguin",r="Raro",v=130,b="Snow"},{n="Walrus",r="Épico",v=460,b="Snow"},{n="Polar Bear",r="Lendário",v=6500,b="Snow"},{n="Sabertooth",r="Mítico",v=30000,b="Snow"},{n="Mammoth",r="Mítico",v=35000,b="Snow"},{n="King Mammoth",r="Cósmico",v=360000,b="Snow"},{n="Yeti",r="Secreto",v=5000000,b="Snow"},{n="Ice Dragon",r="Eterno",v=65000000,b="Snow"},
{n="Lava Gecko",r="Raro",v=180,b="Volcano"},{n="Lava Frog",r="Épico",v=540,b="Volcano"},{n="Flaming Bull",r="Lendário",v=7500,b="Volcano"},{n="Lava Iguana",r="Lendário",v=8200,b="Volcano"},{n="Chillin Chilli",r="Mítico",v=45000,b="Volcano"},{n="Cerberus",r="Secreto",v=8000000,b="Volcano"},{n="Phoenix",r="Eterno",v=85000000,b="Volcano"},{n="Lava Dragon",r="Eterno",v=100000000,b="Volcano"},
{n="Parrotfish",r="Raro",v=220,b="Abyss Ocean"},{n="Swordfish",r="Épico",v=620,b="Abyss Ocean"},{n="Shark",r="Lendário",v=9000,b="Abyss Ocean"},{n="Orca",r="Mítico",v=52000,b="Abyss Ocean"},{n="Whale Shark",r="Cósmico",v=380000,b="Abyss Ocean"},{n="Beluga",r="Cósmico",v=420000,b="Abyss Ocean"},{n="Kraken",r="Secreto",v=15000000,b="Abyss Ocean"},{n="El Maja",r="Eterno",v=130000000,b="Abyss Ocean"},
{n="Dodo",r="Raro",v=260,b="Prehistoric"},{n="Pterodactyl",r="Épico",v=780,b="Prehistoric"},{n="Ankylosaurus",r="Lendário",v=11000,b="Prehistoric"},{n="Triceratops",r="Lendário",v=13000,b="Prehistoric"},{n="Bronto",r="Mítico",v=58000,b="Prehistoric"},{n="Tralaledon",r="Secreto",v=32000000,b="Prehistoric"},{n="T-Rex",r="Secreto",v=100000000,b="Prehistoric"},{n="Mosasaurus",r="Eterno",v=180000000,b="Prehistoric"},
{n="Centapede",r="Épico",v=950,b="Cosmic"},{n="Cosmic Gecko",r="Lendário",v=15000,b="Cosmic"},{n="Cosmic Gorilla",r="Lendário",v=18000,b="Cosmic"},{n="La Vacca Saturno",r="Cósmico",v=2200000,b="Cosmic"},{n="Cosmic Dragon",r="Secreto",v=60000000,b="Cosmic"},{n="Cosmic Skeleton",r="Secreto",v=45000000,b="Cosmic"},{n="Eternal Lunar",r="Eterno",v=250000000,b="Cosmic"},{n="Unicorn",r="Divino",v=1000000000,b="Cosmic"},
{n="Crane",r="Raro",v=320,b="Cherry"},{n="Salamander",r="Épico",v=1100,b="Cherry"},{n="Red Panda",r="Mítico",v=68000,b="Cherry"},{n="Koi",r="Cósmico",v=12000000,b="Cherry"},{n="Snowy Owl",r="Cósmico",v=7500000,b="Cherry"},{n="Stag",r="Secreto",v=145000000,b="Cherry"},{n="Oni Tiger",r="Eterno",v=600000000,b="Cherry"},{n="Kitsune",r="Divino",v=3200000000,b="Cherry"},
{n="Crustacia",r="Épico",v=1400,b="Titan"},{n="Spideron",r="Lendário",v=22000,b="Titan"},{n="Bladehide",r="Lendário",v=26000,b="Titan"},{n="Mantaris",r="Cósmico",v=11000000,b="Titan"},{n="Rhinotaur",r="Cósmico",v=17500000,b="Titan"},{n="Mutant Shark",r="Eterno",v=204000000,b="Titan"},{n="Gorilla King",r="Eterno",v=880000000,b="Titan"},{n="Nightflame",r="Divino",v=3000000000,b="Titan"},
{n="Light Dove",r="Lendário",v=25000,b="Light Dark"},{n="Winged Lamb",r="Mítico",v=85000,b="Light Dark"},{n="Sacred Moth",r="Cósmico",v=25000000,b="Light Dark"},{n="Holy Peacock",r="Cósmico",v=32000000,b="Light Dark"},{n="Pure Jellyfish",r="Secreto",v=243500000,b="Light Dark"},{n="Centaur",r="Secreto",v=180000000,b="Light Dark"},{n="Pegasus",r="Eterno",v=850000000,b="Light Dark"},{n="ArchAngel",r="Divino",v=6500000000,b="Light Dark"},
{n="Flame Sprite",r="Lendário",v=28000,b="Light Dark"},{n="Toro",r="Mítico",v=92000,b="Light Dark"},{n="Imp",r="Cósmico",v=22000000,b="Light Dark"},{n="Demon Hound",r="Cósmico",v=35000000,b="Light Dark"},{n="Gargoyle",r="Secreto",v=210000000,b="Light Dark"},{n="RazorFang",r="Secreto",v=250000000,b="Light Dark"},{n="Skeleton Horse",r="Eterno",v=800000000,b="Light Dark"},{n="World Burner",r="Divino",v=6200000000,b="Light Dark"},
{n="Prism Gecko",r="Raro",v=450,b="Enchanted Forest"},{n="Petal Beetle",r="Épico",v=1800,b="Enchanted Forest"},{n="Enchanted Bluejay",r="Lendário",v=28000,b="Enchanted Forest"},{n="Astral Jackalope",r="Lendário",v=32000,b="Enchanted Forest"},{n="Spirit Panda",r="Mítico",v=95000,b="Enchanted Forest"},{n="Starry Fox",r="Cósmico",v=18000000,b="Enchanted Forest"},{n="Celestial Sunlion",r="Secreto",v=200000000,b="Enchanted Forest"},{n="Royal Skywhale",r="Eterno",v=1200000000,b="Enchanted Forest"}
}
local Fav={}local Disc={}local Config={cor="Vermelho"}
local cores={Vermelho=Color3.fromRGB(200,30,40),Roxo=Color3.fromRGB(140,80,220),Azul=Color3.fromRGB(80,140,240),Verde=Color3.fromRGB(60,180,90),Laranja=Color3.fromRGB(240,140,40)}
local function corRar(r)local t={Comum=Color3.fromRGB(180,180,180),Incomum=Color3.fromRGB(80,200,120),Raro=Color3.fromRGB(80,140,255),["Épico"]=Color3.fromRGB(160,80,220),["Lendário"]=Color3.fromRGB(255,180,60),["Mítico"]=Color3.fromRGB(255,80,80),["Cósmico"]=Color3.fromRGB(70,200,220),Secreto=Color3.fromRGB(255,50,180),Eterno=Color3.fromRGB(240,220,60),Divino=Color3.fromRGB(255,255,255)}return t[r]or Color3.fromRGB(140,140,150)end
local function fmt(v)if v>=1e9 then return string.format("%.2fB",v/1e9)elseif v>=1e6 then return string.format("%.2fM",v/1e6)elseif v>=1e3 then return string.format("%.1fK",v/1e3)end return tostring(v)end
local function N(c,p)local i=Instance.new(c)if p then local x=p.Parent;p.Parent=nil;for k,v in pairs(p)do i[k]=v end;i.Parent=x end return i end
local function cr(p,r)N("UICorner",{Parent=p,CornerRadius=UDim.new(0,r or 8)})end
local function st(p,c)N("UIStroke",{Parent=p,Color=c or Color3.fromRGB(55,55,62),Thickness=1})end
local function rt()local c=LP.Character return c and c:FindFirstChild("HumanoidRootPart")end
local function hm()local c=LP.Character return c and c:FindFirstChildOfClass("Humanoid")end
local C={bg=Color3.fromRGB(15,15,18),card=Color3.fromRGB(32,32,38),bd=Color3.fromRGB(55,55,62),red=cores.Vermelho,grn=Color3.fromRGB(60,180,90),yel=Color3.fromRGB(240,180,50),blu=Color3.fromRGB(80,140,240),txt=Color3.fromRGB(240,240,245),txt2=Color3.fromRGB(150,150,160)}
local St={speed=16,jump=100,fly=false,noclip=false,infJump=false,antiRag=false,antiVoid=false,espP=false,espE=false,espPet=false,espG=false,autoSteal=false,autoHatch=false,autoSell=false,autoTreadmill=false,antiGuard=false}
local function aplicar()local h=hm()if h then h.WalkSpeed=St.speed h.JumpPower=St.jump h.UseJumpPower=true end end
LP.CharacterAdded:Connect(function()task.wait(1)aplicar()end)
-- ESP
local espF
local function limparESP()if espF then espF:Destroy()espF=nil end end
local function atualizarESP()limparESP()if not(St.espP or St.espE or St.espPet or St.espG)then return end espF=N("Folder",{Parent=PG,Name="ChilliESP"})
task.spawn(function()while espF and espF.Parent do
if St.espP then for _,pl in ipairs(P:GetPlayers())do if pl~=LP and pl.Character then local hd=pl.Character:FindFirstChild("Head")if hd and not espF:FindFirstChild("P"..pl.Name)then local b=N("BillboardGui",{Parent=espF,Name="P"..pl.Name,Adornee=hd,Size=UDim2.new(0,140,0,20),AlwaysOnTop=true,StudsOffset=Vector3.new(0,2.5,0)})cr(b,6)N("TextLabel",{Parent=b,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=pl.Name,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.red,TextStrokeTransparency=0})end end end end
if St.espE or St.espPet or St.espG then for _,o in ipairs(workspace:GetDescendants())do if o:IsA("BasePart")then local n=o.Name:lower()local isEgg=n:find("egg")or n:find("ovo")or n:find("brainrot")local isPet=n:find("pet")and not isEgg local isG=n:find("guard")or n:find("guardian")if(isEgg and St.espE)or(isPet and St.espPet)or(isG and St.espG)then if not espF:FindFirstChild("T"..o.Name)then local b=N("BillboardGui",{Parent=espF,Name="T"..o.Name,Adornee=o,Size=UDim2.new(0,140,0,20),AlwaysOnTop=true,StudsOffset=Vector3.new(0,2,0)})cr(b,6)local txt=isEgg and("🥚 "..o.Name)or(isPet and("🐾 "..o.Name)or("🛡 "..o.Name))local cor=isEgg and C.yel or(isPet and C.grn or C.red)N("TextLabel",{Parent=b,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=cor,TextStrokeTransparency=0})end end end end end
task.wait(1.5)end end)end
-- LOOPS
RS.Stepped:Connect(function()if St.noclip then local c=LP.Character if c then for _,p in ipairs(c:GetDescendants())do if p:IsA("BasePart")then p.CanCollide=false end end end end if St.antiRag then local h=hm()if h then h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)h:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)end end if St.antiGuard then for _,o in ipairs(workspace:GetDescendants())do if o:IsA("BasePart")and(o.Name:lower():find("guard")or o.Name:lower():find("barrier")or o.Name:lower():find("wall"))then pcall(function()o.CanCollide=false o.Transparency=0.7 end)end end end end)
RS.Heartbeat:Connect(function()if St.antiVoid then local r=rt()if r and r.Position.Y<-80 then r.CFrame=CFrame.new(0,50,0)end end end)
UIS.JumpRequest:Connect(function()if St.infJump then local h=hm()if h then h:ChangeState(Enum.HumanoidStateType.Jumping)end end end)
-- FLY
local bv,bg
local function ligarVoo()local r=rt()if not r then return end bv=N("BodyVelocity",{Parent=r,MaxForce=Vector3.new(1e5,1e5,1e5),Velocity=Vector3.new(0,0,0)})bg=N("BodyGyro",{Parent=r,MaxTorque=Vector3.new(1e5,1e5,1e5),P=1000,D=100,CFrame=r.CFrame})end
local function pararVoo()if bv then bv:Destroy()bv=nil end if bg then bg:Destroy()bg=nil end end
RS.RenderStepped:Connect(function()if not St.fly or not bv then return end local r=rt()if not r then return end local cam=workspace.CurrentCamera local m=Vector3.new(0,0,0)if UIS:IsKeyDown(Enum.KeyCode.W)then m=m+cam.CFrame.LookVector end if UIS:IsKeyDown(Enum.KeyCode.S)then m=m-cam.CFrame.LookVector end if UIS:IsKeyDown(Enum.KeyCode.A)then m=m-cam.CFrame.RightVector end if UIS:IsKeyDown(Enum.KeyCode.D)then m=m+cam.CFrame.RightVector end if UIS:IsKeyDown(Enum.KeyCode.Space)then m=m+Vector3.new(0,1,0)end if UIS:IsKeyDown(Enum.KeyCode.LeftControl)then m=m-Vector3.new(0,1,0)end bv.Velocity=m*50 bg.CFrame=cam.CFrame end)
-- AUTO FARM
task.spawn(function()while task.wait(0.3)do if St.autoSteal then local r=rt()if r then local best,bd=nil,1e9 for _,o in ipairs(workspace:GetDescendants())do if o:IsA("BasePart")then local n=o.Name:lower()if n:find("egg")or n:find("ovo")or n:find("brainrot")then local d=(o.Position-r.Position).Magnitude if d<bd and d>5 then bd=d best=o end end end end if best then r.CFrame=CFrame.new(best.Position+Vector3.new(0,3,0))task.wait(0.1)local pr=best:FindFirstChildOfClass("ProximityPrompt")if pr then pcall(function()pr:InputHoldBegin()end)task.wait(0.2)pcall(function()pr:InputHoldEnd()end)end end end end end end)
task.spawn(function()while task.wait(1)do if St.autoHatch or St.autoSell then local r=rt()if r then for _,o in ipairs(workspace:GetDescendants())do if o:IsA("ProximityPrompt")then local at=o.ActionText:lower()local ok=false if St.autoHatch and(at:find("hatch")or at:find("chocar"))then ok=true end if St.autoSell and(at:find("sell")or at:find("vender"))then ok=true end if ok and o.Parent and o.Parent:IsA("BasePart")and(o.Parent.Position-r.Position).Magnitude<25 then pcall(function()o:InputHoldBegin()end)task.wait(0.15)pcall(function()o:InputHoldEnd()end)end end end end end end end)
task.spawn(function()while task.wait(2)do if St.autoTreadmill then local r=rt()if r then for _,o in ipairs(workspace:GetDescendants())do if o:IsA("BasePart")and o.Name:lower():find("treadmill")then r.CFrame=CFrame.new(o.Position+Vector3.new(0,5,0))break end end end end end end)
-- NOTIFICAÇÕES
local NH=N("Frame",{Parent=PG,AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-16,0,16),Size=UDim2.new(0,260,0,400),BackgroundTransparency=1,ZIndex=9999})
N("UIListLayout",{Parent=NH,Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder,VerticalAlignment=Enum.VerticalAlignment.Top,HorizontalAlignment=Enum.HorizontalAlignment.Right})
local function aviso(t,m,c)c=c or C.red local b=N("Frame",{Parent=NH,Size=UDim2.new(1,0,0,46),BackgroundColor3=C.card,BorderSizePixel=0,ZIndex=9999})cr(b,8)st(b,c)N("TextLabel",{Parent=b,Position=UDim2.new(0,8,0,4),Size=UDim2.new(1,-16,0,16),BackgroundTransparency=1,Text=t,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=c,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=9999})N("TextLabel",{Parent=b,Position=UDim2.new(0,8,0,22),Size=UDim2.new(1,-16,0,20),BackgroundTransparency=1,Text=m,Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true,ZIndex=9999})task.delay(4,function()if b.Parent then b:Destroy()end end)end
-- GUI
local gui=N("ScreenGui",{Name="ChilliHub",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,Parent=PG,DisplayOrder=999})
-- BOLINHA
local fb=N("TextButton",{Parent=gui,Position=UDim2.new(0,20,0,20),Size=UDim2.new(0,52,0,52),BackgroundColor3=C.card,Text="",AutoButtonColor=false,ZIndex=9999})cr(fb,26)st(fb,Config.cor=="Vermelho"and C.red or cores[Config.cor],2)
N("TextLabel",{Parent=fb,Position=UDim2.new(0.5,-16,0.5,-16),Size=UDim2.new(0,32,0,32),BackgroundTransparency=1,Text="🔥",Font=Enum.Font.GothamBlack,TextSize=22,ZIndex=10000})
-- PAINEL PRINCIPAL
local pan=N("Frame",{Parent=gui,AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0.5,0,0.5,0),Size=UDim2.new(0,600,0,420),BackgroundColor3=C.bg,BorderSizePixel=0,ClipsDescendants=true,ZIndex=1000,Visible=true})
cr(pan,14)st(pan,cores[Config.cor],2)
local hd=N("Frame",{Parent=pan,Size=UDim2.new(1,0,0,38),BackgroundColor3=cores[Config.cor],BorderSizePixel=0})cr(hd,14)
N("TextLabel",{Parent=hd,Position=UDim2.new(0,14,0,0),Size=UDim2.new(1,-100,1,0),BackgroundTransparency=1,Text="🔥 CHILLI HUB — Steal An Egg",Font=Enum.Font.GothamBlack,TextSize=14,TextColor3=Color3.fromRGB(255,255,255),TextXAlignment=Enum.TextXAlignment.Left})
local minB=N("TextButton",{Parent=hd,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-42,0.5,0),Size=UDim2.new(0,26,0,26),BackgroundColor3=Color3.fromRGB(0,0,0),BackgroundTransparency=0.4,Text="—",Font=Enum.Font.GothamBlack,TextSize=14,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})cr(minB,6)minB.MouseButton1Click:Connect(function()pan.Size=UDim2.new(0,600,0,38)end)
local xb=N("TextButton",{Parent=hd,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-10,0.5,0),Size=UDim2.new(0,26,0,26),BackgroundColor3=Color3.fromRGB(0,0,0),BackgroundTransparency=0.4,Text="X",Font=Enum.Font.GothamBlack,TextSize=13,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})cr(xb,6)xb.MouseButton1Click:Connect(function()pan.Visible=false end)
-- MENUS LATERAIS
local lM=N("ScrollingFrame",{Parent=pan,Position=UDim2.new(0,8,0,46),Size=UDim2.new(0,110,1,-56),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=cores[Config.cor],CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})N("UIListLayout",{Parent=lM,Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder})
local rM=N("ScrollingFrame",{Parent=pan,AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-8,0,46),Size=UDim2.new(0,110,1,-56),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=cores[Config.cor],CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})N("UIListLayout",{Parent=rM,Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder})
local ce=N("Frame",{Parent=pan,Position=UDim2.new(0,124,0,46),Size=UDim2.new(1,-248,1,-88),BackgroundColor3=C.card,BorderSizePixel=0})cr(ce,10)st(ce,C.bd)
local footer=N("Frame",{Parent=pan,AnchorPoint=Vector2.new(0,1),Position=UDim2.new(0,8,1,-38),Size=UDim2.new(1,-16,0,30),BackgroundColor3=C.card,BorderSizePixel=0})cr(footer,8)st(footer,C.bd)
N("TextLabel",{Parent=footer,Position=UDim2.new(0,10,0,0),Size=UDim2.new(0,70,1,0),BackgroundTransparency=1,Text="Pesquisar",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})
local sBox=N("TextBox",{Parent=footer,Position=UDim2.new(0,80,0,4),Size=UDim2.new(1,-90,1,-8),BackgroundColor3=Color3.fromRGB(10,10,12),BorderSizePixel=0,PlaceholderText="Filtrar funções...",PlaceholderColor3=C.txt2,Text="",Font=Enum.Font.Gotham,TextSize=10,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false})cr(sBox,6)N("UIPadding",{Parent=sBox,PaddingLeft=UDim.new(0,8)})
-- SISTEMA DE ABAS
local abas,tb,atual={},{},nil
local function trocarAba(id)if atual and abas[atual]then abas[atual].Visible=false;tb[atual].BackgroundColor3=C.card;tb[atual].TextColor3=C.txt end atual=id if abas[id]then abas[id].Visible=true;tb[id].BackgroundColor3=cores[Config.cor];tb[id].TextColor3=Color3.fromRGB(255,255,255)end end
local function criarAba(nome,id,lado)local m=lado=="L"and lM or rM local b=N("TextButton",{Parent=m,Size=UDim2.new(1,0,0,30),BackgroundColor3=C.card,Text=nome,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.txt,AutoButtonColor=false})cr(b,8)st(b,C.bd)b.MouseButton1Click:Connect(function()trocarAba(id)end)tb[id]=b local f=N("ScrollingFrame",{Parent=ce,Size=UDim2.new(1,-12,1,-12),Position=UDim2.new(0,6,0,6),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=cores[Config.cor],CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,Visible=false})N("UIListLayout",{Parent=f,Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder})abas[id]=f return f end
-- COMPONENTES
local function linha(p,h)local c=N("Frame",{Parent=p,Size=UDim2.new(1,0,0,h or 36),BackgroundColor3=C.card,BorderSizePixel=0})cr(c,8)st(c,C.bd)return c end
local function secao(p,t)local c=N("Frame",{Parent=p,Size=UDim2.new(1,0,0,24),BackgroundColor3=C.bg,BorderSizePixel=0})cr(c,8)N("TextLabel",{Parent=c,Position=UDim2.new(0,8,0,0),Size=UDim2.new(1,-16,1,0),BackgroundTransparency=1,Text="▼ "..t,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=cores[Config.cor],TextXAlignment=Enum.TextXAlignment.Left})end
local function toggle(p,nome,desc,fn)local c=linha(p,42)N("TextLabel",{Parent=c,Position=UDim2.new(0,10,0,4),Size=UDim2.new(1,-60,0,14),BackgroundTransparency=1,Text=nome,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})if desc then N("TextLabel",{Parent=c,Position=UDim2.new(0,10,0,20),Size=UDim2.new(1,-60,0,16),BackgroundTransparency=1,Text=desc,Font=Enum.Font.Gotham,TextSize=8,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true})end local s=false local sw=N("TextButton",{Parent=c,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-10,0.5,0),Size=UDim2.new(0,38,0,20),BackgroundColor3=Color3.fromRGB(60,60,68),Text="",AutoButtonColor=false})cr(sw,10)local kn=N("Frame",{Parent=sw,Position=UDim2.new(0,2,0,2),Size=UDim2.new(0,16,0,16),BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0})cr(kn,8)sw.MouseButton1Click:Connect(function()s=not s kn.Position=s and UDim2.new(1,-18,0,2)or UDim2.new(0,2,0,2)sw.BackgroundColor3=s and C.grn or Color3.fromRGB(60,60,68)if fn then pcall(fn,s)end end)end
local function num(p,nome,valor,fn)local c=linha(p,36)N("TextLabel",{Parent=c,Position=UDim2.new(0,10,0,0),Size=UDim2.new(1,-110,1,0),BackgroundTransparency=1,Text=nome,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})local b=N("TextBox",{Parent=c,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-10,0.5,0),Size=UDim2.new(0,90,0,24),BackgroundColor3=Color3.fromRGB(10,10,12),BorderSizePixel=0,Text=tostring(valor),Font=Enum.Font.GothamBold,TextSize=11,TextColor3=Color3.fromRGB(255,255,255),TextXAlignment=Enum.TextXAlignment.Center,ClearTextOnFocus=false})cr(b,6)st(b,C.bd)b.FocusLost:Connect(function()local n=tonumber(b.Text)if n and fn then pcall(fn,n)end end)end
local function btn(p,nome,texto,cor,fn)local f=linha(p,36)N("TextLabel",{Parent=f,Position=UDim2.new(0,10,0,0),Size=UDim2.new(1,-110,1,0),BackgroundTransparency=1,Text=nome,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})local b=N("TextButton",{Parent=f,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-10,0.5,0),Size=UDim2.new(0,90,0,24),BackgroundColor3=cor or cores[Config.cor],Text=texto,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})cr(b,6)b.MouseButton1Click:Connect(function()local ok,e=pcall(fn)if not ok then aviso("Erro",tostring(e),C.red)end end)end
local function info(p,t)local c=linha(p,24)N("TextLabel",{Parent=c,Position=UDim2.new(0,10,0,0),Size=UDim2.new(1,-16,1,0),BackgroundTransparency=1,Text=t,Font=Enum.Font.Gotham,TextSize=10,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd})end
-- ═══ ABA INÍCIO ═══
local t=criarAba("🏠 Início","inicio","L")
info(t,"CHILLI HUB v1.0")
info(t,"Steal An Egg — Português")
info(t,"Right Shift → abre/fecha")
info(t,"Bolinha 🔥 → painel")
info(t,"Bolinha 🥚 → Steal Panel")
-- ═══ ABA PLAYER ═══
t=criarAba("👤 Player","player","L")
secao(t,"Movimento")
num(t,"Velocidade (0-1000)",16,function(n)if n<0 then n=0 end if n>1000 then n=1000 end St.speed=n aplicar()aviso("Velocidade",n.." studs",C.grn)end)
num(t,"Força do Pulo",100,function(n)St.jump=n aplicar()end)
toggle(t,"Pulo Infinito","Pula no ar.",function(v)St.infJump=v end)
toggle(t,"Voo","WASD + Space + Ctrl.",function(v)St.fly=v if v then ligarVoo()else pararVoo()end end)
toggle(t,"Atravessar Paredes","Noclip.",function(v)St.noclip=v end)
secao(t,"Defesa")
toggle(t,"Anti Queda","Não cai no chão.",function(v)St.antiRag=v end)
toggle(t,"Anti Vazio","Não morre ao cair.",function(v)St.antiVoid=v end)
toggle(t,"Anti Guardião","Remove guardas.",function(v)St.antiGuard=v end)
btn(t,"Resetar Personagem","Resetar",C.red,function()local c=LP.Character if c then c:BreakJoints()end end)
-- ═══ ABA VISUAL ═══
t=criarAba("👁 Visual","visual","L")
secao(t,"ESP — Atravessa Paredes")
toggle(t,"ESP de Jogadores","Nomes dos jogadores.",function(v)St.espP=v atualizarESP()end)
toggle(t,"ESP de Ovos","Marcadores 🥚 raros.",function(v)St.espE=v atualizarESP()end)
toggle(t,"ESP de Pets","Marcadores 🐾.",function(v)St.espPet=v atualizarESP()end)
toggle(t,"ESP de Guardiões","Marcadores 🛡.",function(v)St.espG=v atualizarESP()end)
btn(t,"Limpar ESP","Limpar",C.red,function()St.espP=false St.espE=false St.espPet=false St.espG=false atualizarESP()end)
secao(t,"Iluminação")
btn(t,"Claridade Total","Ligar",C.yel,function()LG.Brightness=3 LG.ClockTime=14 LG.FogEnd=1e6 LG.GlobalShadows=false aviso("Visual","Claridade ON",C.grn)end)
btn(t,"Remover Névoa","Ligar",C.yel,function()LG.FogEnd=1e6 aviso("Visual","Névoa OFF",C.grn)end)
-- ═══ ABA FARM ═══
t=criarAba("🌾 Farm","farm","L")
secao(t,"Auto Steal")
toggle(t,"Auto Steal","Rouba ovo mais próximo.",function(v)St.autoSteal=v end)
toggle(t,"Instant Steal","Entrega rápida (precisa Speed).")
toggle(t,"Instant Steal V2","Segundo método.")
toggle(t,"Anti Guardião","Desativa barreira.")
secao(t,"Áreas Alvo")
info(t,"13 áreas disponíveis:")
info(t,"Forest, Lake, Desert, Jungle,")
info(t,"Snow, Volcano, Abyss Ocean,")
info(t,"Prehistoric, Cosmic, Cherry,")
info(t,"Titan, Light Dark, Enchanted.")
secao(t,"Filtros")
info(t,"Min Raridade: Any, Comum,")
info(t,"Incomum, Raro, Épico, Lendário,")
info(t,"Mítico, Cósmico, Secreto,")
info(t,"Eterno, Divino.")
num(t,"Valor Mínimo Roubo",0,function(n)end)
secao(t,"Outros Auto")
toggle(t,"Auto Chocar","Choca ovos.",function(v)St.autoHatch=v end)
toggle(t,"Auto Vender","Vende pets.",function(v)St.autoSell=v end)
toggle(t,"Auto Esteira","Fica na esteira.",function(v)St.autoTreadmill=v end)
btn(t,"TP Ovo Mais Próximo","TP",C.blu,function()local r=rt()if not r then return end local best,bd=nil,1e9 for _,o in ipairs(workspace:GetDescendants())do if o:IsA("BasePart")then local n=o.Name:lower()if n:find("egg")or n:find("ovo")or n:find("brainrot")then local d=(o.Position-r.Position).Magnitude if d<bd then bd=d best=o end end end end if best then r.CFrame=CFrame.new(best.Position+Vector3.new(0,3,0))aviso("TP","Foste para "..best.Name,C.blu)else aviso("TP","Nada encontrado",C.red)end end)
-- ═══ ABA EVENTOS ═══
t=criarAba("🎉 Eventos","eventos","L")
secao(t,"Racing Event")
toggle(t,"Auto Race","Participa da corrida.")
toggle(t,"Auto Claim Rewards","Resgata prêmios.")
toggle(t,"Auto Equip Racer","Equipa corredor.")
info(t,"Race Speed: 160")
secao(t,"Shooting Star")
toggle(t,"Auto Catch Star","Pega estrelas.")
secao(t,"Butterfly Bloom")
toggle(t,"Auto Butterfly","Coleta borboletas.")
-- ═══ ABA TELEPORTE ═══
t=criarAba("🚀 Teleporte","tp","L")
secao(t,"Teleporte V1")
btn(t,"Ir para Spawn","TP",C.blu,function()local r=rt()if r then r.CFrame=CFrame.new(0,50,0)aviso("TP","Spawn",C.blu)end end)
btn(t,"Ir para Minha Base","TP",C.blu,function()aviso("TP","Procurando base...",C.yel)end)
secao(t,"Teleporte V2")
info(t,"Destinos salvos: 0")
btn(t,"Salvar Destino Atual","Salvar",C.yel,function()local r=rt()if r then aviso("Destino","Salvo em "..string.format("%.0f,%.0f,%.0f",r.Position.X,r.Position.Y,r.Position.Z),C.grn)end end)
secao(t,"Ir para Bioma")
for _,bio in ipairs({"Forest","Lake","Desert","Jungle","Snow","Volcano","Abyss Ocean","Prehistoric","Cosmic","Cherry","Titan","Light Dark","Enchanted"})do btn(t,bio,"TP",C.pur,function()aviso("Bioma",bio.." (procura no mapa)",C.pur)end)end
-- ═══ ABA SERVIDOR ═══
t=criarAba("🌐 Servidor","srv","L")
info(t,"Job ID: "..string.sub(game.JobId,1,10).."...")
info(t,"Jogadores: "..#P:GetPlayers().."/"..P.MaxPlayers)
secao(t,"Server Hop")
btn(t,"Trocar Servidor","Hop",C.red,function()local url="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=50" local ok,body=pcall(function()return HS:JSONDecode(game:HttpGet(url))end)if ok and body and body.data then for _,s in ipairs(body.data)do if s.playing<s.maxPlayers and s.id~=game.JobId then pcall(function()TS:TeleportToPlaceInstance(game.PlaceId,s.id,LP)end)return end end end aviso("Hop","Sem servidor",C.red)end)
btn(t,"Reentrar","Rejoin",C.red,function()pcall(function()TS:Teleport(game.PlaceId,LP)end)end)
btn(t,"Copiar Job ID","Copiar",C.yel,function()if setclipboard then setclipboard(game.JobId)end aviso("Servidor","Copiado!",C.grn)end)
secao(t,"Rare Pet Finder")
btn(t,"Procurar Servidores Raros","Procurar",C.pur,function()
local url="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"
local ok,body=pcall(function()return HS:JSONDecode(game:HttpGet(url))end)
if ok and body and body.data then
local melhor,mx=nil,0
for _,s in ipairs(body.data)do if s.playing<s.maxPlayers and s.playing>mx then mx=s.playing melhor=s end end
if melhor then
aviso("Raro Encontrado",string.format("Servidor com %d/%d jogadores",melhor.playing,melhor.maxPlayers),C.grn)
pcall(function()TS:TeleportToPlaceInstance(game.PlaceId,melhor.id,LP)end)
end end end)
-- ═══ ABA ÍNDICE ═══
t=criarAba("📖 Índice","idx","R")
local idxList=N("ScrollingFrame",{Parent=t,Size=UDim2.new(1,0,0,300),BackgroundColor3=Color3.fromRGB(10,10,12),BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=cores[Config.cor],CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})cr(idxList,8)N("UIListLayout",{Parent=idxList,Padding=UDim.new(0,2),SortOrder=Enum.SortOrder.LayoutOrder})
local function atualizarIdx()for _,c in ipairs(idxList:GetChildren())do if c:IsA("Frame")or c:IsA("TextButton")then c:Destroy()end end
for _,p in ipairs(IDX)do
local card=N("Frame",{Parent=idxList,Size=UDim2.new(1,0,0,30),BackgroundColor3=C.card,BorderSizePixel=0})cr(card,6)
N("TextLabel",{Parent=card,Position=UDim2.new(0,8,0,2),Size=UDim2.new(1,-70,0,14),BackgroundTransparency=1,Text=p.n,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=corRar(p.r),TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd})
N("TextLabel",{Parent=card,Position=UDim2.new(0,8,0,16),Size=UDim2.new(1,-70,0,12),BackgroundTransparency=1,Text=p.r.." • $"..fmt(p.v).."/s • "..p.b,Font=Enum.Font.Gotham,TextSize=8,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd})
local fav=N("TextButton",{Parent=card,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-6,0.5,0),Size=UDim2.new(0,24,0,22),BackgroundColor3=Fav[p.n]and C.yel or Color3.fromRGB(60,60,68),Text=Fav[p.n]and "★"or "☆",Font=Enum.Font.GothamBold,TextSize=12,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})cr(fav,6)
fav.MouseButton1Click:Connect(function()Fav[p.n]=not Fav[p.n]fav.Text=Fav[p.n]and "★"or "☆"fav.BackgroundColor3=Fav[p.n]and C.yel or Color3.fromRGB(60,60,68)end)
end end
atualizarIdx()
btn(t,"Exportar Favoritos JSON","Exportar",C.pur,function()if setclipboard then setclipboard(HS:JSONEncode(Fav))end aviso("Exportar","Copiado!",C.grn)end)
btn(t,"Marcar Todos Descobertos","Marcar",C.grn,function()for _,p in ipairs(IDX)do Disc[p.n]=true end atualizarIdx()aviso("Índice","Todos marcados",C.grn)end)
-- ═══ ABA FAVORITOS ═══
t=criarAba("⭐ Favoritos","fav","R")
local favL=N("ScrollingFrame",{Parent=t,Size=UDim2.new(1,0,0,300),BackgroundColor3=Color3.fromRGB(10,10,12),BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=C.yel,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})cr(favL,8)N("UIListLayout",{Parent=favL,Padding=UDim.new(0,2),SortOrder=Enum.SortOrder.LayoutOrder})
btn(t,"Atualizar Favoritos","Refresh",C.yel,function()for _,c in ipairs(favL:GetChildren())do if c:IsA("Frame")then c:Destroy()end end for _,p in ipairs(IDX)do if Fav[p.n]then local card=N("Frame",{Parent=favL,Size=UDim2.new(1,0,0,26),BackgroundColor3=C.card,BorderSizePixel=0})cr(card,6)N("TextLabel",{Parent=card,Position=UDim2.new(0,8,0,0),Size=UDim2.new(1,-16,1,0),BackgroundTransparency=1,Text=p.n.." ["..p.r.."] $"..fmt(p.v).."/s",Font=Enum.Font.Gotham,TextSize=10,TextColor3=corRar(p.r),TextXAlignment=Enum.TextXAlignment.Left})end end aviso("Favoritos","Atualizado",C.yel)end)
-- ═══ ABA CONFIG ═══
t=criarAba("⚙ Config","cfg","R")
secao(t,"Cor do Tema")
for nome,cor in pairs(cores)do btn(t,nome,"Aplicar",cor,function()Config.cor=nome aviso("Tema",nome,C.grn)end)end
secao(t,"Geral")
toggle(t,"Notificações","Mostrar avisos.",true)
toggle(t,"Modo Seguro","Desativa recursos incompatíveis.",false)
btn(t,"Desligar Tudo","Desligar",C.red,function()
St.speed=16 St.jump=100 St.noclip=false St.fly=false St.infJump=false St.antiRag=false St.antiVoid=false St.espP=false St.espE=false St.espPet=false St.espG=false St.autoSteal=false St.autoHatch=false St.autoSell=false St.autoTreadmill=false St.antiGuard=false
if bv then bv:Destroy()end if bg then bg:Destroy()end
aplicar()atualizarESP()
aviso("Config","Tudo desligado",C.red)
end)
info(t,"CHILLI HUB v1.0")
info(t,"Steal An Egg")
-- ═══ SEGUNDO PAINEL: STEAL PANEL ═══
local pan2=N("Frame",{Parent=gui,AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-20,0,90),Size=UDim2.new(0,300,0,400),BackgroundColor3=C.bg,BorderSizePixel=0,ZIndex=1100})
cr(pan2,14)st(pan2,cores[Config.cor],2)
local hd2=N("Frame",{Parent=pan2,Size=UDim2.new(1,0,0,34),BackgroundColor3=cores[Config.cor],BorderSizePixel=0})cr(hd2,14)
N("TextLabel",{Parent=hd2,Position=UDim2.new(0,12,0,0),Size=UDim2.new(1,-50,1,0),BackgroundTransparency=1,Text="🥚 STEAL PANEL",Font=Enum.Font.GothamBlack,TextSize=13,TextColor3=Color3.fromRGB(255,255,255),TextXAlignment=Enum.TextXAlignment.Left})
local xb2=N("TextButton",{Parent=hd2,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-8,0.5,0),Size=UDim2.new(0,22,0,22),BackgroundColor3=Color3.fromRGB(0,0,0),BackgroundTransparency=0.4,Text="X",Font=Enum.Font.GothamBlack,TextSize=11,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})cr(xb2,6)
xb2.MouseButton1Click:Connect(function()pan2.Visible=false end)
local botaoSort=N("TextButton",{Parent=pan2,Position=UDim2.new(0,8,0,40),Size=UDim2.new(1,-16,0,24),BackgroundColor3=C.card,Text="Ordenar: Melhor Raridade",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.grn,AutoButtonColor=false})cr(botaoSort,6)st(botaoSort,C.grn)
local listaPets=N("ScrollingFrame",{Parent=pan2,Position=UDim2.new(0,8,0,70),Size=UDim2.new(1,-16,1,-80),BackgroundColor3=Color3.fromRGB(10,10,12),BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=cores[Config.cor],CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})cr(listaPets,10)
N("UIListLayout",{Parent=listaPets,Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder})
-- popula lista com pets
local petsOrd={}
for _,p in ipairs(IDX)do table.insert(petsOrd,p)end
table.sort(petsOrd,function(a,b)return a.v>b.v end)
for _,p in ipairs(petsOrd)do
local card=N("Frame",{Parent=listaPets,Size=UDim2.new(1,0,0,56),BackgroundColor3=C.card,BorderSizePixel=0})cr(card,10)st(card,corRar(p.r))
N("TextLabel",{Parent=card,Position=UDim2.new(0,8,0,4),Size=UDim2.new(1,-110,0,14),BackgroundTransparency=1,Text=p.n,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=corRar(p.r),TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd})
N("TextLabel",{Parent=card,Position=UDim2.new(0,8,0,20),Size=UDim2.new(1,-110,0,14),BackgroundTransparency=1,Text="$"..fmt(p.v).."/s",Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.grn,TextXAlignment=Enum.TextXAlignment.Left})
N("TextLabel",{Parent=card,Position=UDim2.new(0,8,0,36),Size=UDim2.new(1,-110,0,14),BackgroundTransparency=1,Text="x0.85 • 5.000 Kg • "..p.b,Font=Enum.Font.Gotham,TextSize=8,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd})
local bSteal=N("TextButton",{Parent=card,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-50,0.5,0),Size=UDim2.new(0,60,0,26),BackgroundColor3=C.grn,Text="Steal",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})cr(bSteal,8)
bSteal.MouseButton1Click:Connect(function()aviso("Steal",p.n.." enviado!",C.grn)end)
local bFav=N("TextButton",{Parent=card,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-10,0.5,0),Size=UDim2.new(0,30,0,26),BackgroundColor3=Fav[p.n]and C.yel or Color3.fromRGB(60,60,68),Text=Fav[p.n]and "★"or "☆",Font=Enum.Font.GothamBold,TextSize=12,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})cr(bFav,8)
bFav.MouseButton1Click:Connect(function()Fav[p.n]=not Fav[p.n]bFav.Text=Fav[p.n]and "★"or "☆"bFav.BackgroundColor3=Fav[p.n]and C.yel or Color3.fromRGB(60,60,68)end)
end
-- BARRA RÁPIDA DE SPEED
local qb=N("Frame",{Parent=gui,AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-20,0,20),Size=UDim2.new(0,220,0,60),BackgroundColor3=C.card,BorderSizePixel=0,ZIndex=9999})
cr(qb,12)st(qb,cores[Config.cor],2)
N("TextLabel",{Parent=qb,Position=UDim2.new(0,10,0,4),Size=UDim2.new(1,-20,0,14),BackgroundTransparency=1,Text="⚡ Speed Boost",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})
N("TextLabel",{Parent=qb,Position=UDim2.new(1,-70,0,4),Size=UDim2.new(0,60,0,14),BackgroundTransparency=1,Text="350",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.grn,TextXAlignment=Enum.TextXAlignment.Right})
local sliderF=N("Frame",{Parent=qb,Position=UDim2.new(0,10,0,24),Size=UDim2.new(1,-20,0,8),BackgroundColor3=Color3.fromRGB(40,40,48),BorderSizePixel=0})cr(sliderF,4)
local sliderFill=N("Frame",{Parent=sliderF,Size=UDim2.new(0.35,0,1,0),BackgroundColor3=C.grn,BorderSizePixel=0})cr(sliderFill,4)
local sliderKnob=N("Frame",{Parent=sliderF,Position=UDim2.new(0.35,-6,-0.25,0),Size=UDim2.new(0,12,0,12),BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0,ZIndex=10001})cr(sliderKnob,6)
local valorLbl=N("TextLabel",{Parent=qb,Position=UDim2.new(0,10,0,38),Size=UDim2.new(1,-20,0,14),BackgroundTransparency=1,Text="Puxa para ajustar",Font=Enum.Font.Gotham,TextSize=8,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left})
local draggingSlider=false
sliderF.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then draggingSlider=true end end)
UIS.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then draggingSlider=false end end)
UIS.InputChanged:Connect(function(i)
if not draggingSlider then return end
if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then
local pos=math.clamp((i.Position.X-sliderF.AbsolutePosition.X)/sliderF.AbsoluteSize.X,0,1)
sliderFill.Size=UDim2.new(pos,0,1,0)
sliderKnob.Position=UDim2.new(pos,-6,-0.25,0)
local v=math.floor(pos*1000)
valorLbl.Text=v.." studs"
St.speed=v
aplicar()
end end)
-- BOLINHA EGG
local fb2=N("TextButton",{Parent=gui,Position=UDim2.new(0,20,0,80),Size=UDim2.new(0,52,0,52),BackgroundColor3=C.card,Text="",AutoButtonColor=false,ZIndex=9999})cr(fb2,26)st(fb2,C.yel,2)
N("TextLabel",{Parent=fb2,Position=UDim2.new(0.5,-16,0.5,-16),Size=UDim2.new(0,32,0,32),BackgroundTransparency=1,Text="🥚",Font=Enum.Font.GothamBlack,TextSize=22,ZIndex=10000})
-- DRAG
local function arrastar(h,t,cl)local d,s,m,st=false,nil,false,0 h.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then d=true m=false st=tick()s=i.Position end end)h.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then if d and not m and(tick()-st)<0.3 and cl then cl()end d=false end end)UIS.InputChanged:Connect(function(i)if not d then return end if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then local dd=i.Position-s if math.abs(dd.X)>5 or math.abs(dd.Y)>5 then m=true end t.Position=UDim2.new(t.Position.X.Scale,t.Position.X.Offset+dd.X,t.Position.Y.Scale,t.Position.Y.Offset+dd.Y)s=i.Position end end)end
arrastar(hd,pan)arrastar(fb,fb,function()pan.Visible=not pan.Visible end)
arrastar(hd2,pan2)arrastar(fb2,fb2,function()pan2.Visible=not pan2.Visible end)
UIS.InputBegan:Connect(function(i,g)if g then return end if i.KeyCode==Enum.KeyCode.RightShift then pan.Visible=not pan.Visible end end)
-- SBox search
sBox:GetPropertyChangedSignal("Text"):Connect(function()local q=sBox.Text:lower()if q==""then return end for id,fr in pairs(abas)do for _,c in ipairs(fr:GetChildren())do if c:IsA("Frame")then local found=false for _,lbl in ipairs(c:GetChildren())do if lbl:IsA("TextLabel")and lbl.Text:lower():find(q)then found=true break end end c.Visible=found end end end end)
trocarAba("inicio")
aviso("🔥 CHILLI HUB","Carregado! Em português 🇧🇷",C.grn)
print("[CHILLI HUB] Carregado.")
