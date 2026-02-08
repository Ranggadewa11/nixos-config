{
  lib,
  config,
  ...
}: let
  # 1. Tentukan lokasi folder config kamu
  # (path ./.) berarti folder tempat file ini berada
  configDir = ./.;

  # 2. Fungsi untuk list semua file secara rekursif
  # Ini akan menghasilkan list path file: [ /path/to/kitty/kitty.conf, ... ]
  allFiles = lib.filesystem.listFilesRecursive configDir;

  # 3. Fungsi untuk mengubah path absolut menjadi format xdg.configFile
  mkXdgEntry = filePath: let
    # Mengubah path "/home/.../dotconfig/kitty/kitty.conf" menjadi string "kitty/kitty.conf"
    relativePath = lib.removePrefix (toString configDir + "/") (toString filePath);
  in {
    name = relativePath;
    value = {source = filePath;};
  };

  # 4. Filter: Jangan masukkan file "default.nix" ini sendiri ke dalam config
  configFiles = builtins.filter (f: baseNameOf f != "default.nix") allFiles;

  # 5. Map semua file menjadi format { name = "path"; value = { source = ... }; }
  entries = map mkXdgEntry configFiles;
in {
  # 6. Konversi List menjadi Attribute Set dan masukkan ke xdg.configFile
  xdg.configFile = builtins.listToAttrs entries;
}
