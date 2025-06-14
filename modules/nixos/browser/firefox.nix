{ ... }:
{
  programs.firefox = {
    enable = true;
    preferences = {
      "privacy.fingerprintingProtection" = true;
      "privacy.donottrackheader.enabled" = true;
      "privacy.globalprivacycontrol.enabled" = true;
    };
  };
}
