{
  pkgs,
}:
let

in

pkgs.mkShell {
  name = "node-shell";
  buildInputs = [
    pkgs.nodejs_22
    pkgs.pandoc
    pkgs.texliveMedium
  ];
}
