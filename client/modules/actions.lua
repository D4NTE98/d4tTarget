function ExecuteTargetOption(option)
    if not option then
        return false
    end

    local entity = TargetState.currentEntity
    local coords = TargetState.currentCoords

    if option.action then
        option.action(entity, coords, option.args)
    elseif option.serverEvent then
        TriggerServerEvent('d4tTarget:server:runOption', option.serverEvent, option.args, NetworkGetNetworkIdFromEntity(entity or 0))
    elseif option.event then
        TriggerEvent(option.event, entity, coords, option.args)
    end

    if option.close ~= false then
        HideTargetMenu()
    end

    return true
end

RegisterCommand('+d4tTarget', function()
    TargetState.active = true
end, false)

RegisterCommand('-d4tTarget', function()
    TargetState.active = false
    HideTargetMenu()
end, false)

RegisterKeyMapping('+d4tTarget', 'Open d4tTarget', 'keyboard', 'LMENU')
