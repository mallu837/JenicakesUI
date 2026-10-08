--[[
     _      ___         ____  ______
    | | /| / (_)__  ___/ / / / /  _/
    | |/ |/ / / _ \/ _  / /_/ // /  
    |__/|__/_/_//_/\_,_/\____/___/
    
    v1.6.66  |  2026-10-08  |  Roblox UI Library for scripts
    
    To view the source code, see the `src/` folder on the official GitHub repository.
    
    Author: Footagesus (Footages, .ftgs, oftgs)
    Github: https://github.com/mallu837/JenicakesUI
    Discord: https://discord.gg/ftgs-development-hub-1300692552005189632
    License: MIT
]]

local a={
Window=nil,
Theme=nil,
Creator=require"./modules/Creator",
LocalizationModule=require"./modules/Localization",
NotificationModule=require"./components/Notification",
Themes=nil,
Transparent=false,

TransparencyValue=0.15,

UIScale=1,

ConfigManager=nil,
Version="0.0.0",

Services=require"./utils/services/init",

OnThemeChangeFunction=nil,

cloneref=nil,
UIScaleObj=nil,

CreateWindow=nil,

CurrentInput=nil,
}

local b=(cloneref or clonereference or function(b)
return b
end)

a.cloneref=b

local c=b(game:GetService"HttpService")
local d=b(game:GetService"Players")
local e=b(game:GetService"CoreGui")
local f=b(game:GetService"RunService")
local g=b(game:GetService"UserInputService")

function a.GenerateGUID()
return c:GenerateGUID(false)
end

local h=a.GenerateGUID()

g.InputBegan:Connect(function(i,j)




task.defer(function()
if
i.UserInputType==Enum.UserInputType.MouseButton1
or i.UserInputType==Enum.UserInputType.Touch
then
if a.CurrentInput and a.CurrentInput~=h then
return
end

a.CurrentInput=h


end
end)
end)
g.InputEnded:Connect(function(i,j)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
if a.CurrentInput and a.CurrentInput~=h then
return
end

a.CurrentInput=nil
end
end)

local i=d.LocalPlayer or nil

local j=c:JSONDecode(require"../build/package")
if j then
a.Version=j.version
end

local k=require"./components/KeySystem"

local l=a.Creator

local m=l.New




local n=require"./utils/Acrylic/init"

local o=protectgui or(syn and syn.protect_gui)or function()end

local p=gethui and gethui()or(e or i:WaitForChild"PlayerGui")

local q=m("UIScale",{
Scale=a.UIScale,
})

a.UIScaleObj=q

a.ScreenGui=m("ScreenGui",{
Name="WindUI",
Parent=p,
IgnoreGuiInset=true,
ScreenInsets="None",
DisplayOrder=-99999,
},{

m("Folder",{
Name="Window",
}),






m("Folder",{
Name="KeySystem",
}),
m("Folder",{
Name="Popups",
}),
m("Folder",{
Name="ToolTips",
}),
})

a.NotificationGui=m("ScreenGui",{
Name="WindUI/Notifications",
Parent=p,
IgnoreGuiInset=true,
})
a.DropdownGui=m("ScreenGui",{
Name="WindUI/Dropdowns",
Parent=p,
IgnoreGuiInset=true,
})
a.TooltipGui=m("ScreenGui",{
Name="WindUI/Tooltips",
Parent=p,
IgnoreGuiInset=true,
})
o(a.ScreenGui)
o(a.NotificationGui)
o(a.DropdownGui)
o(a.TooltipGui)

l.Init(a)

function a.SetParent(r,s)
if a.ScreenGui then
a.ScreenGui.Parent=s
end
if a.NotificationGui then
a.NotificationGui.Parent=s
end
if a.DropdownGui then
a.DropdownGui.Parent=s
end
if a.TooltipGui then
a.TooltipGui.Parent=s
end
end
math.clamp(a.TransparencyValue,0,1)

local r=a.NotificationModule.Init(a.NotificationGui)

function a.Notify(s,t)
t.Holder=r.Frame
t.Window=a.Window

return a.NotificationModule.New(t)
end

function a.SetNotificationLower(s,t)
r.SetLower(t)
end

function a.SetFont(s,t)
l.UpdateFont(t)
end

function a.OnThemeChange(s,t)
a.OnThemeChangeFunction=t
end

function a.AddTheme(s,t)
a.Themes[t.Name]=t
return t
end

