{ config, lib, musnix, nix-gaming, pkgs, modulesPath, ... }:

{
  hardware = {
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = true;
    cpu.intel.updateMicrocode = true;
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkForce "performance";
    powertop.enable = true;
  };

  boot = {
    kernelParams = [ "threadirqs" "intel_pstate=disable" ];
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
    };
  };

  console.useXkbConfig = true;
  networking.networkmanager.enable = true;
  programs.dconf.enable = true;
  programs.evolution.enable = true;
  security.rtkit.enable = true;

  services = {
    flatpak.enable = true;
    fwupd.enable = true;
    gnome = {
      evolution-data-server.enable = true;
      gnome-online-accounts.enable = true;
      gnome-keyring.enable = true;
    };
    hardware.bolt.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    udev.packages = [ pkgs.gnome.gnome-settings-daemon ];
    usbmuxd.enable = true;
    xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnomeExtensions.appindicator
    neovim-qt
    pavucontrol
    wl-clipboard
    xdg-utils
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = false;

  musnix.enable = true;
  musnix.rtirq.enable = true;
}
