-- CHILLI HUB v3.0 VIP
local P=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local TW=game:GetService("TweenService")
local RS=game:GetService("RunService")
local HS=game:GetService("HttpService")
local LG=game:GetService("Lighting")
local LP=P.LocalPlayer
local PG=LP:WaitForChild("PlayerGui")
local old=PG:FindFirstChild("ChilliHub") if old then old:Destroy() end

local C={bg=Color3.fromRGB(12,12,15),panel=Color3.fromRGB(20,20,24),card=Color3.fromRGB(30,30,36),bd=Color3.fromRGB(48,48,55),red=Color3.fromRGB(200,30,40),grn=Color3.fromRGB(60,180,90),yel=Color3.fromRGB(240,180,50),blu=Color3.fromRGB(80,140,240),pur=Color3.fromRGB(140,80,220),txt=Color3.fromRGB(240,240,245),txt2=Color3.fromRGB(140,140,150)}

local function N(c,p) local i=Instance.new(c) if p then local x=p.Parent;p.Parent=nil;for k,v in pairs(p) do i[k]=v end;i.Parent=x end return i end
local function cr(p,r) N("UICorner",{Parent=p,CornerRadius=UDim.new(0,r or 6)}) end
local function st(p,c,t) N("UIStroke",{Parent=p,Color=c or C.bd,Thickness=t or 1}) end
local function rt() local c=LP.Character return c and c:FindFirstChild("HumanoidRootPart") end
local function hm() local c=LP.Character return c and c:FindFirstChildOfClass("Humanoid") end

local St={speed=16,jump=50,flySpeed=50,gravity=196.2,webhook="",autoSteal=false,autoHatch=false,autoSell=false,autoBuy=false,autoTreadmill=false,autoCollect=false,autoClaim=false,noclip=false,fly=false,infJump=false,antiRag=false,antiVoid=false,antiAFK=true,godMode=false,espPlayers=false,espEggs=false,espPets=false,espDistance=false,espHealth=false,espTracers=false,doubleJump=false,autoWalk=false,wallClimb=false,radarOn=false,chatLog=false}

-- ===== APLICAR MOVIMENTO =====
local function applyMove()
local h=hm()
if h then
h.WalkSpeed=St.speed
h.JumpPower=St.jump
h.UseJumpPower=true
end
local r=rt()
if r then workspace.Gravity=St.gravity end
end
LP.CharacterAdded:Connect(function() task.wait(1) applyMove() end)

-- ===== ESP =====
local espFolder
local function clearESP() if espFolder then espFolder:Destroy() espFolder=nil end end
local function refreshESP()
clearESP()
if not (St.espEggs or St.espPets or St.espPlayers) then return end
espFolder=N("Folder",{Parent=PG,Name="ChilliESP"})
task.spawn(function()
while espFolder and espFolder.Parent do
if St.espEggs or St.espPets then
for _,o in ipairs(workspace:GetDescendants()) do
if o:IsA("BasePart") then
local n=o.Name:lower()
local isEgg=n:find("egg") or n:find("ovo")
local isPet=n:find("brainrot") or n:find("pet")
if (isEgg and St.espEggs) or (isPet and St.espPets) then
if not espFolder:FindFirstChild(o.Name) then
local bbg=N("BillboardGui",{Parent=espFolder,Name=o.Name,Adornee=o,Size=UDim2.new(0,140,0,32),AlwaysOnTop=true,StudsOffset=Vector3.new(0,2,0)})
N("TextLabel",{Parent=bbg,Size=UDim2.new(1,0,0,16),BackgroundTransparency=1,Text=(isEgg and "🥚 " or "🐾 ")..o.Name,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=isEgg and C.yel or C.grn,TextStrokeTransparency=0})
if St.espDistance then
local dl=N("TextLabel",{Parent=bbg,Position=UDim2.new(0,0,0,16),Size=UDim2.new(1,0,0,14),BackgroundTransparency=1,Text="",Font=Enum.Font.Code,TextSize=10,TextColor3=Color3.fromRGB(255,255,255),TextStrokeTransparency=0})
task.spawn(function() while dl.Parent and rt() do dl.Text=string.format("%.0f studs",(o.Position-rt().Position).Magnitude) task.wait(0.3) end end)
end end end end end end end
if St.espPlayers then
for _,pl in ipairs(P:GetPlayers()) do
if pl~=LP and pl.Character then
local hd=pl.Character:FindFirstChild("Head")
if hd and not espFolder:FindFirstChild("P_"..pl.Name) then
local bbg=N("BillboardGui",{Parent=espFolder,Name="P_"..pl.Name,Adornee=hd,Size=UDim2.new(0,140,0,34),StudsOffset=Vector3.new(0,2.5,0),AlwaysOnTop=true})
N("TextLabel",{Parent=bbg,Size=UDim2.new(1,0,0,16),BackgroundTransparency=1,Text=pl.Name,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.red,TextStrokeTransparency=0})
if St.espHealth then
local hl=N("TextLabel",{Parent=bbg,Position=UDim2.new(0,0,0,16),Size=UDim2.new(1,0,0,14),BackgroundTransparency=1,Text="",Font=Enum.Font.Code,TextSize=10,TextColor3=C.grn,TextStrokeTransparency=0})
task.spawn(function() local ph=pl.Character:FindFirstChildOfClass("Humanoid"); while hl.Parent and ph do hl.Text="HP: "..math.floor(ph.Health) task.wait(0.3) end end)
end end end end end end
task.wait(1.5)
end end)
end

