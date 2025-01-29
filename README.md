# Roblox Lighting Module

A comprehensive lighting module for Roblox that allows developers to easily manage and customize various lighting effects and configurations in their games. This module provides a structured approach to handling lighting properties, including animations and tweening.

## Features

- **Lighting Effects Management**: Easily configure and animate various lighting effects such as Sky, Atmosphere, Bloom, Blur, Depth of Field, and Color Correction.
- **Tweening System**: Smoothly animate lighting properties using Roblox's TweenService.
- **Enum-Based Configuration**: Use predefined enums for consistent and type-safe configuration of lighting properties.
- **Modular Structure**: Clean and organized code structure with clear separation of concerns.

## Installation

1. Place the `Lighting` module in `ReplicatedStorage`.
2. Require the module in your scripts:

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = require(ReplicatedStorage:WaitForChild("Lighting"));
```

## Usage

### Basic Example

```lua
return {
    Lighting.Object.Sky(true, {
        [Lighting.Enums.Sky.SunAngularSize] = 11,
    }),
}
```

### Advanced Example with Tweening

```lua
return {
    Lighting.Object.Sky(true, {
        [Lighting.Enums.Sky.SunAngularSize] = 11,
    }, function(object, config)
        local tweenInfo = TweenInfo.new(1);
        Lighting.TweenArray(object, config, tweenInfo, 0.85);
    end),

    Lighting.Object.Atmosphere(true, {
        [Lighting.Enums.Atmosphere.Decay] = Color3.fromRGB(106, 112, 125),
    }, function(object, config)
        local tweenInfo = TweenInfo.new(1);
        Lighting.TweenArray(object, config, tweenInfo, 0.85);
    end)
}
```

## Tweening System

The module includes a built-in tweening system that allows you to smoothly animate lighting properties. Here’s how to use it:

1. **TweenInfo**: Define your tween parameters using `TweenInfo.new()`.
2. **TweenArray**: Pass your tween info and configuration to `Lighting.TweenArray()`.

### Example

```lua
local tweenInfo = TweenInfo.new(1);
Lighting.TweenArray(object, config, tweenInfo, 0.85);
```

## Configuration Options

### Sky

- `CelestialBodiesShown`: Whether celestial bodies are shown.
- `Offset`: The offset of the sky.
- `MoonAngularSize`: The size of the moon.
- `MoonTextureId`: The texture ID for the moon.
- `SkyboxBk`: The skybox back texture ID.
- `SkyboxDn`: The skybox down texture ID.
- `SkyboxFt`: The skybox front texture ID.
- `Skyboxlt`: The skybox left texture ID.
- `SkyboxRt`: The skybox right texture ID.
- `SkyboxUp`: The skybox up texture ID.
- `StarCount`: The number of stars.
- `SunAngularSize`: The size of the sun.
- `SunTextureId`: The texture ID for the sun.

### Atmosphere

- `Density`: The density of the atmosphere.
- `Offset`: The offset of the atmosphere.
- `Color`: The color of the atmosphere.
- `Decay`: The decay color of the atmosphere.
- `Glare`: The glare intensity.
- `Haze`: The haze intensity.

### Bloom

- `Enabled`: Whether bloom is enabled.
- `Intensity`: The intensity of the bloom.
- `Size`: The size of the bloom.
- `Threshold`: The threshold for the bloom.

### Blur

- `Enabled`: Whether blur is enabled.
- `Size`: The size of the blur.

### Depth of Field

- `Enabled`: Whether depth of field is enabled.
- `FarIntensity`: The intensity of the far depth of field.
- `FocusDistance`: The focus distance.
- `InFocusRadius`: The radius of the in-focus area.
- `NearIntensity`: The intensity of the near depth of field.

### Color Correction

- `Brightness`: The brightness adjustment.
- `Contrast`: The contrast adjustment.
- `Enabled`: Whether color correction is enabled.
- `Saturation`: The saturation adjustment.
- `TintColor`: The tint color.

## Contributing

Contributions are welcome! Feel free to fork the repository and submit pull requests.

## License

[MIT license](https://github.com/negerleins/LightingFramework?tab=MIT-1-ov-file#readme)
