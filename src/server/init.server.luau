
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local WaterHeightCalculator = require(ReplicatedStorage:WaitForChild("Afloat"))

local WaterGrid = {}
WaterGrid.__index = WaterGrid

local SPACING = 1.5
local MAX_DIMENSION = 45
local HALF_OFFSET = (MAX_DIMENSION // 2) + 1

function WaterGrid.new(referencePart)
	local self = setmetatable({}, WaterGrid)
	self.referencePart = referencePart
	self.referenceCFrame = referencePart.CFrame
	self.waterLevel = referencePart.Position.Y

	self.parts = {}
	self.offsets = {}

	self:InitializeGrid()
	return self
end

function WaterGrid:InitializeGrid()
	local partTemplate = Instance.new("Part")
	partTemplate.Anchored = true
	partTemplate.Size = Vector3.new(SPACING, 0, SPACING)
	partTemplate.CanCollide = false
	partTemplate.CanTouch = false
	partTemplate.CanQuery = false

	local index = 0
	local baseCFrame = self.referenceCFrame

	for x = 1, MAX_DIMENSION do
		local xDelta = (x - HALF_OFFSET) * SPACING
		for z = 1, MAX_DIMENSION do
			index += 1
			local zDelta = (z - HALF_OFFSET) * SPACING

			self.offsets[index] = Vector3.new(xDelta, 0, zDelta)

			local wPart = partTemplate:Clone()
			wPart.CFrame = baseCFrame * CFrame.new(xDelta, 0, zDelta)
			wPart.Parent = self.referencePart.Parent
			table.insert(self.parts, wPart)
		end
	end

	partTemplate:Destroy()
end

function WaterGrid:Update(dt, waterHeightCalculator)
	local currentCFrame = self.referenceCFrame
	local yOffset = self.waterLevel - currentCFrame.Position.Y

	waterHeightCalculator.updateWaveClock(dt)

	for i, part in ipairs(self.parts) do
		local offset = self.offsets[i]
		local worldPos = currentCFrame * offset

		local waveOffset = waterHeightCalculator.Calculate(worldPos.X, worldPos.Z)
		part.CFrame = currentCFrame * CFrame.new(offset) * CFrame.new(0, waveOffset + yOffset, 0)
	end
end

function WaterGrid:Destroy()
	for _, part in ipairs(self.parts) do
		part:Destroy()
	end
	self.parts = {}
end

local referencePart = workspace:WaitForChild("Folder"):WaitForChild("Part")

local waterGrid = WaterGrid.new(referencePart)

RunService.Heartbeat:Connect(function(dt)
	waterGrid:Update(dt, WaterHeightCalculator)
end)

game:BindToClose(function()
	waterGrid:Destroy()
end)

local terrain = game.Workspace:WaitForChild("Terrain")
delay(3, function()
	terrain.WaterWaveSpeed = 40
end)

print("Water grid initialized successfully.")
