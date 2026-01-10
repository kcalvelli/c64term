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
          default = self.packages.${system}.c64term;
          c64term = pkgs.callPackage ./c64term { };
        }
      );

      # For use in other flakes
      overlays.default = final: prev: { c64term = self.packages.${final.system}.c64term; };

      # Development shell with cbmbasic
      devShells = forAllSystems (
        system:
        let
          pkgs = pkgsFor system;
          cbmbasic = pkgs.callPackage ./c64term/cbmbasic.nix { };
        in
        {
          default = pkgs.mkShell {
            buildInputs = [
              cbmbasic
              pkgs.fish
            ];

            shellHook = ''
              echo "C64 Development Shell"
              echo "cbmbasic is available - type 'cbmbasic' to enter BASIC mode"
            '';
          };
        }
      );
    };
}
