{
  description = "PerfectPlushieAPI dev shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    in
    {
      devShells = nixpkgs.lib.genAttrs systems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = [ pkgs.jdk17 pkgs.jdk21 ];
            shellHook = ''
              export JAVA_HOME=${pkgs.jdk21}
              export JAVA_17_HOME=${pkgs.jdk17}
              export JAVA_21_HOME=${pkgs.jdk21}
            '';
          };
        }
      );
    };
}
