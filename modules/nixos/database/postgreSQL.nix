{pkgs, ...}: {
  config.services.postgresql = {
    enable = true;
    authentication = pkgs.lib.mkOverride 10 ''
         #Type Database  User  	Address				auth-method
      host  all       all     127.0.0.1/32  trust
    '';
  };
}