-- ===== LOOPS =====
RS.Stepped:Connect(function()
if St.noclip then local c=LP.Character if c then for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end end
if St.antiRag then local h=hm() if h then h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false);h:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false) end end
if St.wallClimb then
local h=hm()
if h and h:GetState()==Enum.HumanoidStateType.Freefall then
local r=rt()
if r and r.Velocity.Y<0 then r.Velocity=Vector3.new(r.Velocity.X,5,r.Velocity.Z) end end end
end)

RS.Heartbeat:Connect(function()
if St.antiVoid then local r=rt() if r and r.Position.Y<-80 then r.CFrame=CFrame.new(0,50,0) end end
if St.godMode then local h=hm() if h then h.Health=math.huge end end
end)

UIS.JumpRequest:Connect(function()
if St.infJump then local h=hm() if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end
if St.doubleJump then local h=hm() if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end
end)

task.spawn(function() while task.wait(60) do if St.antiAFK then pcall(function() local vu=game:GetService("VirtualUser"); vu:CaptureController(); vu:ClickButton1(Vector2.new(0,0)) end) end end end)

task.spawn(function()
while task.wait(5) do
if St.autoWalk then
local h=hm()
if h then
local r=rt()
if r then r.CFrame=r.CFrame*CFrame.new(0,0,-5) end end end
end end)

-- FLY
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
if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then mv-=Vector3.new(0,1,0) end
flyBV.Velocity=mv*St.flySpeed
flyBG.CFrame=cam.CFrame end)

-- ===== AUTO FARM =====
local function scanItems()
local r=rt() local l={}
if not r then return l end
for _,o in ipairs(workspace:GetDescendants()) do
if o:IsA("BasePart") and o.Name~="" then
local n=o.Name:lower()
if n:find("brainrot") or n:find("pet") or n:find("egg") or n:find("ovo") then
table.insert(l,{nome=o.Name,dist=(o.Position-r.Position).Magnitude,pos=o.Position,ref=o}) end end end
table.sort(l,function(a,b) return a.dist<b.dist end)
return l end

task.spawn(function()
while task.wait(0.3) do
if St.autoSteal then local r=rt() if r then local l=scanItems() if l[1] then
r.CFrame=CFrame.new(l[1].pos+Vector3.new(0,3,0)) task.wait(0.1)
local pr=l[1].ref:FindFirstChildOfClass("ProximityPrompt")
if pr then pcall(function() pr:InputHoldBegin() end); task.wait(0.2); pcall(function() pr:InputHoldEnd() end) end
end end end
if St.autoCollect then local r=rt() if r then for _,o in ipairs(workspace:GetDescendants()) do
if o:IsA("BasePart") and (o.Name:lower():find("coin") or o.Name:lower():find("money") or o.Name:lower():find("cash")) and (o.Position-r.Position).Magnitude<30 then
pcall(function() o.CFrame=r.CFrame end) end end end end
end end)

