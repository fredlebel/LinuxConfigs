{
  packageOverrides = pkgs: {

    ghcDevEnv = pkgs.haskellPackages.ghcWithPackages (p: with p; [
      xmonad xmonadContrib xmonadExtras
    ]);

  };
}

