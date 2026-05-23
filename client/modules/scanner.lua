local function getEntityTypeName(entity)
    local entityType = GetEntityType(entity)

    if entityType == 1 then
        if IsPedAPlayer(entity) then
            return 'player'
        end

        return 'ped'
    end

    if entityType == 2 then
        return 'vehicle'
    end

    if entityType == 3 then
        return 'object'
    end

    return nil
end

local function collectEntityOptions(entity, coords)
    local options = {}
    local model = GetEntityModel(entity)
    local entityType = getEntityTypeName(entity)

    if TargetState.globals[entityType] then
        for _, option in ipairs(TargetState.globals[entityType]) do
            options[#options + 1] = option
        end
    end

    if TargetState.entities[entity] then
        for _, option in ipairs(TargetState.entities[entity]) do
            options[#options + 1] = option
        end
    end

    if TargetState.models[model] then
        for _, option in ipairs(TargetState.models[model]) do
            options[#options + 1] = option
        end
    end

    return FilterTargetOptions(options, entity, coords)
end

local function pointInsideZone(zone, coords)
    if zone.type == 'sphere' then
        return #(coords - zone.coords) <= zone.radius
    end

    if zone.type == 'box' then
        local distance = coords - zone.coords
        return math.abs(distance.x) <= zone.size.x / 2 and math.abs(distance.y) <= zone.size.y / 2 and math.abs(distance.z) <= zone.size.z / 2
    end

    return false
end

local function collectZoneOptions(coords)
    local options = {}

    for _, zone in pairs(TargetState.zones) do
        if pointInsideZone(zone, coords) then
            for _, option in ipairs(zone.options or {}) do
                options[#options + 1] = option
            end
        end
    end

    return FilterTargetOptions(options, 0, coords)
end

function ScanTargets()
    local hit, coords, entity = TargetRaycast(Config.MaxDistance)
    local options = {}

    if hit and coords then
        local zoneOptions = collectZoneOptions(coords)

        for _, option in ipairs(zoneOptions) do
            options[#options + 1] = option
        end
    end

    if entity and entity ~= 0 and DoesEntityExist(entity) then
        local entityCoords = GetEntityCoords(entity)
        local distance = #(GetEntityCoords(PlayerPedId()) - entityCoords)

        if distance <= Config.MaxDistance then
            local entityOptions = collectEntityOptions(entity, entityCoords)

            for _, option in ipairs(entityOptions) do
                options[#options + 1] = option
            end

            TargetState.currentEntity = entity
            TargetState.currentCoords = entityCoords
        end
    else
        TargetState.currentEntity = 0
        TargetState.currentCoords = coords
    end

    TargetState.currentOptions = options

    return options
end
