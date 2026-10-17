-- FANTASCRIPT — White Modern Edition (< 250 linhas)
local P=game:GetService("Players")local LP=P.LocalPlayer local PG=LP:WaitForChild("PlayerGui")
local UIS=game:GetService("UserInputService")local RS=game:GetService("RunService")local HS=game:GetService("HttpService")
local old=PG:FindFirstChild("FantaScript")if old then old:Destroy()end
local C={bg=Color3.fromRGB(245,245,247),card=Color3.fromRGB(255,255,255),bd=Color3.fromRGB(220,220,225),txt=Color3.fromRGB(30,30,35),txt2=Color3.fromRGB(130,130,140),acc=Color3.fromRGB(0,122,255),grn=Color3.fromRGB(52,199,89),red=Color3.fromRGB(255,59,48)}
local function N(c,p)local i=Instance.new(c)if p then local x=p.Parent;p.Parent=nil;for k,v in pairs(p)do i[k]=v end;i.Parent=x end return i end
local function cr(p,r)N("UICorner",{Parent=p,CornerRadius=UDim.new(0,r or 8)})end
local function st(p,c)N("UIStroke",{Parent=p,Color=c or C.bd,Thickness=1})end
local function getHRP()local c=LP.Character return c and c:FindFirstChild("HumanoidRootPart")end
local Flags={Steal=false,Hatch=false,Sell=false,Speed=16,ESP_Eggs=false,ESP_Players=false,Fly=false,Noclip=false}
local bv,bg

-- FUNÇÕES LÓGICAS
local function getOvos()local t={}local o=workspace:FindFirstChild("Ovos")if not o then return t end local c=o:FindFirstChild("Chest")if c then for _,v in ipairs(c:GetChildren())do if v:IsA("BasePart")then table.insert(t,v)end end end return t end
task.spawn(function()while task.wait(0.2)do if Flags.Steal then local hrp=getHRP()if hrp then local ovos=getOvos()local best,bd=nil,math.huge for _,o in ipairs(ovos)do local d=(o.Position-hrp.Position).Magnitude if d<bd then bd=d;best=o end end if best then hrp.CFrame=CFrame.new(best.Position+Vector3.new(0,3,0))task.wait(0.1)local pr=best:FindFirstChildOfClass("ProximityPrompt")if pr then pcall(function()pr:InputHoldBegin()end)task.wait(0.2)pcall(function()pr:InputHoldEnd()end)end end end end end end)
task.spawn(function()while task.wait(0.5)do if Flags.Hatch or Flags.Sell then local hrp=getHRP()if hrp then for _,v in ipairs(workspace:GetDescendants())do if v:IsA("ProximityPrompt")then local a=v.ActionText:lower()if(Flags.Hatch and a:find("hatch"))or(Flags.Sell and a:find("sell"))then local p=v.Parent if p and p:IsA("BasePart")and(p.Position-hrp.Position).Magnitude<25 then pcall(function()v:InputHoldBegin()end)task.wait(0.1)pcall(function()v:InputHoldEnd()end)end end end end end end end end)
RS.Stepped:Connect(function()if Flags.Noclip and LP.Character then for _,v in ipairs(LP.Character:GetDescendants())do if v:IsA("BasePart")then v.CanCollide=false end end end end)
RS.RenderStepped:Connect(function()if Flags.Fly and bv and LP.Character then local cam=workspace.CurrentCamera local hrp=getHRP()if hrp and cam then local move=Vector3.new(0,0,0)if UIS:IsKeyDown(Enum.KeyCode.W)then move+=cam.CFrame.LookVector end if UIS:IsKeyDown(Enum.KeyCode.S)then move-=cam.CFrame.LookVector end if UIS:IsKeyDown(Enum.KeyCode.A)then move-=cam.CFrame.RightVector end if UIS:IsKeyDown(Enum.KeyCode.D)then move+=cam.CFrame.RightVector end if UIS:IsKeyDown(Enum.KeyCode.Space)then move+=Vector3.new(0,1,0)end bv.Velocity=move*50 bg.CFrame=cam.CFrame end end end)
-- ESP
local espF
local function updESP()if espF then espF:Destroy()end espF=Instance.new("Folder",PG)espF.Name="FantaESP" if not Flags.ESP_Eggs and not Flags.ESP_Players then return end
    task.spawn(function()while espF and espF.Parent do
        if Flags.ESP_Eggs then for _,v in ipairs(getOvos())do local b=N("BillboardGui",{Parent=espF,Adornee=v,Size=UDim2.new(0,100,0,24),AlwaysOnTop=true,StudsOffset=Vector3.new(0,3,0)})N("TextLabel",{Parent=b,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="🥚 Ovo",Font=Enum.Font.GothamBold,TextSize=12,TextColor3=C.acc,TextStrokeTransparency=0.5})end end
        if Flags.ESP_Players then for _,pl in ipairs(P:GetPlayers())do if pl~=LP and pl.Character then local h=pl.Character:FindFirstChild("Head")if h then local b=N("BillboardGui",{Parent=espF,Adornee=h,Size=UDim2.new(0,100,0,24),AlwaysOnTop=true,StudsOffset=Vector3.new(0,2.5,0)})N("TextLabel",{Parent=b,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=pl.Name,Font=Enum.Font.GothamBold,TextSize=12,TextColor3=C.red,TextStrokeTransparency=0.5})end end end end
        task.wait(1)
    end end)
