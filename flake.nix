{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }:
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs { system = system; config.allowUnfree = true; };
  in
  {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        dotnet-sdk_8
        mono
        omnisharp-roslyn
        netcoredbg
        sqlite
        nodePackages.prettier
        docker-compose
      ];
      shellHook = ''
      export DOTNET_ROOT="${pkgs.dotnet-sdk_8}"
      export PATH=$HOME/.dotnet/tools:$PATH
      '';
    }; 
  };
}
