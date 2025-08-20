{ pkgs, ... }:

{
  home.stateVersion = "23.11";
  programs.fish.enable = true;
  home.packages = with pkgs; [
    htop
    glances
    git
  ];
}