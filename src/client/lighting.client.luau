type workspace = Workspace & {
	Water: Part,
	Normal: Part,
}

local Lighting = game:GetService("Lighting")
local LightingPresets = Lighting:WaitForChild("LightingPresets")

local NormalConfig = require(LightingPresets:WaitForChild("Normal"))
local WaterConfig = require(LightingPresets:WaitForChild("Water"))

local Bounce = false

local function CallNormal()
	if Bounce then
		return
	end
	Bounce = true
	delay(0.5, function()
		Bounce = false
	end)

	for index, object in NormalConfig do
		local success, response = pcall(object :: () -> nil)
		if not success then
			warn(response)
		end -- to make it shut up
	end
end

local function CallWater()
	if Bounce then
		return
	end
	Bounce = true
	delay(0.5, function()
		Bounce = false
	end)

	for index, object in WaterConfig do
		local success, response = pcall(object :: () -> nil)
		if not success then
			warn(response)
		end -- to make it shut up
	end
end

local function LoopCalls()
	while true do
		CallNormal()
		wait(5)
		CallWater()
		wait(5)
	end
end

task.spawn(LoopCalls)

--Normal.Touched:Connect(CallNormal);
--Water.Touched:Connect(CallWater);
