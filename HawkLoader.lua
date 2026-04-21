--[[
      ___ ___                __       ___ ___  ____ _____________ 
     /   |   \_____ __  _  _|  | __  /   |   \|    |   \______   \
    /    ~    \__  \\ \/ \/ /  |/ / /    ~    \    |   /|    |  _/
    \    Y    // __ \\     /|    <  \    Y    /    |  / |    |   \
     \___|_  /(____  /\/\_/ |__|_ \  \___|_  /|______/  |______  /
           \/      \/            \/        \/                  \/ 

    Devs: Hanki, Falpearx
]]

_HawkKey = "pencizurnabayilirim"
local HawkLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/hankiwastaken/HawkUILib/refs/heads/main/Source/HawkLib.lua"))() 
local HttpService = game:GetService("HttpService")
local Notif = HawkLib:AddNotifications()

local success, data = pcall(function()
	return request({
		Url = "https://hawkhub.lol",
		Method = "GET"
	})
end)

if success then
	--Successfull request
	if tostring(data.Body):find("530") then
		Notif:Notification({
			Title = "Hawk Server",
			Description = "The server is down right now. Try again in a bit. Contact Hanki.",
			Selection = "Error",
			Animated = true,
			Cooldown = 5
		})
	elseif tostring(data.Body):find("502") then
		Notif:Notification({
			Title = "Hawk Server",
			Description = "Server is up but the app isn't responding. Contact Hanki.",
			Selection = "Error",
			Animated = true,
			Cooldown = 5
		})
	else
		local HawkServerStatus = game:HttpGet("https://status.hawkhub.lol")
		local HawkServerData = HttpService:JSONDecode(HawkServerStatus)
		
		if HawkServerData.script_status and HawkServerData.script_status == "online" then
			loadstring(game:HttpGet("https://hawkhub.lol", true))("hawkhubneverdies")
		elseif HawkServerData.script_status and HawkServerData.script_status == "offline" then
			Notif:Notification({
				Title = "Hawk HUB",
				Description = "Hawk HUB is down right now. Try again in a bit. Contact Hanki.",
				Selection = "Error",
				Animated = true,
				Cooldown = 5
			})
		end	
	end
else
	warn("Failed to fetch site")
end
