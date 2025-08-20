{
  description = "a family friendly Home Server Setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
  	# Add this block to enable flakes and nix-command permanently
  	nix = {
  	  extraOptions = ''
  	    experimental-features = nix-command flakes
  	  '';
  	};

  	
    nixosConfigurations = {
      # "stewie" = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   modules = [
      #     ./hosts/stewie/default.nix
      #     home-manager.nixosModules.home-manager
      #   ];
      # };

      "peter" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/peter/default.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
