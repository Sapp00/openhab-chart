{
  description = "Dev shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    in
    {
      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        {
          default = pkgs.mkShell {
            # Packages required for the environment
            packages = [
              pkgs.gemini-cli
              pkgs.git
              pkgs.curl
            ];

            shellHook = ''
              if [ -f .env ]; then
                set -a
                source .env
                set +a
              else
                echo "⚠️  Warning: No .env file found. Ensure GOOGLE_API_KEY is set."
              fi
            '';
          };
        }
      );
    };
}