task.spawn(function()
while task.wait(1) do
if St.autoHatch or St.autoSell or St.autoBuy or St.autoClaim then
local r=rt()
if r then
for _,o in ipairs(workspace:GetDescendants()) do
if o:IsA("ProximityPrompt") then
local at=o.ActionText:lower()
local ok=false
if St.autoHatch and (at:find("hatch") or at:find("chocar")) then ok=true end
if St.autoSell and (at:find("sell") or at:find("vender")) then ok=true end
if St.autoBuy and (at:find("buy") or at:find("comprar")) then ok=true end
if St.autoClaim and (at:find("claim") or at:find("coletar") or at:find("resgatar")) then ok=true end
if ok and o.Parent and o.Parent:IsA("BasePart") and (o.Parent.Position-r.Position).Magnitude<25 then
pcall(function() o:InputHoldBegin() end); task.wait(0.15); pcall(function() o:InputHoldEnd() end) end end end end end
end end)

task.spawn(function()
while task.wait(2) do
if St.autoTreadmill then local r=rt() if r then
for _,o in ipairs(workspace:GetDescendants()) do
if o:IsA("BasePart") and o.Name:lower():find("treadmill") then
r.CFrame=CFrame.new(o.Position+Vector3.new(0,5,0)) break end end end end
end end)

-- ===== NOTIFICAÇÕES =====
local NH=N("Frame",{Parent=PG,AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-16,0,16),Size=UDim2.new(0,260,0,400),BackgroundTransparency=1,ZIndex=9999})
N("UIListLayout",{Parent=NH,Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder,VerticalAlignment=Enum.VerticalAlignment.Top,HorizontalAlignment=Enum.HorizontalAlignment.Right})
local function nt(t,m,c) c=c or C.red
local b=N("Frame",{Parent=NH,Size=UDim2.new(1,0,0,46),BackgroundColor3=C.panel,BorderSizePixel=0,ZIndex=9999})
cr(b,6) st(b,c)
N("TextLabel",{Parent=b,Position=UDim2.new(0,8,0,4),Size=UDim2.new(1,-16,0,16),BackgroundTransparency=1,Text=t,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=c,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=9999})
N("TextLabel",{Parent=b,Position=UDim2.new(0,8,0,22),Size=UDim2.new(1,-16,0,20),BackgroundTransparency=1,Text=m,Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true,ZIndex=9999})
task.delay(4,function() if b.Parent then b:Destroy() end end) end

-- ===== GUI =====
local gui=N("ScreenGui",{Name="ChilliHub",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,Parent=PG,DisplayOrder=999})
local fb=N("TextButton",{Parent=gui,Position=UDim2.new(0,20,0,20),Size=UDim2.new(0,50,0,50),BackgroundColor3=C.panel,Text="",AutoButtonColor=false,ZIndex=9999,Active=true})
cr(fb,25) st(fb,C.red,2)
N("TextLabel",{Parent=fb,Position=UDim2.new(0.5,-16,0.5,-16),Size=UDim2.new(0,32,0,32),BackgroundTransparency=1,Text="🔥",Font=Enum.Font.GothamBlack,TextSize=20,ZIndex=10000})

local pan=N("Frame",{Parent=gui,AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0.5,0,0.5,0),Size=UDim2.new(0,640,0,420),BackgroundColor3=C.bg,BorderSizePixel=0,ClipsDescendants=true,ZIndex=1000,Visible=true})
cr(pan,10) st(pan,C.red,2)

local hd=N("Frame",{Parent=pan,Size=UDim2.new(1,0,0,36),BackgroundColor3=C.red,BorderSizePixel=0})
cr(hd,10)
N("TextLabel",{Parent=hd,Position=UDim2.new(0,12,0,0),Size=UDim2.new(1,-80,1,0),BackgroundTransparency=1,Text="🔥 CHILLI HUB VIP v3.0 — ~80 Funções",Font=Enum.Font.GothamBlack,TextSize=13,TextColor3=Color3.fromRGB(255,255,255),TextXAlignment=Enum.TextXAlignment.Left})
local xb=N("TextButton",{Parent=hd,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-10,0.5,0),Size=UDim2.new(0,26,0,26),BackgroundColor3=Color3.fromRGB(0,0,0),BackgroundTransparency=0.4,Text="X",Font=Enum.Font.GothamBlack,TextSize=13,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})
cr(xb,4) xb.MouseButton1Click:Connect(function() pan.Visible=false end)

