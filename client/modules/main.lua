CreateThread(function()
    while true do
        local delay = Config.IdleDelay

        if TargetState.active then
            delay = Config.TickDelay
            local options = ScanTargets()

            if #options > 0 then
                ShowTargetMenu(options)
            else
                HideTargetMenu()
            end
        end

        Wait(delay)
    end
end)

CreateThread(function()
    while true do
        if TargetState.visible and TargetState.currentCoords and Config.EnableSprite then
            DrawMarker(
                2,
                TargetState.currentCoords.x,
                TargetState.currentCoords.y,
                TargetState.currentCoords.z + 0.2,
                0.0,
                0.0,
                0.0,
                0.0,
                180.0,
                0.0,
                0.18,
                0.18,
                0.18,
                Config.Colors.sprite.r,
                Config.Colors.sprite.g,
                Config.Colors.sprite.b,
                Config.Colors.sprite.a,
                false,
                true,
                2,
                false,
                nil,
                nil,
                false
            )

            Wait(0)
        else
            Wait(250)
        end
    end
end)
