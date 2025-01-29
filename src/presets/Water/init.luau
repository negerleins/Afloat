local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = require(ReplicatedStorage:WaitForChild("Lighting"));

return {
    Lighting.Object.Sky(true, {
        [Lighting.Enums.Sky.SunAngularSize] = 1,
    }, function(object, config)
        local tweenInfo = TweenInfo.new(1);
        Lighting.TweenArray(object, config, tweenInfo, 0.85);
	end),
	Lighting.Object.Atmosphere(true, {
		[Lighting.Enums.Atmosphere.Decay] = Color3.fromRGB(255, 0, 4),
	}, function(object, config)
		local tweenInfo = TweenInfo.new(1);
		Lighting.TweenArray(object, config, tweenInfo, 0.85);
	end)
} :: {
    [any]: Lighting.ObjectType
};
