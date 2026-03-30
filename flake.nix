{
  description = "Flake for DAT566 Introduction to Data Science and AI course";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    packages.${system} = {
      python-dat566 = pkgs.python313.withPackages (python-pkgs:
        with python-pkgs; [
          ipykernel
          notebook
          pandas
          matplotlib
          numpy
        ]);
    };

    homeModules.vscode = {
      programs.vscode = {
        enable = true;

        profiles."DAT566" = {
          userSettings = let
            python = self.packages.${system}.python-dat566;
          in {
            "python.defaultInterpreterPath" = "${python}/bin/python";
          };

          extensions = with pkgs.vscode-extensions; [
            ms-python.python
            ms-toolsai.jupyter
          ];
        };
      };
    };

    nixosModules.default = {
      environment.systemPackages = [
        self.packages.${system}.python-dat566
      ];
    };
  };
}