end

-- UI SETUP
local gui=N("ScreenGui",{Name="FantaScript",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,Parent=PG})
local main=N("Frame",{Parent=gui,AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0.5,0,0.5,0),Size=UDim2.new(0,680,0,420),BackgroundColor3=C.bg,BorderSizePixel=0})
cr(main,16);st(main,C.bd)
N("Frame",{Parent=main,Size=UDim2.new(1,0,0,45),BackgroundColor3=C.card,BorderSizePixel=0}).Parent=main
local top=main:GetChildren()[1];cr(top,16);N("Frame",{Parent=top,Position=UDim2.new(0,0,1,-1),Size=UDim2.new(1,0,0,1),BackgroundColor3=C.bd,BorderSizePixel=0})
N("TextLabel",{Parent=top,Position=UDim2.new(0,20,0,0),Size=UDim2.new(0,200,1,0),BackgroundTransparency=1,Text="FANTASCRIPT",Font=Enum.Font.GothamBlack,TextSize=16,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})
N("TextLabel",{Parent=top,Position=UDim2.new(0,130,0,0),Size=UDim2.new(0,100,1,0),BackgroundTransparency=1,Text="/ Steal An Egg",Font=Enum.Font.Gotham,TextSize=12,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left})
local close=N("TextButton",{Parent=top,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-15,0.5,0),Size=UDim2.new(0,28,0,28),BackgroundColor3=C.bg,Text="✕",Font=Enum.Font.GothamBold,TextSize=14,TextColor3=C.txt,AutoButtonColor=false});cr(close,8);close.MouseButton1Click:Connect(function()gui:Destroy()end)
-- Sidebar
local side=N("Frame",{Parent=main,Position=UDim2.new(0,0,0,45),Size=UDim2.new(0,60,1,-45),BackgroundColor3=C.card,BorderSizePixel=0});N("Frame",{Parent=side,Position=UDim2.new(1,-1,0,0),Size=UDim2.new(0,1,1,0),BackgroundColor3=C.bd,BorderSizePixel=0})
local sideL=N("UIListLayout",{Parent=side,Padding=UDim.new(0,6),HorizontalAlignment=Enum.HorizontalAlignment.Center});N("UIPadding",{Parent=side,PaddingTop=UDim.new(0,15)})
local content=N("Frame",{Parent=main,Position=UDim2.new(0,60,0,45),Size=UDim2.new(1,-60,1,-45),BackgroundTransparency=1});N("UIPadding",{Parent=content,PaddingLeft=UDim.new(0,15),PaddingTop=UDim.new(0,15),PaddingRight=UDim.new(0,15)})
-- Componentes UI
local abas={}local btns={}local curr=nil
local function makeTab(id,icon)
    local btn=N("TextButton",{Parent=side,Size=UDim2.new(0,40,0,40),BackgroundColor3=C.bg,Text=icon,Font=Enum.Font.GothamBold,TextSize=18,TextColor3=C.txt2,AutoButtonColor=false});cr(btn,10)
    btn.MouseButton1Click:Connect(function()for i,b in pairs(btns)do b.BackgroundColor3=C.bg;b.TextColor3=C.txt2 end btn.BackgroundColor3=C.card;btn.TextColor3=C.acc if abas[curr]then abas[curr].Visible=false end curr=id;abas[id].Visible=true end)
    btns[id]=btn
    local f=N("ScrollingFrame",{Parent=content,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,ScrollBarThickness=2,ScrollBarImageColor3=C.bd,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,Visible=false})
    N("UIListLayout",{Parent=f,Padding=UDim.new(0,10),SortOrder=Enum.SortOrder.LayoutOrder});abas[id]=f;return f
