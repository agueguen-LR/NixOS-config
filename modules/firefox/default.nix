{
  mkFeature,
  lib,
  config,
  ...
}:
mkFeature config {
  name = "firefox";

  nixos = {
    hostSpecs.quickActions.browser = lib.mkDefault ["firefox"];
  };

  home.programs.firefox = {
    enable = true;

    preferences = {
      "privacy.fingerprintingProtection" = true;
      "privacy.donottrackheader.enabled" = true;
      "privacy.globalprivacycontrol.enabled" = true;
    };
  };
}
