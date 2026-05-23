local function checkJob(option)
    if not option.job then
        return true
    end

    local core = exports.d4tCore and exports.d4tCore:AccessCore() or nil
    local data = core and core.Player and core.Player.Data or nil
    local job = data and data.job and data.job.name or nil

    if type(option.job) == 'string' then
        return job == option.job
    end

    return D4TTarget.HasValue(option.job, job)
end

local function checkGang(option)
    if not option.gang then
        return true
    end

    local core = exports.d4tCore and exports.d4tCore:AccessCore() or nil
    local data = core and core.Player and core.Player.Data or nil
    local gang = data and data.gang and data.gang.name or nil

    if type(option.gang) == 'string' then
        return gang == option.gang
    end

    return D4TTarget.HasValue(option.gang, gang)
end

local function checkItem(option)
    if not option.item then
        return true
    end

    return true
end

function CanUseTargetOption(option, entity, coords)
    if not option or not option.label then
        return false
    end

    if option.canInteract and not option.canInteract(entity, coords, option.args) then
        return false
    end

    if not checkJob(option) then
        return false
    end

    if not checkGang(option) then
        return false
    end

    if not checkItem(option) then
        return false
    end

    return true
end

function FilterTargetOptions(options, entity, coords)
    local result = {}

    for _, option in ipairs(options or {}) do
        if CanUseTargetOption(option, entity, coords) then
            result[#result + 1] = option
        end
    end

    return result
end