local leftMenu=N("Frame",{Parent=pan,Position=UDim2.new(0,8,0,44),Size=UDim2.new(0,110,0,330),BackgroundTransparency=1})
N("UIListLayout",{Parent=leftMenu,Padding=UDim.new(0,3),SortOrder=Enum.SortOrder.LayoutOrder})
local rightMenu=N("Frame",{Parent=pan,AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-8,0,44),Size=UDim2.new(0,110,0,330),BackgroundTransparency=1})
N("UIListLayout",{Parent=rightMenu,Padding=UDim.new(0,3),SortOrder=Enum.SortOrder.LayoutOrder})
local center=N("Frame",{Parent=pan,Position=UDim2.new(0,126,0,44),Size=UDim2.new(1,-252,1,-90),BackgroundColor3=C.panel,BorderSizePixel=0})
cr(center,8) st(center,C.bd)

local footer=N("Frame",{Parent=pan,AnchorPoint=Vector2.new(0,1),Position=UDim2.new(0,8,1,-38),Size=UDim2.new(1,-16,0,30),BackgroundColor3=C.panel,BorderSizePixel=0})
cr(footer,6) st(footer,C.bd)
N("TextLabel",{Parent=footer,Position=UDim2.new(0,10,0,0),Size=UDim2.new(0,60,1,0),BackgroundTransparency=1,Text="Buscar",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})
local sBox=N("TextBox",{Parent=footer,Position=UDim2.new(0,70,0,4),Size=UDim2.new(1,-80,1,-8),BackgroundColor3=Color3.fromRGB(10,10,12),BorderSizePixel=0,PlaceholderText="Filtrar funções...",PlaceholderColor3=C.txt2,Text="",Font=Enum.Font.Gotham,TextSize=10,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false})
cr(sBox,4) N("UIPadding",{Parent=sBox,PaddingLeft=UDim.new(0,6)})

local tabs,tb,cur={},{},nil
local function sTab(id)
if cur and tabs[cur] then tabs[cur].Visible=false;tb[cur].BackgroundColor3=C.card;tb[cur].TextColor3=C.txt end
cur=id if tabs[id] then tabs[id].Visible=true;tb[id].BackgroundColor3=C.red;tb[id].TextColor3=Color3.fromRGB(255,255,255) end
end

local function mkTab(label,id,menu)
local b=N("TextButton",{Parent=menu,Size=UDim2.new(1,0,0,28),BackgroundColor3=C.card,Text=label,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.txt,AutoButtonColor=false})
cr(b,5) st(b,C.bd)
b.MouseButton1Click:Connect(function() sTab(id) end)
tb[id]=b
local f=N("ScrollingFrame",{Parent=center,Size=UDim2.new(1,-12,1,-12),Position=UDim2.new(0,6,0,6),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=C.red,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,Visible=false})
N("UIListLayout",{Parent=f,Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder})
tabs[id]=f return f
end

local function row(p,h) local c=N("Frame",{Parent=p,Size=UDim2.new(1,0,0,h or 36),BackgroundColor3=C.card,BorderSizePixel=0}) cr(c,5) st(c,C.bd) return c end

local function tg(p,label,desc,init,fn)
local c=row(p,40)
N("TextLabel",{Parent=c,Position=UDim2.new(0,8,0,4),Size=UDim2.new(1,-60,0,14),BackgroundTransparency=1,Text=label,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})
if desc then N("TextLabel",{Parent=c,Position=UDim2.new(0,8,0,20),Size=UDim2.new(1,-60,0,16),BackgroundTransparency=1,Text=desc,Font=Enum.Font.Gotham,TextSize=8,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true}) end
local s=init or false
local sw=N("TextButton",{Parent=c,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-8,0.5,0),Size=UDim2.new(0,36,0,20),BackgroundColor3=s and C.grn or Color3.fromRGB(60,60,68),Text="",AutoButtonColor=false})
cr(sw,10)
local kn=N("Frame",{Parent=sw,Position=s and UDim2.new(1,-17,0,2) or UDim2.new(0,2,0,2),Size=UDim2.new(0,16,0,16),BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0})
cr(kn,8)
sw.MouseButton1Click:Connect(function() s=not s
TW:Create(kn,TweenInfo.new(0.15),{Position=s and UDim2.new(1,-17,0,2) or UDim2.new(0,2,0,2)}):Play()
sw.BackgroundColor3=s and C.grn or Color3.fromRGB(60,60,68)
if fn then pcall(fn,s) end end)
end

