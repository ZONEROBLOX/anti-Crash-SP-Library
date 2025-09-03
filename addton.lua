local X=game:GetService(string.char(67,111,114,101,71,117,105))
if X:FindFirstChild(string.char(99,114,115,115,115,115))then return end

local Y=Instance.new(string.char(83,99,114,101,101,110,71,117,105))
Y.Name=string.char(99,114,115,115,115,115)
Y.Parent=X

local Z={}
Z.__index=Z

function Z.n()
   local A=setmetatable({},Z)
   A["\115L"]=nil
   A["\98t"]=nil
   A["\104b"]=nil
   A["\118v"]=true
   A["\100d"]=false
   A["\115s"]=false
   A["\112r"]=true
   return A
end

function Z.q(B,C)
   if B["\112r"]then
      if C then warn(C) else print(C) end
   end
end

function Z.f(D)
   local E=tick()
   while(not D["\115s"])do
      D["\115L"]=X:FindFirstChild("\115p Library")
      if D["\115L"]and D["\115L"]:FindFirstChild("\73mageButton")and D["\115L"]:FindFirstChild("\72ub")then
         D["\98t"]=D["\115L"].ImageButton
         D["\104b"]=D["\115L"].Hub
         D.q(D,"r")
         return true
      end
      if tick()-E>30 then
         D.q(D,"no lib",true)
         return false
      end
      task.wait(0.5)
   end
   return false
end

function Z.g(F)
   if F["\100d"]then return end
   F["\118v"]=not F["\118v"]
   if F["\104b"]then
      F["\104b"].Visible=F["\118v"]
   end
   F["\100d"]=true
   task.delay(3,function()F["\100d"]=false end)
end

function Z.m(H)
   task.spawn(function()
      while not H["\115s"]do
         if not(H["\115L"]and H["\115L"].Parent==X and
            H["\98t"]and H["\98t"].Parent==H["\115L"]and
            H["\104b"]and H["\104b"].Parent==H["\115L"])then
               H.q(H,"err",true)
               if H.f(H)then
                  H["\98t"].MouseButton1Click:Connect(function()H.g(H)end)
               else
                  H["\115s"]=true
                  break
               end
         end
         task.wait(1)
      end
   end)
end

function Z.s(J,K)
   if K==nil then
      J["\112r"]=true
   elseif type(K)=="string"then
      J["\112r"]=(K or""):lower()=="true"
   else
      J["\112r"]=K and true or false
   end
   if J.f(J)then
      J["\98t"].MouseButton1Click:Connect(function()J.g(J)end)
      J.q(J,"ok")
      J.m(J)
   else
      J["\115s"]=true
   end
end

return function()return Z.n()end
