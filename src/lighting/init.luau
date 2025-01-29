--!strict
--!optimize 2

-- [Dependencies] --
local TweenService = game:GetService("TweenService")
local LightingService = game:GetService("Lighting")

--[[ TEMPLATE(S)
	ColorCorrection = {
		Brightness = 0,
		Contrast = 0,
		Enabled = false,
		Saturation = 0,
		TintColor = Color3
	}
	,
	DepthOfField = {
		Enabled = false,
		FarIntensity = 0,
		FocusDistance = 0,
		InFocusRadius = 0,
		NearIntensity = 0
	}
	,
	Blur = {
		Enabled = false,
		Size = 0,
	}
	,
	Bloom = {
		Enabled = false,
		Intensity = 0,
		Size = 0,
		Threshold = 0
	}
	,
	Atmosphere = {
		Density = 0,
		Offset = 0,
		Color = Color3.fromRGB(),
		Decay = Color3.fromRGB(),
		Glare = 0,
		Haze = 0
	}
	,
	Sky = {
		CelestialBodiesShown = false,
		Offset = 0,
		MoonAngularSize = 0,
		MoonTextureId = "",
		SkyboxBk = "",
		SkyboxDn = "",
		SkyboxFt = "",
		Skyboxlt = "",
		SkyboxRt = "",
		SkyboxUp = "",
		StarCount = 0,
		SunAngularSIze = 0,
		SunTextureId = ""
	}
]]

type ColorCorrectionEnum = {
	Brightness: number?,
	Contrast: number?,
	Enabled: boolean?,
	Saturation: number?,
	TintColor: Color3?,
}

type DepthOfFieldEnum = {
	Enabled: boolean?,
	FarIntensity: number?,
	FocusDistance: number?,
	InFocusRadius: number?,
	NearIntensity: number?,
}

type BlurEnum = {
	Enabled: boolean?,
	Size: number?,
}

type BloomEnum = {
	Enabled: boolean?,
	Intensity: number?,
	Size: number?,
	Threshold: number?,
}

type AtmosphereEnum = {
	Density: number?,
	Offset: number?,
	Color: Color3?,
	Decay: Color3?,
	Glare: number?,
	Haze: number?,
}

type SkyEnum = {
	CelestialBodiesShown: boolean?,
	Offset: number?,
	MoonAngularSize: number?,
	MoonTextureId: string?,
	SkyboxBk: string?,
	SkyboxDn: string?,
	SkyboxFt: string?,
	Skyboxlt: string?,
	SkyboxRt: string?,
	SkyboxUp: string?,
	StarCount: number?,
	SunAngularSize: number?,
	SunTextureId: string?,
}

export type EnumObjects = {
	ColorCorrection: ColorCorrectionEnum,
	DepthOfField: DepthOfFieldEnum,
	Blur: BlurEnum,
	Bloom: BloomEnum,
	Atmosphere: AtmosphereEnum,
	Sky: SkyEnum,
}

type CreateEnumsConstructor = {
    EnumArray: { any },
}

type CreateEnumsType = typeof(setmetatable) & CreateEnumsConstructor

type CreateEnums = (enumArray: { string }) -> CreateEnumsType

type CreateEnum = (string) -> string

type ObjectMethod = (render: boolean, config: any, condition: ObjectCondition?) -> ObjectType

type CreateObject = (class: string) -> ObjectMethod

type ObjectCondition = (objectData: ObjectType, config: { any }) -> nil

export type ObjectType = typeof(setmetatable) & {
	Class: string,
} & () -> nil

type Framework = {
	CreateEnums: CreateEnums,
	CreateEnum: CreateEnum,
	CreateObject: CreateObject,
}

type ColorCorrectionMethod = (render: boolean, config: ColorCorrectionEnum, condition: ObjectCondition?) -> ObjectType

type DepthOfFieldMethod = (render: boolean, config: DepthOfFieldEnum, condition: ObjectCondition?) -> ObjectType

type BlurMethod = (render: boolean, config: BlurEnum, condition: ObjectCondition?) -> ObjectType

type BloomMethod = (render: boolean, config: BloomEnum, condition: ObjectCondition?) -> ObjectType

type SkyMethod = (render: boolean, config: SkyEnum, condition: ObjectCondition?) -> ObjectType

type AtmosphereMethod = (render: boolean, config: AtmosphereEnum, condition: ObjectCondition?) -> ObjectType

