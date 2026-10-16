-- FANTASCRIPT — Steal An Egg
local P=game:GetService("Players")local LP=P.LocalPlayer local PG=LP:WaitForChild("PlayerGui")
local UIS=game:GetService("UserInputService")local RS=game:GetService("RunService")
local LG=game:GetService("Lighting")local HS=game:GetService("HttpService")local TS=game:GetService("TeleportService")
local old=PG:FindFirstChild("FantaScript")if old then old:Destroy()end
local RED=Color3.fromRGB(200,30,40)local RED2=Color3.fromRGB(150,20,30)local BG=Color3.fromRGB(15,12,15)local CARD=Color3.fromRGB(28,22,28)local BORDER=Color3.fromRGB(60,30,35)local TXT=Color3.fromRGB(240,235,240)local TXT2=Color3.fromRGB(160,140,150)
local function N(c,p)local i=Instance.new(c)if p then local x=p.Parent;p.Parent=nil;for k,v in pairs(p)do i[k]=v end;i.Parent=x end return i end
local function cr(p,r)N("UICorner",{Parent=p,CornerRadius=UDim.new(0,r or 8)})end
local function st(p,c)N("UIStroke",{Parent=p,Color=c or BORDER,Thickness=1})end
local function rt()local c=LP.Character return c and c:FindFirstChild("HumanoidRootPart")end
local function hm()local c=LP.Character return c and c:FindFirstChildOfClass("Humanoid")end
local St={speed=16,jump=100,fly=false,noclip=false,infJump=false,antiRag=false,invis=false,espEggs=false,espPlayers=false,autoSteal=false,autoHatch=false,autoSell=false,autoPlace=false,autoFuse=false,autoTreadmill=false,autoClaim=false,autoUpgrade=false,antiAFK=true,antiCap=false}
local function aplicar()local h=hm()if h then h.WalkSpeed=St.speed h.JumpPower=St.jump h.UseJumpPower=true end end
LP.CharacterAdded:Connect(function()task.wait(1)aplicar()end)
local function pegarOvos()local l={}local o=workspace:FindFirstChild("Ovos")if not o then return l end local c=o:FindFirstChild("Chest")if not c then return l end for _,x in ipairs(c:GetChildren())do if x:IsA("BasePart")then table.insert(l,x)end end return l end
local espF
local function limparESP()if espF then espF:Destroy()espF=nil end end
local function atualizarESP()limparESP()if not(St.espEggs or St.espPlayers)then return end espF=N("Folder",{Parent=PG,Name="FantaESP"})
task.spawn(function()while espF and espF.Parent do
if St.espPlayers then for _,pl in ipairs(P:GetPlayers())do if pl~=LP and pl.Character then local hd=pl.Character:FindFirstChild("Head")if hd and not espF:FindFirstChild("P"..pl.Name)then local b=N("BillboardGui",{Parent=espF,Name="P"..pl.Name,Adornee=hd,Size=UDim2.new(0,140,0,20),AlwaysOnTop=true,StudsOffset=Vector3.new(0,2.5,0)})cr(b,6)N("TextLabel",{Parent=b,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="👤 "..pl.Name,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=RED,TextStrokeTransparency=0})end end end end
if St.espEggs then local ovos=pegarOvos()for i,o in ipairs(ovos)do local k="E"..i if not espF:FindFirstChild(k)then local b=N("BillboardGui",{Parent=espF,Name=k,Adornee=o,Size=UDim2.new(0,120,0,20),AlwaysOnTop=true,StudsOffset=Vector3.new(0,3,0)})cr(b,6)N("TextLabel",{Parent=b,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="🥚 Ovo",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=Color3.fromRGB(255,200,60),TextStrokeTransparency=0})end end end
task.wait(2)end end)end
RS.Stepped:Connect(function()
if St.noclip then local c=LP.Character if c then for _,p in ipairs(c:GetDescendants())do if p:IsA("BasePart")then p.CanCollide=false end end end end
if St.antiRag then local h=hm()if h then h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false);h:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)end end
if St.invis then local c=LP.Character if c then for _,p in ipairs(c:GetDescendants())do if p:IsA("BasePart")then p.LocalTransparencyModifier=0.9 end end end end
end)
RS.Heartbeat:Connect(function()
if St.antiCap then local r=rt()if r then for _,pl in ipairs(P:GetPlayers())do if pl~=LP and pl.Character then local pr=pl.Character:FindFirstChild("HumanoidRootPart")if pr and(pr.Position-r.Position).Magnitude<15 then local bk=r.CFrame.LookVector*-60 r.CFrame=r.CFrame+Vector3.new(bk.X,10,bk.Z)break end end end end end
if St.antiAFK then end end)
UIS.JumpRequest:Connect(function()if St.infJump then local h=hm()if h then h:ChangeState(Enum.HumanoidStateType.Jumping)end end end)
task.spawn(function()while task.wait(60)do if St.antiAFK then pcall(function()local vu=game:GetService("VirtualUser")vu:CaptureController()vu:ClickButton1(Vector2.new(0,0))end)end end end)
local bv,bg
local function ligarVoo()local r=rt()if not r then return end bv=N("BodyVelocity",{Parent=r,MaxForce=Vector3.new(1e5,1e5,1e5),Velocity=Vector3.new(0,0,0)});bg=N("BodyGyro",{Parent=r,MaxTorque=Vector3.new(1e5,1e5,1e5),P=1000,D=100,CFrame=r.CFrame})end
local function pararVoo()if bv then bv:Destroy()bv=nil end;if bg then bg:Destroy()bg=nil end end
RS.RenderStepped:Connect(function()if not St.fly or not bv then return end local r=rt()if not r then return end local cam=workspace.CurrentCamera local m=Vector3.new(0,0,0)
if UIS:IsKeyDown(Enum.KeyCode.W)then m=m+cam.CFrame.LookVector end
if UIS:IsKeyDown(Enum.KeyCode.S)then m=m-cam.CFrame.LookVector end
if UIS:IsKeyDown(Enum.KeyCode.A)then m=m-cam.CFrame.RightVector end
if UIS:IsKeyDown(Enum.KeyCode.D)then m=m+cam.CFrame.RightVector end
if UIS:IsKeyDown(Enum.KeyCode.Space)then m=m+Vector3.new(0,1,0)end
bv.Velocity=m*50;bg.CFrame=cam.CFrame end)
local basePos=nil
task.spawn(function()while task.wait(0.5)do
if St.autoSteal then local r=rt()if r then basePos=basePos or r.Position local ovos=pegarOvos()if #ovos>0 then local best,bd=nil,1e9 for _,o in ipairs(ovos)do local d=(o.Position-r.Position).Magnitude if d<bd then bd=d;best=o end end if best then r.CFrame=CFrame.new(best.Position+Vector3.new(0,3,0))task.wait(0.15)local pr=best:FindFirstChildOfClass("ProximityPrompt")or best:FindFirstChildWhichIsA("ProximityPrompt",true)if pr then pcall(function()pr:InputHoldBegin()end);task.wait(0.25);pcall(function()pr:InputHoldEnd()end)end task.wait(0.1)r.CFrame=CFrame.new(basePos+Vector3.new(0,3,0))end end end end
if St.autoHatch or St.autoSell or St.autoPlace or St.autoFuse or St.autoTreadmill or St.autoClaim or St.autoUpgrade then
local r=rt()if r then for _,o in ipairs(workspace:GetDescendants())do if o:IsA("ProximityPrompt")then local at=o.ActionText:lower()local ok=false
if St.autoHatch and at:find("hatch")then ok=true end
if St.autoSell and at:find("sell")then ok=true end
if St.autoPlace and at:find("place")then ok=true end
if St.autoFuse and at:find("fuse")then ok=true end
if St.autoTreadmill and at:find("treadmill")then ok=true end
if St.autoClaim and at:find("claim")then ok=true end
if St.autoUpgrade and at:find("upgrade")then ok=true end
if ok and o.Parent and o.Parent:IsA("BasePart")and(o.Parent.Position-r.Position).Magnitude<30 then pcall(function()o:InputHoldBegin()end);task.wait(0.15);pcall(function()o:InputHoldEnd()end)end
end end end end
end end)
local NH=N("Frame",{Parent=PG,AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-16,0,16),Size=UDim2.new(0,260,0,400),BackgroundTransparency=1,ZIndex=9999})
N("UIListLayout",{Parent=NH,Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder,VerticalAlignment=Enum.VerticalAlignment.Top,HorizontalAlignment=Enum.HorizontalAlignment.Right})
local function aviso(t,m,c)c=c or RED
local b=N("Frame",{Parent=NH,Size=UDim2.new(1,0,0,46),BackgroundColor3=CARD,BorderSizePixel=0,ZIndex=9999})cr(b,8);st(b,c)
N("TextLabel",{Parent=b,Position=UDim2.new(0,8,0,4),Size=UDim2.new(1,-16,0,16),BackgroundTransparency=1,Text=t,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=c,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=9999})
N("TextLabel",{Parent=b,Position=UDim2.new(0,8,0,22),Size=UDim2.new(1,-16,0,20),BackgroundTransparency=1,Text=m,Font=Enum.Font.Gotham,TextSize=9,TextColor3=TXT2,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true,ZIndex=9999})
task.delay(4,function()if b.Parent then b:Destroy()end end)end
local gui=N("ScreenGui",{Name="FantaScript",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,Parent=PG,DisplayOrder=999})
local fb=N("TextButton",{Parent=gui,Position=UDim2.new(0,20,0,20),Size=UDim2.new(0,54,0,54),BackgroundColor3=BG,BorderSizePixel=0,Text="",AutoButtonColor=false,ZIndex=9999,Active=true})cr(fb,27);st(fb,RED,2)
N("TextLabel",{Parent=fb,Position=UDim2.new(0.5,-16,0.5,-16),Size=UDim2.new(0,32,0,32),BackgroundTransparency=1,Text="🌶",Font=Enum.Font.GothamBlack,TextSize=24,ZIndex=10000})
local pan=N("Frame",{Parent=gui,AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0.5,0,0.5,0),Size=UDim2.new(0,620,0,400),BackgroundColor3=BG,BorderSizePixel=0,ClipsDescendants=true,ZIndex=1000,Visible=true})cr(pan,14);st(pan,RED,2)
local hd=N("Frame",{Parent=pan,Size=UDim2.new(1,0,0,38),BackgroundColor3=RED,BorderSizePixel=0})cr(hd,14)
N("TextLabel",{Parent=hd,Position=UDim2.new(0,14,0,0),Size=UDim2.new(1,-100,1,0),BackgroundTransparency=1,Text="🌶 FANTASCRIPT",Font=Enum.Font.GothamBlack,TextSize=15,TextColor3=Color3.fromRGB(255,255,255),TextXAlignment=Enum.TextXAlignment.Left})
local xb=N("TextButton",{Parent=hd,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-10,0.5,0),Size=UDim2.new(0,26,0,26),BackgroundTransparency=1,Text="✕",Font=Enum.Font.GothamBlack,TextSize=16,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})
xb.MouseButton1Click:Connect(function()pan.Visible=false end)
local lM=N("ScrollingFrame",{Parent=pan,Position=UDim2.new(0,8,0,48),Size=UDim2.new(0,105,1,-100),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=RED,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})
N("UIListLayout",{Parent=lM,Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder})
local rM=N("ScrollingFrame",{Parent=pan,AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-8,0,48),Size=UDim2.new(0,105,1,-100),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=RED,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})
N("UIListLayout",{Parent=rM,Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder})
local ce=N("Frame",{Parent=pan,Position=UDim2.new(0,118,0,48),Size=UDim2.new(1,-236,1,-100),BackgroundColor3=CARD,BorderSizePixel=0})cr(ce,10);st(ce,BORDER)
local footer=N("Frame",{Parent=pan,AnchorPoint=Vector2.new(0,1),Position=UDim2.new(0,8,1,-42),Size=UDim2.new(1,-16,0,34),BackgroundColor3=CARD,BorderSizePixel=0})cr(footer,10);st(footer,BORDER)
N("TextLabel",{Parent=footer,Position=UDim2.new(0,10,0,0),Size=UDim2.new(0,70,1,0),BackgroundTransparency=1,Text="Pesquisar",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=TXT,TextXAlignment=Enum.TextXAlignment.Left})
local sBox=N("TextBox",{Parent=footer,Position=UDim2.new(0,80,0,5),Size=UDim2.new(1,-90,1,-10),BackgroundColor3=BG,BorderSizePixel=0,PlaceholderText="Filtrar funções...",PlaceholderColor3=TXT2,Text="",Font=Enum.Font.Gotham,TextSize=10,TextColor3=TXT,TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false})cr(sBox,6)
local abas,tb,atual={},{},nil
local function trocarAba(id)if atual and abas[atual]then abas[atual].Visible=false;tb[atual].BackgroundColor3=CARD;tb[atual].TextColor3=TXT end
atual=id
if abas[id]then abas[id].Visible=true;tb[id].BackgroundColor3=RED;tb[id].TextColor3=Color3.fromRGB(255,255,255)end end
local function criarAba(nome,id,lado)local m=lado=="L"and lM or rM
local b=N("TextButton",{Parent=m,Size=UDim2.new(1,0,0,32),BackgroundColor3=CARD,BorderSizePixel=0,Text=nome,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=TXT,AutoButtonColor=false})cr(b,10);st(b,BORDER)
b.MouseButton1Click:Connect(function()trocarAba(id)end)
tb[id]=b
local f=N("ScrollingFrame",{Parent=ce,Size=UDim2.new(1,-12,1,-12),Position=UDim2.new(0,6,0,6),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=RED,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,Visible=false})
N("UIListLayout",{Parent=f,Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder})
abas[id]=f return f end
local function linha(p,h)local c=N("Frame",{Parent=p,Size=UDim2.new(1,0,0,h or 34),BackgroundColor3=CARD,BorderSizePixel=0})cr(c,8);st(c,BORDER)return c end
local function secao(p,t)local c=N("Frame",{Parent=p,Size=UDim2.new(1,0,0,22),BackgroundColor3=BG,BorderSizePixel=0})cr(c,6)
N("TextLabel",{Parent=c,Position=UDim2.new(0,8,0,0),Size=UDim2.new(1,-16,1,0),BackgroundTransparency=1,Text="▼ "..t,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=RED,TextXAlignment=Enum.TextXAlignment.Left})end
local function toggle(p,nome,init,fn)local c=linha(p,34)
N("TextLabel",{Parent=c,Position=UDim2.new(0,10,0,0),Size=UDim2.new(1,-60,1,0),BackgroundTransparency=1,Text=nome,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=TXT,TextXAlignment=Enum.TextXAlignment.Left})
local s=init or false
local sw=N("TextButton",{Parent=c,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-10,0.5,0),Size=UDim2.new(0,38,0,20),BackgroundColor3=Color3.fromRGB(60,60,68),Text="",AutoButtonColor=false})cr(sw,10)
local kn=N("Frame",{Parent=sw,Position=UDim2.new(0,2,0,2),Size=UDim2.new(0,16,0,16),BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0})cr(kn,8)
sw.MouseButton1Click:Connect(function()s=not s
kn.Position=s and UDim2.new(1,-18,0,2)or UDim2.new(0,2,0,2)
sw.BackgroundColor3=s and Color3.fromRGB(60,180,90)or Color3.fromRGB(60,60,68)
if fn then pcall(fn,s)end end)end
local function num(p,nome,valor,fn)local c=linha(p,34)
N("TextLabel",{Parent=c,Position=UDim2.new(0,10,0,0),Size=UDim2.new(1,-110,1,0),BackgroundTransparency=1,Text=nome,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=TXT,TextXAlignment=Enum.TextXAlignment.Left})
local b=N("TextBox",{Parent=c,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-10,0.5,0),Size=UDim2.new(0,90,0,24),BackgroundColor3=BG,BorderSizePixel=0,Text=tostring(valor),Font=Enum.Font.GothamBold,TextSize=11,TextColor3=Color3.fromRGB(255,255,255),TextXAlignment=Enum.TextXAlignment.Center,ClearTextOnFocus=false})cr(b,6);st(b,BORDER)
b.FocusLost:Connect(function()local n=tonumber(b.Text)if n and fn then pcall(fn,n)end end)end
local function btn(p,nome,texto,cor,fn)local f=linha(p,34)
N("TextLabel",{Parent=f,Position=UDim2.new(0,10,0,0),Size=UDim2.new(1,-110,1,0),BackgroundTransparency=1,Text=nome,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=TXT,TextXAlignment=Enum.TextXAlignment.Left})
local b=N("TextButton",{Parent=f,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-10,0.5,0),Size=UDim2.new(0,90,0,24),BackgroundColor3=cor or RED,Text=texto,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})cr(b,6)
b.MouseButton1Click:Connect(function()local ok,e=pcall(fn)if not ok then aviso("Erro",tostring(e),RED)end end)end
local function info(p,t)local c=linha(p,24)
N("TextLabel",{Parent=c,Position=UDim2.new(0,10,0,0),Size=UDim2.new(1,-16,1,0),BackgroundTransparency=1,Text=t,Font=Enum.Font.Gotham,TextSize=10,TextColor3=TXT2,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd})end
-- ABAS ESQUERDA
local t=criarAba("🌾 Farm","farm","L")
secao(t,"Auto Steal")
toggle(t,"Auto Steal",false,function(v)St.autoSteal=v end)
toggle(t,"Anti Captura",false,function(v)St.antiCap=v end)
toggle(t,"Priorizar Ovos Rift",false,function(v)end)
info(t,"Áreas Alvo: 12 selecionadas")
info(t,"Raridade Mínima: Qualquer")
num(t,"Valor Mínimo Roubo",0,function(n)end)
info(t,"Ovos Específicos: Todos")
secao(t,"Auto Ações")
toggle(t,"Auto Place Eggs",false,function(v)St.autoPlace=v end)
toggle(t,"Auto Hatch & Equip",false,function(v)St.autoHatch=v end)
toggle(t,"Auto Sell Eggs",false,function(v)St.autoSell=v end)
toggle(t,"Auto Fuse Machine",false,function(v)St.autoFuse=v end)
toggle(t,"Auto Rift and Boss",false,function(v)end)
toggle(t,"Auto Treadmill",false,function(v)St.autoTreadmill=v end)
toggle(t,"Auto Upgrade Base",false,function(v)St.autoUpgrade=v end)
toggle(t,"Auto Claim Rewards",false,function(v)St.autoClaim=v end)
t=criarAba("👤 Player","plr","L")
secao(t,"Movimento")
num(t,"Velocidade",16,function(n)if n<0 then n=0 end if n>1000 then n=1000 end St.speed=n aplicar()end)
num(t,"Pulo",100,function(n)St.jump=n aplicar()end)
toggle(t,"Pulo Infinito",false,function(v)St.infJump=v end)
toggle(t,"Voo",false,function(v)St.fly=v if v then ligarVoo()else pararVoo()end end)
toggle(t,"Noclip",false,function(v)St.noclip=v end)
secao(t,"Defesa")
toggle(t,"Anti Ragdoll",false,function(v)St.antiRag=v end)
toggle(t,"Anti Trap",false,function(v)St.antiRag=v end)
toggle(t,"Invisibilidade",false,function(v)St.invis=v end)
toggle(t,"Anti AFK",true,function(v)St.antiAFK=v end)
btn(t,"Reset Character","Reset",RED,function()local c=LP.Character if c then c:BreakJoints()end end)
t=criarAba("🔮 Predictor","pred","L")
secao(t,"Egg Predictor")
info(t,"Chances por raridade:")
info(t,"Comum 45% • Incomum 25%")
info(t,"Raro 15% • Épico 8%")
info(t,"Lendário 5% • Mítico 1.5%")
info(t,"Secreto 0.4% • Eterno 0.1%")
secao(t,"Rift Predictor")
info(t,"Riftborn Egg 45%")
info(t,"Riftbeasts Egg 35%")
info(t,"Shattered Rift Egg 20%")
t=criarAba("📈 Progress","prog","L")
toggle(t,"Auto Buy Trail",false,function(v)end)
toggle(t,"Auto Upgrade Base",false,function(v)St.autoUpgrade=v end)
toggle(t,"Auto Upgrade Treadmill",false,function(v)end)
toggle(t,"Auto Claim Rewards",false,function(v)St.autoClaim=v end)
toggle(t,"Auto Claim Index",false,function(v)end)
t=criarAba("🌐 Server","srv","L")
info(t,"Job ID: "..string.sub(game.JobId,1,10).."...")
info(t,"Jogadores: "..#P:GetPlayers().."/"..P.MaxPlayers)
btn(t,"Server Hop","Hop",RED,function()
local u="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=50"
local ok,b=pcall(function()return HS:JSONDecode(game:HttpGet(u))end)
if ok and b and b.data then for _,s in ipairs(b.data)do if s.playing<s.maxPlayers and s.id~=game.JobId then pcall(function()TS:TeleportToPlaceInstance(game.PlaceId,s.id,LP)end)return end end end end)
btn(t,"Reentrar","Rejoin",RED,function()pcall(function()TS:Teleport(game.PlaceId,LP)end)end)
btn(t,"Copiar Job ID","Copiar",Color3.fromRGB(240,180,50),function()if setclipboard then setclipboard(game.JobId)end end)
t=criarAba("🎒 Diversos","misc","L")
toggle(t,"Anti AFK",true,function(v)St.antiAFK=v end)
toggle(t,"Sem Névoa",false,function(v)if v then LG.FogEnd=1e6 end end)
toggle(t,"Claridade Total",false,function(v)if v then LG.Brightness=3 LG.ClockTime=14 LG.GlobalShadows=false end end)
toggle(t,"FPS Optimizer",false,function(v)if v then LG.GlobalShadows=false end end)
-- ABAS DIREITA
t=criarAba("💬 Discord","disc","R")
info(t,"Webhook URL:")
local wb=N("TextBox",{Parent=t,Size=UDim2.new(1,0,0,26),BackgroundColor3=BG,BorderSizePixel=0,PlaceholderText="https://discord.com/api/webhooks/...",PlaceholderColor3=TXT2,Text="",Font=Enum.Font.Gotham,TextSize=9,TextColor3=TXT,TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false})cr(wb,6)
btn(t,"Testar Webhook","Testar",RED,function()local u=wb.Text if u==""then return end pcall(function()HS:PostAsync(u,HS:JSONEncode({content="🌶 FantaScript conectado!"}))end)aviso("Webhook","Enviado!",Color3.fromRGB(60,180,90))end)
toggle(t,"Ping @everyone",false,function(v)end)
toggle(t,"Notify Events",true,function(v)end)
t=criarAba("⌨ Quick Keys","keys","R")
info(t,"Right Shift → abre/fecha")
info(t,"Fly: W A S D + Space")
info(t,"Velocidade: Player")
info(t,"ESP: Visual")
toggle(t,"Mostrar Quick Bars",true,function(v)end)
btn(t,"Reset Keybinds","Reset",RED,function()end)
t=criarAba("👁 Visual","vis","R")
toggle(t,"Egg ESP",false,function(v)St.espEggs=v atualizarESP()end)
toggle(t,"ESP Jogadores",false,function(v)St.espPlayers=v atualizarESP()end)
btn(t,"Limpar ESP","Limpar",RED,function()St.espEggs=false St.espPlayers=false atualizarESP()end)
t=criarAba("⚙ Settings","set","R")
toggle(t,"Animações",true,function(v)end)
toggle(t,"Open On Launch",true,function(v)end)
toggle(t,"FPS/Ping",true,function(v)end)
num(t,"UI Size",100,function(n)end)
btn(t,"Reset Defaults","Reset",RED,function()end)
t=criarAba("⚙ Config","cfg","R")
info(t,"Startup Config: Default")
toggle(t,"Auto Save Config",true,function(v)end)
toggle(t,"Auto Load Config",true,function(v)end)
btn(t,"Exportar JSON","Exportar",RED,function()local d={speed=St.speed,ver="1.0"}if setclipboard then setclipboard(HS:JSONEncode(d))end aviso("Exportar","Copiado",Color3.fromRGB(60,180,90))end)
btn(t,"Criar Perfil","Criar",RED,function()aviso("Perfil","Novo",Color3.fromRGB(60,180,90))end)
btn(t,"Fechar Painel","Fechar",RED,function()pan.Visible=false end)
sBox:GetPropertyChangedSignal("Text"):Connect(function()
local q=sBox.Text:lower()if q==""then return end
for id,fr in pairs(abas)do for _,c in ipairs(fr:GetChildren())do if c:IsA("Frame")then local found=false for _,l in ipairs(c:GetChildren())do if l:IsA("TextLabel")and l.Text:lower():find(q)then found=true break end end c.Visible=found end end end end)
local function arrastar(h,tg,cl)local d,s,m,st=false,nil,false,0
h.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then d=true;m=false;st=tick();s=i.Position end end)
h.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then if d and not m and(tick()-st)<0.3 and cl then cl()end d=false end end)
UIS.InputChanged:Connect(function(i)if not d then return end
if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then
local dd=i.Position-s
if math.abs(dd.X)>5 or math.abs(dd.Y)>5 then m=true end
tg.Position=UDim2.new(tg.Position.X.Scale,tg.Position.X.Offset+dd.X,tg.Position.Y.Scale,tg.Position.Y.Offset+dd.Y)
s=i.Position end end)end
arrastar(hd,pan)arrastar(fb,fb,function()pan.Visible=not pan.Visible end)
UIS.InputBegan:Connect(function(i,g)if g then return end if i.KeyCode==Enum.KeyCode.RightShift then pan.Visible=not pan.Visible end end)
trocarAba("farm")
aviso("🌶 FANTASCRIPT","Carregado! Bem-vindo!",Color3.fromRGB(60,180,90))
print("[FANTASCRIPT] Carregado.")
