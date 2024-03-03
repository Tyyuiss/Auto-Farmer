_G.script_host = 'USERNAME' -- Username of the player you want the bot to teleport to! & Have commands
_G.teleport = true -- Change to False and delete the loadstring to use toggles
_G.prefix = '/' -- / is DEFAULT prefix, /cmds for commands!
_G.messages = true -- Whether or not it sends a message in chat!

_G.whitelisted_users = {'USERNAME'} -- Players that can use commands on your bot(s) other than you!

loadstring(game:HttpGet(("https://raw.githubusercontent.com/Tyyuiss/Auto-Farmer/main/code.lua"),true))()
