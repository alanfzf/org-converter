{
  description = "Base nix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }@inputs:

    flake-utils.lib.eachDefaultSystem (
      system:

      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        mkScript =
          name: text:
          let
            script = pkgs.writeShellScriptBin name text;
          in
          script;

        scripts = [ ];

        devPackages = with nixpkgs; [
          pkgs.nodejs_22
          pkgs.texliveMedium
          pkgs.pandoc
        ];

        postShellHook = "";
      in
      {
        devShells = {
          default = pkgs.mkShell {
            name = "node-dev-shell";
            nativeBuildInputs = scripts;
            packages = devPackages;
            postShellHook = postShellHook;
          };
        };
      }
    );
}
