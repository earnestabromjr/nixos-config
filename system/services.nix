{ pkgs, ... }:

{
  services = {
    cockpit = {
      enable = true;
      showBanner = true;
      plugins = with pkgs; [
        cockpit-files
        cockpit-podman
        cockpit-machines
      ];
    };
    openssh.allowSFTP = true;
    duplicati = {
      enable = true;
    };
    tailscale = {
      enable = true;
    };
    nfs = {
      server.enable = true;
    };
  };
}
