{
  # TODO java language server
  # TODO maybe not java language server
  description = "Shell for python and ai";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
  };

  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      system = "x86_64-linux";
      pkgs = import <nixpkgs> {
        inherit system;
      };
    in
    {
      homeModules.vscode = {
        programs.vscode = {
          enable = true;

          mutableExtensionsDir = false;
          profiles.default = {
            extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
              {
                name = "ms-toolsai.jupyter-cell-tags";
                publisher = "Microsoft";
                version = "0.1.9";
                sha256 = "sha256-sk4F1UXNFq7bNYrWLAW7DxbXMUQGQUZh61UjIa+lfA4=";
              }
              {
                name = "ms-toolsai.jupyter-renderers";
                publisher = "Microsoft";
                version = "1.3.0";
                sha256 = "sha256-2u4Moixrf94vDLBQzz57dToLbqzz7OenQL6G9BMCn3I=";
              }
              {
                name = "ms-toolsai.jupyter-slideshow";
                publisher = "Microsoft";
                version = "0.1.6";
                sha256 = "sha256-eTEdZkHbAGSDXP9A06YL6jDBfO8rU1kC9RysxOUxI1U=";
              }
              {
                name = "ms-toolsai.jupyter-keymap";
                publisher = "Microsoft";
                version = "1.1.2";
                sha256 = "sha256-mQr/uLulKoPVXz0GaMMEHZ/ZSmSAEfO9UpFzy4MfcW4=";
              }
              {
                name = "ms-toolsai.jupyter";
                publisher = "Microsoft";
                version = "2025.9.1";
                sha256 = "sha256-nKK8HRzeqDixpdKmgacjhNzanJaTsAnYLC6nCbmWXuU=";
              }
            ];
          };
        };
      };

      nixosModules.default = {
        environment.systemPackages =
          with pkgs;
          [
            jupyter-all
          ]
          ++ (with pkgs.python313Packages; [
            pandas
            matplotlib
            numpy
          ]);
      };
    };
}
