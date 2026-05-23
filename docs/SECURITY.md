# Security

d4tTarget includes basic protection for server-triggered options.

## Server Validation

Server options are validated using:

- Event name type checks
- ACE permission checks
- Rate limiting
- Network entity resolution

## ACE Permission

When enabled, the source must have:

```cfg
d4tTarget.use
```

## Rate Limit

Rate limits are configured in:

```text
shared/config.lua
```

## Recommended Usage

Keep sensitive validation inside your own server event handlers. d4tTarget protects the transport layer, but final permission checks should always happen inside the resource that performs the action.
