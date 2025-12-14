--==================================================
-- CINEMATIC LUXE GRAPHICS
-- Warm Cinema Edition
-- Created by VXX
--==================================================

-- CORE SERVICES
local Lighting = game:GetService("Lighting")
local Terrain = workspace.Terrain

--==================================================
-- RENDER TECHNOLOGY (MAX QUALITY)
--==================================================

Lighting.Technology = Enum.Technology.Future
Lighting.GlobalShadows = false
Lighting.ShadowSoftness = 10
Lighting.ExposureCompensation = -0.001

-- Simulação de iluminação global (PBR FEEL)
Lighting.EnvironmentDiffuseScale = 12.1
Lighting.EnvironmentSpecularScale = 12.25

--==================================================
-- VIEW DISTANCE
--==================================================

Lighting.FogStart = 0
Lighting.FogEnd = 150000

--==================================================
-- POST PROCESSING (CINEMA)
--==================================================

local function getOrCreate(name, class)
    local obj = Lighting:FindFirstChild(name)
    if not obj then
        obj = Instance.new(class)
        obj.Name = name
        obj.Parent = Lighting
    end
    return obj
end

local colorCorrection = getOrCreate("Luxe_Color", "ColorCorrectionEffect")
local bloom = getOrCreate("Luxe_Bloom", "BloomEffect")
local sunRays = getOrCreate("Luxe_SunRays", "SunRaysEffect")

-- Remove efeitos que estragam cinema
for _,fx in pairs(Lighting:GetChildren()) do
    if fx:IsA("BlurEffect") or fx:IsA("DepthOfFieldEffect") then
        fx:Destroy()
    end
end

--==================================================
-- CINEMATIC WARM COLOR GRADING (SUBTLE)
--==================================================

Lighting.Ambient = Color3.fromRGB(130, 125, 120)
Lighting.OutdoorAmbient = Color3.fromRGB(185, 180, 170)

colorCorrection.TintColor = Color3.fromRGB(255, 242, 225)
colorCorrection.Saturation = 0.06
colorCorrection.Contrast = 0.16
colorCorrection.Brightness = -0.03

--==================================================
-- REALISTIC REFLECTIONS (CONTROLLED)
--==================================================

bloom.Intensity = 0.12
bloom.Size = 14
bloom.Threshold = 0.9

sunRays.Intensity = 0.035
sunRays.Spread = 0.25

--==================================================
-- TIME & LIGHT
--==================================================

Lighting.ClockTime = 14
Lighting.Brightness = 2.2

--==================================================
-- WATER (PRESERVED - NOT MODIFIED)
--==================================================

Terrain.WaterColor = Terrain.WaterColor
Terrain.WaterTransparency = Terrain.WaterTransparency
Terrain.WaterReflectance = Terrain.WaterReflectance
Terrain.WaterWaveSize = Terrain.WaterWaveSize
Terrain.WaterWaveSpeed = Terrain.WaterWaveSpeed

--==================================================
-- FINAL TOUCH (FAKE RAY TRACING FEEL)
--==================================================

for _,obj in pairs(workspace:GetDescendants()) do
    if obj:IsA("BasePart") then
        obj.CastShadow = true
        obj.Reflectance = math.clamp(obj.Reflectance, 0, 0.05)
    end
end
local PROFILE = {
    Brightness = 0.02,
    Contrast = 0.03,
    Saturation = 22.08,
    TintColor = Color3.fromRGB(255, 255, 255),

    BloomIntensity = 0.35,
    BloomSize = 10,
    BloomThreshold = 0.92,
    SunRaysIntensity = 0.05,
    SunRaysSpread = 0.9,

    DoF_FocusDistance = 0, 
    DoF_InFocusRadius = 12,
    DoF_BlurAmount = 0.4,

    BlurSize = 0,

    Enabled = true,
}
local Terrain = game:GetService("Workspace").Terrain
local SOFT_WATER_COLOR = Color3.fromRGB(180, 200, 255)
Terrain.WaterColor = SOFT_WATER_COLOR
Terrain.WaterTransparency = 0.85
Terrain.WaterReflectance = 1.0 

Terrain.WaterWaveSize = 0.6 
Terrain.WaterWaveSpeed = 10.0
