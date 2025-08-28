# Natural Selection Server with Metamod and AMX Mod X

## Mods Included

This server includes:
- **Metamod-R v1.3.0.149** - Plugin interface for Half-Life engine
- **AMX Mod X v1.9.0** - Administration and scripting platform

## Configuration Files

### Admin Management
- `config/admins.cfg` - Define server administrators
- `config/plugins.ini` - Enable/disable AMX Mod X plugins

### Adding Admins

Edit `config/admins.cfg` and add your admins:
```
"YourName" "YourPassword" "abcdefghijklmnopqrstu" "ce"
```

Or use Steam ID format:
```
"STEAM_0:1:12345678" "" "abcdefghijklmnopqrstu" "ce"
```

### Admin Flags
- `a` - immunity (can't be kicked/banned)
- `b` - slot reservation
- `c` - kick command
- `d` - ban/unban commands
- `e` - slay/slap commands
- `f` - map command
- `g` - cvar command
- `h` - config command
- `i` - chat commands
- `j` - vote commands
- `u` - menu access

### Plugin Management

Edit `config/plugins.ini` to enable/disable plugins:
- Add `;` at the beginning of a line to disable a plugin
- Remove `;` to enable a plugin

Example:
```
admin.amxx          ; Enabled
;mapchooser.amxx    ; Disabled
```

### Admin Commands

Once connected as admin, use these commands:
- `amx_help` - Show available commands
- `amx_who` - Show online admins
- `amx_kick <player>` - Kick a player
- `amx_ban <player> <minutes>` - Ban a player
- `amx_map <mapname>` - Change map
- `amx_vote <question>` - Start a vote

### Console Commands

From server console:
- `meta list` - Show loaded Metamod plugins
- `amx_plugins` - Show loaded AMX Mod X plugins
- `amx_modules` - Show loaded AMX Mod X modules

## Troubleshooting

### Check if mods are loaded:
1. Connect to server console
2. Type `meta version` - should show Metamod-R version
3. Type `amx_version` - should show AMX Mod X version

### Plugin not loading:
1. Check `config/plugins.ini` for correct plugin name
2. Ensure plugin file exists in `data/mods/ns/addons/amxmodx/plugins/`
3. Check server logs for error messages

### Admin commands not working:
1. Verify admin entry in `config/admins.cfg`
2. Check admin flags are correct
3. Ensure you're using correct name/password or Steam ID