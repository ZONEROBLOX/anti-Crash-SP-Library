local X = game:GetService("CoreGui")
if X:FindFirstChild("crssss") then return end
local Y = Instance.new("ScreenGui")
Y.Name = "crssss"
Y.Parent = X

local Z = {}
Z.__index = Z

function Z.n()
    local A = setmetatable({}, Z)
    A["_SL"] = nil
    A["_bt"] = nil
    A["_hb"] = nil
    A["_visible"] = true
    A["_debounce"] = false
    A["_stopped"] = false
    A["_print"] = true
    return A
end

function Z.q(self, msg, useWarn)
    if self["_print"] then
        if useWarn then warn(msg) else print(msg) end
    end
end

function Z.f(self)
    local startTime = tick()
    while (not self["_stopped"]) do
        self["_SL"] = X:FindFirstChild("sp Library")
        if self["_SL"] and self["_SL"]:FindFirstChild("ImageButton") and self["_SL"]:FindFirstChild("Hub") then
            self["_bt"] = self["_SL"].ImageButton
            self["_hb"] = self["_SL"].Hub
            self:q("Library found")
            return true
        end
        if tick() - startTime > 30 then
            self:q("no lib", true)
            return false
        end
        task.wait(0.5)
    end
    return false
end

function Z.g(self)
    if self["_debounce"] then return end
    self["_visible"] = not self["_visible"]
    if self["_hb"] then
        self["_hb"].Visible = self["_visible"]
    end
    self["_debounce"] = true
    task.delay(3, function() self["_debounce"] = false end)
end

function Z.m(self)
    task.spawn(function()
        while not self["_stopped"] do
            if not (self["_SL"] and self["_SL"].Parent == X and
                    self["_bt"] and self["_bt"].Parent == self["_SL"] and
                    self["_hb"] and self["_hb"].Parent == self["_SL"]) then
                self:q("err", true)
                if self:f() then
                    self["_bt"].MouseButton1Click:Connect(function() self:g() end)
                else
                    self["_stopped"] = true
                    break
                end
            end
            task.wait(1)
        end
    end)
end

function Z.s(self, printEnable)
    if printEnable == nil then
        self["_print"] = true
    elseif type(printEnable) == "string" then
        self["_print"] = (printEnable or ""):lower() == "true"
    else
        self["_print"] = printEnable and true or false
    end
    if self:f() then
        self["_bt"].MouseButton1Click:Connect(function() self:g() end)
        self:q("ok")
        self:m()
    else
        self["_stopped"] = true
    end
end

return function()
    local obj = Z.n()
    function obj:start(printEnable)
        self:s(printEnable)
    end
    return obj
end
