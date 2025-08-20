{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/docker.nix
  ];

  networking.hostName = "stewie";

  virtualisation.oci-containers.containers = {
    jellyfin = {
      image = "lscr.io/linuxserver/jellyfin:latest";
      extraOptions = [ "--network=host" ];
      volumes = [
        "/mnt/storage/media:/data"
        "/var/lib/jellyfin:/config"
      ];
      devices = [ "/dev/dri:/dev/dri" ];
    };

    navidrone = {
      image = "vx3r/navidrone:latest";
      volumes = [
        "/mnt/media/audio:/audio"
      ];
      ports = [
        "4533:4533"
      ];
    };
  };

  # User definition with host-specific permissions
  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "video" "render" ];
    initialHashedPassword = ""; # Set with `passwd admin` after install
    openssh.authorizedKeys.keys = [ "ssh-ed25519 <YOUR_PUBLIC_SSH_KEY>" ];
  };

  home-manager.users.admin = {
    imports = [ ./../../users/admin.nix ];
  };
}