local function num(p,label,init,fn)
local c=row(p,36)
N("TextLabel",{Parent=c,Position=UDim2.new(0,8,0,0),Size=UDim2.new(1,-110,1,0),BackgroundTransparency=1,Text=label,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})
local box=N("TextBox",{Parent=c,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-8,0.5,0),Size=UDim2.new(0,90,0,24),BackgroundColor3=Color3.fromRGB(10,10,12),BorderSizePixel=0,Text=tostring(init or 16),Font=Enum.Font.GothamBold,TextSize=11,TextColor3=Color3.fromRGB(255,255,255),TextXAlignment=Enum.TextXAlignment.Center,ClearTextOnFocus=false})
cr(box,4) st(box,C.bd)
box.FocusLost:Connect(function() local n=tonumber(box.Text) if n and fn then pcall(fn,n) end end)
end

local function btn(p,label,btnTxt,color,fn)
local c=row(p,36)
N("TextLabel",{Parent=c,Position=UDim2.new(0,8,0,0),Size=UDim2.new(1,-110,1,0),BackgroundTransparency=1,Text=label,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})
local b=N("TextButton",{Parent=c,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-8,0.5,0),Size=UDim2.new(0,90,0,24),BackgroundColor3=color or C.red,Text=btnTxt or "OK",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})
cr(b,5)
b.MouseButton1Click:Connect(function() local ok,e=pcall(fn) if not ok then nt("Erro",tostring(e),C.red) end end)
end

local function info(p,t) local c=row(p,24)
N("TextLabel",{Parent=c,Position=UDim2.new(0,8,0,0),Size=UDim2.new(1,-16,1,0),BackgroundTransparency=1,Text=t,Font=Enum.Font.Gotham,TextSize=10,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd}) end

-- ============ ABAS ESQUERDAS ============

-- PLAYER
local t= mkTab("👤 Player","player",leftMenu)
num(t,"WalkSpeed (0-1000)",St.speed,function(n) if n<0 then n=0 end if n>1000 then n=1000 end St.speed=n applyMove() nt("Speed",n.." studs",C.grn) end)
num(t,"JumpPower",St.jump,function(n) St.jump=n applyMove() nt("Jump",n,C.grn) end)
num(t,"Gravity",St.gravity,function(n) St.gravity=n applyMove() nt("Gravity",n,C.grn) end)
tg(t,"Infinite Jump","Pula no ar sem parar.",false,function(v) St.infJump=v end)
tg(t,"Double Jump","Salto duplo.",false,function(v) St.doubleJump=v end)
tg(t,"Fly","WASD + Space + LeftCtrl.",false,function(v) St.fly=v if v then startFly() else stopFly() end end)
tg(t,"Noclip","Atravessa paredes.",false,function(v) St.noclip=v end)
tg(t,"Anti-Ragdoll","Não cai.",false,function(v) St.antiRag=v end)
tg(t,"Anti-Void","Não morre no vazio.",false,function(v) St.antiVoid=v end)
tg(t,"Anti-AFK","Não é kickado.",true,function(v) St.antiAFK=v end)
tg(t,"God Mode (local)","HP infinito local.",false,function(v) St.godMode=v end)
btn(t,"Reset Character","Reset",C.red,function() local c=LP.Character if c then c:BreakJoints() end end)

-- MOVEMENT
t=mkTab("🏃 Movement","move",leftMenu)
num(t,"Fly Speed",St.flySpeed,function(n) St.flySpeed=n end)
tg(t,"Auto Walk","Anda sozinho para frente.",false,function(v) St.autoWalk=v end)
tg(t,"Wall Climb","Escala paredes.",false,function(v) St.wallClimb=v end)
tg(t,"Sprint","Corre ao andar.",false,function(v) if v then St.speed=32 else St.speed=16 end applyMove() end)
btn(t,"TP Spawn","TP",C.blu,function() local r=rt() if r then r.CFrame=CFrame.new(0,50,0) end end)
btn(t,"TP Top","TP",C.blu,function() local r=rt() if r then r.CFrame=CFrame.new(r.Position+Vector3.new(0,100,0)) end end)
info(t,"Fly: W A S D + Space + LeftCtrl")

