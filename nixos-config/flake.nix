{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
	url = "github:nix-community/home-manager/release-24.05";
	inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, ...}: {
    # replace 'joes-desktop' with your hostname here.
    nixosConfigurations.lamtdang = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
      	./configuration.nix
	home-manager.nixosModules.home-manager
	{
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;

	  home-manager.users.lamtdang = import ./home.nix;
	}
	{
	  nix = {
	  	settings.experimental-features = [ "nix-command" "flakes" ];

	};
	}
	];
    };
  };
}
