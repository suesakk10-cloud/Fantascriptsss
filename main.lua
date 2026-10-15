-- DOCHILLI HUB v1.0
local P=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local TW=game:GetService("TweenService")
local LP=P.LocalPlayer
local PG=LP:WaitForChild("PlayerGui")
local old=PG:FindFirstChild("DochilliHub") if old then old:Destroy() end

local C={bg=Color3.fromRGB(18,12,22),card=Color3.fromRGB(30,20,36),bd=Color3.fromRGB(55,30,70),red=Color3.fromRGB(180,30,60),pur=Color3.fromRGB(120,60,180),txt=Color3.fromRGB(240,235,245),txt2=Color3.fromRGB(160,150,175)}

local function N(c,p) local i=Instance.new(c) if p then local x=p.Parent;p.Parent=nil;for k,v in pairs(p) do i[k]=v end;i.Parent=x end return i end
local function cr(p,r) N("UICorner",{Parent=p,CornerRadius=UDim.new(0,r or 6)}) end
local function st(p,c) N("UIStroke",{Parent=p,Color=c or C.bd,Thickness=1}) end
local function rt() local c=LP.Character return c and c:FindFirstChild("HumanoidRootPart") end

local NH=N("Frame",{Parent=PG,AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-16,0,16),Size=UDim2.new(0,260,0,400),BackgroundTransparency=1})
N("UIListLayout",{Parent=NH,Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder,VerticalAlignment=Enum.VerticalAlignment.Top,HorizontalAlignment=Enum.HorizontalAlignment.Right})
local function nt(t,m,c) c=c or C.red
local b=N("Frame",{Parent=NH,Size=UDim2.new(1,0,0,50),BackgroundColor3=C.card,BorderSizePixel=0})
cr(b,8) st(b,c)
N("TextLabel",{Parent=b,Position=UDim2.new(0,8,0,4),Size=UDim2.new(1,-16,0,16),BackgroundTransparency=1,Text=t,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=c,TextXAlignment=Enum.TextXAlignment.Left})
N("TextLabel",{Parent=b,Position=UDim2.new(0,8,0,22),Size=UDim2.new(1,-16,0,24),BackgroundTransparency=1,Text=m,Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true})
task.delay(5,function() if b.Parent then b:Destroy() end end) end

local gui=N("ScreenGui",{Name="DochilliHub",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,Parent=PG})
local fb=N("TextButton",{Parent=gui,Position=UDim2.new(0,20,0,20),Size=UDim2.new(0,52,0,52),BackgroundColor3=C.bg,Text="",AutoButtonColor=false,ZIndex=9999})
cr(fb,26) st(fb,C.red)
N("TextLabel",{Parent=fb,Position=UDim2.new(0.5,-16,0.5,-16),Size=UDim2.new(0,32,0,32),BackgroundTransparency=1,Text="🥚",Font=Enum.Font.GothamBlack,TextSize=22,ZIndex=10000})

local pan=N("Frame",{Parent=gui,AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0.5,0,0.5,0),Size=UDim2.new(0,520,0,540),BackgroundColor3=C.bg,BorderSizePixel=0,ClipsDescendants=true,ZIndex=1000})
cr(pan,12) st(pan,C.pur)
local hd=N("Frame",{Parent=pan,Size=UDim2.new(1,0,0,40),BackgroundColor3=Color3.fromRGB(0,0,0),BackgroundTransparency=0.65,BorderSizePixel=0})
cr(hd,12)
N("TextLabel",{Parent=hd,Position=UDim2.new(0,12,0,0),Size=UDim2.new(1,-100,1,0),BackgroundTransparency=1,Text="🥚 DOCHILLI HUB v1.0",Font=Enum.Font.GothamBold,TextSize=12,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})
local xb=N("TextButton",{Parent=hd,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-12,0.5,0),Size=UDim2.new(0,24,0,24),BackgroundTransparency=1,Text="✕",Font=Enum.Font.GothamBold,TextSize=14,TextColor3=C.txt2,AutoButtonColor=false})
xb.MouseButton1Click:Connect(function() gui:Destroy() end)

local bd=N("Frame",{Parent=pan,Position=UDim2.new(0,8,0,46),Size=UDim2.new(1,-16,1,-54),BackgroundTransparency=1})
local sb=N("ScrollingFrame",{Parent=bd,Size=UDim2.new(0,130,1,0),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=C.pur,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})
N("UIListLayout",{Parent=sb,Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder})
local ct=N("Frame",{Parent=bd,Position=UDim2.new(0,138,0,0),Size=UDim2.new(1,-138,1,0),BackgroundColor3=Color3.fromRGB(25,16,32),BorderSizePixel=0})
cr(ct,8) st(ct,C.bd)

local tabs,tb,cur={},{},nil
local function sTab(id) if cur and tabs[cur] then tabs[cur].Visible=false;tb[cur].BackgroundColor3=C.card;tb[cur].TextColor3=C.txt2 end
cur=id if tabs[id] then tabs[id].Visible=true;tb[id].BackgroundColor3=C.red;tb[id].TextColor3=Color3.fromRGB(255,255,255) end end

local function mTab(id,l,fn)
local b=N("TextButton",{Parent=sb,Size=UDim2.new(1,0,0,28),BackgroundColor3=C.card,Text=l,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left,AutoButtonColor=false})
cr(b,6) st(b,C.bd)
N("UIPadding",{Parent=b,PaddingLeft=UDim.new(0,8)})
b.MouseButton1Click:Connect(function() sTab(id) end)
tb[id]=b
local f=N("ScrollingFrame",{Parent=ct,Size=UDim2.new(1,-12,1,-12),Position=UDim2.new(0,6,0,6),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=C.pur,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,Visible=false})
N("UIListLayout",{Parent=f,Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder})
tabs[id]=f fn(f) end

