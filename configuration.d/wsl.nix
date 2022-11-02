{ lib, pkgs, config, modulesPath, ... }:

{
  wsl = {
    enable = true;
    interop.register = true;
    startMenuLaunchers = true;
    wslConf.automount.root = "/mnt";
  };

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    libsecret
    wl-clipboard
    xdg-desktop-portal
    xdg-desktop-portal-gtk
  ];
}
