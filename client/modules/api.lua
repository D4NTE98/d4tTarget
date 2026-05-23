local function normalizeOptions(options)
    if type(options) ~= 'table' then
        return {}
    end

    local result = {}

    for index, option in ipairs(options) do
        local item = D4TTarget.Copy(option)
        item.id = item.id or D4TTarget.MakeId('option')
        item.index = index
        result[#result + 1] = item
    end

    return result
end

local function addBucket(bucket, key, options)
    bucket[key] = bucket[key] or {}

    for _, option in ipairs(normalizeOptions(options)) do
        bucket[key][#bucket[key] + 1] = option
    end

    return key
end

function RegisterBoxZone(id, coords, size, options, targetOptions)
    id = id or D4TTarget.MakeId('zone')

    TargetState.zones[id] = {
        id = id,
        type = 'box',
        coords = coords,
        size = size or vector3(2.0, 2.0, 2.0),
        rotation = options and options.rotation or 0.0,
        debug = options and options.debug or false,
        options = normalizeOptions(targetOptions)
    }

    return id
end

function RegisterSphereZone(id, coords, radius, options, targetOptions)
    id = id or D4TTarget.MakeId('zone')

    TargetState.zones[id] = {
        id = id,
        type = 'sphere',
        coords = coords,
        radius = radius or 2.0,
        debug = options and options.debug or false,
        options = normalizeOptions(targetOptions)
    }

    return id
end

function RegisterEntityTarget(entity, options)
    if not entity or entity == 0 then
        return false
    end

    return addBucket(TargetState.entities, entity, options)
end

function RegisterModelTarget(models, options)
    if type(models) ~= 'table' then
        models = { models }
    end

    for _, model in ipairs(models) do
        if type(model) == 'string' then
            model = joaat(model)
        end

        addBucket(TargetState.models, model, options)
    end

    return true
end

function RegisterBoneTarget(bones, options)
    if type(bones) ~= 'table' then
        bones = { bones }
    end

    for _, bone in ipairs(bones) do
        addBucket(TargetState.bones, bone, options)
    end

    return true
end

function RegisterGlobalTarget(targetType, options)
    if not TargetState.globals[targetType] then
        return false
    end

    for _, option in ipairs(normalizeOptions(options)) do
        TargetState.globals[targetType][#TargetState.globals[targetType] + 1] = option
    end

    return true
end

function UnregisterZone(id)
    TargetState.zones[id] = nil
    return true
end

function UnregisterEntityTarget(entity)
    TargetState.entities[entity] = nil
    return true
end

function UnregisterModelTarget(model)
    if type(model) == 'string' then
        model = joaat(model)
    end

    TargetState.models[model] = nil
    return true
end

function UnregisterBoneTarget(bone)
    TargetState.bones[bone] = nil
    return true
end

exports('RegisterBoxZone', RegisterBoxZone)
exports('RegisterSphereZone', RegisterSphereZone)
exports('RegisterEntityTarget', RegisterEntityTarget)
exports('RegisterModelTarget', RegisterModelTarget)
exports('RegisterBoneTarget', RegisterBoneTarget)
exports('RegisterGlobalTarget', RegisterGlobalTarget)
exports('UnregisterZone', UnregisterZone)
exports('UnregisterEntityTarget', UnregisterEntityTarget)
exports('UnregisterModelTarget', UnregisterModelTarget)
exports('UnregisterBoneTarget', UnregisterBoneTarget)
