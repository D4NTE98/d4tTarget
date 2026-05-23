# API

## Target Types

d4tTarget supports:

- Zones
- Entities
- Models
- Bones
- Global entity groups

## Option Priority

Options are collected from:

1. Active zone
2. Global entity type
3. Exact entity
4. Entity model

All valid options are displayed together in the NUI menu.

## Client Event Option

```lua
{
    label = 'Talk',
    event = 'npc:client:talk'
}
```

## Server Event Option

```lua
{
    label = 'Open Storage',
    serverEvent = 'storage:server:open',
    args = {
        id = 'main'
    }
}
```

## Direct Action Option

```lua
{
    label = 'Inspect',
    action = function(entity, coords, args)
    end
}
```
