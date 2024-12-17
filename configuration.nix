 { pkgs, ... }:
 
 {
   nix.settings = {
     experimental-features = "nix-command flakes";
     auto-optimise-store = true;
   };
   
   environment.systemPackages = [
     pkgs.vim
     pkgs.git
     pkgs.zip
     pkgs.unzip
     pkgs.wget
   ];
   
   fileSystems."/" = {
     device = "/dev/disk/by-label/nixos";
     fsType = "ext4";
   };
   fileSystems."/boot" = {
     device = "/dev/disk/by-label/boot";
     fsType = "ext4";
   };
   swapDevices = [
     {
       device = "/dev/disk/by-label/swap";
     }
   ];
   
   documentation.nixos.enable = false;
   time.timeZone = "Europe/London";
   i18n.defaultLocale = "en_GB.UTF-8";
   console.keyMap = "us";
   nix.settings.trusted-users = [ "@wheel" ];
   
   boot.loader.grub.enable = true;
   boot.loader.grub.device = "/dev/sda";
   boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "ext4" ];
   
   users.users = {
     root.hashedPassword = "!"; # Disable root login
     username = {
       isNormalUser = true;
       extraGroups = [ "wheel" ];
       openssh.authorizedKeys.keys = [
         ssh-rsa "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCzb0B+xhRUTNjAFyCSf5nYY75cRhlJZOha1JW73GM+8vGFhyz2iskXcayk0VyhAzsax6sBzY2P91Fa/kxepybsqV5jdFqwauHrHnopg166laoMj5UwDh1lh354bx7Ox/8o6nQYP5j8alJtfHg8Gv84MvkoKjNoesVs0/JzytpMbIl7QpliQgo4crM4sEYrXYIvSKS5Hbbg/aLBtLRVXmYkKK6fNSrgFeecJUdcB/qck//MnwhcigmrJUjIoLBJMApmca/65htoltDnscbUp2XRyd7xpavavmthzqbZbpyPhGMaTtamc9TtPBtl0alhuVJiXYLRQj0sYph6pRelpQGngU89ORq5XTeicMbW/rmZLglV6h75uo0TgXIXITAbJvfCtIEojQsEcjSSlcWHUvmH9FkekdA4X2rEwwGNdYpYGHd/pxB+/bdmZKDoMnyGpLhu4ZVoKB6fdIGeI7sSnCqCQXdBPMPNW16kUIrrbS9dse5YVS5WxYZosLaeam6IWr27hxtXwNuSY+Dbvz4eidGMLn8rnJFPd4qDarukA/5sSuEqyrnIOCKRV4+eXwY8NR4DLBNwrNhnPeJ/0hZizaWSgEbnuaJDRB8DsAjKyU50gk70e7JNtvNAUCZ3G9zR3Aa3RvIqrdsiZHnaKip9fd2czNxX9Te+Em4ey9XG1JD8Kw== Hetzner Cloud"
       ];
     };
   };
   
   security.sudo.wheelNeedsPassword = false;
   
   services.openssh = {
     enable = true;
     settings = {
       PermitRootLogin = "no";
       PasswordAuthentication = false;
       KbdInteractiveAuthentication = false;
     };
   };
   networking.firewall.allowedTCPPorts = [ 22 ];
   
   # This value determines the NixOS release from which the default
   # settings for stateful data, like file locations and database versions
   # on your system were taken. It‘s perfectly fine and recommended to leave
   # this value at the release version of the first install of this system.
   # Before changing this value read the documentation for this option
   # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
   system.stateVersion = "24.11"; # Did you read the comment?
 }
