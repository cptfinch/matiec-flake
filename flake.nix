{
  description = "Matiec IEC 61131-3 compiler";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.matiec = let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
      };
    in pkgs.stdenv.mkDerivation {
      pname = "matiec";
      version = "71b7135";  # Most recent commit hash - there is no releases nor tags 

      src = pkgs.fetchFromGitHub {
        owner = "thiagoralves";
        repo = "matiec";
        rev = "71b713522a1c48e44f5cfb8cdceb47ece0647ae9";
        sha256 = "OwTgGwI7wc1ePwemZNKXP8+XvDdGJgt0wUnVs3nu5+o=";
      };

      buildInputs = [ pkgs.bison pkgs.flex pkgs.autoconf pkgs.automake ];  # Removed gcc , 

      buildPhase = ''
        autoreconf -i
        ./configure
        make
      '';

      installPhase = ''
        mkdir -p $out/bin
        cp ./iec2c $out/bin/
      '';

      meta = with pkgs.lib; {
        description = "Matiec IEC 61131-3 compiler";
        license = licenses.gpl3;
        platforms = platforms.linux;
      };
    };
  };
}


