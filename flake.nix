{
  description = "C64 Term - Authentic Commodore 64 terminal experience";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgsFor = system: import nixpkgs { inherit system; };
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = pkgsFor system;
        in
        {
          default = self.packages.${system}.c64-shell;
          c64-shell = pkgs.callPackage ./c64-shell { };
        }
      );

      # For use in other flakes
      overlays.default = final: prev: { c64-shell = self.packages.${final.system}.c64-shell; };
    };
}
