# Clanware Justice SDK
An SDK for the Clanware Justice API. This is based off of the [Clanware Justice API](https://justice.clanware.org/api/docs), version 1.0.0.

## Installation
This SDK is available on npm (for Roblox-TS) and on wally (for Lua). To install it, run this command:
```bash
  npm install @rbxts/clanware-justice-sdk
```

Or add this to your `wally.toml`:
```toml
  [dependencies]
  justice-sdk = "cosigyn/justice-sdk@latest"
```

Alternatively you can download a `.rbxm` from the [releases](https://github.com/Clanware-Innovations/justice-lua-sdk/releases) page.

## Usage
### Roblox-TS
```ts
  import { createClanwareService } from "@rbxts/clanware-justice-sdk";
  import { HTTPService } from "@rbxts/services"

  const = ClanwareService = createClanwareService().getInstance('API-KEY')

  print(HTTPService.JSONDecode(ClanwareService.listDegenerates().Body)[0])
```

### Lua
```lua
  local ClanwareService = require(game:GetService("ReplicatedStorage").ClanwareService).getInstance('API-KEY')
  local HttpService = game:GetService("HttpService")

  print(HttpService:JSONDecode(ClanwareService:listDegenerates())[1])
```