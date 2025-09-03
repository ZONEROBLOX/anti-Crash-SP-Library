local CoreGui = game:GetService("CoreGui")

-- تحقق من وجود ScreenGui باسم crssss
if CoreGui:FindFirstChild("crssss") then
    return
end

-- إنشاء ScreenGui جديد باسم crssss
local crssss = Instance.new("ScreenGui")
crssss.Name = "crssss"
crssss.Parent = CoreGui

local AntiCrash = {}
AntiCrash.__index = AntiCrash

function AntiCrash.new()
    local self = setmetatable({}, AntiCrash)
    self.spLibrary = nil
    self.button = nil
    self.hub = nil
    self.isVisible = true
    self.debounce = false
    self.stopScript = false
    self.printer___ = true
    return self
end

function AntiCrash:PrintSafe(message, isWarn)
    if self.printer___ then
        if isWarn then
            warn(message)
        else
            print(message)
        end
    end
end

function AntiCrash:FindElements()
    local startTime = tick()
    while not self.stopScript do
        self.spLibrary = CoreGui:FindFirstChild("sp Library")
        if self.spLibrary and self.spLibrary:FindFirstChild("ImageButton") and self.spLibrary:FindFirstChild("Hub") then
            self.button = self.spLibrary.ImageButton
            self.hub = self.spLibrary.Hub
            self:PrintSafe("It has been restarted.")
            return true
        end
        if tick() - startTime > 30 then
            self:PrintSafe("The crash source has been stopped due to the library not being found.", true)
            return false
        end
        task.wait(0.5)
    end
    return false
end

function AntiCrash:ToggleHub()
    if self.debounce then return end
    self.isVisible = not self.isVisible
    if self.hub then
        self.hub.Visible = self.isVisible
    end
    self.debounce = true
    task.delay(3, function()
        self.debounce = false
    end)
end

function AntiCrash:Monitor()
    task.spawn(function()
        while not self.stopScript do
            if not (self.spLibrary and self.spLibrary.Parent == CoreGui and
                    self.button and self.button.Parent == self.spLibrary and
                    self.hub and self.hub.Parent == self.spLibrary) then
                self:PrintSafe("Error modifying the source of the SP library Trying to do so...", true)
                if self:FindElements() then
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
        self.printer_ = (printer_ or ""):lower() == "true"
    else
        self.printer_ = printer_ and true or false
    end

    if self:FindElements() then
        self.button.MouseButton1Click:Connect(function() self:ToggleHub() end)
        self:PrintSafe("Anti-crash is running")
        self:Monitor()
    else
        self.stopScript = true
    end
end

return function()
    return AntiCrash.new()
end
