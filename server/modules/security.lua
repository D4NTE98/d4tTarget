local buckets = {}

local function canUseSource(source)
    if not Config.Permissions.useAce then
        return true
    end

    return IsPlayerAceAllowed(source, Config.Permissions.defaultAce)
end

local function rateAllowed(source)
    if not Config.RateLimit.enabled then
        return true
    end

    local now = GetGameTimer()
    local data = buckets[source] or {
        started = now,
        count = 0
    }

    if now - data.started > Config.RateLimit.interval then
        data.started = now
        data.count = 0
    end

    data.count = data.count + 1
    buckets[source] = data

    return data.count <= Config.RateLimit.maxTriggers
end

RegisterNetEvent('d4tTarget:server:runOption', function(eventName, args, netId)
    local source = source

    if type(eventName) ~= 'string' then
        return
    end

    if not canUseSource(source) then
        return
    end

    if not rateAllowed(source) then
        return
    end

    local entity = 0

    if netId and netId ~= 0 then
        entity = NetworkGetEntityFromNetworkId(netId)
    end

    TriggerEvent(eventName, source, entity, args)
end)

AddEventHandler('playerDropped', function()
    buckets[source] = nil
end)
