function ShowTargetMenu(options)
    if not Config.EnableNuiMenu then
        return
    end

    local safeOptions = {}

    for _, option in ipairs(options or {}) do
        safeOptions[#safeOptions + 1] = D4TTarget.SafeOption(option)
    end

    TargetState.visible = true
    SetNuiFocus(false, false)

    SendNUIMessage({
        action = 'show',
        options = safeOptions
    })
end

function HideTargetMenu()
    TargetState.visible = false
    TargetState.currentOptions = {}

    SendNUIMessage({
        action = 'hide'
    })
end

function RefreshTargetMenu(options)
    if not TargetState.visible then
        return
    end

    ShowTargetMenu(options)
end

RegisterNUICallback('select', function(data, cb)
    local index = tonumber(data.index)
    local option = TargetState.currentOptions[index]

    if option then
        ExecuteTargetOption(option)
    end

    cb({ ok = true })
end)

RegisterNUICallback('close', function(_, cb)
    HideTargetMenu()
    cb({ ok = true })
end)
