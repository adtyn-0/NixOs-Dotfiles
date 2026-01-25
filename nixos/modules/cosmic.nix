{ config, pkgs, ... }:

{
  # COSMIC Desktop Environment (NixOS 25.05+)
  services.desktopManager.cosmic.enable = true;

  # COSMIC Greeter (display manager)
  # Enable ONLY when you want to log into COSMIC
  services.displayManager.cosmic-greeter.enable = true;

  # Performance optimization (recommended by System76)
  services.system76-scheduler.enable = true;

  # Clipboard behavior (optional, global clipboard access)
  environment.sessionVariables = {
    COSMIC_DATA_CONTROL_ENABLED = "1";
  };

  # Firefox theming fix (only if you use Firefox in COSMIC)
  # programs.firefox.preferences = {
  #   "widget.gtk.libadwaita-colors.enabled" = false;
  # };

  # Optional: exclude default COSMIC apps (25.11+ only)
  # environment.cosmic.excludePackages = with pkgs; [
  #   cosmic-edit
  # ];
}
