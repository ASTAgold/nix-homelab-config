{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    # ./../../modules/docker.nix
  ];
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "peter";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Casablanca";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ar_MA.UTF-8";
    LC_IDENTIFICATION = "ar_MA.UTF-8";
    LC_MEASUREMENT = "ar_MA.UTF-8";
    LC_MONETARY = "ar_MA.UTF-8";
    LC_NAME = "ar_MA.UTF-8";
    LC_NUMERIC = "ar_MA.UTF-8";
    LC_PAPER = "ar_MA.UTF-8";
    LC_TELEPHONE = "ar_MA.UTF-8";
    LC_TIME = "ar_MA.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

# Allow unfree packages
nixpkgs.config.allowUnfree = true;

# Enable the OpenSSH daemon.
services.openssh.enable = true;


#   # Container definitions for the Dell
#   virtualisation.oci-containers.containers = {
#     qbit = {
#       image = "lscr.io/linuxserver/qbittorrent:latest";
#       volumes = [
#         "/mnt/storage/config/qbit:/config"
#         "/mnt/storage/downloads:/downloads"
#       ];
#       ports = [
#         "6881:6881"
#         "6881:6881/udp"
#       ];
#     };

# 
#   # Storage configuration
#   fileSystems."/mnt/data1" = {
#     device = "/dev/disk/by-uuid/<YOUR_DRIVE1_UUID>";
#     fsType = "ext4";
#   };
#   fileSystems."/mnt/data2" = {
#     device = "/dev/disk/by-uuid/<YOUR_DRIVE2_UUID>";
#     fsType = "ext4";
#   };
#   fileSystems."/mnt/parity" = {
#     device = "/dev/disk/by-uuid/<YOUR_PARITY_UUID>";
#     fsType = "ext4";
#   };
# 
#   services.mergerfs = {
#     enable = true;
#     pools = [{
#       name = "storage";
#       paths = [ "/mnt/data1" "/mnt/data2" ];
#       mountPoint = "/mnt/storage";
#       options = "defaults,allow_other,use_ino";
#     }];
#   };

#   services.snapraid = {
#     enable = true;
#     config = ''
#       parity /mnt/parity/snapraid.parity
#       content /mnt/data1/snapraid.content
#       content /mnt/data2/snapraid.content
#       disk data1 /mnt/data1
#       disk data2 /mnt/data2
#       exclude /mnt/storage/media/*
#     '';
#   };

#   services.samba = {
#     enable = true;
#     shares = {
#       storage = {
#         path = "/mnt/storage";
#         "guest ok" = "yes";
#         "read only" = "no";
#         "create mask" = "0664";
#         "directory mask" = "0775";
#       };
#     };
#   };

  # User definition with host-specific permissions
  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    initialHashedPassword = ""; # Set with `passwd admin` after install
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIER4S+aFma+Vhg7zR1smua2plzOy8R/TPArb14+zO3oL abde2006llah@gmail.com" ];
  };

  home-manager.users.admin = {
    imports = [ ./../../users/admin.nix ];
  };

    system.stateVersion = "25.05"; # Did you read the comment?
}

