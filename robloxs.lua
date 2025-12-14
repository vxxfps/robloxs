
-- CORE SERVICES
local Lighting = game:GetService("Lighting")
local Terrain = game:GetService("Workspace").Terrain

-- RENDER CONFIGURATION (HIGH QUALITY)
Lighting.Technology = Enum.Technology.Future  
Lighting.GlobalShadows = true
Lighting.ShadowSoftness = 0.3  
Lighting.ExposureCompensation = 0.05  

-- VIEW CONFIGURATION
Lighting.FogEnd = 100000  
Lighting.FogStart = 0

-- === POST-PROCESSING EFFECTS ===
local colorCorrection = Lighting:FindFirstChild("Luxe_Color")
if not colorCorrection then
    colorCorrection = Instance.new("ColorCorrectionEffect")
    colorCorrection.Name = "Luxe_Color"
    colorCorrection.Parent = Lighting
end

local sunRays = Lighting:FindFirstChild("Luxe_SunRays")
if not sunRays then
    sunRays = Instance.new("SunRaysEffect")
    sunRays.Name = "Luxe_SunRays"
    sunRays.Parent = Lighting
end

local bloom = Lighting:FindFirstChild("Luxe_Bloom")
if not bloom then
    bloom = Instance.new("BloomEffect")
    bloom.Name = "Luxe_Bloom"
    bloom.Parent = Lighting
end

-- Ensures no unwanted blur is present
if Lighting:FindFirstChild("Luxe_Blur") then Lighting:FindFirstChild("Luxe_Blur"):Destroy() end
if Lighting:FindFirstChild("RTX_DoF") then Lighting:FindFirstChild("RTX_DoF"):Destroy() end
if Lighting:FindFirstChild("RTX_Film") then Lighting:FindFirstChild("RTX_Film"):Destroy() end

--==================================================
-- THEMES & PRESETS ESSENCIAIS
-- (Apenas o preset "Vibrant Cinema" é necessário para o dia)
--==================================================

local THEMES = {
    -- Balanced and Neutral Cinematic Tone (Cor Neon: Amarela/Dia)
    ["Vibrant Cinema"] = {
        Ambient = Color3.fromRGB(150, 150, 160),  
        Outdoor = Color3.fromRGB(200, 200, 210),  
        Tint = Color3.fromRGB(255, 250, 245),      
        Saturation = 0.1,        
        Contrast = 0.08,        
    }
}

local PROFILE = {
    -- AJUSTE DE BRILHO: Nível de Bloom MÍNIMO
    BloomIntensity = 0.15,    
    BloomSize = 10,
    BloomThreshold = 0.95,    
    SunRaysIntensity_Day = 0.05,  
    SunRaysSpread_Day = 0.2,      
}

--==================================================
-- APPLY FUNCTIONS (SIMPLIFICADAS)
--==================================================

local function applyTheme(theme)
    local t = THEMES[theme]
    if not t then return end

    -- Apply Lighting Colors
    Lighting.Ambient = t.Ambient
    Lighting.OutdoorAmbient = t.Outdoor

    -- Apply Color Correction Filters
    colorCorrection.TintColor = t.Tint
    colorCorrection.Saturation = t.Saturation
    colorCorrection.Contrast = t.Contrast
    
    -- Apply Visual Effects Presets
    bloom.Intensity = PROFILE.BloomIntensity
    bloom.Size = PROFILE.BloomSize
    bloom.Threshold = PROFILE.BloomThreshold
end

local function setDay()
    Lighting.ClockTime = 14
    Lighting.Brightness = 2
    
    sunRays.Intensity = PROFILE.SunRaysIntensity_Day
    sunRays.Spread = PROFILE.SunRaysSpread_Day
    
    applyTheme("Vibrant Cinema") 
end

--==================================================
-- WATER & TERRAIN (MANTIDO)
--==================================================

local SOFT_WATER_COLOR = Color3.fromRGB(180, 200, 255)
Terrain.WaterColor = SOFT_WATER_COLOR
Terrain.WaterTransparency = 0.85
Terrain.WaterReflectance = 1.0
Terrain.WaterWaveSize = 0.6
Terrain.WaterWaveSpeed = 10.0

--==================================================
-- INITIALIZATION
--==================================================

setDay()