local function cd(p,h) local c=N("Frame",{Parent=p,Size=UDim2.new(1,0,0,h or 40),BackgroundColor3=C.card,BorderSizePixel=0}) cr(c,6) st(c,C.bd) return c end
local function lb(p,t,c) local f=cd(p,26)
N("TextLabel",{Parent=f,Position=UDim2.new(0,8,0,0),Size=UDim2.new(1,-16,1,0),BackgroundTransparency=1,Text=t,Font=Enum.Font.Gotham,TextSize=10,TextColor3=c or C.txt,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd}) end
local function bt(p,l,t,c,fn) local f=cd(p,34)
N("TextLabel",{Parent=f,Position=UDim2.new(0,8,0,0),Size=UDim2.new(1,-120,1,0),BackgroundTransparency=1,Text=l,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})
local b=N("TextButton",{Parent=f,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-8,0.5,0),Size=UDim2.new(0,100,0,22),BackgroundColor3=c or C.red,Text=t or "OK",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})
cr(b,5)
b.MouseButton1Click:Connect(function() local ok,e=pcall(fn) if not ok then nt("Erro",tostring(e),C.red) end end) end
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

-- ===== ABA HOME =====
mTab("home","🏠 Início",function(t)
lb(t,"DOCHILLI HUB v1.0")
lb(t,"Radar de ovos + Pet Index")
lb(t,"Dados DEMO — edita o script")
end)

-- ===== ABA EGG RADAR =====
local function scan()
local r=rt() local l={}
if not r then return l end
for _,o in ipairs(workspace:GetDescendants()) do
if o:IsA("BasePart") then local n=o.Name:lower()
if n:find("egg") or n:find("ovo") or n:find("brainrot") then
table.insert(l,{nome=o.Name,dist=(o.Position-r.Position).Magnitude,pos=o.Position}) end end end
table.sort(l,function(a,b) return a.dist<b.dist end)
return l end

mTab("radar","🔍 Egg Radar",function(t)
lb(t,"Procurar ovos no mapa")
bt(t,"Fazer scan","Scan",C.pur,function()
local l=scan() nt("Egg Radar",#l.." ovos encontrados",C.pur) end)
local lf=N("ScrollingFrame",{Parent=t,Size=UDim2.new(1,0,0,260),BackgroundColor3=Color3.fromRGB(15,10,20),BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=C.red,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})
cr(lf,6) N("UIListLayout",{Parent=lf,Padding=UDim.new(0,3),SortOrder=Enum.SortOrder.LayoutOrder})
bt(t,"Atualizar lista","Refresh",C.red,function()
for _,c in ipairs(lf:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
for _,o in ipairs(scan()) do
local row=N("TextButton",{Parent=lf,Size=UDim2.new(1,0,0,24),BackgroundColor3=C.card,Text="",AutoButtonColor=false})
cr(row,4)
N("TextLabel",{Parent=row,Position=UDim2.new(0,6,0,0),Size=UDim2.new(1,-12,1,0),BackgroundTransparency=1,Text=string.format("%s (%.0f studs)",o.nome,o.dist),Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})
row.MouseButton1Click:Connect(function() local r=rt() if r then r.CFrame=CFrame.new(o.pos+Vector3.new(0,3,0)) end end) end end) end)

-- ===== ABA PET INDEX =====
mTab("index","📖 Pet Index",function(t)
lb(t,"Lista de pets (DEMO)")
lb(t,"Edita o script para valores reais")
bt(t,"Exportar coleção","JSON",C.pur,function()
nt("Exportar","(função exemplo)",C.pur) end) end)

-- ===== ABA SERVER =====
mTab("srv","🌐 Server",function(t)
lb(t,"Job ID: "..string.sub(game.JobId,1,8).."...")
lb(t,"Jogadores: "..#P:GetPlayers().."/"..P.MaxPlayers)
bt(t,"Copiar Job ID","Copiar",C.pur,function()
if setclipboard then setclipboard(game.JobId) end
nt("Server","Job ID copiado!",C.pur) end) end)

-- ===== ABA CONFIG =====
mTab("cfg","⚙ Config",function(t)
tg(t,"Animações","Ativa transições suaves",function(v)
nt("Config","Animações "..(v and "ON" or "OFF"),C.pur) end)
bt(t,"Fechar painel","Fechar",C.red,function() pan.Visible=false end) end)

-- Drag
local function drag(h,tg,cl)
local d,ds,sp,mv=false,nil,nil,false
h.InputBegan:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
d=true mv=false ds=i.Position sp=tg.Position
i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then d=false if not mv and cl then cl() end end end) end end)
UIS.InputChanged:Connect(function(i)
if not d then return end
if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then
local dl=i.Position-ds
if math.abs(dl.X)>3 or math.abs(dl.Y)>3 then mv=true end
tg.Position=UDim2.new(sp.X.Scale,sp.X.Offset+dl.X,sp.Y.Scale,sp.Y.Offset+dl.Y) end end) end

drag(hd,pan)
drag(fb,fb,function() pan.Visible=not pan.Visible end)

sTab("home")
nt("DOCHILLI HUB","Carregado com sucesso!",C.pur)
print("[DOCHILLI HUB] Carregado.")