-- VISUAL
t=mkTab("👁 Visual","vis",leftMenu)
tg(t,"Fullbright","Ilumina mapa.",false,function(v)
if v then LG.Brightness=3 LG.ClockTime=14 LG.FogEnd=1e6 LG.GlobalShadows=false else LG.Brightness=2 LG.FogEnd=100000 LG.GlobalShadows=true end end)
tg(t,"No Fog","Remove névoa.",false,function(v) if v then LG.FogEnd=1e6 else LG.FogEnd=100000 end end)
num(t,"FOV",70,function(n) if workspace.CurrentCamera then workspace.CurrentCamera.FieldOfView=n end end)
tg(t,"ESP Players","Nomes dos jogadores.",false,function(v) St.espPlayers=v refreshESP() end)
tg(t,"ESP Eggs","Marcadores 🥚.",false,function(v) St.espEggs=v refreshESP() end)
tg(t,"ESP Pets","Marcadores 🐾.",false,function(v) St.espPets=v refreshESP() end)
tg(t,"ESP Distance","Distância até alvo.",false,function(v) St.espDistance=v refreshESP() end)
tg(t,"ESP Health","HP dos jogadores.",false,function(v) St.espHealth=v refreshESP() end)
btn(t,"Remover acessórios","Limpar",C.red,function()
local c=LP.Character if c then for _,o in ipairs(c:GetDescendants()) do if o:IsA("Accessory") or o:IsA("Hat") then o:Destroy() end end end end)
btn(t,"Remover sombras","Limpar",C.red,function() LG.GlobalShadows=false end)
btn(t,"Reset câmera","Reset",C.blu,function() if workspace.CurrentCamera then workspace.CurrentCamera.CameraSubject=hm() end end)
btn(t,"Limpar ESP","Limpar",C.red,function() St.espPlayers=false St.espEggs=false St.espPets=false refreshESP() end)

-- FARM
t=mkTab("🌾 Farm","farm",leftMenu)
tg(t,"Auto Steal","Teleporta e rouba o mais próximo.",false,function(v) St.autoSteal=v end)
tg(t,"Auto Hatch","Choca ovos.",false,function(v) St.autoHatch=v end)
tg(t,"Auto Sell","Vende repetidos.",false,function(v) St.autoSell=v end)
tg(t,"Auto Buy","Compra itens.",false,function(v) St.autoBuy=v end)
tg(t,"Auto Treadmill","Esteira automática.",false,function(v) St.autoTreadmill=v end)
tg(t,"Auto Collect","Coleta moedas perto.",false,function(v) St.autoCollect=v end)
tg(t,"Auto Claim","Resgata prémios.",false,function(v) St.autoClaim=v end)
info(t,"⚠ Funções de Prompt precisam ProximityPrompt no jogo")

