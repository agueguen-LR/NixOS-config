{pkgs, ...}: {
  config.services.postgresql = {
    enable = true;
    authentication = pkgs.lib.mkOverride 10 ''
      # TYPE   DATABASE      USER         ADDRESS        METHOD

      # Allow local socket connections
      local   all           all                          trust

      # Allow TCP localhost connections
      host    all           all         127.0.0.1/32     trust
      host    all           all         ::1/128          trust
    '';
  };
}