end
local function addTitle(p,t)local f=N("Frame",{Parent=p,Size=UDim2.new(1,0,0,24),BackgroundTransparency=1})N("TextLabel",{Parent=f,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=t,Font=Enum.Font.GothamBold,TextSize=12,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left})end
local function addToggle(p,t,d,cb)local f=N("Frame",{Parent=p,Size=UDim2.new(1,0,0,50),BackgroundColor3=C.card});cr(f,10);st(f,C.bd)
    N("TextLabel",{Parent=f,Position=UDim2.new(0,15,0,6),Size=UDim2.new(1,-60,0,16),BackgroundTransparency=1,Text=t,Font=Enum.Font.GothamBold,TextSize=12,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})
    if d then N("TextLabel",{Parent=f,Position=UDim2.new(0,15,0,22),Size=UDim2.new(1,-60,0,16),BackgroundTransparency=1,Text=d,Font=Enum.Font.Gotham,TextSize=10,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left}) end
    local stt=false;local sw=N("TextButton",{Parent=f,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-15,0.5,0),Size=UDim2.new(0,42,0,22),BackgroundColor3=C.bd,Text="",AutoButtonColor=false});cr(sw,11)
    local kn=N("Frame",{Parent=sw,Position=UDim2.new(0,2,0,2),Size=UDim2.new(0,18,0,18),BackgroundColor3=C.card,BorderSizePixel=0});cr(kn,9)
    sw.MouseButton1Click:Connect(function()stt=not stt kn.Position=stt and UDim2.new(1,-20,0,2)or UDim2.new(0,2,0,2)sw.BackgroundColor3=stt and C.grn or C.bd if cb then cb(stt)end end)end
