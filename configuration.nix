
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };


  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # https://nixos.wiki/wiki/KDE
  services.xserver.displayManager.defaultSession = "plasmawayland";

  # https://nixos.wiki/wiki/KDE
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
     elisa
     konsole
     okular
     gwenview
  ];

  /*
  # Nixos and Hyprland - Best Match Ever | https://www.youtube.com/watch?v=61wGzIv12Ds
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    # If your cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    opengl.enable = true;
  };


  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
  */

  #ADRIAN: attempt at making wine work
  hardware = {
    opengl.enable = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #ADRIAN: I do
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.adrian = {
    isNormalUser = true;
    description = "adrian";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      kate
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  wget
  exa
  brave
  vscode-fhs
  bat
  zellij
  ripgrep
  fd
  gitui
  speedtest-rs
  wiki-tui
  starship
  kitty
  htop
  btop
  procs
  bandwhich
  gping
  fzf
  tealdeer
  nushell
  zoxide
  scc
  entr
  exiftool
  jq
  tre-command
  buku
  cmus
  httpie
  lolcat
  cowsay
  neofetch
  navi
  cmatrix
  lf

  # Nixos and Hyprland - Best Match Ever | https://www.youtube.com/watch?v=61wGzIv12Ds
  /*  
waybar
  
  #(waybar.overrideAttrs (oldAttrs: {
  #  mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  #  })
  #)
  
  dunst
  libnotify
  # maybe later (it has more customization): 
  #eww

  swww

  rofi-wayland

  # Weirdly this also works for hyprland even though it is called "swaylock"
  swaylock
  wlogout

  # I forgot that this isn't installed by default without KDE
  dolphin
*/
  browsh



  kasmweb
  gnome.gnome-boxes

  ];
#  virtualisation.virtualbox.host.enable = true;
#  users.extraGroups.vboxusers.members = [ "adrian" ];
 

  # Nixos and Hyprland - Best Match Ever | https://www.youtube.com/watch?v=61wGzIv12Ds
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

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
  system.stateVersion = "23.05"; # Did you read the comment?
  
  # https://discourse.nixos.org/t/solved-script-for-adding-aliases/30549/3
  programs = {
    command-not-found.enable = false;
    bash = {
        shellAliases = {
            ls = "exa -l";
            cat = "bat";
        };
    };
  };
  nix.settings.experimental-features = ["nix-command" "flakes"];

  #ADRIAN
  #boot.binfmt.emulatedSystems = [
  #  "x86_64-windows"
  #];
}
