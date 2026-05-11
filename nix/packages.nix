{
  pkgs,
  self,
  system,
}:
let
  appSrc = ../.;
  appDir = "/app";
  appPort = "3000";
in
{
  npm-build = pkgs.buildNpmPackage {
    pname = "npm-build";
    version = "1.0.0";
    src = appSrc;

    npmDepsHash = "sha256-VnGWE3qqIHhnzc0Yz+9QrgekqU6nVaOtVFt7Gq0ZH6s=";
    npmBuildScript = "build";

    installPhase = ''
      mkdir -p $out/${appDir}
      cp -r dist $out/${appDir}
      cp -r node_modules $out/${appDir}
    '';

  };

  default = pkgs.dockerTools.buildImage {
    name = "node-app";
    tag = "latest";

    copyToRoot = pkgs.buildEnv {
      name = "copy-to-root";
      paths = [
        # normal packages
        pkgs.dockerTools.usrBinEnv
        pkgs.dockerTools.binSh
        pkgs.dockerTools.caCertificates
        pkgs.dockerTools.fakeNss
        pkgs.coreutils
        pkgs.bashInteractive
        # extras
        pkgs.nodejs_22
        pkgs.pandoc
        pkgs.texliveMedium
        # builds steps
        self.packages.${system}.npm-build
      ];

    };

    runAsRoot = ''
      cp -r ${appSrc}/* ${appDir}
      chown -R nobody:nobody ${appDir}
      chmod -R 770 ${appDir}
    '';

    config = {
      WorkingDir = "${appDir}";
      Cmd = [
        "sleep"
        "infinity"
      ];
      ExposedPorts = {
        "${appPort}/tcp" = { };
      };
    };
  };
}
