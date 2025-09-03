local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("crssss") then return end

local crssss = Instance.new("ScreenGui")
crssss.Name = "crssss"
crssss.Parent = CoreGui

local AntiCrash = {}
AntiCrash.__index = AntiCrash

-- 🛑 Fake Security Banner (Just to confuse deobfuscators)
local function ForbiddenAccess()
    return "⚠️ SYSTEM LOCKDOWN ENABLED ⚠️"
end

-- Helper: build string from ASCII
local function S(tbl)
    local r = ""
    for i=1,#tbl do
        r = r .. string.char(tbl[i])
    end
    return r
end

-- Hidden call (print / warn)
local function HiddenCall(msg, isWarn)
    local f = ({[true] = table.concat({"w","a","r","n"}), [false] = table.concat({"p","r","i","n","t"})})
    getfenv()[f[isWarn]](msg)
end

function AntiCrash.new()
    local self = setmetatable({}, AntiCrash)
    self.spLibrary, self.button, self.hub = nil, nil, nil
    self.isVisible, self.debounce, self.stopScript = true, false, false
    self.printer___ = true
    return self
end

function AntiCrash:PrintSafe(message, isWarn)
    if self.printer___ then
        HiddenCall(message, isWarn)
    end
end

function AntiCrash:FindElements()
    local startTime = tick()
    while not self.stopScript do
        self.spLibrary = CoreGui:FindFirstChild(S({115,112,32,76,105,98,114,97,114,121})) -- "sp Library"
        if self.spLibrary and self.spLibrary:FindFirstChild(S({73,109,97,103,101,66,117,116,116,111,110})) 
           and self.spLibrary:FindFirstChild(S({72,117,98})) then
            self.button = self.spLibrary[S({73,109,97,103,101,66,117,116,116,111,110})]
            self.hub = self.spLibrary[S({72,117,98})]
            self:PrintSafe(S({73,116,32,104,97,115,32,98,101,101,110,32,114,101,115,116,97,114,116,101,100,46}))
            return true
        end
        if tick() - startTime > 30 then
            self:PrintSafe(S({84,104,101,32,99,114,97,115,104,32,115,111,117,114,99,101,32,104,97,115,32,98,101,101,110,32,115,116,111,112,112,101,100,32,100,117,101,32,116,111,32,116,104,101,32,108,105,98,114,97,114,121,32,110,111,116,32,98,101,105,110,103,32,102,111,117,110,100,46}), true)
            return false
        end
        task.wait(0.5)
    end
    return false
end

function AntiCrash:ToggleHub()
    if self.debounce then return end
    self.isVisible = not self.isVisible
    if self.hub then self.hub.Visible = self.isVisible end
    self.debounce = true
    task.delay(3, function() self.debounce = false end)
end

function AntiCrash:Monitor()
    task.spawn(function()
        while not self.stopScript do
            if not (self.spLibrary and self.spLibrary.Parent == CoreGui
                 and self.button and self.button.Parent == self.spLibrary
                 and self.hub and self.hub.Parent == self.spLibrary) then
                self:PrintSafe(S({69,114,114,111,114,32,109,111,100,105,102,121,105,110,103,32,116,104,101,32,115,111,117,114,99,101,32,111,102,32,116,104,101,32,83,80,32,108,105,98,114,97,114,121,32,84,114,121,105,110,103,32,116,111,32,100,111,32,115,111,46,46,46}), true)
                if self:FindElements() and self.button then
                    self.button.MouseButton1Click:Connect(function() self:ToggleHub() end)
                else
                    self.stopScript = true
                    break
                end
            end
            task.wait(1)
        end
    end)
end

function AntiCrash:Start(printer___)
    if printer___ == nil then
        self.printer___ = true
    elseif type(printer___) == "string" then
        self.printer___ = (printer___:lower() == "true")
    elseif type(printer___) == "boolean" then
        self.printer___ = printer___
    else
        self.printer___ = true
    end

    if self:FindElements() and self.button then
        self.button.MouseButton1Click:Connect(function() self:ToggleHub() end)
        self:PrintSafe(S({65,110,116,105,45,99,114,97,115,104,32,105,115,32,114,117,110,110,105,110,103}))
        self:Monitor()
    else
        self.stopScript = true
    end
end

-- Fake Trap Function (never called)
local function CriticalSystemShutdown()
    while false do end
end

return function()
    return AntiCrash.new()
end
