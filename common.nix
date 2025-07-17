# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, options, pkgs, ... }:

{
  imports =
    [ 
      <home-manager/nixos>
    ];


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
	blender
	btop-rocm
	discord
	ffmpeg
	firefox
	gh
	godot_4
	htop
	kdePackages.dolphin
	keepassxc
	nautilus
	neovim
	nextcloud-client
	ouch
	pavucontrol
	podman-tui
	reptyr
	rnote
	rpi-imager
	vlc
	vscode
	wireguard-tools
	wl-clipboard
	xournalpp
  ];

  ## docker and podman
  # docker
  virtualisation.docker.enable = true;
  # podman
  virtualisation.containers.enable = true;
  virtualisation = {
  	podman = {
		enable = true;
		# Required for containers under podman-compose to be able to talk to each other.
      		defaultNetwork.settings.dns_enabled = true;
	};
  };
  

  programs.git = {
  	enable = true;
	config = {
		# should probably be done in home-manager
		user.email = "jonas.bonnaudet@gmail.com";
		user.name = "Jonas";
		pull.rebase = true;
	};
  };


  # steam
  programs.steam = {
    enable = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # zsh
  # Prevent the new user dialog in zsh
  system.userActivationScripts.zshrc = "touch .zshrc";

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      rebuild = "sudo nixos-rebuild switch";
      update = "sudo nix-channel --update";
      ssh = "TERM=xterm ssh";
    };
    ohMyZsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "robbyrussell";
      };
    loginShellInit = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ] ; then
        exec sway
      fi
      '';

  };

  # Enable the gnome-keyring secrets vault. 
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true;

  # sway
  programs.sway = {
  	enable = true;
        wrapperFeatures.gtk = true;
	# add waybar as a "dependecy" of sway
	extraPackages = with pkgs; [ brightnessctl grim pulseaudio waybar wofi slurp ];
  };

  # foot configuration
  programs.foot = {
    enable = true;

    settings.main = {
      font = "Inconsolata:size=10";
    };
  };

  # enable bluetooth
  services.blueman.enable = true; # blueman to connect bluetooth devices
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # fonts
  fonts.packages = with pkgs; [
	nerd-fonts.jetbrains-mono
	noto-fonts
  	noto-fonts-cjk-sans
  	noto-fonts-emoji
  	liberation_ttf
  	fira-code
  	fira-code-symbols
  	mplus-outline-fonts.githubRelease
  	dina-font
  	proggyfonts
  ];

  # home manager for config files and stuff lol
  home-manager.users.jonas = {
    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "24.11";

    xdg.configFile = {
    	"sway/config".source = ./dotfiles/sway/config;
	"waybar/config".source = ./dotfiles/waybar/config;
	"waybar/style.css".source = ./dotfiles/waybar/style.css;
	"wofi/style.css".source = ./dotfiles/wofi/style.css;
    };
    programs.ssh = {
      enable = true;
      extraConfig = builtins.readFile ./dotfiles/ssh/config;
    };
  };

  # ptrace = 0 for reptyr. makes so that every process can call ptrace on any process (kinda gdb like)
  boot.kernel.sysctl."kernel.yama.ptrace_scope" = 0;

  # auto updates
#  system.autoUpgrade = {
#    enable = true;
#    #flake = inputs.self.outPath;
#    flags = [
#      "--update-input"
#      "nixpkgs"
#      "-L" # print build logs
#    ];
#    dates = "10:00";
#  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # tood set hostname for each host
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "se";
    variant = "us";
  };

  # Configure console keymap
  console.keyMap = "us";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jonas = {
    isNormalUser = true;
    description = "jonas";
    extraGroups = [ "networkmanager" "video" "wheel" "dialout" "docker" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
