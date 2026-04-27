{ pkgs, ... }:

{
  services.cockpit = {
    enable = true;
    showBanner = true;
    plugins = with pkgs; [
      cockpit-files
      cockpit-podman
      cockpit-machines
    ];
  };

  services.openssh.allowSFTP = true;
  # programs.ssh.startAgent = true;

  # Backup
  services.duplicati = {
    enable = true;
  };
}