function a.SetTheme(s,t)
if a.Themes[t]then
a.Theme=a.Themes[t]
l.SetTheme(a.Themes[t])

if a.OnThemeChangeFunction then
a.OnThemeChangeFunction(t)
end

return a.Themes[t]
end
return nil
end

function a.GetThemes(s)
return a.Themes
end
function a.GetCurrentTheme(s)
return a.Theme.Name
end
function a.GetTransparency(s)
return a.Transparent or false
end
function a.GetWindowSize(s)
return a.Window.UIElements.Main.Size
end
function a.Localization(s,t)
return a.LocalizationModule:New(t,l)
end

function a.SetLanguage(s,t)
if l.Localization then
return l.SetLanguage(t)
end
return false
end

function a.ToggleAcrylic(s,t)
if a.Window and a.Window.AcrylicPaint and a.Window.AcrylicPaint.Model then
a.Window.Acrylic=t
a.Window.AcrylicPaint.Model.Transparency=t and 0.98 or 1
if t then
n.Enable()
else
n.Disable()
end
end
end

function a.Gradient(s,t,u)
local v={}
local w={}

for x,y in next,t do
local z=tonumber(x)
if z then
z=math.clamp(z/100,0,1)

local A=y.Color
if typeof(A)=="string"and string.sub(A,1,1)=="#"then
A=Color3.fromHex(A)
end

local B=y.Transparency or 0

table.insert(v,ColorSequenceKeypoint.new(z,A))
table.insert(w,NumberSequenceKeypoint.new(z,B))
end
end

table.sort(v,function(x,y)
return x.Time<y.Time
end)
table.sort(w,function(x,y)
return x.Time<y.Time
end)

if#v<2 then
table.insert(v,ColorSequenceKeypoint.new(1,v[1].Value))
table.insert(w,NumberSequenceKeypoint.new(1,w[1].Value))
end

local x={
Color=ColorSequence.new(v),
Transparency=NumberSequence.new(w),
}

if u then
for y,z in pairs(u)do
x[y]=z
end
end

return x
end

function a.Popup(s,t)
t.WindUI=a
return require"./components/popup/init".new(t,a.ScreenGui.Popups)
end

a.Themes=require"./themes/init"(a,l)

l.Themes=a.Themes

a:SetTheme"Dark"
a:SetLanguage(l.Language)

function a.CreateWindow(s,t)
local u=require"./components/window/init"

if not f:IsStudio()and writefile then
if not isfolder"WindUI"then
makefolder"WindUI"
end
if t.Folder then
makefolder(t.Folder)
else
makefolder(t.Title)
end
end

t.WindUI=a
t.Window=a.Window
t.Parent=a.ScreenGui.Window

if a.Window then
warn"You cannot create more than one window"
return
end

local v=true

local w=a.Themes[t.Theme or"Dark"]


l.SetTheme(w)

local x=gethwid or function()
return d.LocalPlayer.UserId
end

local y=x()

if t.KeySystem then
v=false

local function loadKeysystem()
k.new(t,y,function(z)
v=z
end)
end

local z=(t.Folder or"Temp").."/"..y..".key"

if t.KeySystem.KeyValidator then
if t.KeySystem.SaveKey and isfile(z)then
local A=readfile(z)
local B=t.KeySystem.KeyValidator(A)

if B then
v=true
else
loadKeysystem()
end
else
loadKeysystem()
end
elseif not t.KeySystem.API then
if t.KeySystem.SaveKey and isfile(z)then
local A=readfile(z)
local B=(type(t.KeySystem.Key)=="table")and table.find(t.KeySystem.Key,A)
or tostring(t.KeySystem.Key)==tostring(A)

if B then
v=true
else
loadKeysystem()
end
else
loadKeysystem()
end
else
if isfile(z)then
local A=readfile(z)
local B=false

for C,D in next,t.KeySystem.API do
local E=a.Services[D.Type]
if E then
local F={}
for G,H in next,E.Args do
table.insert(F,D[H])
end

local G=E.New(table.unpack(F))
local H=G.Verify(A)
if H then
B=true
break
end
end
end

v=B
if not B then
loadKeysystem()
end
else
loadKeysystem()
end
end

repeat
task.wait()
until v
end

local z=u(t)

a.Transparent=t.Transparent
a.Window=z

if t.Acrylic then
n.init()
end













return z
end

return a
