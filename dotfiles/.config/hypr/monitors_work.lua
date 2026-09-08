--###############
--## MONITORS ###
--###############

-- Match dock monitors by description: MST connector names (DP-n) change on every replug
local left = "desc:Dell Inc. DELL S2725DS 5PV5J74"
local right = "desc:Dell Inc. DELL U2424H HR2QG34"

hl.monitor({
    output = "eDP-1",
    mode = "1920x1200",
    position = "0x300",
    scale = "1.25",
})

hl.monitor({
    output = left,
    mode = "2560x1440",
    position = "1536x0",
    scale = "1",
})

hl.monitor({
    output = right,
    mode = "1920x1080",
    position = "4096x0",
    scale = "1",
    transform = 3,
})

-- Workspaces

hl.workspace_rule({
    workspace = "name:1",
    monitor = "eDP-1",
})

hl.workspace_rule({
    workspace = "name:2",
    monitor = left,
})

hl.workspace_rule({
    workspace = "name:4",
    monitor = left,
})

hl.workspace_rule({
    workspace = "name:6",
    monitor = left,
})

hl.workspace_rule({
    workspace = "name:8",
    monitor = left,
})

hl.workspace_rule({
    workspace = "name:3",
    monitor = right,
})

hl.workspace_rule({
    workspace = "name:5",
    monitor = right,
})

hl.workspace_rule({
    workspace = "name:7",
    monitor = right,
})

hl.workspace_rule({
    workspace = "name:9",
    monitor = right,
})


-- autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("firefox", { workspace = "1 silent" })
    hl.exec_cmd("code", { workspace = "2 silent" })
    hl.exec_cmd("kitty", { workspace = "3" })
end)
