{ ... }:
{
  virtualisation.oci-containers.backend = "podman";

  virtualisation.oci-containers.containers.pegaprox = {
    image = "ghcr.io/pegaprox/pegaprox:latest";
    ports = [
      "5000:5000" # web UI + API
      "5001:5001" # VNC websocket (noVNC console)
      "5002:5002" # SSH websocket (xterm.js)
    ];
    volumes = [
      "/var/lib/pegaprox/config:/app/config"
      "/var/lib/pegaprox/logs:/app/logs"
    ];
    autoStart = true;
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/pegaprox/config 0755 root root -"
    "d /var/lib/pegaprox/logs 0755 root root -"
  ];
}