local function addSlider(p,t,max,def,cb)local f=N("Frame",{Parent=p,Size=UDim2.new(1,0,0,50),BackgroundColor3=C.card});cr(f,10);st(f,C.bd)
    N("TextLabel",{Parent=f,Position=UDim2.new(0,15,0,6),Size=UDim2.new(1,0,0,16),BackgroundTransparency=1,Text=t,Font=Enum.Font.GothamBold,TextSize=12,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})
    local val=N("TextLabel",{Parent=f,Position=UDim2.new(1,-60,0,6),Size=UDim2.new(0,45,0,16),BackgroundTransparency=1,Text=tostring(def),Font=Enum.Font.GothamBold,TextSize=12,TextColor3=C.acc,TextXAlignment=Enum.TextXAlignment.Right})
    local bar=N("Frame",{Parent=f,Position=UDim2.new(0,15,0,28),Size=UDim2.new(1,-30,0,6),BackgroundColor3=C.bd,BorderSizePixel=0});cr(bar,3)
    local fill=N("Frame",{Parent=bar,Size=UDim2.new(def/max,0,1,0),BackgroundColor3=C.acc,BorderSizePixel=0});cr(fill,3)
    local dragging=false;bar.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=true end end)
    UIS.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false end end)
    UIS.InputChanged:Connect(function(i)if dragging and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then local pct=math.clamp((i.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)fill.Size=UDim2.new(pct,0,1,0)local v=math.floor(pct*max)val.Text=tostring(v)if cb then cb(v)end end end)end
local function addBtn(p,t,cb)local f=N("TextButton",{Parent=p,Size=UDim2.new(1,0,0,36),BackgroundColor3=C.card,Text=t,Font=Enum.Font.GothamBold,TextSize=12,TextColor3=C.txt,AutoButtonColor=false});cr(f,10);st(f,C.bd)
    f.MouseButton1Click:Connect(function()pcall(cb)end)end

-- ABAS
local tDash=makeTab("dash","🏠");local tFarm=makeTab("farm","🌾");local tPlayer=makeTab("player","👤");local tConfig=makeTab("cfg","⚙️")
-- Dashboard
addTitle(tDash,"DASHBOARD")
local banner=N("Frame",{Parent=tDash,Size=UDim2.new(1,0,0,80),BackgroundColor3=C.acc});cr(banner,10)
N("TextLabel",{Parent=banner,Position=UDim2.new(0,20,0,20),Size=UDim2.new(1,0,0,20),BackgroundTransparency=1,Text="Welcome back,",Font=Enum.Font.Gotham,TextSize=12,TextColor3=Color3.fromRGB(255,255,255),TextXAlignment=Enum.TextXAlignment.Left})
N("TextLabel",{Parent=banner,Position=UDim2.new(0,20,0,36),Size=UDim2.new(1,0,0,24),BackgroundTransparency=1,Text=LP.Name,Font=Enum.Font.GothamBold,TextSize=18,TextColor3=Color3.fromRGB(255,255,255),TextXAlignment=Enum.TextXAlignment.Left})
addBtn(tDash,"Rejoin Server",function()game:GetService("TeleportService"):Teleport(game.PlaceId,LP)end)
addBtn(tDash,"Copy Job ID",function()if setclipboard then setclipboard(game.JobId)end end)
-- Farm
addTitle(tFarm,"AUTO FARM")
addToggle(tFarm,"Auto Steal","Vai até o ovo mais próximo",function(v)Flags.Steal=v end)
addToggle(tFarm,"Auto Hatch","Choca ovos na sua base",function(v)Flags.Hatch=v end)
addToggle(tFarm,"Auto Sell","Vende pets/ovos na sua base",function(v)Flags.Sell=v end)
-- Player
addTitle(tPlayer,"MOVIMENTO")
addSlider(tPlayer,"WalkSpeed",1000,16,function(v)Flags.Speed=v if LP.Character and LP.Character:FindFirstChild("Humanoid")then LP.Character.Humanoid.WalkSpeed=v end end)
addToggle(tPlayer,"Fly (WASD+Space)","Voa pelo mapa",function(v)Flags.Fly=v
    if v then local h=getHRP()if h then bv=N("BodyVelocity",{Parent=h,MaxForce=Vector3.new(1e5,1e5,1e5),Velocity=Vector3.new(0,0,0)})bg=N("BodyGyro",{Parent=h,MaxTorque=Vector3.new(1e5,1e5,1e5),P=1000,D=100,CFrame=h.CFrame})end
    else if bv then bv:Destroy()end if bg then bg:Destroy()end end end)
addToggle(tPlayer,"Noclip","Atravessa paredes",function(v)Flags.Noclip=v end)
addTitle(tPlayer,"ESP")
addToggle(tPlayer,"Egg ESP","Mostra ovos",function(v)Flags.ESP_Eggs=v updESP()end)
addToggle(tPlayer,"Player ESP","Mostra jogadores",function(v)Flags.ESP_Players=v updESP()end)
-- Config
addTitle(tConfig,"CONFIGURAÇÕES")
addBtn(tConfig,"Reset Tudo",function()
    Flags.Steal=false Flags.Hatch=false Flags.Sell=false Flags.Fly=false Flags.Noclip=false Flags.ESP_Eggs=false Flags.ESP_Players=false
    if bv then bv:Destroy()end if bg then bg:Destroy()end
    updESP() main:Destroy() print("FantaScript Desligado.")
end)
-- Fechar e Iniciar
curr="dash";abas["dash"].Visible=true;btns["dash"].BackgroundColor3=C.card;btns["dash"].TextColor3=C.acc
print("[FANTASCRIPT] White Edition Carregado.")
