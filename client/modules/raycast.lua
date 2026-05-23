local function rotationToDirection(rotation)
    local adjusted = vector3(
        math.rad(rotation.x),
        math.rad(rotation.y),
        math.rad(rotation.z)
    )

    local direction = vector3(
        -math.sin(adjusted.z) * math.abs(math.cos(adjusted.x)),
        math.cos(adjusted.z) * math.abs(math.cos(adjusted.x)),
        math.sin(adjusted.x)
    )

    return direction
end

function TargetRaycast(distance)
    local cameraCoords = GetGameplayCamCoord()
    local cameraRotation = GetGameplayCamRot(2)
    local direction = rotationToDirection(cameraRotation)
    local targetCoords = cameraCoords + direction * (distance or Config.MaxDistance)

    local handle = StartShapeTestRay(
        cameraCoords.x,
        cameraCoords.y,
        cameraCoords.z,
        targetCoords.x,
        targetCoords.y,
        targetCoords.z,
        -1,
        PlayerPedId(),
        7
    )

    local _, hit, endCoords, surfaceNormal, entity = GetShapeTestResult(handle)

    return hit == 1, endCoords, entity, surfaceNormal
end
