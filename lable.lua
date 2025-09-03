local CoreGui = game:GetService("CoreGui")

-- نتأكد انه ما فيه نسخة مكررة
if CoreGui:FindFirstChild("crssss") then return end

local crssss = Instance.new("ScreenGui")
crssss.Name = "crssss"
crssss.Parent = CoreGui

local AntiCrash = {}
AntiCrash.__index = AntiCrash

-- الإنشاء
function AntiCrash.new()
    local self = setmetatable({}, AntiCrash)
    self.spLibrary, self.button, self.hub = nil, nil, nil
    self.isVisible, self.debounce, self.stopScript = true, false, false
    self.printer___ = true
    return self
end

-- طباعة آمنة (تقدر تعطلها)
function AntiCrash:PrintSafe(msg, isWarn)
    if self.printer___ then
        if isWarn then
            warn(msg)
        else
            print(msg)
        end
    end
end

-- البحث عن عناصر المكتبة
function AntiCrash:FindElements()
    while not self.stopScript do
        self.spLibrary = CoreGui:FindFirstChild("sp Library")
        if self.spLibrary 
           and self.spLibrary:FindFirstChild("ImageButton") 
           and self.spLibrary:FindFirstChild("Hub") then
           
            self.button = self.spLibrary.ImageButton
            self.hub = self.spLibrary.Hub
            self:PrintSafe("Library found and restarted.")
            return true
        end
        task.wait(0.5)
    end
    return false
end

-- إظهار/إخفاء الـ Hub
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

-- المراقبة المستمرة
function AntiCrash:Monitor()
    task.spawn(function()
        while not self.stopScript do
            if not (self.spLibrary 
                and self.button and self.hub
                and self.spLibrary.Parent == CoreGui
                and self.button.Parent == self.spLibrary
                and self.hub.Parent == self.spLibrary) then
                
                self:PrintSafe("SP library missing, trying to recover...", true)
                
                if self:FindElements() and self.button then
                    self.button.MouseButton1Click:Connect(function()
                        self:ToggleHub()
                    end)
                else
                    self.stopScript = true
                    break
                end
            end
            task.wait(1)
        end
    end)
end

-- التشغيل
function AntiCrash:Start(printer___)
    -- تبسيط: أي قيمة غير nil تخزن مباشرة كبول
    if type(printer___) == "string" then
        self.printer___ = (printer___:lower() == "true")
    elseif type(printer___) == "boolean" then
        self.printer___ = printer___
    else
        self.printer___ = true -- الافتراضي
    end

    if self:FindElements() and self.button then
        self.button.MouseButton1Click:Connect(function()
            self:ToggleHub()
        end)
        self:PrintSafe("Anti-crash is running.")
        self:Monitor()
    else
        self.stopScript = true
    end
end

return function()
    return AntiCrash.new()
end
