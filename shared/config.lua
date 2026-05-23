Config = {}

Config.OpenKey = 19
Config.MaxDistance = 5.0
Config.DefaultDrawDistance = 12.0
Config.TickDelay = 0
Config.IdleDelay = 250
Config.EnableDebug = false
Config.EnableNuiMenu = true
Config.EnableOutline = true
Config.EnableSprite = true
Config.RequireLineOfSight = true

Config.Colors = {
    sprite = { r = 255, g = 255, b = 255, a = 210 },
    outline = { r = 80, g = 160, b = 255, a = 180 }
}

Config.Permissions = {
    useAce = true,
    defaultAce = 'd4tTarget.use'
}

Config.RateLimit = {
    enabled = true,
    interval = 1000,
    maxTriggers = 8
}
