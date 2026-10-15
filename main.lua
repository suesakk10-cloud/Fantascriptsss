-- CHILLI HUB v4.0
local P=game:GetService("Players")local UIS=game:GetService("UserInputService")local TW=game:GetService("TweenService")local RS=game:GetService("RunService")local LP=P.LocalPlayer local PG=LP:WaitForChild("PlayerGui")
local old=PG:FindFirstChild("ChilliHub")if old then old:Destroy()end
local C={bg=Color3.fromRGB(12,12,15),card=Color3.fromRGB(30,30,36),bd=Color3.fromRGB(48,48,55),red=Color3.fromRGB(200,30,40),grn=Color3.fromRGB(60,180,90),yel=Color3.fromRGB(240,180,50),blu=Color3.fromRGB(80,140,240),pur=Color3.fromRGB(140,80,220),txt=Color3.fromRGB(240,240,245),txt2=Color3.fromRGB(140,140,150)}
local function N(c,p)local i=Instance.new(c)if p then local x=p.Parent;p.Parent=nil;for k,v in pairs(p)do i[k]=v end;i.Parent=x end return i end
local function cr(p,r)N("UICorner",{Parent=p,CornerRadius=UDim.new(0,r or 6)})end
local function st(p,c)N("UIStroke",{Parent=p,Color=c or C.bd})end
local function rt()local c=LP.Character return c and c:FindFirstChild("HumanoidRootPart")end
local function hm()local c=LP.Character return c and c:FindFirstChildOfClass("Humanoid")end
local St={speed=16,jump=50,gravity=196.2,flySpeed=50,espP=false,espE=false,noclip=false,fly=false,infJump=false,antiRag=false,autoSteal=false,autoHatch=false,autoSell=false,webhook=""}
local function apply()local h=hm()if h then h.WalkSpeed=St.speed h.JumpPower=St.jump h.UseJumpPower=true end workspace.Gravity=St.gravity end
LP.CharacterAdded:Connect(function()task.wait(1)apply()end)
local espF
local function clearESP()if espF then espF:Destroy()espF=nil end end
local function refreshESP()clearESP()if not(St.espP or St.espE)then return end espF=N("Folder",{Parent=PG,Name="ESP"})
task.spawn(function()while espF and espF.Parent do
if St.espP then for _,pl in ipairs(P:GetPlayers())do if pl~=LP and pl.Character then local hd=pl.Character:FindFirstChild("Head")if hd and not espF:FindFirstChild("P"..pl.Name)then local b=N("BillboardGui",{Parent=espF,Name="P"..pl.Name,Adornee=hd,Size=UDim2.new(0,120,0,20),AlwaysOnTop=true,StudsOffset=Vector3.new(0,2.5,0)})N("TextLabel",{Parent=b,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=pl.Name,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.red,TextStrokeTransparency=0})end end end end
if St.espE then for _,o in ipairs(workspace:GetDescendants())do if o:IsA("BasePart")then local n=o.Name:lower()if n:find("egg")or n:find("ovo")then if not espF:FindFirstChild("E"..o.Name)then local b=N("BillboardGui",{Parent=espF,Name="E"..o.Name,Adornee=o,Size=UDim2.new(0,100,0,20),AlwaysOnTop=true,StudsOffset=Vector3.new(0,2,0)})N("TextLabel",{Parent=b,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="🥚 "..o.Name,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.yel,TextStrokeTransparency=0})end end end end end
task.wait(1.5)end end)end
RS.Stepped:Connect(function()if St.noclip then local c=LP.Character if c then for _,p in ipairs(c:GetDescendants())do if p:IsA("BasePart")then p.CanCollide=false end end end end
if St.antiRag then local h=hm()if h then h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)h:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)end end end)
UIS.JumpRequest:Connect(function()if St.infJump then local h=hm()if h then h:ChangeState(Enum.HumanoidStateType.Jumping)end end end)
local bv,bg
local function startFly()local r=rt()if not r then return end bv=N("BodyVelocity",{Parent=r,MaxForce=Vector3.new(1e5,1e5,1e5),Velocity=Vector3.new(0,0,0)})bg=N("BodyGyro",{Parent=r,MaxTorque=Vector3.new(1e5,1e5,1e5),P=1000,D=100,CFrame=r.CFrame})end
local function stopFly()if bv then bv:Destroy()bv=nil end if bg then bg:Destroy()bg=nil end end
RS.RenderStepped:Connect(function()if not St.fly or not bv then return end local r=rt()if not r then return end local cam=workspace.CurrentCamera local m=Vector3.new(0,0,0)if UIS:IsKeyDown(Enum.KeyCode.W)then m=m+cam.CFrame.LookVector end if UIS:IsKeyDown(Enum.KeyCode.S)then m=m-cam.CFrame.LookVector end if UIS:IsKeyDown(Enum.KeyCode.A)then m=m-cam.CFrame.RightVector end if UIS:IsKeyDown(Enum.KeyCode.D)then m=m+cam.CFrame.RightVector end if UIS:IsKeyDown(Enum.KeyCode.Space)then m=m+Vector3.new(0,1,0)end bv.Velocity=m*St.flySpeed bg.CFrame=cam.CFrame end)
task.spawn(function()while task.wait(0.3)do if St.autoSteal then local r=rt()if r then local best,bd=nil,1e9 for _,o in ipairs(workspace:GetDescendants())do if o:IsA("BasePart")then local n=o.Name:lower()if n:find("egg")or n:find("ovo")or n:find("brainrot")then local d=(o.Position-r.Position).Magnitude if d<bd then bd=d best=o end end end end if best then r.CFrame=CFrame.new(best.Position+Vector3.new(0,3,0))task.wait(0.1)local pr=best:FindFirstChildOfClass("ProximityPrompt")if pr then pcall(function()pr:InputHoldBegin()end)task.wait(0.2)pcall(function()pr:InputHoldEnd()end)end end end end end end)
task.spawn(function()while task.wait(1)do if St.autoHatch or St.autoSell then local r=rt()if r then for _,o in ipairs(workspace:GetDescendants())do if o:IsA("ProximityPrompt")then local at=o.ActionText:lower()local ok=false if St.autoHatch and(at:find("hatch")or at:find("chocar"))then ok=true end if St.autoSell and(at:find("sell")or at:find("vender"))then ok=true end if ok and o.Parent and o.Parent:IsA("BasePart")and(o.Parent.Position-r.Position).Magnitude<25 then pcall(function()o:InputHoldBegin()end)task.wait(0.15)pcall(function()o:InputHoldEnd()end)end end end end end end end)
local NH=N("Frame",{Parent=PG,AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-16,0,16),Size=UDim2.new(0,260,0,400),BackgroundTransparency=1,ZIndex=9999})
N("UIListLayout",{Parent=NH,Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder,VerticalAlignment=Enum.VerticalAlignment.Top,HorizontalAlignment=Enum.HorizontalAlignment.Right})
local function nt(t,m,c)c=c or C.red local b=N("Frame",{Parent=NH,Size=UDim2.new(1,0,0,46),BackgroundColor3=C.card,BorderSizePixel=0,ZIndex=9999})cr(b,6)st(b,c)N("TextLabel",{Parent=b,Position=UDim2.new(0,8,0,4),Size=UDim2.new(1,-16,0,16),BackgroundTransparency=1,Text=t,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=c,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=9999})N("TextLabel",{Parent=b,Position=UDim2.new(0,8,0,22),Size=UDim2.new(1,-16,0,20),BackgroundTransparency=1,Text=m,Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true,ZIndex=9999})task.delay(4,function()if b.Parent then b:Destroy()end end)end
local gui=N("ScreenGui",{Name="ChilliHub",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,Parent=PG,DisplayOrder=999})
local fb=N("TextButton",{Parent=gui,Position=UDim2.new(0,20,0,20),Size=UDim2.new(0,50,0,50),BackgroundColor3=C.card,Text="",AutoButtonColor=false,ZIndex=9999})
cr(fb,25)st(fb,C.red)N("TextLabel",{Parent=fb,Position=UDim2.new(0.5,-16,0.5,-16),Size=UDim2.new(0,32,0,32),BackgroundTransparency=1,Text="🔥",Font=Enum.Font.GothamBlack,TextSize=20,ZIndex=10000})
local pan=N("Frame",{Parent=gui,AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0.5,0,0.5,0),Size=UDim2.new(0,620,0,400),BackgroundColor3=C.bg,BorderSizePixel=0,ClipsDescendants=true,ZIndex=1000,Visible=true})
cr(pan,10)st(pan,C.red,2)
local hd=N("Frame",{Parent=pan,Size=UDim2.new(1,0,0,36),BackgroundColor3=C.red,BorderSizePixel=0})cr(hd,10)
N("TextLabel",{Parent=hd,Position=UDim2.new(0,12,0,0),Size=UDim2.new(1,-80,1,0),BackgroundTransparency=1,Text="🔥 CHILLI HUB VIP v4.0",Font=Enum.Font.GothamBlack,TextSize=13,TextColor3=Color3.fromRGB(255,255,255),TextXAlignment=Enum.TextXAlignment.Left})
local xb=N("TextButton",{Parent=hd,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-10,0.5,0),Size=UDim2.new(0,26,0,26),BackgroundColor3=Color3.fromRGB(0,0,0),BackgroundTransparency=0.4,Text="X",Font=Enum.Font.GothamBlack,TextSize=13,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})cr(xb,4)xb.MouseButton1Click:Connect(function()pan.Visible=false end)
local lM=N("Frame",{Parent=pan,Position=UDim2.new(0,8,0,44),Size=UDim2.new(0,110,0,330),BackgroundTransparency=1})N("UIListLayout",{Parent=lM,Padding=UDim.new(0,3),SortOrder=Enum.SortOrder.LayoutOrder})
local rM=N("Frame",{Parent=pan,AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-8,0,44),Size=UDim2.new(0,110,0,330),BackgroundTransparency=1})N("UIListLayout",{Parent=rM,Padding=UDim.new(0,3),SortOrder=Enum.SortOrder.LayoutOrder})
local ce=N("Frame",{Parent=pan,Position=UDim2.new(0,126,0,44),Size=UDim2.new(1,-252,1,-90),BackgroundColor3=C.card,BorderSizePixel=0})cr(ce,8)st(ce,C.bd)
local tabs,tb,cur={},{},nil
local function sTab(id)if cur and tabs[cur]then tabs[cur].Visible=false;tb[cur].BackgroundColor3=C.card;tb[cur].TextColor3=C.txt end cur=id if tabs[id]then tabs[id].Visible=true;tb[id].BackgroundColor3=C.red;tb[id].TextColor3=Color3.fromRGB(255,255,255)end end
local function mk(lb,id,m)local b=N("TextButton",{Parent=m,Size=UDim2.new(1,0,0,28),BackgroundColor3=C.card,Text=lb,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.txt,AutoButtonColor=false})cr(b,5)st(b,C.bd)b.MouseButton1Click:Connect(function()sTab(id)end)tb[id]=b local f=N("ScrollingFrame",{Parent=ce,Size=UDim2.new(1,-12,1,-12),Position=UDim2.new(0,6,0,6),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=C.red,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,Visible=false})N("UIListLayout",{Parent=f,Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder})tabs[id]=f return f end
local function rw(p,h)local c=N("Frame",{Parent=p,Size=UDim2.new(1,0,0,h or 36),BackgroundColor3=C.card,BorderSizePixel=0})cr(c,5)st(c,C.bd)return c end
local function tg(p,lb,d,i,fn)local c=rw(p,40)N("TextLabel",{Parent=c,Position=UDim2.new(0,8,0,4),Size=UDim2.new(1,-60,0,14),BackgroundTransparency=1,Text=lb,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})if d then N("TextLabel",{Parent=c,Position=UDim2.new(0,8,0,20),Size=UDim2.new(1,-60,0,16),BackgroundTransparency=1,Text=d,Font=Enum.Font.Gotham,TextSize=8,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true})end local s=i or false local sw=N("TextButton",{Parent=c,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-8,0.5,0),Size=UDim2.new(0,36,0,20),BackgroundColor3=s and C.grn or Color3.fromRGB(60,60,68),Text="",AutoButtonColor=false})cr(sw,10)local kn=N("Frame",{Parent=sw,Position=s and UDim2.new(1,-17,0,2)or UDim2.new(0,2,0,2),Size=UDim2.new(0,16,0,16),BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0})cr(kn,8)sw.MouseButton1Click:Connect(function()s=not s TW:Create(kn,TweenInfo.new(0.15),{Position=s and UDim2.new(1,-17,0,2)or UDim2.new(0,2,0,2)}):Play()sw.BackgroundColor3=s and C.grn or Color3.fromRGB(60,60,68)if fn then pcall(fn,s)end end)end
local function nm(p,lb,i,fn)local c=rw(p,36)N("TextLabel",{Parent=c,Position=UDim2.new(0,8,0,0),Size=UDim2.new(1,-110,1,0),BackgroundTransparency=1,Text=lb,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})local b=N("TextBox",{Parent=c,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-8,0.5,0),Size=UDim2.new(0,90,0,24),BackgroundColor3=Color3.fromRGB(10,10,12),BorderSizePixel=0,Text=tostring(i or 16),Font=Enum.Font.GothamBold,TextSize=11,TextColor3=Color3.fromRGB(255,255,255),TextXAlignment=Enum.TextXAlignment.Center,ClearTextOnFocus=false})cr(b,4)st(b,C.bd)b.FocusLost:Connect(function()local n=tonumber(b.Text)if n and fn then pcall(fn,n)end end)end
local function bt(p,lb,t,c,fn)local f=rw(p,36)N("TextLabel",{Parent=f,Position=UDim2.new(0,8,0,0),Size=UDim2.new(1,-110,1,0),BackgroundTransparency=1,Text=lb,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})local b=N("TextButton",{Parent=f,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-8,0.5,0),Size=UDim2.new(0,90,0,24),BackgroundColor3=c or C.red,Text=t or "OK",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})cr(b,5)b.MouseButton1Click:Connect(function()local ok,e=pcall(fn)if not ok then nt("Erro",tostring(e),C.red)end end)end
local function inf(p,t)local c=rw(p,24)N("TextLabel",{Parent=c,Position=UDim2.new(0,8,0,0),Size=UDim2.new(1,-16,1,0),BackgroundTransparency=1,Text=t,Font=Enum.Font.Gotham,TextSize=10,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd})end
-- ABAS
local t=mk("👤 Player","player",lM)
nm(t,"WalkSpeed (0-1000)",St.speed,function(n)if n<0 then n=0 end if n>1000 then n=1000 end St.speed=n apply()nt("Speed",n,C.grn)end)
nm(t,"JumpPower",St.jump,function(n)St.jump=n apply()end)
nm(t,"Gravity",St.gravity,function(n)St.gravity=n apply()end)
tg(t,"Infinite Jump","Pula no ar.",false,function(v)St.infJump=v end)
tg(t,"Fly (WASD+Space)","Voa.",false,function(v)St.fly=v if v then startFly()else stopFly()end end)
tg(t,"Noclip","Atravessa paredes.",false,function(v)St.noclip=v end)
tg(t,"Anti-Ragdoll","Não cai.",false,function(v)St.antiRag=v end)
bt(t,"Reset Character","Reset",C.red,function()local c=LP.Character if c then c:BreakJoints()end end)
t=mk("👁 Visual","vis",lM)
tg(t,"ESP Players","Nomes.",false,function(v)St.espP=v refreshESP()end)
tg(t,"ESP Eggs","Marcadores 🥚.",false,function(v)St.espE=v refreshESP()end)
bt(t,"Fullbright","Ligar",C.red,function()LG.Brightness=3 LG.ClockTime=14 LG.FogEnd=1e6 LG.GlobalShadows=false nt("Visual","Fullbright ON",C.grn)end)
nm(t,"FOV",70,function(n)if workspace.CurrentCamera then workspace.CurrentCamera.FieldOfView=n end end)
bt(t,"Limpar ESP","Limpar",C.red,function()St.espP=false St.espE=false refreshESP()end)
t=mk("🌾 Farm","farm",lM)
tg(t,"Auto Steal","Teleporta e rouba.",false,function(v)St.autoSteal=v end)
tg(t,"Auto Hatch","Choca ovos.",false,function(v)St.autoHatch=v end)
tg(t,"Auto Sell","Vende repetidos.",false,function(v)St.autoSell=v end)
bt(t,"TP para ovo mais próximo","TP",C.blu,function()local r=rt()if not r then return end local best,bd=nil,1e9 for _,o in ipairs(workspace:GetDescendants())do if o:IsA("BasePart")then local n=o.Name:lower()if n:find("egg")or n:find("ovo")or n:find("brainrot")then local d=(o.Position-r.Position).Magnitude if d<bd then bd=d best=o end end end end if best then r.CFrame=CFrame.new(best.Position+Vector3.new(0,3,0))nt("TP","Foste para "..best.Name,C.blu)else nt("TP","Nada encontrado",C.red)end end)
t=mk("🌐 Server","srv",lM)
inf(t,"Job ID: "..string.sub(game.JobId,1,10).."...")
inf(t,"Jogadores: "..#P:GetPlayers().."/"..P.MaxPlayers)
bt(t,"Copiar Job ID","Copiar",C.red,function()if setclipboard then setclipboard(game.JobId)end nt("Copiado","Job ID",C.grn)end)
bt(t,"Rejoin","Rejoin",C.red,function()pcall(function()game:GetService("TeleportService"):Teleport(game.PlaceId,LP)end)end)
bt(t,"Server Hop","Hop",C.red,function()local url="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=50" local ok,body=pcall(function()return game:GetService("HttpService"):JSONDecode(game:HttpGet(url))end)if ok and body and body.data then for _,s in ipairs(body.data)do if s.playing<s.maxPlayers and s.id~=game.JobId then pcall(function()game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,s.id,LP)end)return end end end nt("Hop","Sem servidor",C.red)end)
t=mk("📊 Stats","stats",rM)
inf(t,"FPS: -- | Ping: --")
task.spawn(function()while task.wait(1)do local f=math.floor(1/RS.RenderStepped:Wait())local p=math.floor(LP:GetNetworkPing()*1000)inf(t,string.format("FPS: %d | Ping: %d ms",f,p))end end)
t=mk("🔔 Alerts","alerts",rM)
tg(t,"Avisar join","Notifica quem entra.",false,function(v)if v then P.PlayerAdded:Connect(function(pl)nt("👤 Entrou",pl.Name,C.pur)end)end end)
bt(t,"Testar notificação","Testar",C.pur,function()nt("Teste","Funcionou!",C.grn)end)
t=mk("⚙ Config","cfg",rM)
bt(t,"Reset tudo","Reset",C.red,function()St.speed=16 St.jump=50 St.gravity=196.2 St.noclip=false St.fly=false St.infJump=false St.antiRag=false St.espP=false St.espE=false St.autoSteal=false St.autoHatch=false St.autoSell=false if bv then bv:Destroy()end if bg then bg:Destroy()end apply()refreshESP()nt("Reset","Tudo desligado",C.red)end)
bt(t,"Fechar painel","Fechar",C.red,function()pan.Visible=false end)
-- DRAG
local function drag(h,t,cl)local d,s,m,st=false,nil,false,0 h.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then d=true m=false st=tick()s=i.Position end end)h.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then if d and not m and(tick()-st)<0.3 and cl then cl()end d=false end end)UIS.InputChanged:Connect(function(i)if not d then return end if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then local dd=i.Position-s if math.abs(dd.X)>5 or math.abs(dd.Y)>5 then m=true end t.Position=UDim2.new(t.Position.X.Scale,t.Position.X.Offset+dd.X,t.Position.Y.Scale,t.Position.Y.Offset+dd.Y)s=i.Position end end)end
drag(hd,pan)drag(fb,fb,function()pan.Visible=not pan.Visible end)
UIS.InputBegan:Connect(function(i,g)if g then return end if i.KeyCode==Enum.KeyCode.RightShift then pan.Visible=not pan.Visible end end)
sTab("player")nt("🔥 CHILLI HUB","v4.0 carregado",C.red)print("[CHILLI HUB] v4.0 carregado.")
