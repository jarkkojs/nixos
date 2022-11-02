
{
  inputs = {
    musnix.url = github:musnix/musnix;
    nixos.url = github:nixos/nixpkgs/nixos-22.11;
    nixpkgs.url = github:NixOS/nixpkgs/nixos-22.11;
  };

  outputs = {musnix, nixos, nixpkgs, ...}: {
    nixosConfigurations = with nixpkgs.lib; let
      lib = nixpkgs.lib;
      nixos-wsl = import ./nixos-wsl;
      base = {
        system = "x86_64-linux";
        specialArgs = {
          inherit nixpkgs;
          inherit musnix;
        };
        modules = [
          ./configuration.nix
          ({imports = optional (pathExists ./local.nix) ./local.nix;})
        ];
      };
    in
      with nixpkgs.lib; {
        gnome = nixosSystem {
          inherit (base) system specialArgs;
          modules =
            base.modules ++
            [
              musnix.nixosModules.musnix
              ./hardware-configuration.nix
              ./configuration.d/gnome.nix
            ];
        };

        wsl = nixosSystem {
          inherit (base) system specialArgs;
          modules =
            base.modules ++
            [
              nixos-wsl.nixosModules.wsl
              ./configuration.d/wsl.nix
            ];
        };
      };
  };
}