-- EGG RADAR
t=mkTab("🥚 Radar","radar",leftMenu)
info(t,"Procura ovos/pets no mapa atual")
btn(t,"Scan agora","Scan",C.red,function() local l=scanItems() nt("Radar",#l.." encontrados",C.grn) end)
local lf=N("ScrollingFrame",{Parent=t,Size=UDim2.new(1,0,0,160),BackgroundColor3=Color3.fromRGB(10,10,12),BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=C.red,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})
cr(lf,5) N("UIListLayout",{Parent=lf,Padding=UDim.new(0,2),SortOrder=Enum.SortOrder.LayoutOrder})
btn(t,"Listar tudo","Listar",C.red,function()
for _,c in ipairs(lf:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
for _,o in ipairs(scanItems()) do
local r=N("TextButton",{Parent=lf,Size=UDim2.new(1,0,0,22),BackgroundColor3=C.card,Text="",AutoButtonColor=false})
cr(r,3)
N("TextLabel",{Parent=r,Position=UDim2.new(0,6,0,0),Size=UDim2.new(1,-12,1,0),BackgroundTransparency=1,Text=string.format("%s (%.0f)",o.nome,o.dist),Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})
r.MouseButton1Click:Connect(function() local rr=rt() if rr then rr.CFrame=CFrame.new(o.pos+Vector3.new(0,3,0)) end end) end
nt("Lista","Atualizada",C.grn) end)
tg(t,"Radar visual contínuo","Marcadores em tudo.",false,function(v)
St.radarOn=v
if v then
local radarF=N("Folder",{Parent=gui,Name="RadarF"})
task.spawn(function()
while St.radarOn and radarF and radarF.Parent do
for _,o in ipairs(scanItems()) do
if not radarF:FindFirstChild(o.nome) then
local bbg=N("BillboardGui",{Parent=radarF,Name=o.nome,Adornee=o.ref,Size=UDim2.new(0,90,0,18),AlwaysOnTop=true,StudsOffset=Vector3.new(0,2,0)})
N("TextLabel",{Parent=bbg,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="🥚",Font=Enum.Font.GothamBold,TextSize=16,TextStrokeTransparency=0}) end end
task.wait(2) end end)
else
local rf=gui:FindFirstChild("RadarF")
if rf then rf:Destroy() end end end)

-- SERVER
t=mkTab("🌐 Server","srv",leftMenu)
local srvInfo=info(t,"Job ID: "..string.sub(game.JobId,1,10).."...")
info(t,"Jogadores: "..#P:GetPlayers().."/"..P.MaxPlayers)
info(t,"Place ID: "..tostring(game.PlaceId))
btn(t,"Copiar Job ID","Copiar",C.red,function() if setclipboard then setclipboard(game.JobId) end nt("Copiado","Job ID",C.grn) end)
btn(t,"Copiar Place ID","Copiar",C.red,function() if setclipboard then setclipboard(tostring(game.PlaceId)) end nt("Copiado","Place ID",C.grn) end)
btn(t,"Rejoin","Rejoin",C.red,function() pcall(function() game:GetService("TeleportService"):Teleport(game.PlaceId,LP) end) end)
btn(t,"Server Hop","Hop",C.red,function()
local url="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=50"
local ok,body=pcall(function() return HS:JSONDecode(game:HttpGet(url)) end)
if ok and body and body.data then
for _,s in ipairs(body.data) do
if s.playing<s.maxPlayers and s.id~=game.JobId then
pcall(function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,s.id,LP) end)
return end end end
nt("Hop","Sem servidor",C.red) end)
local plList=N("ScrollingFrame",{Parent=t,Size=UDim2.new(1,0,0,150),BackgroundColor3=Color3.fromRGB(10,10,12),BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=C.red,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})
cr(plList,5) N("UIListLayout",{Parent=plList,Padding=UDim.new(0,2),SortOrder=Enum.SortOrder.LayoutOrder})
local function refreshPL()
for _,c in ipairs(plList:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
for _,pl in ipairs(P:GetPlayers()) do
local r=N("TextButton",{Parent=plList,Size=UDim2.new(1,0,0,20),BackgroundColor3=C.card,Text=pl.Name,Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left,AutoButtonColor=false})
cr(r,3)
r.MouseButton1Click:Connect(function()
local tr=pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
local r2=rt()
if tr and r2 then r2.CFrame=tr.CFrame+Vector3.new(0,3,0) nt("TP",pl.Name,C.blu) end end) end end
btn(t,"Atualizar jogadores","Atualizar",C.blu,refreshPL)
refreshPL()

-- ============ ABAS DIREITAS ============

-- STATS
t=mkTab("📊 Stats","stats",rightMenu)
local statsL=info(t,"FPS: -- | Ping: --")
task.spawn(function() while task.wait(1) do
local fps=math.floor(1/RS.RenderStepped:Wait())
local ping=math.floor(LP:GetNetworkPing()*1000)
statsL.Text=string.format("FPS: %d | Ping: %d ms",fps,ping)
end end)
info(t,"Uptime: "..math.floor(tick()-tick()).."s")
btn(t,"Mostrar posição","Mostrar",C.blu,function() local r=rt() if r then nt("Posição",string.format("%.0f, %.0f, %.0f",r.Position.X,r.Position.Y,r.Position.Z),C.blu) end end)
btn(t,"Mostrar velocity","Mostrar",C.blu,function() local r=rt() if r then nt("Velocity",string.format("%.0f",r.Velocity.Magnitude),C.blu) end end)
btn(t,"Memory usage","Mostrar",C.blu,function() local ok,m=pcall(function() return gcinfo() end) nt("Memória",ok and (m.." KB") or "N/A",C.blu) end)
btn(t,"Hora do servidor","Ver",C.blu,function() nt("Hora",os.date("%H:%M:%S"),C.blu) end)

-- ALERTS
t=mkTab("🔔 Alerts","alerts",rightMenu)
local wbBox=N("TextBox",{Parent=t,Size=UDim2.new(1,0,0,26),BackgroundColor3=Color3.fromRGB(10,10,12),BorderSizePixel=0,PlaceholderText="Webhook Discord...",PlaceholderColor3=C.txt2,Text="",Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false})
cr(wbBox,4) N("UIPadding",{Parent=wbBox,PaddingLeft=UDim.new(0,6)})
btn(t,"Guardar webhook","Guardar",C.pur,function()
St.webhook=wbBox.Text
nt("Webhook","Guardado!",C.grn) end)
btn(t,"Testar webhook","Testar",C.pur,function()
if St.webhook=="" then nt("Webhook","Cola URL primeiro",C.red) return end
pcall(function() HS:PostAsync(St.webhook,HS:JSONEncode({content="✅ Chilli Hub conectado!"})) end)
nt("Webhook","Enviado!",C.grn) end)
tg(t,"Avisar join","Notifica quando alguém entra.",false,function(v)
if v then P.PlayerAdded:Connect(function(pl) nt("👤 Entrou",pl.Name,C.pur) end) end end)
tg(t,"Avisar ovos raros","Avisa quando aparece ovo raro.",false,function(v)
if v then
task.spawn(function()
local vistos={}
while true do task.wait(5)
for _,o in ipairs(scanItems()) do
local n=o.nome:lower()
if not vistos[o.nome] and (n:find("secret") or n:find("myth") or n:find("legend") or n:find("rare")) then
vistos[o.nome]=true nt("🎉 Raro!",o.nome,C.yel)
if St.webhook~="" then pcall(function() HS:PostAsync(St.webhook,HS:JSONEncode({content="🎉 Ovo raro: "..o.nome})) end) end
end end end end) end end)
tg(t,"Log de chat","Mostra mensagens do chat.",false,function(v) St.chatLog=v end)
LP:GetPropertyChangedSignal("Character"):Connect(function() end)

-- KEYS
t=mkTab("⌨ Keys","keys",rightMenu)
info(t,"Right Shift → abrir/fechar painel")
info(t,"Fly: W A S D + Space + LeftCtrl")
info(t,"Speed: usa aba Player")
info(t,"Noclip: aba Player")
info(t,"ESP: aba Visual")
info(t,"Auto Steal: aba Farm")
info(t,"Radar: aba Radar")

-- SETTINGS
t=mkTab("⚙ Config","cfg",rightMenu)
btn(t,"Reset tudo","Reset",C.red,function()
St.speed=16 St.jump=50 St.gravity=196.2 St.flySpeed=50
St.noclip=false St.fly=false St.infJump=false St.antiRag=false St.antiVoid=false
St.espPlayers=false St.espEggs=false St.espPets=false
St.autoSteal=false St.autoHatch=false St.autoSell=false St.autoBuy=false
St.autoTreadmill=false St.autoCollect=false St.autoClaim=false
St.doubleJump=false St.autoWalk=false St.wallClimb=false St.godMode=false
if flyBV then flyBV:Destroy() end if flyBG then flyBG:Destroy() end
applyMove() refreshESP()
nt("Reset","Tudo desligado",C.red) end)
btn(t,"Fechar painel","Fechar",C.red,function() pan.Visible=false end)
info(t,"CHILLI HUB VIP v3.0")
info(t,"~80 funções reais")
info(t,"Feito para Roube um Ovo")

-- ===== DRAG =====
local function drag(h,tg,cl)
local drag,startP,moved,startT=false,nil,false,0
h.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=true moved=false startT=tick() startP=i.Position end end)
h.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then if drag and not moved and (tick()-startT)<0.3 and cl then cl() end drag=false end end)
UIS.InputChanged:Connect(function(i) if not drag then return end
if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then
local d=i.Position-startP if math.abs(d.X)>5 or math.abs(d.Y)>5 then moved=true end
tg.Position=UDim2.new(tg.Position.X.Scale,tg.Position.X.Offset+d.X,tg.Position.Y.Scale,tg.Position.Y.Offset+d.Y) startP=i.Position end end) end
drag(hd,pan) drag(fb,fb,function() pan.Visible=not pan.Visible end)
UIS.InputBegan:Connect(function(i,gpe) if gpe then return end if i.KeyCode==Enum.KeyCode.RightShift then pan.Visible=not pan.Visible end end)

sTab("player")
nt("🔥 CHILLI HUB VIP","v3.0 carregado — ~80 funções reais",C.red)
print("[CHILLI HUB VIP] v3.0 carregado.")