type LightingMethods = {
	TweenArray: (object: ObjectType, array: { any }, TweenInfo, lerpTime: number?) -> (),
	GetLightingInstance: (class: string) -> Object & Instance,
	Instances: {
		number: "NumberValue",
		Color3: "Color3Value",
	},
	Tweens: { [string] : { Tween } },
	Object: {
		Sky: SkyMethod,
        ColorCorrection: ColorCorrectionMethod,
        DepthOfField: DepthOfFieldMethod,
        Blur: BlurMethod,
        Atmosphere: AtmosphereMethod,
        Bloom: BloomMethod
	},
	Enums: EnumObjects,
}

local Framework = {
	CreateEnums = function(enumArray)
		local metatable = setmetatable({
            EnumArray = enumArray,
        }, {
            __index = function(object, index): any
                local result, found = nil, table.find(object.EnumArray, index) :: number

				if typeof(found) == "number" then
					result = object.EnumArray[found]
				elseif found then
					result = found
				end;

				return result;
            end,
            __newindex = function()
                error("Cannot modify read-only enum", 2)
            end,
        })

		return metatable :: CreateEnumsType | any -- Script Analysis Shut up
	end,
	CreateObject = function(class: string)
		return function(render, config, condition)
			local metatable = setmetatable({
				Class = class,
			}, {
				__call = function(object)
					if not render then
						return
					end

					if condition then
						condition(object, config)
					end
				end,
			})

			return metatable :: ObjectType | any -- Script Analysis Shut up
		end
	end,
} :: Framework

local Lighting = {
	Object = {},
	Enums = {
		Sky = Framework.CreateEnums({
			"CelestialBodiesShown",
			"Offset",
			"MoonAngularSize",
			"MoonTextureId",
			"SkyboxBk",
			"SkyboxDn",
			"SkyboxFt",
			"Skyboxlt",
			"SkyboxRt",
			"SkyboxUp",
			"StarCount",
			"SunAngularSize",
			"SunTextureId",
		}),
		Atmosphere = Framework.CreateEnums({
			"Density",
			"Offset",
			"Color",
			"Decay",
			"Glare",
			"Haze",
		}),
        Bloom = Framework.CreateEnums({
            "Enabled",
            "Intensity",
            "Size",
            "Threshold",
        }),
        Blur = Framework.CreateEnums({
            "Enabled",
            "Size",
        }),
        DepthOfField = Framework.CreateEnums({
            "Enabled",
            "FarIntensity",
            "FocusDistance",
            "InFocusRadius",
            "NearIntensity",
        }),
        ColorCorrection = Framework.CreateEnums({
            "Brightness",
            "Contrast",
            "Enabled",
            "Saturation",
            "TintColor",
        }),
	},
	Tweens = {},
	Instances = {
		string = "StringValue",
		boolean = "BoolValue",
		number = "NumberValue",
		Color3 = "Color3Value",
	},
} :: LightingMethods

Lighting.GetLightingInstance = function(class: string)
	local found = LightingService:FindFirstChildOfClass(class) or Instance.new(class, LightingService)
	return found
end

Lighting.TweenArray = function(object, config, tweenInfo)
    local lightingInstance = Lighting.GetLightingInstance(object.Class)
    if not lightingInstance then return end


    if Lighting.Tweens[object.Class] then
        for index, tween in Lighting.Tweens[object.Class] do
            tween:Pause();
        end
    else
        Lighting.Tweens[object.Class] = {};
    end;

    local tweenableProperties = {}
    for property, targetValue in pairs(config) do
        if (lightingInstance :: any)[property] == nil then continue end
        if (lightingInstance :: any)[property] == targetValue then continue end;

        local currentValue = (lightingInstance :: any)[property]
        local valueType = typeof(currentValue)

        if currentValue == targetValue then continue end

        if valueType == "number" or valueType == "Color3" then
            tweenableProperties[property] = targetValue
        else
            (lightingInstance :: any)[property] = targetValue
        end
    end

    if next(tweenableProperties) then
        local tween = TweenService:Create(lightingInstance, tweenInfo, tweenableProperties)
        table.insert(Lighting.Tweens[object.Class], tween);
        tween:Play()
    end
end


Lighting.Object.Sky = Framework.CreateObject("Sky")

Lighting.Object.Atmosphere = Framework.CreateObject("Atmosphere")

Lighting.Object.Blur = Framework.CreateObject("BlurEffect")

Lighting.Object.Bloom = Framework.CreateObject("BloomEffect")

Lighting.Object.DepthOfField = Framework.CreateObject("DepthOfFieldEffect")

Lighting.Object.ColorCorrection = Framework.CreateObject("ColorCorrectionEffect")

return Lighting
