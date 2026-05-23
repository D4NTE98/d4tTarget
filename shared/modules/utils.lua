D4TTarget = D4TTarget or {}

function D4TTarget.Copy(value)
    if type(value) ~= 'table' then
        return value
    end

    local result = {}

    for key, item in pairs(value) do
        result[D4TTarget.Copy(key)] = D4TTarget.Copy(item)
    end

    return result
end

function D4TTarget.MakeId(prefix)
    return ('%s:%s:%s'):format(prefix or 'target', GetGameTimer and GetGameTimer() or os.time(), math.random(100000, 999999))
end

function D4TTarget.Distance(a, b)
    return #(a - b)
end

function D4TTarget.IsFunction(value)
    return type(value) == 'function'
end

function D4TTarget.HasValue(list, value)
    if type(list) ~= 'table' then
        return false
    end

    for _, item in pairs(list) do
        if item == value then
            return true
        end
    end

    return false
end

function D4TTarget.SafeOption(option)
    local safe = {}

    safe.id = option.id
    safe.label = option.label
    safe.icon = option.icon
    safe.distance = option.distance
    safe.event = option.event
    safe.serverEvent = option.serverEvent
    safe.args = option.args
    safe.close = option.close ~= false

    return safe
end
