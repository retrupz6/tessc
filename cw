local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
	Name = "Rayfield Example Window",
	LoadingTitle = "Rayfield Interface Suite",
	LoadingSubtitle = "by Sirius",
	ConfigurationSaving = {
		Enabled = false,
		FolderName = "Rayfield Interface Suite",
		FileName = "Big Hub"
	},
	KeySystem = false, -- Set this to true to use their key system
	KeySettings = {
		Title = "Sirius Hub",
		Subtitle = "Key System",
		Note = "Join the discord (discord.gg/sirius)",
		SaveKey = true,
		Key = "ABCDEF"
	}
})

local Tab = Window:CreateTab("Tab Example", 4483362458)
local Button = Tab:CreateButton({
   Name = "Auto Parry & Inf Stamina",
   Callback = function()
    for i,v in pairs(getgc(true)) do
        if typeof(v) == "table" and rawget(v, "getIsMaxed") then
            v.getIsMaxed = function()
                return false
            end
            v.getFlags = function()
                return 1
            end
            v.addFlags = function(a,b)
                a:setFlags(0)
                return
            end
        end
        -- "There was another script here but it caused the user to crash (lag out), so it had to be removed" -KiwisASkid --
        if typeof(v) == "table" and rawget(v, "spawnCharacter") then
            local oldfunc = v.spawnCharacter
            v.SpawnCharacter = function(a)
                for _,f in pairs(getgc(true)) do
                    if typeof(f) == "table" and rawget(f, "getIsMaxed") then
                        f.getIsMaxed = function()
                            return false
                        end
                        f.getFlags = function()
                            return 1
                        end
                        f.addFlags = function(aa,b)
                            aa:setFlags(0)
                            return
                        end
                    end
                end
            end
        end
        if typeof(v) == "table" and rawget(v, "getCanJump") then
            v.getCanJump = function()
                return true
            end
        end
        if typeof(v) == "table" and rawget(v, "JUMP_DELAY_ADD") then
            v.JUMP_DELAY_ADD = 0.5
        end
        if typeof(v) == "table" and rawget(v, "_setStamina") then
            v._setStamina = function(a, b)
                a._stamina = math.huge
                a._staminaChangedSignal:Fire(99)
            end
        end
     end
     game.StarterGui:SetCore("SendNotification", {Title = "Virus", Text = "Script Inf Stamina & Inf Jump has loaded, "..game.Players.LocalPlayer.DisplayName..".", Duration = 4,})
     
     --auto parry
     
     local lp = game.Players.LocalPlayer
     
     local animationInfo = {}
     
     function getInfo(id)
       local success, info = pcall(function()
           return game:GetService("MarketplaceService"):GetProductInfo(id)
       end)
       if success then
           return info
       end
       return {Name=''}
     end
     function block(player)
       keypress(0x46)
       wait()
       keyrelease(0x46)
     end
     
     local AnimNames = {
       'Slash',
       'Swing',
       'Sword'
     }
     
     function playerAdded(v)
         local function charadded(char)
           local humanoid = char:WaitForChild("Humanoid", 5)
           if humanoid then
               humanoid.AnimationPlayed:Connect(function(track)
                   local info = animationInfo[track.Animation.AnimationId]
                   if not info then
                       info = getInfo(tonumber(track.Animation.AnimationId:match("%d+")))
                       animationInfo[track.Animation.AnimationId] = info
                   end
                  
                   if (lp.Character and lp.Character:FindFirstChild("Head") and v.Character:FindFirstChild("Head")) then
                       local mag = (v.Character.Head.Position - lp.Character.Head.Position).Magnitude
                       if mag < 15  then
                          
                           for _, animName in pairs(AnimNames) do
                               if info.Name:match(animName) then
                                   pcall(block, v)
                               end
                           end
                          
                       end
                   end
               end)
           end
       end
      
       if v.Character then
           charadded(v.Character)
       end
       v.CharacterAdded:Connect(charadded)
     end
     
     for i,v in pairs(game.Players:GetPlayers()) do
        if v ~= lp then
            playerAdded(v)
        end
     end
     
     game.Players.PlayerAdded:Connect(playerAdded)
     game.StarterGui:SetCore("SendNotification", {Title = "Virus", Text = "Script Auto Parry has loaded, "..game.Players.LocalPlayer.DisplayName..".", Duration = 4,})
   end,
   
})

local Button = Tab:CreateButton({
    Name = "Dash No Cooldown",
    Callback = function()
        local val = true
        for i,v2 in pairs(getgc(true)) do
                if typeof(v2) == "table" and rawget(v2, "DASH_COOLDOWN") then
                    if val then
                        v2.DASH_COOLDOWN = 0
                    else
                        v2.DASH_COOLDOWN = 0
    
                    end
                end
        end    
    end,
 })

 local Button = Tab:CreateButton({
    Name = "No Utility",
    game.StarterGui:SetCore("SendNotification", {Title = "Virus", Text = "Script No Utility has loaded, "..game.Players.LocalPlayer.DisplayName..".", Duration = 4,})
    Callback = function()
        local methodHook
        methodHook = hookmetamethod(game, "__namecall", function(self, ...)
        if not checkcaller() and getnamecallmethod() == "FireServer" and antidamage and tostring(self) == "GotHitRE" then
            return
        elseif not checkcaller() and getnamecallmethod() == "FireServer" and nofall and self.Name == fallremote.Name then
            return
        elseif (getnamecallmethod() == "Kick" or getnamecallmethod() == "kick") and self == game.Players.LocalPlayer then
            return
        end
        return methodHook(self, ...)
        end)
        
        antidamage = val
    end,
 })
local Tab = Window:CreateTab("Tab Example", 4483362458)
local Tab = Window:CreateTab("Tab Example", 4483362458)
