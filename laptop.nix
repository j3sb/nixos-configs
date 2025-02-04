{config, options, pkgs, ...}:

{
  imports = 
    [
      ./common.nix
    ];

    networking.hostName = "nixost-light"; # Define your hostname.
}

