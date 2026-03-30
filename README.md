# DAT566 Flake

Nix flake for DAT566 .

Includes Jupyter Notebook configuration with Python 3.13, libraries for the course (NumPy, Pandas and Matplotlib) and VSCode extensions.

## Installation

Add the flake input to your `flake.nix`:

```nix
{
  inputs.dat566.url = "github:LinuxAtChalmers/dat566-flake";
}
```

Add the system module to `configuration.nix` which will install the necessary
libraries:

```
{ pkgs, inputs, ... }:
{
  imports = [
    inputs.dat566.nixosModules.default
  ];
}
```
    

Also add the Home Manager module, this will install the extensions for
Visual Studio Code and set the relevant paths:

```
{ pkgs, inputs, ... }:
{
  home-manager.users.youruser = {
    # import the home manager module
    imports = [
      inputs.dat566.homeModules.default
    ];
  };
}
```

Rebuild your system, you can now start Visual Studio Code and everything should
be set up for you.
