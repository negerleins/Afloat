local module = {}

local terrain = game.Workspace:WaitForChild("Terrain") :: Terrain

local MAX_WAVE_MAGNITUDE = 1.94
local MAX_WAVELENGTH = 85

local wt = 0

local function getWavelength()
	local a = math.sqrt(terrain.WaterWaveSize)
	return a * MAX_WAVELENGTH
end

function module.updateWaveClock(deltaTime: number)
	wt += deltaTime * terrain.WaterWaveSpeed
end

function module.Calculate(x: number, z: number)
	if terrain.WaterWaveSize > 0.02 then
		local w = getWavelength()
		local o = math.cos(2 * math.pi * (x + wt) / w) * math.sin(2 * z * math.pi / w)
		o *= terrain.WaterWaveSize * MAX_WAVE_MAGNITUDE
		return o
	else
		return 0
	end
end

return module
