{ pkgs, ... }:
{
  # Enable common container config files in /etc/containers

  virtualisation = {
    hypervGuest.enable = true;
    containers.enable = true;
    docker.enable = true;
    podman = {
      enable = true;
      dockerCompat = false;
      defaultNetwork.settings.dns_enabled = true;
    };
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        swtpm.package = pkgs.swtpm;
        package = pkgs.qemu_kvm;
      };
    };
  };

  # Useful other development tools
  environment.systemPackages = with pkgs; [
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    docker-compose # start group of containers for dev
    distrobox
    distrobox-tui
    boxbuddy
    #podman-compose # start group of containers for dev
  ];
}
