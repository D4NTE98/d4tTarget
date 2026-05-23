# d4tTarget

d4tTarget is a modern FiveM interaction targeting system designed for d4tCore.

It provides entity, model, zone and global interaction support with a clean export API, NUI interaction menu and basic server-side protection for triggered server options.

## Features

- Entity targeting
- Model targeting
- Global player, ped, vehicle and object targeting
- Box zones
- Sphere zones
- Raycast based detection
- NUI interaction menu
- Server event rate limiting
- ACE permission protection
- d4tCore compatible job and gang checks
- Lightweight modular structure

## Installation

1. Place `d4tTarget` inside your resources folder.
2. Add this to `server.cfg`:

```cfg
ensure d4tCore
ensure d4tTarget
```

3. Grant ACE permission if enabled:

```cfg
add_ace group.admin d4tTarget.use allow
```

## Folder Structure

```text
d4tTarget/
├── client/
│   └── modules/
├── server/
│   └── modules/
├── shared/
│   └── modules/
├── web/
├── docs/
├── fxmanifest.lua
└── README.md
```

## Client Exports

### RegisterBoxZone

```lua
exports.d4tTarget:RegisterBoxZone(id, coords, size, options, targetOptions)
```

Example:

```lua
exports.d4tTarget:RegisterBoxZone('police_armory', vector3(452.1, -980.2, 30.6), vector3(2.0, 2.0, 2.0), {
    rotation = 0.0
}, {
    {
        label = 'Open Armory',
        icon = '⚙',
        job = 'police',
        event = 'police:client:openArmory'
    }
})
```

### RegisterSphereZone

```lua
exports.d4tTarget:RegisterSphereZone(id, coords, radius, options, targetOptions)
```

### RegisterEntityTarget

```lua
exports.d4tTarget:RegisterEntityTarget(entity, options)
```

### RegisterModelTarget

```lua
exports.d4tTarget:RegisterModelTarget(models, options)
```

Example:

```lua
exports.d4tTarget:RegisterModelTarget({ 'prop_atm_01', 'prop_atm_02' }, {
    {
        label = 'Use ATM',
        icon = '$',
        event = 'banking:client:openATM'
    }
})
```

### RegisterGlobalTarget

```lua
exports.d4tTarget:RegisterGlobalTarget(targetType, options)
```

Available target types:

- `player`
- `ped`
- `vehicle`
- `object`

Example:

```lua
exports.d4tTarget:RegisterGlobalTarget('vehicle', {
    {
        label = 'Lockpick Vehicle',
        icon = '🔑',
        event = 'vehicles:client:lockpick'
    }
})
```

### RegisterBoneTarget

```lua
exports.d4tTarget:RegisterBoneTarget(bones, options)
```

### Unregister Exports

```lua
exports.d4tTarget:UnregisterZone(id)
exports.d4tTarget:UnregisterEntityTarget(entity)
exports.d4tTarget:UnregisterModelTarget(model)
exports.d4tTarget:UnregisterBoneTarget(bone)
```

## Option Schema

```lua
{
    id = 'unique_option_id',
    label = 'Option Label',
    icon = '◆',
    event = 'client:event:name',
    serverEvent = 'server:event:name',
    args = {},
    job = 'police',
    gang = 'lostmc',
    close = true,
    canInteract = function(entity, coords, args)
        return true
    end,
    action = function(entity, coords, args)
    end
}
```

## Server Options

When `serverEvent` is used, d4tTarget validates the request and triggers the server event internally.

Server handler example:

```lua
RegisterNetEvent('garage:server:openVehicle', function(source, entity, args)
end)
```

## Configuration

Main settings are available in:

```text
shared/config.lua
```

Important options:

- `Config.MaxDistance`
- `Config.EnableNuiMenu`
- `Config.EnableSprite`
- `Config.Permissions.useAce`
- `Config.RateLimit.enabled`

## Notes

d4tTarget is designed as a standalone targeting layer for d4tCore resources. It does not require external target systems.
