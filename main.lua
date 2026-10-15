-- FANTASCRIPT v7.0 — Full com Painel Duplo
local P=game:GetService("Players")local UIS=game:GetService("UserInputService")local TW=game:GetService("TweenService")local RS=game:GetService("RunService")local LG=game:GetService("Lighting")local HS=game:GetService("HttpService")local LP=P.LocalPlayer local PG=LP:WaitForChild("PlayerGui")
local old=PG:FindFirstChild("FantaScript")if old then old:Destroy()end
local IDX={
{n="Chicken",r="Common",v=1,ovo="Forest"},{n="Dog",r="Common",v=2,ovo="Forest"},{n="Bird",r="Uncommon",v=8,ovo="Forest"},{n="Owl",r="Rare",v=35,ovo="Forest"},{n="Raccoon",r="Rare",v=45,ovo="Forest"},{n="Fox",r="Epic",v=180,ovo="Forest"},{n="Bear",r="Epic",v=240,ovo="Forest"},{n="Brr Brr Patapim",r="Legendary",v=1800,ovo="Forest"},
{n="Frog",r="Common",v=3,ovo="Lake"},{n="Duckling",r="Common",v=4,ovo="Lake"},{n="Catfish",r="Uncommon",v=12,ovo="Lake"},{n="Turtle",r="Rare",v=60,ovo="Lake"},{n="Trulimero Trulicina",r="Epic",v=260,ovo="Lake"},{n="Swan",r="Epic",v=320,ovo="Lake"},{n="Axolotl",r="Legendary",v=2800,ovo="Lake"},{n="Leviathan",r="Cosmic",v=220000,ovo="Lake"},
{n="Jerboa",r="Common",v=6,ovo="Desert"},{n="Fennec",r="Uncommon",v=18,ovo="Desert"},{n="Camel",r="Rare",v=75,ovo="Desert"},{n="Tob Tobi Tob Tob",r="Epic",v=325,ovo="Desert"},{n="Snake",r="Legendary",v=3600,ovo="Desert"},{n="Scorpion",r="Mythic",v=18500,ovo="Desert"},{n="Sand Spider",r="Mythic",v=16000,ovo="Desert"},{n="Royal Sphinx",r="Cosmic",v=280000,ovo="Desert"},
{n="Toucan",r="Rare",v=110,ovo="Jungle"},{n="Chimpanzee",r="Rare",v=90,ovo="Jungle"},{n="Crocodile",r="Epic",v=420,ovo="Jungle"},{n="Gorilla",r="Legendary",v=4800,ovo="Jungle"},{n="Orangutini",r="Legendary",v=5500,ovo="Jungle"},{n="Spider",r="Mythic",v=22000,ovo="Jungle"},{n="Tiger",r="Mythic",v=28000,ovo="Jungle"},{n="King Snake",r="Secret",v=3500000,ovo="Jungle"},
{n="Penguin",r="Rare",v=130,ovo="Snow"},{n="Walrus",r="Epic",v=460,ovo="Snow"},{n="Polar Bear",r="Legendary",v=6500,ovo="Snow"},{n="Sabertooth",r="Mythic",v=30000,ovo="Snow"},{n="Mammoth",r="Mythic",v=35000,ovo="Snow"},{n="King Mammoth",r="Cosmic",v=360000,ovo="Snow"},{n="Yeti",r="Secret",v=5000000,ovo="Snow"},{n="Ice Dragon",r="Eternal",v=65000000,ovo="Snow"},
{n="Lava Gecko",r="Rare",v=180,ovo="Volcano"},{n="Lava Frog",r="Epic",v=540,ovo="Volcano"},{n="Flaming Bull",r="Legendary",v=7500,ovo="Volcano"},{n="Lava Iguana",r="Legendary",v=8200,ovo="Volcano"},{n="Chillin Chilli",r="Mythic",v=45000,ovo="Volcano"},{n="Cerberus",r="Secret",v=8000000,ovo="Volcano"},{n="Phoenix",r="Eternal",v=85000000,ovo="Volcano"},{n="Lava Dragon",r="Eternal",v=100000000,ovo="Volcano"},
{n="Parrotfish",r="Rare",v=220,ovo="Ocean"},{n="Swordfish",r="Epic",v=620,ovo="Ocean"},{n="Shark",r="Legendary",v=9000,ovo="Ocean"},{n="Orca",r="Mythic",v=52000,ovo="Ocean"},{n="Whale Shark",r="Cosmic",v=380000,ovo="Ocean"},{n="Beluga",r="Cosmic",v=420000,ovo="Ocean"},{n="Kraken",r="Secret",v=15000000,ovo="Ocean"},{n="El Maja",r="Eternal",v=130000000,ovo="Ocean"},
{n="Dodo",r="Rare",v=260,ovo="Prehistoric"},{n="Pterodactyl",r="Epic",v=780,ovo="Prehistoric"},{n="Ankylosaurus",r="Legendary",v=11000,ovo="Prehistoric"},{n="Triceratops",r="Legendary",v=13000,ovo="Prehistoric"},{n="Bronto",r="Mythic",v=58000,ovo="Prehistoric"},{n="Tralaledon",r="Secret",v=32000000,ovo="Prehistoric"},{n="T-Rex",r="Secret",v=100000000,ovo="Prehistoric"},{n="Mosasaurus",r="Eternal",v=180000000,ovo="Prehistoric"},
{n="Centapede",r="Epic",v=950,ovo="Cosmic"},{n="Cosmic Gecko",r="Legendary",v=15000,ovo="Cosmic"},{n="Cosmic Gorilla",r="Legendary",v=18000,ovo="Cosmic"},{n="La Vacca Saturno",r="Cosmic",v=2200000,ovo="Cosmic"},{n="Cosmic Dragon",r="Secret",v=60000000,ovo="Cosmic"},{n="Cosmic Skeleton",r="Secret",v=45000000,ovo="Cosmic"},{n="Eternal Lunar",r="Eternal",v=250000000,ovo="Cosmic"},{n="Unicorn",r="Divine",v=1000000000,ovo="Cosmic"},
{n="Crane",r="Rare",v=320,ovo="Cherry"},{n="Salamander",r="Epic",v=1100,ovo="Cherry"},{n="Red Panda",r="Mythic",v=68000,ovo="Cherry"},{n="Koi",r="Cosmic",v=12000000,ovo="Cherry"},{n="Snowy Owl",r="Cosmic",v=7500000,ovo="Cherry"},{n="Stag",r="Secret",v=145000000,ovo="Cherry"},{n="Oni Tiger",r="Eternal",v=600000000,ovo="Cherry"},{n="Kitsune",r="Divine",v=3200000000,ovo="Cherry"},
{n="Crustacia",r="Epic",v=1400,ovo="Titan"},{n="Spideron",r="Legendary",v=22000,ovo="Titan"},{n="Bladehide",r="Legendary",v=26000,ovo="Titan"},{n="Mantaris",r="Cosmic",v=11000000,ovo="Titan"},{n="Rhinotaur",r="Cosmic",v=17500000,ovo="Titan"},{n="Mutant Shark",r="Eternal",v=204000000,ovo="Titan"},{n="Gorilla King",r="Eternal",v=880000000,ovo="Titan"},{n="Nightflame",r="Divine",v=3000000000,ovo="Titan"},
{n="Light Dove",r="Legendary",v=25000,ovo="Angels"},{n="Winged Lamb",r="Mythic",v=85000,ovo="Angels"},{n="Sacred Moth",r="Cosmic",v=25000000,ovo="Angels"},{n="Holy Peacock",r="Cosmic",v=32000000,ovo="Angels"},{n="Pure Jellyfish",r="Secret",v=243500000,ovo="Angels"},{n="Centaur",r="Secret",v=180000000,ovo="Angels"},{n="Pegasus",r="Eternal",v=850000000,ovo="Angels"},{n="ArchAngel",r="Divine",v=6500000000,ovo="Angels"},
{n="Flame Sprite",r="Legendary",v=28000,ovo="Demons"},{n="Toro",r="Mythic",v=92000,ovo="Demons"},{n="Imp",r="Cosmic",v=22000000,ovo="Demons"},{n="Demon Hound",r="Cosmic",v=35000000,ovo="Demons"},{n="Gargoyle",r="Secret",v=210000000,ovo="Demons"},{n="RazorFang",r="Secret",v=250000000,ovo="Demons"},{n="Skeleton Horse",r="Eternal",v=800000000,ovo="Demons"},{n="World Burner",r="Divine",v=6200000000,ovo="Demons"},
{n="Equinox",r="Eternal",v=1800000000,ovo="Fusion"},{n="Aetheron",r="Divine",v=6900000000,ovo="Fusion"},
{n="Prism Gecko",r="Rare",v=450,ovo="Enchanted"},{n="Petal Beetle",r="Epic",v=1800,ovo="Enchanted"},{n="Enchanted Bluejay",r="Legendary",v=28000,ovo="Enchanted"},{n="Astral Jackalope",r="Legendary",v=32000,ovo="Enchanted"},{n="Spirit Panda",r="Mythic",v=95000,ovo="Enchanted"},{n="Starry Fox",r="Cosmic",v=18000000,ovo="Enchanted"},{n="Celestial Sunlion",r="Secret",v=200000000,ovo="Enchanted"},{n="Royal Skywhale",r="Eternal",v=1200000000,ovo="Enchanted"}
}
local Fav={}local Disc={}local Notifs={}local Errs={}local Cache={}local Config={accent="Vermelho",safe=false}
local function idxCor(r)if r=="Common"then return Color3.fromRGB(180,180,180)elseif r=="Uncommon"then return Color3.fromRGB(80,200,120)elseif r=="Rare"then return Color3.fromRGB(80,140,255)elseif r=="Epic"then return Color3.fromRGB(160,80,220)elseif r=="Legendary"then return Color3.fromRGB(255,180,60)elseif r=="Mythic"then return Color3.fromRGB(255,80,80)elseif r=="Cosmic"then return Color3.fromRGB(70,200,220)elseif r=="Secret"then return Color3.fromRGB(255,50,180)elseif r=="Eternal"then return Color3.fromRGB(240,220,60)elseif r=="Divine"then return Color3.fromRGB(255,255,255)end return Color3.fromRGB(140,140,150)end
local function fmt(v)if v>=1e9 then return string.format("%.2fB",v/1e9)elseif v>=1e6 then return string.format("%.2fM",v/1e6)elseif v>=1e3 then return string.format("%.1fK",v/1e3)end return tostring(v)end
local function N(c,p)local i=Instance.new(c)if p then local x=p.Parent;p.Parent=nil;for k,v in pairs(p)do i[k]=v end;i.Parent=x end return i end
local function cr(p,r)N("UICorner",{Parent=p,CornerRadius=UDim.new(0,r or 6)})end
local function st(p,c)N("UIStroke",{Parent=p,Color=c or Color3.fromRGB(48,48,55)})end
local function rt()local c=LP.Character return c and c:FindFirstChild("HumanoidRootPart")end
local function hm()local c=LP.Character return c and c:FindFirstChildOfClass("Humanoid")end
local C={bg=Color3.fromRGB(12,12,15),card=Color3.fromRGB(30,30,36),bd=Color3.fromRGB(48,48,55),red=Color3.fromRGB(200,30,40),grn=Color3.fromRGB(60,180,90),yel=Color3.fromRGB(240,180,50),blu=Color3.fromRGB(80,140,240),pur=Color3.fromRGB(140,80,220),txt=Color3.fromRGB(240,240,245),txt2=Color3.fromRGB(140,140,150)}
local St={speed=16,jump=100,gravity=196.2,flySpeed=50,espP=false,espE=false,espD=false,espH=false,noclip=false,fly=false,infJump=false,antiRag=false,antiVoid=false,autoSteal=false,autoHatch=false,autoSell=false,autoBuy=false,autoTreadmill=false,autoClaim=false,autoUpgrade=false,godMode=false}
local function apply()local h=hm()if h then h.WalkSpeed=St.speed h.JumpPower=St.jump h.UseJumpPower=true end workspace.Gravity=St.gravity end
LP.CharacterAdded:Connect(function()task.wait(1)apply()end)
local espF
local function clearESP()if espF then espF:Destroy()espF=nil end end
local function refreshESP()clearESP()if not(St.espP or St.espE)then return end espF=N("Folder",{Parent=PG,Name="FantaESP"})
task.spawn(function()while espF and espF.Parent do
if St.espP then for _,pl in ipairs(P:GetPlayers())do if pl~=LP and pl.Character then local hd=pl.Character:FindFirstChild("Head")if hd and not espF:FindFirstChild("P"..pl.Name)then local b=N("BillboardGui",{Parent=espF,Name="P"..pl.Name,Adornee=hd,Size=UDim2.new(0,150,0,44),AlwaysOnTop=true,StudsOffset=Vector3.new(0,2.5,0)})N("TextLabel",{Parent=b,Size=UDim2.new(1,0,0,16),BackgroundTransparency=1,Text=pl.Name,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.red,TextStrokeTransparency=0})if St.espH then local hl=N("TextLabel",{Parent=b,Position=UDim2.new(0,0,0,16),Size=UDim2.new(1,0,0,14),BackgroundTransparency=1,Text="",Font=Enum.Font.Code,TextSize=10,TextColor3=C.grn,TextStrokeTransparency=0})task.spawn(function()local h2=pl.Character:FindFirstChildOfClass("Humanoid")while hl.Parent and h2 do hl.Text="HP:"..math.floor(h2.Health)task.wait(0.3)end end)end if St.espD then local dl=N("TextLabel",{Parent=b,Position=UDim2.new(0,0,0,30),Size=UDim2.new(1,0,0,14),BackgroundTransparency=1,Text="",Font=Enum.Font.Code,TextSize=10,TextColor3=Color3.fromRGB(255,255,255),TextStrokeTransparency=0})task.spawn(function()while dl.Parent and rt()do local hr=pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")if hr then dl.Text=string.format("%.0f",(rt().Position-hr.Position).Magnitude)end task.wait(0.3)end end)end end end end end
if St.espE then for _,o in ipairs(workspace:GetDescendants())do if o:IsA("BasePart")then local n=o.Name:lower()if n:find("egg")or n:find("ovo")or n:find("brainrot")then if not espF:FindFirstChild("E"..o.Name)then local b=N("BillboardGui",{Parent=espF,Name="E"..o.Name,Adornee=o,Size=UDim2.new(0,130,0,32),AlwaysOnTop=true,StudsOffset=Vector3.new(0,2,0)})N("TextLabel",{Parent=b,Size=UDim2.new(1,0,0,16),BackgroundTransparency=1,Text="🥚 "..o.Name,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.yel,TextStrokeTransparency=0})if St.espD then local dl=N("TextLabel",{Parent=b,Position=UDim2.new(0,0,0,16),Size=UDim2.new(1,0,0,14),BackgroundTransparency=1,Text="",Font=Enum.Font.Code,TextSize=10,TextColor3=Color3.fromRGB(255,255,255),TextStrokeTransparency=0})task.spawn(function()while dl.Parent and rt()do dl.Text=string.format("%.0f",(o.Position-rt().Position).Magnitude)task.wait(0.3)end end)end end end end end end
task.wait(1.5)end end)end
RS.Stepped:Connect(function()if St.noclip then local c=LP.Character if c then for _,p in ipairs(c:GetDescendants())do if p:IsA("BasePart")then p.CanCollide=false end end end end if St.antiRag then local h=hm()if h then h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)h:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)end end end)
RS.Heartbeat:Connect(function()if St.antiVoid then local r=rt()if r and r.Position.Y<-80 then r.CFrame=CFrame.new(0,50,0)end end if St.godMode then local h=hm()if h then h.Health=math.huge end end end)
UIS.JumpRequest:Connect(function()if St.infJump then local h=hm()if h then h:ChangeState(Enum.HumanoidStateType.Jumping)end end end)
local bv,bg
local function startFly()local r=rt()if not r then return end bv=N("BodyVelocity",{Parent=r,MaxForce=Vector3.new(1e5,1e5,1e5),Velocity=Vector3.new(0,0,0)})bg=N("BodyGyro",{Parent=r,MaxTorque=Vector3.new(1e5,1e5,1e5),P=1000,D=100,CFrame=r.CFrame})end
local function stopFly()if bv then bv:Destroy()bv=nil end if bg then bg:Destroy()bg=nil end end
RS.RenderStepped:Connect(function()if not St.fly or not bv then return end local r=rt()if not r then return end local cam=workspace.CurrentCamera local m=Vector3.new(0,0,0)if UIS:IsKeyDown(Enum.KeyCode.W)then m=m+cam.CFrame.LookVector end if UIS:IsKeyDown(Enum.KeyCode.S)then m=m-cam.CFrame.LookVector end if UIS:IsKeyDown(Enum.KeyCode.A)then m=m-cam.CFrame.RightVector end if UIS:IsKeyDown(Enum.KeyCode.D)then m=m+cam.CFrame.RightVector end if UIS:IsKeyDown(Enum.KeyCode.Space)then m=m+Vector3.new(0,1,0)end if UIS:IsKeyDown(Enum.KeyCode.LeftControl)then m=m-Vector3.new(0,1,0)end bv.Velocity=m*St.flySpeed bg.CFrame=cam.CFrame end)
task.spawn(function()while task.wait(0.3)do if St.autoSteal then local r=rt()if r then local best,bd=nil,1e9 for _,o in ipairs(workspace:GetDescendants())do if o:IsA("BasePart")then local n=o.Name:lower()if n:find("egg")or n:find("ovo")or n:find("brainrot")then local d=(o.Position-r.Position).Magnitude if d<bd and d>5 then bd=d best=o end end end end if best then r.CFrame=CFrame.new(best.Position+Vector3.new(0,3,0))task.wait(0.1)local pr=best:FindFirstChildOfClass("ProximityPrompt")if pr then pcall(function()pr:InputHoldBegin()end)task.wait(0.2)pcall(function()pr:InputHoldEnd()end)end end end end end end)
task.spawn(function()while task.wait(1)do if St.autoHatch or St.autoSell or St.autoBuy or St.autoClaim or St.autoUpgrade then local r=rt()if r then for _,o in ipairs(workspace:GetDescendants())do if o:IsA("ProximityPrompt")then local at=o.ActionText:lower()local ok=false if St.autoHatch and(at:find("hatch")or at:find("chocar"))then ok=true end if St.autoSell and(at:find("sell")or at:find("vender"))then ok=true end if St.autoBuy and(at:find("buy")or at:find("comprar"))then ok=true end if St.autoClaim and(at:find("claim")or at:find("resgatar"))then ok=true end if St.autoUpgrade and(at:find("upgrade")or at:find("melhorar"))then ok=true end if ok and o.Parent and o.Parent:IsA("BasePart")and(o.Parent.Position-r.Position).Magnitude<25 then pcall(function()o:InputHoldBegin()end)task.wait(0.15)pcall(function()o:InputHoldEnd()end)end end end end end end end)
task.spawn(function()while task.wait(2)do if St.autoTreadmill then local r=rt()if r then for _,o in ipairs(workspace:GetDescendants())do if o:IsA("BasePart")and o.Name:lower():find("treadmill")then r.CFrame=CFrame.new(o.Position+Vector3.new(0,5,0))break end end end end end end)
local eggF=N("Folder",{Parent=PG,Name="EggTracker"})
local function scanEggs()local r=rt()local list={}if not r then return list end for _,o in ipairs(workspace:GetDescendants())do if o:IsA("BasePart")then local n=o.Name:lower()if n:find("egg")or n:find("ovo")or n:find("brainrot")then table.insert(list,{nome=o.Name,ref=o,pos=o.Position,dist=(o.Position-r.Position).Magnitude})end end end table.sort(list,function(a,b)return a.dist<b.dist end)Cache.eggs=list return list end
local NH=N("Frame",{Parent=PG,AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-16,0,16),Size=UDim2.new(0,260,0,400),BackgroundTransparency=1,ZIndex=9999})N("UIListLayout",{Parent=NH,Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder,VerticalAlignment=Enum.VerticalAlignment.Top,HorizontalAlignment=Enum.HorizontalAlignment.Right})
local function nt(t,m,c)c=c or C.red local b=N("Frame",{Parent=NH,Size=UDim2.new(1,0,0,46),BackgroundColor3=C.card,BorderSizePixel=0,ZIndex=9999})cr(b,6)st(b,c)N("TextLabel",{Parent=b,Position=UDim2.new(0,8,0,4),Size=UDim2.new(1,-16,0,16),BackgroundTransparency=1,Text=t,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=c,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=9999})N("TextLabel",{Parent=b,Position=UDim2.new(0,8,0,22),Size=UDim2.new(1,-16,0,20),BackgroundTransparency=1,Text=m,Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true,ZIndex=9999})table.insert(Notifs,{t=t,m=m})task.delay(4,function()if b.Parent then b:Destroy()end end)end
local function logErr(e)table.insert(Errs,{t=os.date("%H:%M:%S"),msg=tostring(e)})end
local gui=N("ScreenGui",{Name="FantaScript",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,Parent=PG,DisplayOrder=999})
local fb=N("TextButton",{Parent=gui,Position=UDim2.new(0,20,0,20),Size=UDim2.new(0,50,0,50),BackgroundColor3=C.card,Text="",AutoButtonColor=false,ZIndex=9999})cr(fb,25)st(fb,C.red,2)N("TextLabel",{Parent=fb,Position=UDim2.new(0.5,-16,0.5,-16),Size=UDim2.new(0,32,0,32),BackgroundTransparency=1,Text="🔥",Font=Enum.Font.GothamBlack,TextSize=20,ZIndex=10000})
local pan=N("Frame",{Parent=gui,AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0.5,0,0.5,0),Size=UDim2.new(0,700,0,440),BackgroundColor3=C.bg,BorderSizePixel=0,ClipsDescendants=true,ZIndex=1000,Visible=true})
cr(pan,10)st(pan,C.red,2)
local hd=N("Frame",{Parent=pan,Size=UDim2.new(1,0,0,36),BackgroundColor3=C.red,BorderSizePixel=0})cr(hd,10)
N("TextLabel",{Parent=hd,Position=UDim2.new(0,12,0,0),Size=UDim2.new(1,-160,1,0),BackgroundTransparency=1,Text="🔥 FANTASCRIPT v7.0 — Full",Font=Enum.Font.GothamBlack,TextSize=13,TextColor3=Color3.fromRGB(255,255,255),TextXAlignment=Enum.TextXAlignment.Left})
local minBtn=N("TextButton",{Parent=hd,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-40,0.5,0),Size=UDim2.new(0,26,0,26),BackgroundColor3=Color3.fromRGB(0,0,0),BackgroundTransparency=0.4,Text="_",Font=Enum.Font.GothamBlack,TextSize=14,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})cr(minBtn,4)
minBtn.MouseButton1Click:Connect(function()pan.Size=UDim2.new(0,700,0,36)end)
local xb=N("TextButton",{Parent=hd,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-10,0.5,0),Size=UDim2.new(0,26,0,26),BackgroundColor3=Color3.fromRGB(0,0,0),BackgroundTransparency=0.4,Text="X",Font=Enum.Font.GothamBlack,TextSize=13,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})cr(xb,4)xb.MouseButton1Click:Connect(function()pan.Visible=false end)
local lM=N("ScrollingFrame",{Parent=pan,Position=UDim2.new(0,6,0,44),Size=UDim2.new(0,110,0,350),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=C.red,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})N("UIListLayout",{Parent=lM,Padding=UDim.new(0,3),SortOrder=Enum.SortOrder.LayoutOrder})
local rM=N("ScrollingFrame",{Parent=pan,AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-6,0,44),Size=UDim2.new(0,110,0,350),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=C.red,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})N("UIListLayout",{Parent=rM,Padding=UDim.new(0,3),SortOrder=Enum.SortOrder.LayoutOrder})
local ce=N("Frame",{Parent=pan,Position=UDim2.new(0,122,0,44),Size=UDim2.new(1,-244,1,-90),BackgroundColor3=C.card,BorderSizePixel=0})cr(ce,8)st(ce,C.bd)
local footer=N("Frame",{Parent=pan,AnchorPoint=Vector2.new(0,1),Position=UDim2.new(0,6,1,-38),Size=UDim2.new(1,-12,0,32),BackgroundColor3=C.card,BorderSizePixel=0})cr(footer,6)st(footer,C.bd)
N("TextLabel",{Parent=footer,Position=UDim2.new(0,10,0,0),Size=UDim2.new(0,60,1,0),BackgroundTransparency=1,Text="Buscar",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})
local sBox=N("TextBox",{Parent=footer,Position=UDim2.new(0,70,0,4),Size=UDim2.new(1,-80,1,-8),BackgroundColor3=Color3.fromRGB(10,10,12),BorderSizePixel=0,PlaceholderText="Filtrar funções ou pets...",PlaceholderColor3=C.txt2,Text="",Font=Enum.Font.Gotham,TextSize=10,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false})cr(sBox,4)N("UIPadding",{Parent=sBox,PaddingLeft=UDim.new(0,6)})
local tabs,tb,cur={},{},nil
local function sTab(id)if cur and tabs[cur]then tabs[cur].Visible=false;tb[cur].BackgroundColor3=C.card;tb[cur].TextColor3=C.txt end cur=id if tabs[id]then tabs[id].Visible=true;tb[id].BackgroundColor3=C.red;tb[id].TextColor3=Color3.fromRGB(255,255,255)end end
local function mk(lb,id,m)local b=N("TextButton",{Parent=m,Size=UDim2.new(1,0,0,26),BackgroundColor3=C.card,Text=lb,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.txt,AutoButtonColor=false})cr(b,5)st(b,C.bd)b.MouseButton1Click:Connect(function()sTab(id)end)tb[id]=b local f=N("ScrollingFrame",{Parent=ce,Size=UDim2.new(1,-12,1,-12),Position=UDim2.new(0,6,0,6),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=C.red,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,Visible=false})N("UIListLayout",{Parent=f,Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder})tabs[id]=f return f end
local function rw(p,h)local c=N("Frame",{Parent=p,Size=UDim2.new(1,0,0,h or 36),BackgroundColor3=C.card,BorderSizePixel=0})cr(c,5)st(c,C.bd)return c end
local function tg(p,lb,d,i,fn)local c=rw(p,40)N("TextLabel",{Parent=c,Position=UDim2.new(0,8,0,4),Size=UDim2.new(1,-60,0,14),BackgroundTransparency=1,Text=lb,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})if d then N("TextLabel",{Parent=c,Position=UDim2.new(0,8,0,20),Size=UDim2.new(1,-60,0,16),BackgroundTransparency=1,Text=d,Font=Enum.Font.Gotham,TextSize=8,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true})end local s=i or false local sw=N("TextButton",{Parent=c,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-8,0.5,0),Size=UDim2.new(0,36,0,20),BackgroundColor3=s and C.grn or Color3.fromRGB(60,60,68),Text="",AutoButtonColor=false})cr(sw,10)local kn=N("Frame",{Parent=sw,Position=s and UDim2.new(1,-17,0,2)or UDim2.new(0,2,0,2),Size=UDim2.new(0,16,0,16),BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0})cr(kn,8)sw.MouseButton1Click:Connect(function()s=not s TW:Create(kn,TweenInfo.new(0.15),{Position=s and UDim2.new(1,-17,0,2)or UDim2.new(0,2,0,2)}):Play()sw.BackgroundColor3=s and C.grn or Color3.fromRGB(60,60,68)if fn then local ok,e=pcall(fn,s)if not ok then logErr(e)end end end)end
local function nm(p,lb,i,fn)local c=rw(p,36)N("TextLabel",{Parent=c,Position=UDim2.new(0,8,0,0),Size=UDim2.new(1,-110,1,0),BackgroundTransparency=1,Text=lb,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})local b=N("TextBox",{Parent=c,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-8,0.5,0),Size=UDim2.new(0,90,0,24),BackgroundColor3=Color3.fromRGB(10,10,12),BorderSizePixel=0,Text=tostring(i or 16),Font=Enum.Font.GothamBold,TextSize=11,TextColor3=Color3.fromRGB(255,255,255),TextXAlignment=Enum.TextXAlignment.Center,ClearTextOnFocus=false})cr(b,4)st(b,C.bd)b.FocusLost:Connect(function()local n=tonumber(b.Text)if n and fn then local ok,e=pcall(fn,n)if not ok then logErr(e)end end end)end
local function bt(p,lb,t,c,fn)local f=rw(p,34)N("TextLabel",{Parent=f,Position=UDim2.new(0,8,0,0),Size=UDim2.new(1,-110,1,0),BackgroundTransparency=1,Text=lb,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left})local b=N("TextButton",{Parent=f,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-8,0.5,0),Size=UDim2.new(0,90,0,22),BackgroundColor3=c or C.red,Text=t or "OK",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})cr(b,5)b.MouseButton1Click:Connect(function()local ok,e=pcall(fn)if not ok then logErr(e)nt("Erro",tostring(e),C.red)end end)end
local function inf(p,t)local c=rw(p,24)N("TextLabel",{Parent=c,Position=UDim2.new(0,8,0,0),Size=UDim2.new(1,-16,1,0),BackgroundTransparency=1,Text=t,Font=Enum.Font.Gotham,TextSize=10,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd})end
local t=mk("🌾 Farm","farm",lM)
tg(t,"Racing Event","Placeholder.")tg(t,"Shooting Star","Placeholder.")tg(t,"Dr Scramble Lab","Placeholder.")tg(t,"Butterfly Bloom","Placeholder.")tg(t,"Wisp Companion","Placeholder.")tg(t,"Auto Mutation","Placeholder.",false,function(v)end)tg(t,"Auto Place Egg","Placeholder.",false,function(v)end)
tg(t,"Auto Treadmill","Esteira.",false,function(v)St.autoTreadmill=v end)
tg(t,"Auto Hatch","Choca ovos.",false,function(v)St.autoHatch=v end)
tg(t,"Auto Sell","Vende.",false,function(v)St.autoSell=v end)
tg(t,"Auto Buy","Compra.",false,function(v)St.autoBuy=v end)
tg(t,"Auto Claim","Resgata.",false,function(v)St.autoClaim=v end)
tg(t,"Auto Upgrade","Melhora.",false,function(v)St.autoUpgrade=v end)
tg(t,"Auto Favorite","Favorita.",false,function(v)end)
tg(t,"Auto Progression","Placeholder.",false,function(v)end)
t=mk("👤 Player","player",lM)
nm(t,"WalkSpeed (0-1000)",St.speed,function(n)if n<0 then n=0 end if n>1000 then n=1000 end St.speed=n apply()nt("Speed",n,C.grn)end)
nm(t,"JumpPower",St.jump,function(n)St.jump=n apply()end)
nm(t,"Gravity",St.gravity,function(n)St.gravity=n apply()end)
nm(t,"FOV",70,function(n)if workspace.CurrentCamera then workspace.CurrentCamera.FieldOfView=n end end)
nm(t,"Fly Speed",St.flySpeed,function(n)St.flySpeed=n end)
tg(t,"Infinite Jump","Pula no ar.",false,function(v)St.infJump=v end)
tg(t,"Fly (WASD+Space)","Voa.",false,function(v)St.fly=v if v then startFly()else stopFly()end end)
tg(t,"Noclip","Atravessa.",false,function(v)St.noclip=v end)
tg(t,"Anti-Ragdoll","Não cai.",false,function(v)St.antiRag=v end)
tg(t,"Anti-Void","Não morre no vazio.",false,function(v)St.antiVoid=v end)
tg(t,"God Mode","HP infinito local.",false,function(v)St.godMode=v end)
bt(t,"Reset Character","Reset",C.red,function()local c=LP.Character if c then c:BreakJoints()end end)
bt(t,"TP Spawn","TP",C.blu,function()local r=rt()if r then r.CFrame=CFrame.new(0,50,0)end end)
t=mk("👁 Visual","vis",lM)
tg(t,"ESP Players","Nomes.",false,function(v)St.espP=v refreshESP()end)
tg(t,"ESP Eggs","Marcadores 🥚.",false,function(v)St.espE=v refreshESP()end)
tg(t,"ESP Distance","Distância.",false,function(v)St.espD=v refreshESP()end)
tg(t,"ESP Health","HP.",false,function(v)St.espH=v refreshESP()end)
bt(t,"Fullbright","Ligar",C.red,function()LG.Brightness=3 LG.ClockTime=14 LG.FogEnd=1e6 LG.GlobalShadows=false nt("Visual","Fullbright ON",C.grn)end)
bt(t,"No Fog","Ligar",C.red,function()LG.FogEnd=1e6 nt("Visual","Fog OFF",C.grn)end)
bt(t,"Limpar ESP","Limpar",C.red,function()St.espP=false St.espE=false St.espD=false St.espH=false refreshESP()end)
t=mk("🥚 Egg Radar","radar",lM)
inf(t,"Rastreia ovos no mapa atual")
bt(t,"Scan agora","Scan",C.red,function()local l=scanEggs()nt("Radar",#l.." ovos encontrados",C.grn)end)
bt(t,"Listar com preview","Listar",C.red,function()local l=scanEggs()local txt=""for i=1,math.min(#l,10)do txt=txt..string.format("%s (%.0f)\n",l[i].nome,l[i].dist)end nt("Lista",txt~="" and txt or "Vazio",C.pur)end)
bt(t,"TP para ovo mais próximo","TP",C.blu,function()local l=scanEggs()if l[1]then local r=rt()if r then r.CFrame=CFrame.new(l[1].pos+Vector3.new(0,3,0))nt("TP",l[1].nome,C.blu)end end end)
bt(t,"Marcar todos 🥚","Marcar",C.yel,function()local l=scanEggs()for _,o in ipairs(l)do if not eggF:FindFirstChild("M"..o.nome)then local b=N("BillboardGui",{Parent=eggF,Name="M"..o.nome,Adornee=o.ref,Size=UDim2.new(0,80,0,18),AlwaysOnTop=true,StudsOffset=Vector3.new(0,2,0)})N("TextLabel",{Parent=b,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="🥚",Font=Enum.Font.GothamBold,TextSize=16,TextStrokeTransparency=0})end end nt("Radar","Marcadores colocados",C.yel)end)
t=mk("🐾 Pet Preview","prev",lM)
inf(t,"Escolhe um bioma:")
local eggList=N("ScrollingFrame",{Parent=t,Size=UDim2.new(1,0,0,100),BackgroundColor3=Color3.fromRGB(10,10,12),BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=C.red,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})cr(eggList,5)N("UIListLayout",{Parent=eggList,Padding=UDim.new(0,2),SortOrder=Enum.SortOrder.LayoutOrder})
local petShow=N("ScrollingFrame",{Parent=t,Size=UDim2.new(1,0,0,180),BackgroundColor3=Color3.fromRGB(10,10,12),BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=C.pur,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})cr(petShow,5)N("UIListLayout",{Parent=petShow,Padding=UDim.new(0,2),SortOrder=Enum.SortOrder.LayoutOrder})
local biomas={"Forest","Lake","Desert","Jungle","Snow","Volcano","Ocean","Prehistoric","Cosmic","Cherry","Titan","Angels","Demons","Fusion","Enchanted"}
for _,bio in ipairs(biomas)do local b=N("TextButton",{Parent=eggList,Size=UDim2.new(1,0,0,22),BackgroundColor3=C.card,Text=bio,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.txt,AutoButtonColor=false})cr(b,3)b.MouseButton1Click:Connect(function()
for _,c in ipairs(petShow:GetChildren())do if c:IsA("Frame")then c:Destroy()end end
for _,p in ipairs(IDX)do if p.ovo==bio then local card=N("Frame",{Parent=petShow,Size=UDim2.new(1,0,0,38),BackgroundColor3=C.card,BorderSizePixel=0})cr(card,3)
N("TextLabel",{Parent=card,Position=UDim2.new(0,6,0,2),Size=UDim2.new(1,-12,0,14),BackgroundTransparency=1,Text=p.n.." ["..p.r.."]",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=idxCor(p.r),TextXAlignment=Enum.TextXAlignment.Left})
N("TextLabel",{Parent=card,Position=UDim2.new(0,6,0,18),Size=UDim2.new(1,-12,0,14),BackgroundTransparency=1,Text="Valor: $/s "..fmt(p.v).." | Index: "..(Disc[p.n]and "✓"or "?"),Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left})
end end
nt("Preview",bio.." carregado",C.pur)end)end
t=mk("📖 Index","idx",lM)
local idxList=N("ScrollingFrame",{Parent=t,Size=UDim2.new(1,0,0,340),BackgroundColor3=Color3.fromRGB(10,10,12),BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=C.red,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})cr(idxList,5)N("UIListLayout",{Parent=idxList,Padding=UDim.new(0,2),SortOrder=Enum.SortOrder.LayoutOrder})
local idxQuery=""
local function refreshIdx()for _,c in ipairs(idxList:GetChildren())do if c:IsA("Frame")or c:IsA("TextButton")then c:Destroy()end end
local total=#IDX local disc=0 for _,p in pairs(Disc)do if p then disc+=1 end end
inf(t,string.format("Total: %d | Descobertos: %d (%d%%)",total,disc,math.floor(disc/total*100)))
for _,p in ipairs(IDX)do if idxQuery==""or p.n:lower():find(idxQuery:lower())or p.r:lower():find(idxQuery:lower())then
local card=N("Frame",{Parent=idxList,Size=UDim2.new(1,0,0,28),BackgroundColor3=C.card,BorderSizePixel=0})cr(card,3)
N("TextLabel",{Parent=card,Position=UDim2.new(0,6,0,0),Size=UDim2.new(1,-60,1,0),BackgroundTransparency=1,Text=p.n.."  •  "..p.r.."  •  "..fmt(p.v).."/s",Font=Enum.Font.Gotham,TextSize=10,TextColor3=idxCor(p.r),TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd})
local fav=N("TextButton",{Parent=card,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-6,0.5,0),Size=UDim2.new(0,24,0,20),BackgroundColor3=Fav[p.n]and C.yel or Color3.fromRGB(60,60,68),Text=Fav[p.n]and "★"or "☆",Font=Enum.Font.GothamBold,TextSize=12,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})cr(fav,3)
fav.MouseButton1Click:Connect(function()Fav[p.n]=not Fav[p.n]fav.Text=Fav[p.n]and "★"or "☆"fav.BackgroundColor3=Fav[p.n]and C.yel or Color3.fromRGB(60,60,68)end)
end end end
refreshIdx()
nm(t,"Pesquisar",0,function(n)idxQuery=tostring(n)end)
bt(t,"Marcar todos descobertos","Marcar",C.grn,function()for _,p in ipairs(IDX)do Disc[p.n]=true end refreshIdx()nt("Index","Todos marcados",C.grn)end)
bt(t,"Exportar JSON","Exportar",C.pur,function()local d={favoritos=Fav,descobertos=Disc}if setclipboard then setclipboard(HS:JSONEncode(d))end nt("Exportar","Copiado",C.pur)end)
bt(t,"Limpar tudo","Limpar",C.red,function()Disc={}Fav={}refreshIdx()nt("Index","Limpo",C.red)end)
t=mk("⭐ Favoritos","fav",lM)
local favList=N("ScrollingFrame",{Parent=t,Size=UDim2.new(1,0,0,340),BackgroundColor3=Color3.fromRGB(10,10,12),BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=C.yel,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})cr(favList,5)N("UIListLayout",{Parent=favList,Padding=UDim.new(0,2),SortOrder=Enum.SortOrder.LayoutOrder})
bt(t,"Atualizar favoritos","Refresh",C.yel,function()for _,c in ipairs(favList:GetChildren())do if c:IsA("Frame")then c:Destroy()end end for _,p in ipairs(IDX)do if Fav[p.n]then local card=N("Frame",{Parent=favList,Size=UDim2.new(1,0,0,26),BackgroundColor3=C.card,BorderSizePixel=0})cr(card,3)N("TextLabel",{Parent=card,Position=UDim2.new(0,6,0,0),Size=UDim2.new(1,-12,1,0),BackgroundTransparency=1,Text=p.n.." ["..p.r.."] "..fmt(p.v).."/s",Font=Enum.Font.Gotham,TextSize=10,TextColor3=idxCor(p.r),TextXAlignment=Enum.TextXAlignment.Left})end end nt("Fav","Atualizado",C.yel)end)
t=mk("🌐 Server","srv",lM)
inf(t,"Job ID: "..string.sub(game.JobId,1,10).."...")
inf(t,"Jogadores: "..#P:GetPlayers().."/"..P.MaxPlayers)
bt(t,"Copiar Job ID","Copiar",C.red,function()if setclipboard then setclipboard(game.JobId)end nt("Copiado","Job ID",C.grn)end)
bt(t,"Rejoin","Rejoin",C.red,function()pcall(function()game:GetService("TeleportService"):Teleport(game.PlaceId,LP)end)end)
bt(t,"Server Hop","Hop",C.red,function()local url="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=50" local ok,body=pcall(function()return HS:JSONDecode(game:HttpGet(url))end)if ok and body and body.data then for _,s in ipairs(body.data)do if s.playing<s.maxPlayers and s.id~=game.JobId then pcall(function()game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,s.id,LP)end)return end end end nt("Hop","Sem servidor",C.red)end)
t=mk("🎒 Misc","misc",lM)
tg(t,"Lab Recipe Tracker","Placeholder.")tg(t,"Auto Craft Essence","Placeholder.")tg(t,"Skip Mutated Pets","Placeholder.")tg(t,"Auto Buy Nitro","Placeholder.")tg(t,"Anti Trap","Anti armadilha.",false,function(v)end)
t=mk("⚙ Config","cfg",rM)
inf(t,"Accent: "..Config.accent)
bt(t,"Cor: Vermelho","🔴",C.red,function()Config.accent="Vermelho"nt("Accent","Vermelho",C.red)end)
bt(t,"Cor: Roxo","🟣",C.pur,function()Config.accent="Roxo"nt("Accent","Roxo",C.pur)end)
bt(t,"Cor: Azul","🔵",C.blu,function()Config.accent="Azul"nt("Accent","Azul",C.blu)end)
bt(t,"Cor: Verde","🟢",C.grn,function()Config.accent="Verde"nt("Accent","Verde",C.grn)end)
tg(t,"Modo Seguro","Desativa recursos incompatíveis.",false,function(v)Config.safe=v nt("Config","Safe "..(v and "ON"or "OFF"),C.yel)end)
bt(t,"Reset tudo","Reset",C.red,function()St.speed=16 St.jump=100 St.gravity=196.2 St.noclip=false St.fly=false St.infJump=false St.antiRag=false St.antiVoid=false St.godMode=false St.espP=false St.espE=false St.autoSteal=false St.autoHatch=false St.autoSell=false if bv then bv:Destroy()end if bg then bg:Destroy()end apply()refreshESP()nt("Reset","Tudo desligado",C.red)end)
bt(t,"Fechar painel","Fechar",C.red,function()pan.Visible=false end)
t=mk("📊 Stats","stats",rM)
inf(t,"FPS: -- | Ping: --")
task.spawn(function()while task.wait(1)do local f=math.floor(1/RS.RenderStepped:Wait())local p=math.floor(LP:GetNetworkPing()*1000)inf(t,string.format("FPS:%d Ping:%dms",f,p))end end)
bt(t,"Ver posição","Ver",C.blu,function()local r=rt()if r then nt("Pos",string.format("%.0f, %.0f, %.0f",r.Position.X,r.Position.Y,r.Position.Z),C.blu)end end)
t=mk("🔔 Alerts","alerts",rM)
local wbBox=N("TextBox",{Parent=t,Size=UDim2.new(1,0,0,26),BackgroundColor3=Color3.fromRGB(10,10,12),BorderSizePixel=0,PlaceholderText="Webhook Discord...",PlaceholderColor3=C.txt2,Text="",Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.txt,TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false})cr(wbBox,4)N("UIPadding",{Parent=wbBox,PaddingLeft=UDim.new(0,6)})
bt(t,"Testar webhook","Testar",C.pur,function()local u=wbBox.Text if u==""then nt("Webhook","Cola URL",C.red)return end pcall(function()HS:PostAsync(u,HS:JSONEncode({content="✅ FantaScript conectado!"}))end)nt("Webhook","Enviado",C.grn)end)
tg(t,"Avisar join","Notifica quem entra.",false,function(v)if v then P.PlayerAdded:Connect(function(pl)nt("👤 Entrou",pl.Name,C.pur)end)end end)
tg(t,"Avisar ovos raros","Avisa ovos raros.",false,function(v)if v then task.spawn(function()local vistos={}while true do task.wait(5)for _,o in ipairs(scanEggs())do local n=o.nome:lower()if not vistos[o.nome]and(n:find("secret")or n:find("myth")or n:find("legend"))then vistos[o.nome]=true nt("🎉 Raro!",o.nome,C.yel)end end end end)end end)
bt(t,"Ver log de erros","Ver",C.red,function()if #Errs==0 then nt("Erros","Sem erros",C.grn)else local txt=""for i=1,math.min(#Errs,5)do txt=txt..Errs[i].t..": "..Errs[i].msg.."\n"end nt("Erros",txt,C.red)end end)
t=mk("⌨ Keys","keys",rM)
inf(t,"Right Shift → abrir/fechar")
inf(t,"Fly: W A S D + Space + LCtrl")
inf(t,"Bolinha 🔥 → painel principal")
inf(t,"Bolinha 🥚 → painel de ovos")
t=mk("ℹ About","about",rM)
inf(t,"FANTASCRIPT v7.0")
inf(t,"Full Edition com Painel Duplo")
inf(t,"Feito para Steal an Egg")
sBox:GetPropertyChangedSignal("Text"):Connect(function()local q=sBox.Text:lower()if q==""then return end for id,fr in pairs(tabs)do for _,c in ipairs(fr:GetChildren())do if c:IsA("Frame")then local found=false for _,lbl in ipairs(c:GetChildren())do if lbl:IsA("TextLabel")and lbl.Text:lower():find(q)then found=true break end end c.Visible=found end end end end)
local function drag(h,t,cl)local d,s,m,st=false,nil,false,0 h.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then d=true m=false st=tick()s=i.Position end end)h.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then if d and not m and(tick()-st)<0.3 and cl then cl()end d=false end end)UIS.InputChanged:Connect(function(i)if not d then return end if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then local dd=i.Position-s if math.abs(dd.X)>5 or math.abs(dd.Y)>5 then m=true end t.Position=UDim2.new(t.Position.X.Scale,t.Position.X.Offset+dd.X,t.Position.Y.Scale,t.Position.Y.Offset+dd.Y)s=i.Position end end)end
drag(hd,pan)drag(fb,fb,function()pan.Visible=not pan.Visible end)
UIS.InputBegan:Connect(function(i,g)if g then return end if i.KeyCode==Enum.KeyCode.RightShift then pan.Visible=not pan.Visible end end)
-- ===== PAINEL 2: EGG RADAR LIVE =====
local pan2=N("Frame",{Parent=gui,AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-20,0,80),Size=UDim2.new(0,340,0,420),BackgroundColor3=C.bg,BorderSizePixel=0,ZIndex=1100})
cr(pan2,10)st(pan2,C.yel,2)
local hd2=N("Frame",{Parent=pan2,Size=UDim2.new(1,0,0,32),BackgroundColor3=C.yel,BorderSizePixel=0})cr(hd2,10)
N("TextLabel",{Parent=hd2,Position=UDim2.new(0,10,0,0),Size=UDim2.new(1,-50,1,0),BackgroundTransparency=1,Text="🥚 EGG RADAR — LIVE",Font=Enum.Font.GothamBlack,TextSize=12,TextColor3=Color3.fromRGB(0,0,0),TextXAlignment=Enum.TextXAlignment.Left})
local xb2=N("TextButton",{Parent=hd2,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-8,0.5,0),Size=UDim2.new(0,22,0,22),BackgroundColor3=Color3.fromRGB(0,0,0),BackgroundTransparency=0.4,Text="X",Font=Enum.Font.GothamBlack,TextSize=11,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})cr(xb2,4)
xb2.MouseButton1Click:Connect(function()pan2.Visible=false end)
local listBody=N("ScrollingFrame",{Parent=pan2,Position=UDim2.new(0,6,0,38),Size=UDim2.new(1,-12,1,-46),BackgroundColor3=Color3.fromRGB(10,10,12),BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=C.yel,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y})
cr(listBody,6)
N("UIListLayout",{Parent=listBody,Padding=UDim.new(0,3),SortOrder=Enum.SortOrder.LayoutOrder})
local function refreshLive()
for _,c in ipairs(listBody:GetChildren())do if c:IsA("Frame")then c:Destroy()end end
local eggs=scanEggs()
if #eggs==0 then
N("TextLabel",{Parent=listBody,Size=UDim2.new(1,0,0,30),BackgroundTransparency=1,Text="Nenhum ovo no mapa agora...",Font=Enum.Font.Gotham,TextSize=11,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left})
return
end
for _,o in ipairs(eggs)do
local lowName=o.nome:lower()
local matched=nil
if lowName:find("forest")then matched={r="Common",v=1800,n="Forest"}elseif lowName:find("lake")then matched={r="Uncommon",v=2800,n="Lake"}elseif lowName:find("desert")then matched={r="Rare",v=280000,n="Desert"}elseif lowName:find("jungle")then matched={r="Epic",v=3500000,n="Jungle"}elseif lowName:find("snow")or lowName:find("ice")then matched={r="Legendary",v=65000000,n="Snow"}elseif lowName:find("volcano")or lowName:find("lava")then matched={r="Mythic",v=100000000,n="Volcano"}elseif lowName:find("ocean")or lowName:find("abyss")then matched={r="Cosmic",v=130000000,n="Ocean"}elseif lowName:find("prehistoric")or lowName:find("dino")then matched={r="Secret",v=180000000,n="Prehistoric"}elseif lowName:find("cosmic")then matched={r="Eternal",v=1000000000,n="Cosmic"}elseif lowName:find("cherry")or lowName:find("sakura")then matched={r="Divine",v=3200000000,n="Cherry"}elseif lowName:find("titan")or lowName:find("temple")then matched={r="Eternal",v=3000000000,n="Titan"}elseif lowName:find("angel")or lowName:find("demon")then matched={r="Divine",v=6500000000,n="Angels/Demons"}end
local card=N("Frame",{Parent=listBody,Size=UDim2.new(1,0,0,54),BackgroundColor3=C.card,BorderSizePixel=0})
cr(card,4)
st(card,matched and idxCor(matched.r)or C.bd)
N("TextLabel",{Parent=card,Position=UDim2.new(0,8,0,4),Size=UDim2.new(1,-16,0,14),BackgroundTransparency=1,Text="🥚 "..o.nome,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.yel,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd})
local info="Dist: "..string.format("%.0f",o.dist).." studs"
if matched then info=info.." | "..matched.r.." | $"..fmt(matched.v).."/s" end
N("TextLabel",{Parent=card,Position=UDim2.new(0,8,0,20),Size=UDim2.new(1,-16,0,14),BackgroundTransparency=1,Text=info,Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.txt2,TextXAlignment=Enum.TextXAlignment.Left})
local idxStatus=matched and(Disc[o.nome]and "✓ Descoberto"or "? Não descoberto")or "N/D"
N("TextLabel",{Parent=card,Position=UDim2.new(0,8,0,36),Size=UDim2.new(1,-80,0,14),BackgroundTransparency=1,Text="Index: "..idxStatus,Font=Enum.Font.Gotham,TextSize=9,TextColor3=matched and(Disc[o.nome]and C.grn or C.yel)or C.txt2,TextXAlignment=Enum.TextXAlignment.Left})
local tpB=N("TextButton",{Parent=card,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-8,0.5,0),Size=UDim2.new(0,60,0,22),BackgroundColor3=C.blu,Text="TP",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=Color3.fromRGB(255,255,255),AutoButtonColor=false})
cr(tpB,4)
tpB.MouseButton1Click:Connect(function()
local r=rt()
if r then r.CFrame=CFrame.new(o.pos+Vector3.new(0,3,0))
nt("TP",o.nome,C.blu)end
end)
end
end
task.spawn(function()
while pan2 and pan2.Parent do
task.wait(3)
pcall(refreshLive)
end
end)
local fb2=N("TextButton",{Parent=gui,Position=UDim2.new(0,20,0,80),Size=UDim2.new(0,50,0,50),BackgroundColor3=C.yel,Text="",AutoButtonColor=false,ZIndex=9999})
cr(fb2,25)st(fb2,C.red,2)
N("TextLabel",{Parent=fb2,Position=UDim2.new(0.5,-16,0.5,-16),Size=UDim2.new(0,32,0,32),BackgroundTransparency=1,Text="🥚",Font=Enum.Font.GothamBlack,TextSize=22,ZIndex=10000})
drag(fb2,fb2,function()pan2.Visible=not pan2.Visible end)
pan2.Visible=true
sTab("farm")
nt("🔥 FANTASCRIPT v7.0","Painel duplo carregado!",C.red)
task.wait(0.5)
pcall(refreshLive)
print("[FANTASCRIPT] v7.0 carregado.")
