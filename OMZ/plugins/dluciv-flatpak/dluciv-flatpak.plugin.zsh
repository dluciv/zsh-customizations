function __flatpak-upgrade__ () {
  # user
  echo "Upgrading user flatpak..."
  flatpak upgrade --assumeyes; flatpak uninstall --assumeyes --unused
  # system
  echo "Upgrading system flatpak..."
  sudo flatpak upgrade --assumeyes; sudo flatpak uninstall --assumeyes --unused
}
