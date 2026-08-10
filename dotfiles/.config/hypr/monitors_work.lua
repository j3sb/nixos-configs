--###############
--## MONITORS ###
--###############

hl.monitor({
    output = "eDP-1",
    mode = "1920x1200",
    position = "0x300",
    scale = "1.25",
})

hl.monitor({
    output = "DP-7",
    mode = "2560x1440",
    position = "1536x0",
    scale = "1",
})

hl.monitor({
    output = "DP-8",
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
    monitor = "DP-7",
})

hl.workspace_rule({
    workspace = "name:4",
    monitor = "DP-7",
})

hl.workspace_rule({
    workspace = "name:6",
    monitor = "DP-7",
})

hl.workspace_rule({
    workspace = "name:8",
    monitor = "DP-7",
})

hl.workspace_rule({
    workspace = "name:3",
    monitor = "DP-8",
})

hl.workspace_rule({
    workspace = "name:5",
    monitor = "DP-8",
})

hl.workspace_rule({
    workspace = "name:7",
    monitor = "DP-8",
})

hl.workspace_rule({
    workspace = "name:9",
    monitor = "DP-8",
})


-- autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("firefox", { workspace = "1 silent" })
    hl.exec_cmd("code", { workspace = "2 silent" })
    hl.exec_cmd("kitty", { workspace = "3" })
end)
